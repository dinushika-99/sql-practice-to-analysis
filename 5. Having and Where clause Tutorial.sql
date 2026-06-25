-- HAVING AND WHERE CALAUSE 

-- where clause can't use aggregate functions to filter 

select gender, AVG(age)
from parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

select occupation, AVG(salary)
from parks_and_recreation.employee_salary
where occupation LIKE '%Manager%'          -- filter by row level
group by occupation 
HAVING AVG(salary) > 75000;                -- filter by aggregate function level

-- HAVING run after the GROUP BY clause. 
-- WHERE clause can't run aggregate functions
-- after GROUP BY clause HAVING clause can filter by aggregate funtion level

