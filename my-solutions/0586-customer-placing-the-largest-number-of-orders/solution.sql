# Write your MySQL query statement below
/*SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY count(order_number) DESC
LIMIT 1*/

SELECT customer_number
FROM (
    SELECT customer_number,
           COUNT(order_number) AS cnt,
           DENSE_RANK() OVER (ORDER BY COUNT(order_number) DESC) AS rnk
    FROM orders
    GROUP BY customer_number
) t
WHERE rnk = 1;

