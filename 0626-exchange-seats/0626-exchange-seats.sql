# Write your MySQL query statement below
/*SELECT
CASE
WHEN id%2 = 1 AND id<(SELECT MAX(id) FROM seat) THEN id+1
WHEN id%2 = 0 THEN id - 1
ELSE id
END AS id, student
FROM seat
ORDER BY id*/

SELECT id ,
COALESCE (CASE 
WHEN id%2=1 THEN LEAD(student) OVER (ORDER BY id)
ELSE LAG(student) OVER (ORDER BY id)
END,
 student) AS student
FROM seat

#pysaprk query
/*from pyspark.sql.window import Window

window_spec = Window.orderBy() # Empty partition = whole table
result = seat.withColumn("max_id", F.max("id").over(window_spec)) \
             .withColumn("id", 
                 F.when((F.col("id") % 2 == 1) & (F.col("id") < F.col("max_id")), F.col("id") + 1)
                  .when(F.col("id") % 2 == 0, F.col("id") - 1)
                  .otherwise(F.col("id"))
             ).drop("max_id").orderBy("id")*/