# Write your MySQL query statement below
SELECT product_name,SUM(unit) as unit
FROM products
JOIN orders ON products.product_id = orders.product_id
WHERE order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY product_name
HAVING SUM(unit)>=100

#pyspark query
/*from pyspark.sql import functions as F

result = products_df.join(orders_df, "product_id") \
    .filter(F.col("order_date").between("2020-02-01", "2020-02-29")) \
    .groupBy("product_name") \
    .agg(F.sum("unit").alias("unit")) \
    .filter(F.col("unit") >= 100)

result.show()*/
