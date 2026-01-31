# Write your MySQL query statement below
/*SELECT e1.name
FROM employee e1
JOIN employee e2
ON e1.id = e2.managerid
GROUP BY e1.id, e1.name
HAVING COUNT(*) >= 5;*/

SELECT name
FROM (
    SELECT
        e1.id,
        e1.name,
        COUNT(e2.id) OVER (PARTITION BY e1.id) AS emp_count
    FROM employee e1
    LEFT JOIN employee e2
        ON e1.id = e2.managerid
) t
GROUP BY id, name, emp_count
HAVING emp_count >= 5;

