SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)

#pyspark query
/*from pyspark.sql import functions as F
from pyspark.sql.window import Window
window_tiv = Window.partitionBy("tiv_2015")
window_loc = Window.partitionBy("lat", "lon")

insurance_with_counts = insurance_df.withColumn(
    "tiv_count", F.count("*").over(window_tiv)
).withColumn(
    "loc_count", F.count("*").over(window_loc)
)

result = insurance_with_counts.filter(
    (F.col("tiv_count") > 1) & (F.col("loc_count") == 1)
).agg(
    F.round(F.sum("tiv_2016"), 2).alias("tiv_2016")
)

result.show()*/
