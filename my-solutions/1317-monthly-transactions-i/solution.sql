# Write your MySQL query statement below
SELECT LEFT(trans_date,7) as month,
country,
COUNT(id) as trans_count,
SUM(state = "approved") as approved_count,
SUM(amount) as trans_total_amount,
SUM((state = "approved")* amount) as approved_total_amount
FROM transactions
GROUP BY month, country

#pyspark query
/* from pyspark.sql import functions as F
results = transactions.groupBy(F.substring(trans_date,1,7).alias("month"), country)
.agg(
    F.count(id).alias("trans_count"),
    F.sum(F.when(F.col('state')=="approved"),1).otherwise(0).alias('approved_count'),
    F.sum(F.col("amount").alias('trans_total_amount'),
    F.sum(F.when(F.col('state')=='approved',F.col('amount')),1).otherwise(0)).alias('approved_total_amount')
)*/
