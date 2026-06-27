-- Window Function 

select gender, AVG(salary)
from employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
group by gender;                            -- using group by - group similar result together to get answer


select gender, AVG(salary) over()           -- Window function 
from employee_demographics dem              -- calculations across a set of rows without combining them into one row.
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;


select gender, AVG(salary) over(partition by gender)   -- separate average salary gender wise
from employee_demographics dem                         -- why we use like this. separate rows same results. 
	JOIN employee_salary sal                           -- To add additional columns into it 
    ON dem.employee_id = sal.employee_id;
    
    
select dem.first_name, dem.last_name, gender, AVG(salary)
from employee_demographics dem                      -- when we do like this - use group by and other columns into resul.
	JOIN employee_salary sal                        -- can't get true result for aggregate function
    ON dem.employee_id = sal.employee_id
group by first_name, last_name, gender;    


select dem.first_name, dem.last_name, gender, AVG(salary) over(partition by gender)   
from employee_demographics dem                          -- see the results
	JOIN employee_salary sal                            -- calculates correctly
    ON dem.employee_id = sal.employee_id;  
    
    
-- another EXAMPLE 

select dem.first_name, dem.last_name, gender, 
SUM(salary) over(partition by gender)             -- gives female salary sum and male salary sum seperately
from employee_demographics dem                          
	JOIN employee_salary sal                            
    ON dem.employee_id = sal.employee_id; 
    

-- ROLLING UP TOTAL - using order by 
select dem.first_name, dem.last_name, gender, salary,
SUM(salary) over(partition by gender ORDER BY dem.employee_id) AS Rolling_Total
from employee_demographics dem                          
	JOIN employee_salary sal                            
    ON dem.employee_id = sal.employee_id;
    
    
-- SPECIAL thing only with WINDOW FUNCTION 
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender)                -- add row numbers for rows. like id and unique
from employee_demographics dem                          
	JOIN employee_salary sal                            
    ON dem.employee_id = sal.employee_id;
    
-- ROW_NUMBER FUNCTION
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender ORDER BY salary)               -- can use order by also for row num 
from employee_demographics dem                          
	JOIN employee_salary sal                            
    ON dem.employee_id = sal.employee_id;  
    
-- RANK FUNCTION
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender ORDER BY salary DESC) AS row_num,
RANK() OVER(partition by gender ORDER BY salary DESC)  AS rank_num       -- give rank. male 5 and 6 row numbers are same in rank
from employee_demographics dem                                           -- because salaries are same
	JOIN employee_salary sal                                             -- after 5 and 5, the next row 7
    ON dem.employee_id = sal.employee_id; 
    
    
-- DENSE RANK FUNCTION
select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(partition by gender ORDER BY salary DESC) AS row_num,
RANK() OVER(partition by gender ORDER BY salary DESC)  AS rank_num,
DENSE_RANK() OVER(partition by gender ORDER BY salary DESC)  AS dense_rank_num    -- after 5 and 5, next row 6    
from employee_demographics dem                                           
	JOIN employee_salary sal                                             
    ON dem.employee_id = sal.employee_id;   
    