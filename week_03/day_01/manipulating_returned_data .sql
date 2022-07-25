-- Manipulating returned data 
-- specifying column alisases using AS
-- using DISTINCT() function
--aggregate functions
--sort records
-- limit number of records returned 

--manipulating data returned by alterign SELECT 
SELECT 
id ,
first_name ,
last_name 
FROM employees 
WHERE department = 'Accounting';

SELECT 
first_name,
last_name,
concat(first_name, ' ', last_name) AS full_name
FROM employees;

-- filter out rows wothout first and last name 

SELECT 
first_name,
last_name,
concat(first_name, ' ', last_name) AS full_name
FROM employees
WHERE (first_name IS NOT NULL) AND (last_name IS NOT NULL);

--Distinct()
-- check number of departments in data

SELECT DISTINCT (department)
FROM employees ;

-- aggregate functions 
-- how many employees started in 2001

SELECT 
count(*) AS started_in_2001
FROM employees 
WHERE start_date BETWEEN '2001-01-01' AND '2001-12-31';

--other aggregate functions
--SUM()
--AVG()
--MIN()
--MAX()

SELECT 
max(salary) AS max_salary,
min(salary) AS min_salary 
FROM employees;

SELECT 
avg(salary) AS avg_salary
FROM employees 
WHERE (department = 'Human Resources');

SELECT 
sum(salary) AS total_salary
FROM employees 
WHERE start_date BETWEEN '2018-01-01' AND '2018-12-31';

-- ORDER BY sorts query return ascending or descending - comes after where 


-- finding lowest earning employee
SELECT *
FROM employees 
WHERE salary IS NOT NULL 
ORDER BY salary ASC 
LIMIT 1;

-- limits restricts no. of results 
SELECT *
FROM employees 
WHERE salary IS NOT NULL 
ORDER BY salary DESC NULLS LAST  
LIMIT 1;

-- NULLS LAST puts nulls at the end of order

-- multi-level sorting
-- employee details by full time hours (high-low) & alphabetically by last name 

SELECT *
FROM employees 
ORDER BY
fte_hours DESC NULLS LAST,
last_name ASC NULLS LAST ;

SELECT *
FROM employees 
ORDER BY
start_date ASC NULLS LAST 
LIMIT 1;

SELECT *
FROM employees 
WHERE country = 'Libya'
ORDER BY 
salary DESC NULLS LAST 
LIMIT 1;

-- ties can happen when ordering which would be an issue if you put a limit of 1 on the return 
-- need to write two chunks to find these ties 

SELECT
country 
FROM employees 
ORDER BY country
LIMIT 1;

SELECT *
FROM employees
WHERE country = 'Afghanistan';

SELECT 
id,
first_name,
last_name,
concat(first_name, ' ', last_name) AS full_name
FROM employees 
WHERE concat(first_name, ' ', last_name) LIKE 'A%';








































