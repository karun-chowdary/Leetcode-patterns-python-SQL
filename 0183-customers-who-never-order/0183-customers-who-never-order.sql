# Write your MySQL query statement below
SELECT name as Customers
FROM customers c
LEFT JOIN orders o
ON c.id = o.customerid
WHERE o.id is NULL