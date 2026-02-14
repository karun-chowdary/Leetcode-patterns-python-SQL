# Write your MySQL query statement below
SELECT product_id
FROM products
WHERE low_fats='Y' AND recyclable = 'Y'

#pyspark code
/* from pyspark.sql.functions import col
results = products.filter((col("low_fats")=="Y")&(col("recyclable")=="Y"))
            .select("product_id")
results.show()*/