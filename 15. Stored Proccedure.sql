-- Stored Procedure 
-- A Stored Procedure is a saved collection of SQL statements that is stored in the database and can be executed whenever needed.

-- create stored procedure
CREATE PROCEDURE large_salary()      
select *
from employee_salary
where salary > 50000;             -- procedure created 

CALL large_salary();              -- call to procedure

-- need to store multiple quereis in one procedure

CREATE PROCEDURE large_salary2()     -- in this way below query run alone not with large_salary2 
select *
from employee_salary
where salary > 50000;                -- here ; <- is delimeter, separate the queries.
select *
from employee_salary
where salary > 10000; 


DROP PROCEDURE IF EXISTS large_salary3;
DELIMITER $$             
CREATE PROCEDURE large_salary3() 
BEGIN    
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;      
    
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$                
DELIMITER ;  

-- WE change the default delimiter to $$
-- need to mention end of the query using new delimiter
-- again change the delimiter to default one          

CALL large_salary3();       -- when execute we can get two outputs


-- use parameters
DROP PROCEDURE IF EXISTS large_salary4;
DELIMITER $$          
CREATE PROCEDURE large_salary4(param_emp_id INT) 
BEGIN    
	SELECT salary
	FROM employee_salary
    where employee_id = param_emp_id;
END $$                
DELIMITER ;      

call large_salary4(1);

-- can create procedure to use specific output




