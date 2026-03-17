# Write your MySQL query statement below
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

#pyspark query
/*from pyspark.sql import functions as F
result = courses_df.groupBy("class") \
    .agg(F.count("student").alias("student_count")) \
    .filter(F.col("student_count") >= 5) \
    .select("class")

result.show()*/