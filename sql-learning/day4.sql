-- Day 4: SQL Practice
-- Source: LeetCode
-- Problem: Average Time of Process per Machine

-- Pattern:
-- Event pairing (Self Join + Aggregation Pattern) or window functions
--using window functions is safer and gives you best performance.
--using window functions is very good for production-grade and easy to maintain

-- Goal:
--Calculate the average processing time per machine by pairing start and end events for each process.



Table:
Input: 
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+

problem statement:

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

Approach:

1. Self join the table using "machine_id" column (all rows with same machine_id are paired (many-to-many)
2.filter using WHERE . it will filter valid start - end pairs.
3.we will group all rows with same machine_id using GROUP BY.
4. we use aggregate function to fing average using AVG. it will run on all rows of that machine.
5. we will round of the decimal to 3 using ROUND function.
6. we will retrieve the machine_id and processing_time column using SELECT

Approach if we use window fucntions:(only step 3 changes below)

using MAX + CASE + partition by:
	 Partition looks at all rows of that machine.
	MAX and CASE finds the start and end time of that machine 
	Attach them to every rows of that machine


Query using self Join and aggregation:

SELECT 
    s.machine_id, 
    ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time 
FROM Activity s
JOIN Activity e 
  ON s.machine_id = e.machine_id
WHERE s.activity_type = 'start'
  AND e.activity_type = 'end'
GROUP BY s.machine_id;


Query using window functions:

Query:
SELECT
    machine_id,
    ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM (
    SELECT
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'start' THEN timestamp END)
            OVER (PARTITION BY machine_id, process_id) AS start_time,
        MAX(CASE WHEN activity_type = 'end' THEN timestamp END)
            OVER (PARTITION BY machine_id, process_id) AS end_time
    FROM Activity
) t
GROUP BY machine_id;

In above code:
-- Important:
-- Window functions must partition by BOTH machine_id and process_id
-- Partitioning only by machine_id will pair incorrect start/end events

Which is better:
Using window fucntions is safer if we have duplicates self join is risky.

| Self Join             | Window                         |
| --------------------- | ------------------------------ |
| Explodes rows         | Keeps rows                     |
| Needs GROUP BY to fix | GROUP BY only for final output |
| Risky with duplicates | Stable                         |
| Older pattern         | Modern                         |

performance characterisitics:

| Aspect             | Self Join | Window Function |
| ------------------ | --------- | --------------- |
| Table scans        | Multiple  | Single          |
| Readability        | Medium    | High            |
| Scalability        | Medium    | High            |
| Risk of duplicates | High      | Low             |        



| Use this when →                  | **Self Join + GROUP BY** | **Window Function + GROUP BY** |
| -------------------------------- | ------------------------ | ------------------------------ |
| Data size is large               | Avoid                    | Best                           |
| Multiple start/end events exist  | No                       | Yes                            |
| Data may be dirty / inconsistent | No                       | Best                           |
| Need production-grade query      | No                       | Yes                            |
| Want safest logic                | No                       | Yes                            |
| Want best performance            | No                       | Yes                            |
| Avoid row explosion              | No                       | Yes                            |
| Real-world ETL / pipelines       | No                       | Yes                            |
| Easy to maintain                 | No                       | Yes                            |


-- Key Takeaway:
-- Window functions preserve row-level context and avoid row explosion,
-- making them safer for production ETL pipelines.


