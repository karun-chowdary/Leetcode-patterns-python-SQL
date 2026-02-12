# Write your MySQL query statement below
SELECT name as Customers
FROM customers c
LEFT JOIN orders o
ON c.id = o.customerid
WHERE o.id is NULL

#pyspark code
/* customers_with_no_order = customers.join(
    orders, 
    customers.id == orders.id,
    "left anti").select(customers.name.alias("Customers"))
    customer_with_no_order.show()*/

#SQL-style left join
/* customers_with_no_order = customers.alias('c').join(
    orders.alias('o'),
    col("c.id") == col("o.id"),
    "left"
)..filter(col('o.id').isNULL())
.select(col('c.name').alias("Customers"))*/