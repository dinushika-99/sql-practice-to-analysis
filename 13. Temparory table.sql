-- TEMPORARY TABLE
-- Can be reused in multiple queries.

-- first method to create temp table. Created using CREATE TABLE or SELECT INTO.
CREATE TEMPORARY TABLE temp_table   -- only create temporary
(first_name varchar(50),            -- can create like normal table
last_name varchar(50),
favorite_movie varchar(50)
);

select *
from temp_table;

insert into temp_table 
values( 'Dinushika', 'Weerakoon', 'Last Ship');


-- second method to create temp table
select * 
from employee_salary;

create temporary table salary_over_50k  -- temp table works in another tab after execution 
select *                                -- after close and open the mysql, temp table not working
from employee_salary
where salary >= 50000;

select *
from salary_over_50k;