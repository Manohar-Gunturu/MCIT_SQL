set SERVEROUTPUT on;

drop function get_bal;

CREATE FUNCTION get_bal(acc_no IN NUMBER) 
   RETURN NUMBER 
   IS acc_bal NUMBER(11,2);
   BEGIN 
      SELECT amount 
      INTO acc_bal 
      FROM amount 
      WHERE id = acc_no; 
      RETURN(acc_bal); 
    END;

select get_bal(2) from dual;


create OR REPLACE  function incs(num IN NUMBER) return NUMBER
    IS sum1 NUMBER(8,0);
    BEGIN
      sum1 := 0;
      WHILE sum1 < 11 LOOP
        sum1 := sum1 + 1;
      END LOOP;
      RETURN(sum1);
    END;

select incs(10) from dual;


create OR REPLACE  function incsfor(num IN NUMBER) return NUMBER
    IS sum1 NUMBER(8,0);
      counter NUMBER(3);
    BEGIN
      counter := 0;
      sum1 := 0;
      FOR counter IN  1..11 LOOP
        sum1 := sum1 + 2;
      END LOOP;
      RETURN(sum1);
    END;

select incsfor(10) from dual;


create OR REPLACE  procedure pc1(num IN NUMBER)
    IS sum1 NUMBER(8,0);
    rec amount%ROWTYPE;    
    BEGIN
      FOR rec IN  (select name from amount) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.name );
      END LOOP;
    END;

execute pc1(2);


create or replace PROCEDURE findMin(x IN number, y IN number, z OUT number) IS 
BEGIN 
   IF x < y THEN 
      z:= x; 
   ELSE 
      z:= y; 
   END IF; 
END;   

create OR REPLACE  function usefindMin(num1 IN NUMBER, num2 IN NUMBER) return NUMBER
IS small NUMBER(8,0);
BEGIN
  findMin(num1, num2, small);
  return(small);
END;

select usefindMin(2,5) from dual;

CREATE TYPE UserType AS OBJECT 
(
     ID number(5,0),
     amount number(8,2), 
     name varchar2(50)
);

CREATE OR REPLACE TYPE test_type AS TABLE OF NUMBER;
CREATE OR REPLACE FUNCTION test_func RETURN test_type 
    PIPELINED
    AS
    BEGIN
     FOR i IN 1..100
     LOOP
        PIPE ROW(i);
      END LOOP;
    END;

create or replace type user_collection  as table of UserType;


CREATE OR REPLACE FUNCTION get_row_am(a_rows IN NUMBER) RETURN user_collection 
PIPELINED 
AS
rec amount%ROWTYPE;    
BEGIN
  FOR rec IN (select * from amount where rownum < a_rows) LOOP
    PIPE ROW(UserType(rec.id,  rec.amount, rec.name ));
  END LOOP;
  RETURN;
END;


select * from table(get_row_am(4));






DECLARE 
   message  varchar2(20):= 'Hello, World!'; 
BEGIN 
   dbms_output.put_line(message); 
END; 

DECLARE
  CURSOR c1 IS
    SELECT last_name, salary, hire_date, job_id FROM hr.employees 
       WHERE employee_id = 120;
-- declare record variable that represents a row fetched from the employees table
   employee_rec c1%ROWTYPE; 
BEGIN
-- open the explicit cursor and use it to fetch data into employee_rec
  OPEN c1;
  FETCH c1 INTO employee_rec;
  DBMS_OUTPUT.PUT_LINE('Employee name: ' || employee_rec.last_name);
END;
