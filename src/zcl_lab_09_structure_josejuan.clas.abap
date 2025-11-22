CLASS zcl_lab_09_structure_josejuan DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_09_structure_josejuan IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

*1. Declaración estructuras

TYPES: BEGIN OF ty_flights,
        iduser TYPE c LENGTH 40,
        aircode TYPE /dmo/carrier_id,
        flightnum TYPE /dmo/connection_id,
        key TYPE land1,
        seat TYPE /dmo/plane_seats_occupied,
        flightdate TYPE /dmo/flight_date,
       END OF ty_flights.

TYPES: BEGIN OF ty_airlines,
        carrid TYPE /dmo/carrier_id,
        connid TYPE /dmo/connection_id,
        countryfr TYPE land1,
        cityfrom TYPE /dmo/city,
        airfrom TYPE /dmo/airport_id,
        countryto TYPE land1,
       END OF ty_airlines.



*2. Estructuras anidadas (NESTED)

TYPES: BEGIN OF ty_nested,
        flights TYPE ty_flights,
        airlines TYPE ty_airlines,
       END OF ty_nested.



*3. Estructuras complejas (DEEP)

TYPES: BEGIN OF ty_deep,
        carrid TYPE /dmo/carrier_id,
        connid TYPE /dmo/connection_id,
        flights TYPE ty_flights,
       END OF ty_deep.



*4. Añadir datos

DATA ls_flights TYPE ty_flights.

ls_flights-iduser     = 'USER001'.
ls_flights-aircode    = 'AA'.
ls_flights-flightnum  = '0400'.
ls_flights-key        = 'ES'.
ls_flights-seat       = 120.
ls_flights-flightdate = '20250120'.


DATA ls_airlines TYPE ty_airlines.

ls_airlines-carrid     = 'AA'.
ls_airlines-connid     = '0400'.
ls_airlines-countryfr  = 'ES'.
ls_airlines-cityfrom   = 'SEVILLE'.
ls_airlines-airfrom    = 'SVQ'.
ls_airlines-countryto  = 'US'.



DATA ls_nested TYPE ty_nested.

ls_nested-flights = ls_flights.
ls_nested-airlines = ls_airlines.



DATA ls_deep TYPE ty_deep.

ls_deep-carrid = 'IB'.
ls_deep-connid = '160'.

ls_deep-flights-iduser     = 'USER002'.
ls_deep-flights-aircode    = 'IB'.
ls_deep-flights-flightnum  = '00'.
ls_deep-flights-key        = 'ES'.
ls_deep-flights-seat       = 180.
ls_deep-flights-flightdate = '20250608'.



*5. Estructura INCLUDE

TYPES: BEGIN OF ty_include_flights1,
         INCLUDE TYPE ty_flights,
      END OF ty_include_flights1.

TYPES: BEGIN OF ty_include_flights2,
         INCLUDE TYPE ty_airlines,
       END OF ty_include_flights2.



*6. Eliminar datos

CLEAR ls_nested.

CLEAR ls_deep.


ENDMETHOD.

ENDCLASS.
