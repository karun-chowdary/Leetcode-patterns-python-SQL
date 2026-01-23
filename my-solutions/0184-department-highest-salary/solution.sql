/*SELECT d.name as Department,e.name as Employee, e.salary as Salary
FROM employee e
JOIN department d
ON d.id = e.departmentid
WHERE (e.departmentid, e.salary) IN
(SELECT departmentid, MAX(Salary)
FROM employee
GROUP BY departmentid)*/

SELECT d.name as Department,
        e.name as Employee,
        e.salary as Salary
    FROM(SELECT *,
        DENSE_RANK() OVER(
            PARTITION BY departmentid
            ORDER BY salary DESC
        ) as rnk
        FROM employee
    ) as e
JOIN department d
ON e.departmentid = d.id
WHERE rnk = 1

