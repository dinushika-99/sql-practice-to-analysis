-- JOIN
select *
from employee_demographics;

select *
from employee_salary;

-- INNER JOIN
select dem.first_name, age, gender
from employee_demographics AS dem 
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
-- OUTER JOIN
-- LEFT OUTER JOIN
select *
from employee_demographics AS dem           -- left table - employee_demographics 
LEFT JOIN employee_salary AS sal           -- right table - employee_salary
	ON dem.employee_id = sal.employee_id;
-- The right table will be matched with all rows in the left table.

select *
from employee_demographics AS dem           -- left table - employee_demographics 
RIGHT JOIN employee_salary AS sal           -- right table - employee_salary
	ON dem.employee_id = sal.employee_id;
-- left table will be fit with all the rows of right table. 
-- add null for left table id 2 


-- SELF JOIN 
-- tie the table wiht itself

select emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa, 
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name, 
emp2.first_name AS first_name_emp, 
emp2.last_name AS last_name_emp
from employee_salary AS emp1
JOIN employee_salary AS emp2
    ON emp1.employee_id + 1 = emp2.employee_id;


-- JOIN MULTIPLE TABLES

select *
from employee_demographics AS dem 
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;
    




    