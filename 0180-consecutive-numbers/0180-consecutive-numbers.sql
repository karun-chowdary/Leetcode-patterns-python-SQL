# Write your MySQL query statement below
/*SELECT DISTINCT num as ConsecutiveNums
FROM(
    SELECT id,
    LAG(num) OVER(ORDER BY id) As Prevnum,
    num,
    LEAD(num) OVER(ORDER BY id) As Nextnum
    FROM logs
) t
WHERE num = Prevnum AND num = Nextnum

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM logs l1
JOIN logs l2 ON l1.id = l2.id+1
JOIN logs l3 ON l1.id = l3.id+2
WHERE l1.num = l2.num AND l1.num = l3.num*/

SELECT DISTINCT num As ConsecutiveNums
FROM (
SELECT num,
id - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
FROM logs
) t
GROUP BY num, grp
HAVING COUNT(*) >= 3;

#pyspark query
/*from pyspark.sql import functions as F
from pyspark.sql.window import Window

window_spec = Window.orderBy("id")

# 3. Create the "Look Ahead" columns
# lead(col, 1) looks at the next row
# lead(col, 2) looks at the row after that
logs_df = logs.withColumn("next_num", F.lead("num", 1).over(window_spec)) \
              .withColumn("next_next_num", F.lead("num", 2).over(window_spec))

# 4. Filter where all three columns match
# We use .distinct() because a number might appear 4+ times in a row
result = logs_df.filter(
    (F.col("num") == F.col("next_num")) & 
    (F.col("num") == F.col("next_next_num"))
).select(F.col("num").alias("ConsecutiveNums")).distinct()

result.show()*/