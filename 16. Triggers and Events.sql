-- Trigger and Events 

-- Trigger: Automatically executes SQL statements when a specific event
-- (INSERT, UPDATE, or DELETE) occurs on a table.


-- Example
-- if we want to add salary table , 
-- automatically need to add employee details to employee_dempgraphic table

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN 
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Hasitha', 'Weerakoon', 'Tech Lead 99X', 500000, NULL);
    
-- why use after - after insert data for salary table. insert / update
-- why use BEFORE - before delete data from salry table. like that 
-- FOR EACH ROW - trigger going to activated for each row that is inserted
-- why use NEW  - we only want new value inserted to salary table. 
-- OLD - when we use deleted or updated 

-- triggeres can see under the employee_salary table section


select *
from employee_salary;

select * 
from employee_demographics;
-- trigger affected to demographic table.


-- EVENTS

-- Event: Automatically executes a scheduled SQL task at a specified date, time,
-- or recurring interval.

select * 
from employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE 
	from employee_demographics
    where age >= 60;
END $$
DELIMITER ;   

-- In every 30 second procede a schedule to delete employee who age >= 60
-- IF not working EVENT we can chek it like this 

SHOW VARIABLES LIKE 'event%'; 





