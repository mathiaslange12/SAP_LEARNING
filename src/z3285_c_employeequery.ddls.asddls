@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Employee (Query)'

@Metadata.ignorePropagatedAnnotations: true

define view entity Z3285_C_EMPLOYEEQUERY
  as select from Z3285_R_Employee

{
  key EmployeeId,

      FirstName,
      LastName,
      DepartmentId,

      _Department.Description                                                                               as DepartmentDescription,
      // _Department._Assistant.LastName as AssistantName,
      concat_with_space(_Department._Assistant.FirstName, _Department._Assistant.LastName, 1)               as AssistantName,

      @EndUserText.label: 'Employee Role'
      case EmployeeId
        when _Department.DepartmentHead then 'H'
        when _Department.DepartmentAssistant then 'A'
        else ' '
      end                                                                                                   as EmployeeRole,



      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion(amount             => AnnualSalary,
                          source_currency    => CurrencyCode,
                          target_currency    => $projection.CurrencyCodeUSD,
                          exchange_rate_date => $session.system_date)                                       as AnualSalaryConverted,

      @EndUserText.label: 'Monthly Salary Converted'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast( $projection.AnualSalaryConverted as abap.fltp ) / 12.0                                          as MonthlySalaryConverted,


      cast('USD' as /dmo/currency_code)                                                                     as CurrencyCodeUSD,

      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(cast(AnnualSalary as abap.fltp) / 12.0 as abap.dec(10,2))                                        as MonthlySalary,

      CurrencyCode,

      cast(cast(dats_days_between(EntryDate, $session.system_date) as abap.fltp) / 365.0 as abap.dec(10,1)) as CompanyAffiliationCast,
      division(dats_days_between(EntryDate, $session.system_date), 365, 1)                                  as CompanyAffiliation,

      /* Associations */
      _Department
}
