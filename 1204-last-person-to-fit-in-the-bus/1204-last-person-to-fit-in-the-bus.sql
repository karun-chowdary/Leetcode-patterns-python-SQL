# Write your MySQL query statement below
/*SELECT person_name 
FROM (SELECT person_name, weight, turn, SUM(weight) over(ORDER BY turn) as cum_sum
FROM queue) x
WHERE cum_sum <=1000
ORDER BY turn DESC 
LIMIT 1*/

SELECT q1.person_name
FROM queue q1
WHERE (
    SELECT SUM(q2.weight)
    FROM queue q2
    WHERE q2.turn <= q1.turn
) <= 1000
ORDER BY q1.turn DESC
LIMIT 1;

#pyspark code
/*SELECT person_name
FROM (
    SELECT person_name, 
           SUM(weight) OVER(ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total
    FROM queue
) t
WHERE running_total <= 1000
ORDER BY running_total DESC
LIMIT 1;*/