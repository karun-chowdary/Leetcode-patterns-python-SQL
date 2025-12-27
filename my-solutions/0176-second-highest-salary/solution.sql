# Write your MySQL query statement below
#SELECT distinct max(salary) as SecondHighestSalary
#FROM employee 
#WHERE salary<(SELECT max(salary) FROM employee)

SELECT MAX(salary) as SecondHighestSalary
FROM (
    SELECT salary , DENSE_RANK() OVER(ORDER BY salary DESC) as rnk
    FROM employee
)t
where rnk = 2
