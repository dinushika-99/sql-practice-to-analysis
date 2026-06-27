-- Case Statement

select first_name, last_name, age,
	case  
		when age <= 30 then 'Young'
        when age between 31 and 50 then 'Old'
        when age >= 51 then 'Very old'
	end
from employee_demographics;

select *
from employee_salary;

select * 
from parks_departments;

-- salary < 50000 = 5% 
-- salary > 50000 = 7%
-- finance = 10% bonus 

select first_name, last_name, salary, 
	case
		when salary < 50000 then concat(salary * 105 / 100)
        when salary > 50000 then concat(salary * 107 / 100)
	end AS new_salary,
	case 
		when dept_id = 6 then salary * 0.1 
    end AS Bonus
from employee_salary;


 
