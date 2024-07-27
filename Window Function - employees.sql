-- Write a query that upon execution, 
-- assigns a row number to all managers we have information for in the "employees" database (regardless of their department).
-- Let the numbering disregard the department the managers have worked in. 
-- Also, let it start from the value of 1. Assign that value to the manager with the lowest employee number.

SELECT
emp_no,
dept_no,
ROW_NUMBER()OVER(ORDER BY emp_no)AS row_num	
FROM
dept_manager;

-- Write a query that upon execution, assigns a sequential number for each employee
 -- number registered in the "employees" table. Partition the data by the 
 -- employee's first name and order it by their last name in ascending order (for each partition).
 
 SELECT

emp_no,

first_name,

last_name,

ROW_NUMBER() OVER (PARTITION BY first_name ORDER BY last_name) AS row_num

FROM

employees;

SELECT

dm.emp_no,

    salary,

    ROW_NUMBER() OVER () AS row_num1,

    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num2

FROM

dept_manager dm

    JOIN 

    salaries s ON dm.emp_no = s.emp_no

ORDER BY row_num1, emp_no, salary ASC;

-- lowest salary value each employee has ever signed a contract for. 
SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

GROUP BY emp_no;

-- Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
SELECT

emp_no,

salary,

ROW_NUMBER() OVER w AS row_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Write a query that upon execution, displays the number of salary contracts that each manager has ever signed while working in the company

SELECT

    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts

FROM

    dept_manager dm

        JOIN

    salaries s ON dm.emp_no = s.emp_no

GROUP BY emp_no

ORDER BY emp_no;

