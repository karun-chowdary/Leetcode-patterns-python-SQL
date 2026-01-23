query:
Write a solution to find employees who have the highest salary in each of the departments.

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+

Logic:
We can use group+subquery or windows function

Pattern: Group + sub query pattern

Code :

"SELECT d.name as Department,e.name as Employee, e.salary as Salary
FROM employee e
JOIN department d
ON d.id = e.departmentid
WHERE (e.departmentid, e.salary) IN
(SELECT departmentid, MAX(Salary)
FROM employee
GROUP BY departmentid)"

How it runs:
sub-query returns maxmimum salary in department
other query filters employees that match sub-query result.
it will handles auotmatically.

Alternate method using window function:

code:

SELECT d.name as Department,
        e.name as Employee,
        e.salary as Salary
    FROM(SELECT *,
        DENSE_RANK() OVER(
            PARTITION BY departmentid
            ORDER BY salary DESC
        ) as rank
        FROM employee
    ) as e
JOIN department d
ON e.departmentid = d.id
WHERE rank = 1


How it runs:

Using pattern Window_functions
when window_function is runs in code it will in order as below:
	Split data by department
	Sort salaries within department
	Assign rank from 1.
Dense_rank will give same rank to same salary in respective department.
No rows are removed or added.
Rank is just added.
Now database will see this new table  as tempoary table named as "e".
Next we will join department table with temporary table "e".
then where will apply to rank = 1
window functions annotate and then filter.


Comparison of both

| Aspect                   | GROUP BY + Subquery | Window Function |
| ------------------------ | ------------------- | --------------- |
| Rows reduced             | Yes                 | No              |
| Readability              | Medium              | High            |
| Handles ties             | Yes                 | Yes             |
| Top-N per group          | Hard                | Easy            |
| Performance (large data) | Medium              | Better          |
| Modern SQL               | Older style         | Preferred       |

Use GROUP BY + Subquery:
	When DB does not support window functions
	For simple MAX/MIN per group

Use Window Functions:
	For Top-N per group
	Ranking problems
	Large datasets
	Cleaner and flexible logic


| GROUP BY        | WINDOW FUNCTIONS|
| --------------- | ------------ |
| Collapses rows  | Keeps rows   |
| Needs join-back | No join-back |
| Hard for Top-N  | Easy         |
| Older style     | Modern SQL   |




