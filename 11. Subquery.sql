-- Subqueries

select *
from employee_demographics;

select* 
from employee_salary;

select * 
from parks_departments;

-- subquery in where clause
select *
from employee_demographics
where employee_id IN (
			select employee_id
            from employee_salary
            where dept_id = 1);
            
-- subquery in select statement
select first_name, salary, 
						( select avg(salary)
						from employee_salary) AS avg_salary
from employee_salary;


-- subquery in from clause
select gender, AVG(`AVG(age)`)
from (select gender, AVG(age), MAX(age), MIN(age), COUNT(age)
	from employee_demographics
	group by gender) AS AGG_table             -- every table need to name - alias new table. 
group by gender;                              -- can create new table and can use it as a table- subqueery


select gender, AVG(max_age)
from (select gender, 
		AVG(age) AS avg_age,             -- can alias aggregate function and can use in select statement without backtick
        MAX(age) AS max_age, 
        MIN(age) AS min_age, 
        COUNT(age) AS count_age
	from employee_demographics
	group by gender) AS AGG_table              
group by gender;    
