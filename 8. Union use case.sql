-- UNIONS

-- Allows user to join rows together
-- one select statement to another select statement 

select age, gender
from employee_demographics
UNION 
select first_name, last_name
from employee_salary;              -- this is wrong

-- Both SELECT statements must return the same number of columns.
-- The columns should have compatible data types.
-- The columns should represent similar kinds of information.

select first_name, last_name
from employee_demographics
UNION 
select first_name, last_name
from employee_salary;          -- This works because both queries return two columns,
                               -- and the corresponding columns have compatible data types 
                               -- (numbers with numbers, text with text).

select first_name, last_name
from employee_demographics
UNION DISTINCT                -- if need to select unique values only  
select first_name, last_name
from employee_salary;  

select first_name, last_name
from employee_demographics
UNION ALL                   -- if need to select all values of borh tables   
select first_name, last_name
from employee_salary;


select first_name, last_name, 'Old' AS Label
from employee_demographics
where age > 50;            -- label people who older than 50 as old

select first_name, last_name, 'Highly pay' AS Payment
from employee_salary
where salary > 70000;     -- get highly payed employees


-- take them together
select first_name, last_name, 'Old' AS Label
from employee_demographics
where age > 50
UNION 
select first_name, last_name, 'Highly pay' AS Label
from employee_salary
where salary > 70000;               -- old and highly payed employees together


select first_name, last_name, 'Old Man' AS Label
from employee_demographics
where age > 40 and gender = 'Male';          -- find age greater than 40 and male employees

select first_name, last_name, 'Old Lady' AS Label
from employee_demographics
where age > 40 and gender = 'Female';        -- -- find age greater than 40 and female employees


select first_name, last_name, 'Old Man' AS Label         -- take 3 of them together by union
from employee_demographics                                 -- age > 40 and male
where age > 40 and gender = 'Male'                         -- age > 40 and female
UNION                                                      -- sal > 70000 employees
select first_name, last_name, 'Old Lady' AS Label
from employee_demographics
where age > 40 and gender = 'Female'
UNION
select first_name, last_name, 'Highly pay' AS Label
from employee_salary
where salary > 70000
ORDER BY first_name, last_name                          -- can know in order are they highly payed old or not
;





