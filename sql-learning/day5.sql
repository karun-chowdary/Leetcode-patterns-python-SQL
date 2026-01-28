-- Day 5: SQL Practice
-- Source: LeetCode
-- Problem: game-play-analysis

-- Pattern:
-- Entity aggregation pattern, Retention analysis pattern, Window-based event sequencing

--Why window functions:
-- Window functions preserve player-level context and avoid row explosion,
-- making them ideal for retention and cohort analysis in analytics pipelines.



-- Goal:
-- 1. Find out the first login date of each player.
-- 2. Calculate Day-1 retention (players who logged in exactly one day after first login)



Table:
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Approach-1 for 1:

1. Get data from the activity table.
2. Group the data by player_id using GROUP BY.
3. Within each player_id group, find the earliest login date using the MIN function on event_date.
4. Return one row per player containing their first login date.

Approach-2 for 1:
1. Read data from the activity table.
2. Use ROW_NUMBER window function partitioned by player_id and ordered by event_date.
3. ROW_NUMBER assigns a sequential number to each login event for a player without collapsing the rows
4. Filter rows where the row number is 1 to get the first login event per player.
5. Return one row per player with their first login date.
----------------------------------------------------------------------------------------------------------------

query(Approach-1):

SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id;

-------------------------------------------------------------------------------------------------------------------
query(Approach-2):

SELECT player_id, event_date AS first_login
FROM (
    SELECT player_id,
           event_date,
           ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM activity
) t
WHERE rn = 1;

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Approach-1 for 2:

1. First, get the first login date for each player by grouping data using GROUP BY on player_id and applying the MIN function on event_date.
2. This subquery creates a derived table that contains each player and their first login date.
3. Perform a LEFT JOIN between the activity table and the derived table using player_id.
4. Add an additional join condition to match only those activity records where the event_date is exactly one day after the first login date.
5. COUNT of A2.player_id gives the number of players who logged in again on the next day.
6. COUNT of DISTINCT A1.player_id gives the total number of players.
7. Divide both counts to calculate the retention fraction and round the result to two decimal places.

Approach-2 for 2:

1. Read data from the activity table.
2. Use a window function with PARTITION BY player_id to compute the first login date for each player without collapsing rows.
3. Use the LEAD window function to get the next login date for each player based on event_date order.
4. Compare the next login date with the first login date plus one day.
5. Assign value 1 if the player logged in exactly the next day, otherwise assign 0.
6. Use AVG to compute the fraction of players who returned the next day.
7. Round the final result to two decimal places.


Query(Approach 1):

SELECT ROUND(COUNT(A2.player_id)/COUNT(DISTINCT A1.player_id),2) AS fraction
FROM activity AS A1
LEFT JOIN (
    SELECT player_id, MIN(event_date) as first_date
    FROM activity 
    GROUP BY player_id
) AS A2
ON A1.player_id = A2.player_id 
AND A1.event_date = DATE_ADD(A2.first_date, INTERVAL 1 DAY);

------------------------------------------------------------------------------------------------------------------------------
Query (Approach 2):

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





Performance characteristics:

| Aspect                 | GROUP BY + MIN      | Window Function (ROW_NUMBER) |
| ---------------------- | ------------------- | ---------------------------- |
| Table scans            | Single              | Single                       |
| Sorting required       | Engine dependent    | Yes (ORDER BY in window)     |
| Memory usage           | Low                 | Medium                       |
| Execution speed        | Fast                | Slightly slower              |
| Scalability            | High                | High                         |
| Handles duplicates     | Yes                 | Yes                          |
| Row-level detail       | No (rows collapsed) | Yes                          |
| Readability            | High                | High                         |
| Production suitability | Yes                 | Yes                          |
     

Key takeaways:

--GROUP BY + LEFT JOIN works but can become costly and complex.
--Window functions are safer, cleaner, and more scalable for retention problems.


