# Write your MySQL query statement below
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product)

#PySpark Query
/*from pyspark.sql import functions as F

# 1. Get the total number of products as a scalar value
total_products_count = product.count()

# 2. Group by customer, count unique products, and filter
result = customer.groupBy("customer_id") \
    .agg(F.countDistinct("product_key").alias("distinct_products")) \
    .filter(F.col("distinct_products") == total_products_count) \
    .select("customer_id")

result.show()*/