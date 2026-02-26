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