@AbapCatalog: {
    dataMaintenance: #RESTRICTED,
    viewEnhancementCategory: [ #PROJECTION_LIST ],
    extensibility.dataSources: [ 'Employee' ],
    extensibility.elementSuffix: 'ZEM'
}

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Employee (Query)'

@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define view entity Z3285_C_EMPLOYEEQUERYP
  with parameters
    p_target_curr : /dmo/currency_code,

    
    @Environment.systemField: #SYSTEM_DATE
    p_date        : abap.dats

  as select from Z3285_R_Employee as Employee

{
  key EmployeeId,

      FirstName,
      LastName,
      DepartmentId,

      _Department.Description                                                                             as DepartmentDescription,
      // _Department._Assistant.LastName as AssistantName,
      concat_with_space(_Department._Assistant.FirstName, _Department._Assistant.LastName, 1)             as AssistantName,

      
      case EmployeeId
        when _Department.DepartmentHead then 'H'
        when _Department.DepartmentAssistant then 'A'
        else ' '
      end                                                                                                 as EmployeeRole,


      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => AnnualSalary,
                          source_currency    => CurrencyCode,
                          target_currency    => $projection.CurrencyCode,
                          exchange_rate_date => $parameters.p_date)                                       as AnualSalaryConverted,

      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(cast($projection.AnualSalaryConverted as abap.fltp) / 12.0 as abap.dec( 10, 2 ) )              as MonthlySalaryConverted,


      //      cast('USD' as /dmo/currency_code)                                                                     as CurrencyCodeUSD,
      $parameters.p_target_curr                                                                           as CurrencyCode,

      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(cast(AnnualSalary as abap.fltp) / 12.0 as abap.dec(10,2))                                      as MonthlySalary,

      //      CurrencyCode,

      cast(cast(dats_days_between(EntryDate, $parameters.p_date) as abap.fltp) / 365.0 as abap.dec(10,1)) as CompanyAffiliationCast,
      division(dats_days_between(EntryDate, $parameters.p_date), 365, 1)                                  as CompanyAffiliation,

      /* Associations */
      _Department
}
