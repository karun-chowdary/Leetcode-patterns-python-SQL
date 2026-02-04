Select 
    round(avg(order_date = customer_pref_delivery_date)*100, 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in (
  Select customer_id, min(order_date) 
  from Delivery
  group by customer_id
);-- Day 11: SQL Practice
-- Source: LeetCode
-- Problem: Immediate Food Delivery II

-- Pattern:
-- GROUP BY + Subquery, Window Function First Row pattern

-- Goal:
-- Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.



Table:
 
Input:
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+

Approach-1:

1. Group delivery table by customer_id.
2. Find first order date using MIN(order_date).
3. Subquery returns (customer_id, first_order_date).
4. Filter main table to keep only those first orders.
5. Compare order_date with customer_pref_delivery_date.
6. SUM counts immediate deliveries.
7. COUNT counts total customers.
8. Calculate percentage.



query:

SELECT
ROUND(
    100 * SUM(order_date = customer_pref_delivery_date) / COUNT(*),
    2
) AS immediate_percentage
FROM delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM delivery
    GROUP BY customer_id
);




Approach-2 :

1. Read delivery table once.
2. Partition rows by customer_id.
3. Sort by order_date.
4. Assign row number using ROW_NUMBER.
5. rn = 1 marks first order.
6. Filter only first orders.
7. Compare delivery dates.
8. AVG directly calculates percentage.

Query:

SELECT
ROUND(
    100 * AVG(order_date = customer_pref_delivery_date),
    2
) AS immediate_percentage
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM delivery
) t
WHERE rn = 1;


Performance characteristics:

| Aspect            | GROUP BY + sub query       | Window Function  |
| ----------------- | -------------------------- | -----------------|
| Table scans       | Multiple                   | Single           |  
| Sorting           | Required                   | Required         | 
| scalability       | Low                        | high             |
| Readability       | Low                        | high             | 


Key takeaways:
--GROUP BY approach is simple and traditional
--Window function approach is cleaner and more scalable


