SELECT d.name as department,
e.name as Employee,
e.salary as Salary
FROM (
    SELECT *,
    DENSE_RANK() OVER(PARTITION BY departmentid ORDER BY salary DESC) as rnk
    FROM employee 
)e
JOIN department d
ON e.departmentid = d.id
WHERE rnk = 1

/*SELECT d.departmentid as Department
e.name as Employee
e.salary as Salary
FROM employee e
JOIN department d
ON e.departmentid = d.id
WHERE (e.departmentid, e.Salary) IN(
    SELECT departmentid, MAX(Salary)
    FROM employee 
    GROUP BY departmentid
) */





















