-- Day 6: SQL Practice
-- Source: LeetCode
-- Problem: Customer Placing the Largest Number of Orders

-- Pattern:
-- Aggregation with sorting pattern, window functions

 When to use Window Functions here:
-- 1. When ties must be handled correctly
-- 2. When analytics logic needs to return multiple top results
-- 3. When extending logic to Top-N analysis



-- Goal:
-- Find the customer_number that placed the highest number of orders.



Table:
 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+

Approach-1:

1. Get data from the orders table.
2. Group the data by customer_number using GROUP BY.
3. Count the number of orders for each customer using COUNT(order_number).
4. Sort the grouped result in descending order based on the order count.
5. Use LIMIT 1 to return only the customer with the highest number of orders.

-- Limitation: ORDER BY + LIMIT returns only one row and does not handle ties deterministically.


query:

SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1;



Approach-2 :

1. Read data from the orders table.
2. Group the data by customer_number using GROUP BY.
3. Count the number of orders for each customer using COUNT(order_number).
4. Use the DENSE_RANK window function to rank customers based on their order count in descending order.
5. DENSE_RANK assigns rank 1 to the customer or customers with the highest number of orders.
6. Create a derived table that contains customer_number, order count, and rank.
7. Filter the result using WHERE rnk = 1 to return only the top customer or customers.

Query:

SELECT customer_number
FROM (
    SELECT customer_number,
           COUNT(order_number) AS cnt,
           DENSE_RANK() OVER (ORDER BY COUNT(order_number) DESC) AS rnk
    FROM orders
    GROUP BY customer_number
) t
WHERE rnk = 1;


Performance characteristics:

| Aspect            | Query 1 (ORDER BY + LIMIT) | Query 2 (Window Function) |
| ----------------- | -------------------------- | ------------------------- |
| Table scans       | Single                     | Single                    |
| Sorting           | Required                   | Required                  |
| Extra computation | No                         | Yes (ranking)             |
| Memory usage      | Low                        | Medium                    |
| Execution speed   | Faster                     | Slightly                  |

Key Takeaways:
-- Window functions are preferred when deterministic results are required,
-- especially when multiple customers can share the same maximum value.



