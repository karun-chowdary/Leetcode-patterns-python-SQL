# Write your MySQL query statement below
/*SELECT ROUND(COUNT(A2.player_id)/COUNT(DISTINCT A1.player_id),2) AS fraction
FROM activity AS A1
LEFT JOIN (
    SELECT player_id, MIN(event_date) as first_date
    FROM activity 
    GROUP BY player_id
) AS A2
ON A1.player_id = A2.player_id AND A1.event_date = DATE_ADD(A2.first_date, INTERVAL +1 Day)*/

SELECT ROUND(AVG(returned_next_day), 2) AS fraction
FROM (
    SELECT
        player_id,
        CASE 
            WHEN LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date)
                 = DATE_ADD(event_date, INTERVAL 1 DAY)
            THEN 1 ELSE 0
        END AS returned_next_day,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM activity
) t
WHERE rn = 1;

