# Write your MySQL query statement below
SELECT user_id, CONCAT(UPPER(SUBSTRING(name,1,1)),LOWER(SUBSTRING(name,2))) as name
FROM users
ORDER BY user_id

/*SELECT user_id,initcap(name) as name
FROM users*/

#pyspark code
/*from pyspark.sql.functions import initcap

result = users.select(
    "user_id", 
    initcap("name").alias("name")
).orderBy("user_id")

result.show()*/

#another method in pyspark
/*from pyspark.sql.functions import col, concat, upper, lower, substring, length

result = users.select(
    col("user_id"),
    concat(
        upper(substring(col("name"), 1, 1)),             # First letter to Upper
        lower(substring(col("name"), 2, 1000))           # Rest of the string to Lower
    ).alias("name")
).orderBy("user_id")

result.show()*/