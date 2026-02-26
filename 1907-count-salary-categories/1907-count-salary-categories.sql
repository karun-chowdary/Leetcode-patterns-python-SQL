# Write your MySQL query statement below
SELECT 'Low Salary' as category, COUNT(*) as accounts_count
FROM accounts
WHERE income <20000
UNION ALL 
SELECT 'Average Salary' as category, COUNT(*) as accounts_count
FROM accounts
WHERE income BETWEEN 20000 and 50000
UNION ALL
SELECT 'High Salary' as caategory, COUNT(*) as accounts_count
FROM accounts
WHERE income >50000

#pyspark query
/*from pyspark.sql import functions as F

# 1. Categorize the income using when/otherwise logic
categorized_df = accounts.withColumn("category", 
    F.when(F.col("income") < 20000, "Low Salary")
     .when(F.col("income").between(20000, 50000), "Average Salary")
     .otherwise("High Salary")
)

# 2. Group and Aggregate
result = categorized_df.groupBy("category") \
                       .agg(F.count("*").alias("accounts_count"))

result.show()*/