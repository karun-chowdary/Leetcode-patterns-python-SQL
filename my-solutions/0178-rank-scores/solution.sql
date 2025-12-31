# Write your MySQL query statement below
SELECT score, DENSE_RANK() OVER(ORDER BY score DESC) as "rank" FROM scores
/*FROM(
    SELECT salary
    RANK() OVER(ORDER BY score DESC) as "rank"
    FROM scores
) t
order by salary desc*/
