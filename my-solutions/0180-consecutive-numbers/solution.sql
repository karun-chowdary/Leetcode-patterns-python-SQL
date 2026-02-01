# Write your MySQL query statement below
/*SELECT DISTINCT num as ConsecutiveNums
FROM(
    SELECT id,
    LAG(num) OVER(ORDER BY id) As Prevnum,
    num,
    LEAD(num) OVER(ORDER BY id) As Nextnum
    FROM logs
) t
WHERE num = Prevnum AND num = Nextnum

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM logs l1
JOIN logs l2 ON l1.id = l2.id+1
JOIN logs l3 ON l1.id = l3.id+2
WHERE l1.num = l2.num AND l1.num = l3.num*/

SELECT DISTINCT num As ConsecutiveNums
FROM (
SELECT num,
id - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
FROM logs
) t
GROUP BY num, grp
HAVING COUNT(*) >= 3;
