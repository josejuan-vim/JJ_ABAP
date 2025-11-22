CLASS zcl_lab_07_tables_josejuan DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_07_tables_josejuan IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.



*1. Añadir registros **********************************************************

"Define structure"
TYPES: BEGIN OF zemp_logali,
         id     TYPE c LENGTH 10,
         email  TYPE string,
         ape1   TYPE c LENGTH 40,
         ape2   TYPE c LENGTH 40,
         name   TYPE c LENGTH 40,
         fechan TYPE d,
         fechaa TYPE d,
       END OF zemp_logali.

"Estructura
DATA: ms_employees TYPE zemp_logali.

"Tabla interna
DATA: mt_employees TYPE STANDARD TABLE OF zemp_logali.

"Añadir 1º registro
ms_employees = VALUE zemp_logali(
  id     = '001'
  email  = 'empleado1@viseo.com'
  ape1   = 'GOMEZ'
  ape2   = 'BARBA'
  name   = 'JOSE JUAN'
  fechan = '19950425'
  fechaa = '20220201'
).

APPEND ms_employees TO mt_employees.

"Añadir 2º registro
ms_employees = VALUE zemp_logali(
  id     = '002'
  email  = 'empleado2@viseo.com'
  ape1   = 'PEREZ'
  ape2   = 'GARCIA'
  name   = 'MARIA'
  fechan = '19900210'
  fechaa = '20240220'
).

APPEND ms_employees TO mt_employees.

out->write(
    EXPORTING
        data = mt_employees
        name = 'Empleados'
).



*2. Insertar registros (INSERT) **********************************************************

"Añadir 3º registro
ms_employees = VALUE zemp_logali(
  id     = '003'
  email  = 'empleado3@viseo.com'
  ape1   = 'MARTIN'
  ape2   = 'PONCE'
  name   = 'LUCIA'
  fechan = '20010701'
  fechaa = '20230223'
).

INSERT ms_employees INTO TABLE mt_employees.


out->write(
    EXPORTING
        data = mt_employees
        name = 'Empleados'
).



*3. Añadir registros con APPEND **********************************************************

DATA: mt_employees_2 TYPE STANDARD TABLE OF zemp_logali.

"Añadir 1º registro
ms_employees = VALUE zemp_logali(
  id     = '001'
  email  = 'empleado1@externo.com'
  ape1   = 'DIAZ'
  ape2   = 'GONZALEZ'
  name   = 'DAVID'
  fechan = '19830901'
  fechaa = '20251008'
).

APPEND ms_employees TO mt_employees_2.

out->write(
    EXPORTING
        data = mt_employees_2
        name = 'Freelances'
).


"Añadir 2º registro con APPEND VALUE
APPEND VALUE zemp_logali(
  id     = '002'
  email  = 'empleado2@externo.com'
  ape1   = 'MARTINEZ'
  ape2   = 'BASCO'
  name   = 'ALMUDENA'
  fechan = '19890430'
  fechaa = '20250508'
) TO mt_employees_2.

out->write(
    EXPORTING
        data = mt_employees_2
        name = 'Freelances'
).

"Añadir registros del índice 2 al 3 de la tabla mt_employees a la tabla mt_employees_2.
APPEND LINES OF mt_employees FROM 2 TO 3 TO mt_employees_2.

out->write(
    EXPORTING
        data = mt_employees_2
        name = 'Freelances'
).



*4. CORRESPONDING **********************************************************

"Definir estructuras

DATA: ms_spfli   TYPE /dmo/connection,
      ms_spfli_2 TYPE /dmo/connection.

"Definir tabla interna

DATA mt_spfli TYPE STANDARD TABLE of /dmo/connection.

" Variable para almacenar el conteo total de vuelos
DATA lv_flight_count TYPE i.

"Consultar número total de vuelos con carrier_id = 'LH'.
SELECT SINGLE COUNT(*)
    FROM /dmo/connection
    WHERE carrier_id = 'LH'
    INTO @lv_flight_count.

out->write( lv_flight_count ).


"Seleccionamos todos los vuelos de 'LH' a la tabla interna
SELECT *
  FROM /dmo/connection
  WHERE carrier_id = 'LH'
  INTO TABLE @mt_spfli.

"Verificar si la tabla tiene registros antes de intentar leerla
IF mt_spfli IS NOT INITIAL.

"Leer el primer registro de MT_SPFLI en la estructura MS_SPFLI
  READ TABLE mt_spfli INDEX 1 INTO ms_spfli.

  IF
  sy-subrc EQ 0.
    " Mover la información de MS_SPFLI a MS_SPFLI_2
    MOVE-CORRESPONDING ms_spfli TO ms_spfli_2.

  ELSE.
    out->write( 'Error al leer el primer registro' ).

  ENDIF.

ELSE.
    out->write( 'La tabla mt_spfli no contiene registros' ).

ENDIF.

out->write(
    EXPORTING
        data = mt_spfli
        name = 'Vuelos LH'
).


  ENDMETHOD.

ENDCLASS.
