extend view entity Z3285_C_EMPLOYEEQUERYP with
association [1..1] to I_Country as _ZZCountryZem on $projection.ZZCoutryZem = _ZZCountryZem.Country
{
  Employee.ZZTitleZem,
  Employee.ZZCoutryZem,

  @EndUserText.label: 'Employee Fullname'
  concat_with_space( Employee.FirstName, Employee.LastName, 1 ) as ZZFullNameZem,

  _ZZCountryZem.IsEuropeanUnionMember                           as ZZEUBasedZem
}
