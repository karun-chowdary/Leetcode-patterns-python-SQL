-- Day 9: SQL Practice
-- Source: LeetCode
-- Problem: Consecutive Numbers

-- Pattern:
-- Self Join alignment pattern, Neighbor comparison pattern(window functions), Gaps and Islands pattern

When to use:
-- Self Join: simple interview logic only
-- LAG/LEAD: small fixed window comparisons (2–3 neighbors)
-- Gaps & Islands: scalable solution for long or variable sequences



-- Goal:
-- Find all numbers that appear at least three times consecutively.



Table:
 
Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+

Approach-1:

1. Join table with itself 3 times
2. Align rows consecutively (id, id+1, id+2)
3. Compare numbers
4. Return matching ones



query:

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM logs l1
JOIN logs l2 ON l2.id = l1.id + 1
JOIN logs l3 ON l3.id = l1.id + 2
WHERE l1.num = l2.num AND l1.num = l3.num



Approach-2 :

1. Read logs table ordered by id.
Use window functions:
2. LAG(num) Gets previous row’s number
3. LEAD(num) Gets next row’s number
4. Now each row has: id | Prevnum | num | Nextnum
5. filter where columns Prevnum, num, Nextnum matches
6. removing duplicates using DISTINCT

Query:

SELECT DISTINCT num as ConsecutiveNums
FROM(
    SELECT id,
    LAG(num) OVER(ORDER BY id) As Prevnum,
    num,
    LEAD(num) OVER(ORDER BY id) As Nextnum
    FROM logs) t
WHERE num = Prevnum AND num = Nextnum

Approach -3:

1. Group consecutive sequences using id - row_number trick
2. Count group size
3. Return groups with size >= 3

Query:
SELECT DISTINCT num As ConsecutiveNums
FROM (
SELECT num,
id - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
FROM logs
) t
GROUP BY num, grp
HAVING COUNT(*) >= 3;



Performance characteristics:

| Aspect            | Self Join                  | Window Function  |  Gaps and island pattern(using ROW_NUMBER()) 
| ----------------- | -------------------------- | -----------------|-------------------------------------------------
| Table scans       | Multiple                   | Single           |    single   
| Sorting           | No                         | Required         |    Required
| scalability       | Low                        | high             |    High
| Readability       | Low                        | high             |    Medium


Key takeaways:
--If only 2–3 neighbors → use LAG/LEAD
--If many consecutive sequences → use Gaps and Islands
--Avoid self joins unless necessary


