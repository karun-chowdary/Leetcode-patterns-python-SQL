# Write your MySQL query statement below
/*SELECT
CASE
WHEN id%2 = 1 AND id<(SELECT MAX(id) FROM seat) THEN id+1
WHEN id%2 = 0 THEN id - 1
ELSE id
END AS id, student
FROM seat
ORDER BY id*/

SELECT id ,
COALESCE (CASE 
WHEN id%2=1 THEN LEAD(student) OVER (ORDER BY id)
ELSE LAG(student) OVER (ORDER BY id)
END,
 student) AS student
FROM seat

/*SELECT 
CASE WHEN id%2=0  THEN id-1
WHEN (id%2=1 AND id!=(SELECT COUNT(*) FROM seat)) THEN id+1
ELSE id
END as id, student
FROM seat
ORDER BY id*/