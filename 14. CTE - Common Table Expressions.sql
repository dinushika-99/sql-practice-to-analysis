-- CTEs - Common Table Expressions
-- temporary table that exists only while the query runs.
-- with <CTE name> AS (
-- );                  -- syntax of CTE

SELECT *                        -- Using subquery. not CTE
FROM employee_salary
WHERE salary >
(
    SELECT AVG(salary)
    FROM employee_salary
);


WITH avg_salary AS                  -- need to run both together or right after CTE. 
(                                   -- otherwise CTE will not work
    SELECT AVG(salary) AS avg_sal
    FROM employee_salary
)
SELECT *                              -- only run this after while, will not work
FROM employee_salary, avg_salary      -- CTE is not a permanat table, view - it's temperary 
WHERE salary > avg_sal;


-- Multiple CTEs
WITH CTE_example AS(
select employee_id, first_name, last_name, salary
from employee_salary
where salary > 50000
),
CTE_example2 AS
(
select employee_id, gender, age
from employee_demographics
where age > 40
)
select *            -- we can create multiple CTEs and join them like tables
from CTE_example    -- can take out our output
JOIN CTE_example2 
	ON CTE_example.employee_id = CTE_example2.employee_id;


WITH CTE_Example( Gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS    -- can rename them here - overwrite column names
(
select gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
from employee_demographics dem
join employee_salary sal
	ON dem.employee_id = sal.employee_id
group by gender 
)
select * 
from CTE_Example;




