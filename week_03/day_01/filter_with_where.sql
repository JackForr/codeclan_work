SELECT*
FROM employees
WHERE id = 3

SELECT *
FROM employees 
WHERE fte_hours >= 0.5;

SELECT *
FROM employees 
WHERE country != 'Brazil';

-- AND and OR

SELECT *
FROM employees 
WHERE country = 'China' AND start_date >= '2019-01-01'
AND start_date <= '2019-12-31';

-- be wary of the order of evaluation

SELECT *
FROM employees 
WHERE country = 'China' AND (start_date >= '2019-01-01'
OR pension_enrol = TRUE);

--BETWEEN, NOT & IN

SELECT *
FROM employees 
WHERE fte_hours BETWEEN 0.25 AND 0.5;

SELECT *
FROM employees 
WHERE start_date NOT BETWEEN '2017-01-01' AND '2017-12-31';

SELECT *
FROM employees 
WHERE country IN ('Spain', 'South Africa', 'Ireland', 'Germany');

SELECT *
FROM employees 
WHERE (start_date BETWEEN '2016-01-01' AND '2016-12-31')
AND (fte_hours >= 0.50);

-- LIKE, wildcards & regex

SELECT *
FROM employees 
WHERE (country = 'Greece') AND (last_name LIKE 'Mc%');

SELECT *
FROM employees 
WHERE last_name LIKE '%ere%';

SELECT *
FROM employees 
WHERE last_name LIKE 'D%';

-- ILIKE makes LIKE insensitive to case  
SELECT *
FROM employees 
WHERE last_name ILIKE 'D%';

-- ~ to define a regex pattern match 
-- employees with second letter fo last name r or s and third letter a or o
SELECT *
FROM employees
WHERE last_name ~ '^.[rs][ao]';

-- pattern building similar to R 

SELECT *
FROM employees
WHERE last_name !~ '^.[rs][ao]';

-- opposite of a regex with "!"

-- NULL & IS NULL

 SELECT *
 FROM employees 
 WHERE email IS NULL 

-- detects NULL values in the data 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 









































