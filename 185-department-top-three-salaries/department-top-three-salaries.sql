SELECT d.name as Department, e.name as Employee, e.salary as Salary
FROM (
    SELECT *,
    DENSE_RANK() OVER(
        PARTITION BY departmentid
        ORDER BY salary DESC   
    ) as rnk
    FROM employee
)as e
JOIN department d
    ON e.departmentid = d.id
WHERE rnk<4

# Write your MySQL query statement below
/*SELECT d.name as Department, e.name as Employee, e.Salary
FROM employee e
JOIN department d
ON e.departmentid = d.id
WHERE 3>(SELECT COUNT(DISTINCT(e2.salary))
FROM employee e2
WHERE e2.salary>e.salary AND e.departmentid=e2.departmentid
)*/