select *
from parks_and_recreation.employee_demographics;

select *
from parks_and_recreation.employee_salary;

select *
from parks_and_recreation.parks_departments;

-- adding new calculation column - auto adding (age + 10)
select first_name, last_name, age AS 'AGE', age +10 AS 'new age'  
from parks_and_recreation.employee_demographics; 
# PAMDAS - calculation execution order

-- select unique values
select DISTINCT gender 
from parks_and_recreation.employee_demographics;

-- alone gender column not uniqe, but both together unique
select DISTINCT first_name, gender
from parks_and_recreation.employee_demographics;

