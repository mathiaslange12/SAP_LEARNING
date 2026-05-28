CLASS zcl_3285_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3285_path_expr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
    FROM z3285_c_employeequery
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           DepartmentDescription,
           AssistantName,
*           \_Department\_Head-LastName AS HeadName,
           concat_with_space( \_Department\_Head-FirstName, \_Department\_Head-LastName, 1 ) AS HeadName


    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
