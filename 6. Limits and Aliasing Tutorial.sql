-- LIMITS and ALIASING

-- limits - how many rows need to see in output

select *
from parks_and_recreation.employee_demographics
LIMIT 3;

select *
from parks_and_recreation.employee_demographics
ORDER BY age DESC                   -- first make order and take first 3 rows
LIMIT 3;

select *
from parks_and_recreation.employee_demographics
ORDER BY age DESC                
LIMIT 3, 1;                       -- after selecting 3 rows, one means the next row .(if limit 4, the 4 th row )


-- ALIASING - change the name of the column

select gender, avg(age) AS avg_age            -- can add a name for new column
from parks_and_recreation.employee_demographics
group by gender
having avg_age > 40    -- can use new column names for new querring




