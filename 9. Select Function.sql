-- SELECT FUNCTION

SELECT LENGTH('Dinushika');        -- can count length using function (predefine)

select first_name, LENGTH(first_name) AS length
from employee_demographics
order by length;

SELECT UPPER('dinushika');        -- tern into upper case letters
SELECT LOWER('DINUSHIKA');        -- tern into lower case letters

select first_name, UPPER(first_name)
from employee_demographics; 


-- TRIM 
SELECT TRIM('        Sky     ');    -- TRIM remove leading and trailing white spaces

SELECT LTRIM('     Sky    k');
SELECT RTRIM('              Sky k              ');


select first_name, 
  left(first_name, 4), 
  right(first_name, 4)   -- first name first 4 letters, first name last 4 letters
from employee_demographics;

select first_name, SUBSTRING(first_name, 3, 2)         -- first_name 3rd letter with 2 letters
from employee_demographics;


select birth_date, SUBSTRING(birth_date, 3, 2) AS birth_month       -- take month out from birthday    
from employee_demographics;

select first_name, REPLACE(first_name, 'a', 'z')       -- replace letter a to z in the first_name
from employee_demographics;


select LOCATE('i', 'Dinushika');


select first_name, LOCATE('an', first_name) 
from employee_demographics;

select first_name, last_name, CONCAT(first_name,' ', last_name) AS full_name  -- concatination
from employee_demographics; 










































