-- Use a CTE (a Common Table Expression) and a SUM() function in the SELECT 
-- statement in a query to find out how many male employees have never signed a contract 
-- with a salary value higher than or equal to the all-time company salary average.

WITH cte AS (

SELECT AVG(salary) AS avg_salary FROM salaries

)

SELECT

SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,

COUNT(s.salary) AS no_of_salary_contracts

FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

-- Use two common table expressions and a SUM() function in the SELECT statement 
-- of a query to obtain the number of male employees whose highest salaries have been below the all-time average.
WITH cte1 AS (

SELECT AVG(salary) AS avg_salary FROM salaries

),

cte2 AS (

SELECT s.emp_no, MAX(s.salary) AS max_salary

FROM salaries s

JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'

GROUP BY s.emp_no

)

SELECT

SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_salaries_below_avg

FROM employees e

JOIN cte2 c2 ON c2.emp_no = e.emp_no

JOIN cte1 c1;

