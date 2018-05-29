CREATE OR REPLACE
PROCEDURE BUSCAR_PACIENTES (AGE_MIN    PATIENTS.AGE%TYPE,
                            AGE_MAX    PATIENTS.AGE%TYPE,
                            AUNIT          PATIENTS.AUNIT%TYPE) --APPLICANT UNIT
IS
   CURSOR NAGE_AUNIT
   IS
      SELECT *
        FROM PATIENTS
       WHERE     AUNIT = AUNIT
             AND AGE BETWEEN AGE_MIN AND AGE_MAX;

   DAGE   NAGE_AUNIT%ROWTYPE; --datatype specifier
BEGIN
   OPEN NAGE_AUNIT; --ITERAR
   LOOP
      FETCH NAGE_AUNIT INTO DAGE;

      EXIT WHEN NAGE_AUNIT%NOTFOUND; --BREAK
             
      DBMS_OUTPUT.PUT_LINE ( 
            'ID PACIENTE '|| DAGE.EMPLOYEE_ID || 
            ' PACIENTE '|| DAGE.FIRST_NAME || ' '|| DAGE.LAST_NAME|| 
            ' EDAD ACTUAL ' || DAGE.AGE);
   END LOOP;
  CLOSE NAGE_AUNIT;
  --FIN DEL CURSOR
END;
--FIN DEL PROCEDIMIENTO BUSQUEDA


CREATE OR REPLACE FUNCTION VALIDAR_EDADES (TYPE PATIENTS.AGE%TYPE,TYPE2 PATIENTS.AGE%TYPE)
   RETURN BOOLEAN
IS
   FLAG   BOOLEAN;
BEGIN
   IF TYPE > 0 AND TYPE2 > 0
   THEN
      FLAG := TRUE;
   ELSE
      FLAG := FALSE;
   END IF;

   RETURN FLAG;
END;

DECLARE
    AGEMIN  PATIENTS.AGE%TYPE;
    AGEMAX  PATIENTS.AGE%TYPE;
    AUNIT  PATIENTS.AUNIT%TYPE;
    
BEGIN
   AGEMIN := &AGEMIN;
   AGEMAX := &AGEMAX;
   AUNIT := &AUNIT;
   
    IF VALIDAR_EDADES(AGEMIN, AGEMAX) THEN
      ADMIN1.BUSCAR_PACIENTES (AGEMIN, AGEMAX, AUNIT);
   ELSE
      DBMS_OUTPUT.PUT_LINE ('INVALID DATA ');
   END IF;

   

   --ADMIN1.BUSCAR_PACIENTES (AGEMIN, AGEMAX, AUNIT);
  
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.PUT_LINE ('ERROR ' || SQLCODE);
END;


/