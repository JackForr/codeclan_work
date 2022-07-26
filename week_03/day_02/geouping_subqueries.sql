-- no of employees in each department 
SELECT 
count(id) AS num_employees, 
department  
FROM employees 
GROUP BY department -- anything IN the GROUP BY must be IN SELECT
ORDER BY count(id);

-- no of employees in each country and department 
SELECT 
count(id) AS num_employees,
country,
department 
FROM employees 
GROUP BY country, department 
ORDER BY count(id) ;

--how many employees in each department work either 0.25 or 0.5v fte_hours

SELECT 
count(id), 
fte_hours
FROM employees 
WHERE fte_hours IN (0.25, 0.5)
GROUP BY fte_hours 

-- see how null effects counts

SELECT
count(id),
count(first_name), -- count does NOT INCLUDE NULLS 
count(*)
FROM employees 

-- find longest serving employee in each department 
SELECT 
department,
first_name,
last_name,
ROUND (EXTRACT (DAY FROM NOW()-MIN(start_date))/365) AS time_served
FROM employees 
GROUP BY department, first_name, last_name 
ORDER BY department, time_served DESC NULLS LAST ;

-- "How many employees in each department are enrolled in the pension scheme?"

SELECT 
count(id) AS pension_employees,
department,
pension_enrol
FROM employees 
WHERE pension_enrol = TRUE 
GROUP BY department, pension_enrol ;


-- "Perform a breakdown by country of the number of employees that do not have a stored first name."

SELECT 
count(id),
country
FROM employees 
WHERE first_name IS NULL
GROUP BY country ;

-- departments wher at least 40 eployees work either 0.25 or 0.5 fte hours

SELECT 
count(id),
department 
FROM employees 
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY department 
HAVING count(id) >= 40; -- the equivalent OF "where" but FOR GROUPS 

-- countries where min salary of a  pension eroled employee < 21, 000

SELECT
country,
min(salary)
FROM employees 
WHERE pension_enrol = TRUE 
--AND salary < 21000
GROUP BY country 
HAVING min(salary) < 21000 -- this METHOD removes dupicates IF present
ORDER BY min(salary);

--  show departments where earliest start date amongst grade 1 employees us prior to 1991

SELECT 
department,
min(start_date)
FROM employees 
WHERE grade = 1
GROUP BY department 
HAVING min(start_date) < '1991-01-01'

-- find all the emplyees in legal dep. who earn over the company wide avg salrary 

SELECT *
FROM employees 
WHERE department = 'Legal'
AND salary < (
				SELECT
				avg (salary)
				FROM employees
				WHERE department = 'Legal'
				);

-- find all employees in legal who earn less than the average legal salary
			
SELECT
count(id),
country,
salary
FROM employees 
WHERE department ='Legal'
AND salary < ( SELECT avg(salary) FROM employees 
			   WHERE department = 'Legal')
GROUP BY country, salary 
ORDER BY salary, country ;













