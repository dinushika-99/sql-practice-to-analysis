-- GROUP BY

-- by grouping  filter results
select *
from parks_and_recreation.employee_demographics;

select gender
from parks_and_recreation.employee_demographics
group by gender; 

select first_name 
from parks_and_recreation.employee_demographics
group by gender;            -- gives error 


-- When using GROUP BY, every column in the SELECT statement 
-- must either be included in the GROUP BY clause or 
-- used inside an aggregate function (COUNT, SUM, AVG, MIN, MAX).

select gender, AVG(age)
from employee_demographics
group by gender;

select occupation
from employee_salary
group by  occupation;   -- occupation column has same values multiple times. can group by to get unique

select occupation, salary
from employee_salary
group by  occupation, salary;   -- now unique with both columns together

select gender, AVG(age), MAX(age), MIN(age), COUNT(age)
from employee_demographics
group by gender;


-- ORDER BY

select *
from employee_demographics
ORDER BY gender;       -- sorting results by the column here mention by ascending or descending order. 
                       -- default ascending

select *
from employee_demographics
ORDER BY gender, age DESC;         -- first sorting by gender and after age by descending order


select *
from employee_demographics
ORDER BY gender DESC;          

select *
from employee_demographics
ORDER BY age ASC; 



