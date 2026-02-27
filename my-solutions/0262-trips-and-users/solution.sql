# Write your MySQL query statement below
SELECT 
    request_at AS Day, 
    ROUND(SUM(status <> 'completed') / COUNT(*), 2) AS "Cancellation Rate"
FROM trips
WHERE client_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes')
  AND driver_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes')
  AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at;

#pyspark query
/*from pyspark.sql import functions as F
result = trips_df.alias("t") \
    .join(users_df.alias("c"), F.col("t.client_id") == F.col("c.users_id")) \
    .join(users_df.alias("d"), F.col("t.driver_id") == F.col("d.users_id")) \
    .filter((F.col("c.banned") == 'No') & (F.col("d.banned") == 'No')) \
    .groupBy("request_at") \
    .agg(
        F.round(F.mean((F.col("status") != 'completed').cast("integer")), 2).alias("Cancellation Rate")
    )*/
