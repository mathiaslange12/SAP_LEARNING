CLASS zcl_3285_parameter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3285_parameter IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT
      FROM z3285_c_employeequeryp( p_target_curr = 'USD' )
*                                   p_date        = @( cl_abap_context_info=>get_system_date( ) ) )

      FIELDS employeeid,
             firstname,
             lastname,
             departmentid,

             departmentdescription,
             assistantname,
             \_department\_head-lastname AS headname,

             MonthlySalary,
             MonthlySalaryConverted,
             CurrencyCode,
             CompanyAffiliation

      INTO TABLE @DATA(result).

    out->write( result ).
  ENDMETHOD.
ENDCLASS.
