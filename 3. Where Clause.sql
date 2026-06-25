-- WHERE CLAUSE

-- using comparison operators
select *
from parks_and_recreation.employee_demographics
where first_name = 'Leslie';

select *
from parks_and_recreation.employee_salary
where salary > 50000; 

select *
from parks_and_recreation.employee_salary
where salary >= 50000; 

select *
from parks_and_recreation.employee_demographics
where gender != 'Female'
;

select *
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01';


-- AND OR NOT - LOGICAL OPERATORS
select *
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' AND gender = 'male'  -- need to true birth_date and gender 
; 

select *
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' OR gender = 'male';  -- even if one of birth_date and gender is true, give output

select *
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' OR NOT gender = 'male';  -- birth_date or gender should not be male

select *
from parks_and_recreation.employee_demographics
where (first_name = 'Leslie' AND age = 44) OR age > 55;      -- if we need to get very unique info


-- LIKE Statement
-- % and _
select *
from parks_and_recreation.employee_demographics
where first_name LIKE 'a%';     -- name starts with 'a'        

select *
from parks_and_recreation.employee_demographics
where first_name LIKE '%a%';    -- name has letter 'a' in the middle

select *
from parks_and_recreation.employee_demographics
where first_name LIKE '%a';    -- The letter 'a' anywhere after the first letter of the name

select *
from parks_and_recreation.employee_demographics
where first_name LIKE 'a__';      -- after first letter 'a', exactly 2 letters

select *
from parks_and_recreation.employee_demographics
where first_name LIKE 'a___';

select *
from parks_and_recreation.employee_demographics
where first_name LIKE 'a___%';   -- after first letter 'a', exactly 3 letters, and after can be any letter

select *
from parks_and_recreation.employee_demographics
where birth_date LIKE '1989%'; 




