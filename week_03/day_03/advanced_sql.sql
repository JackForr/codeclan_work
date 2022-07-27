-- advanced SQL topics
-- creating functions (dependant on database permissions)



--1. use the keyword CREATE [OR REPLACE] to start definign your function
--2. giving your fucntion a name = percent_change
--3. specify argyments of ypur function and their data types
--4. specify the datatype of the result
--5. write the code for the fucntion
--6. specify language 
--7. immutabel means cannot be changed 

CREATE OR REPLACE FUNCTION 
percent_change(new_value NUMERIC, old_value NUMERIC, decimals INT DEFAULT 2)
RETURNS NUMERIC AS 
    'SELECT ROUND(100 * (new_value - old_value) / old_value, decimals);'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

percent_change <- FUNCTION(new_value - old_value, decimals = 2)


SELECT ROUND(100 * (50 - 40) / 40, 2)

SELECT 
percent_change(50, 40),
percent_change(100, 99, 4);

-- percentage change of salary of legal employees after pay rise 
SELECT 
id,
first_name,
last_name,
salary,
salary + 100 AS new_salary,
percent_change(salary + 1000, salary, 2)
FROM employees 
WHERE department = 'Legal'
ORDER BY percent_change DESC NULLS LAST  ;

SELECT 
make_badge(first_name, last_name, department) AS badge
FROM employees;

-- investigating query performance 
-- fetch table of department average salaries for employees in selected countries
EXPLAIN ANALYSE
SELECT 
department, 
avg(salary)
FROM employees 
WHERE country IN ('Germany', 'France', 'Italy', 'Spain')
GROUP BY department 
ORDER BY avg(salary);

-- how could we speed up this query?
--using index columns - they provide a quick way of finding rows using the index column

--search phonebook
--1. start at the start and go through each page until you find "David Currie" (sequential scan)
--2. use index notice that surname starts with a C, go directly to C (index scan)

-- use employees indexed (by country)
EXPLAIN ANALYZE 
SELECT 
department, 
avg(salary)
FROM employees_indexed
WHERE country IN ('France', 'Germany', 'Italy', 'Spain')
GROUP BY department
ORDER BY avg(salary);

-- common table expressions
	-- create temporary tables before the start of our query and access like a databse table

-- find all employees in the legal department who earned less than mean salary of that department 

SELECT
FROM 
WHERE 
GROUP 
HAVING
ORDER 
LIMIT 

SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < 
(SELECT avg(salary) 
FROM employees 
WHERE department = 'Legal');

--common tables allow you to specify this tmep table in our subquery as a table in the database

WITH dep_average AS (
SELECT avg(salary) AS avg_salary 
FROM employees 
WHERE department = 'Legal'
)
SELECT *
FROM employees
WHERE department = 'Legal' AND salary < (
SELECT avg_salary
FROM dep_average);

-- find all the employees in 'Legal' who earn less than the mean salary and work fewer than mean fte_hours
-- 1. find the mean salary
-- 2. find the mean fte hours
-- 3. plug into WHERE

-- subquery solution 
SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < (
	SELECT avg(salary)
	FROM employees
	WHERE department = 'Legal'
) AND fte_hours < (
	SELECT avg(fte_hours)
	FROM employees
	WHERE department = 'Legal');

-- common table solution
WITH dep_averages AS (
	SELECT
		avg(salary) AS avg_salary,
		avg(fte_hours) AS avg_fte
	FROM employees
	WHERE department = 'Legal'
	)
	SELECT *
	FROM employees
	WHERE department = 'Legal' AND salary < (
		SELECT avg_salary
		FROM dep_averages
	) AND fte_hours < (
		SELECT avg_fte
		FROM dep_averages
	);

-- table with each employees first name, last name, department, country, salary and a comparison of their
-- vs that of the country and department and country they work in 
-- salary / dep avg
-- salary / country avg

-- 1. find avg salary for departments
-- 2. country avg
-- 3. joins
-- 4. use avg values to calculate employee ratios 

WITH dep_avgs AS (
	SELECT 
		department, 
		avg(salary) AS avg_salary_department
FROM employees 
GROUP BY department
),
country_avgs AS (
	SELECT 
		country,
		avg(salary) AS avg_salary_country
FROM employees 
GROUP BY country
)
SELECT 	
	E.first_name,
	E.last_name ,
	E.department ,
	E.country ,
	E.salary ,
	round(E.salary / dep_a.avg_salary_department, 2),
	round(E. salary / c_a.avg_salary_country, 2)
FROM employees AS E 
INNER JOIN dep_avgs AS dep_a
ON E.department = dep_a.department
INNER JOIN country_avgs AS c_a 
ON E.country = c_a.country;

-- window functions

-- show for each employee their salary together with minimum and maximum salries in their department

-- window function (OVER) method
SELECT
	first_name,
	last_name,
	salary ,
	min(salary) OVER (PARTITION BY department),
	max(salary) OVER (PARTITION BY department)
FROM employees;

--common tables method
WITH dep_avgs AS (
SELECT 
	department,
	min(salary) AS min_salary,
	max(salary) AS max_salary
FROM employees 
GROUP BY department 
)
SELECT 
	e.first_name ,
	e.last_name ,
	e.salary ,
	e.department ,
	dep_a.min_salary ,
	dep_a.max_salary
FROM employees AS e
INNER JOIN dep_avgs AS dep_a
ON e.department = dep_a.department;













































