# Write your MySQL query statement below
SELECT employee_id, (salary)*(employee_id%2)*(name NOT LIKE "M%") AS bonus
FROM employees
ORDER BY employee_id


#Query using case when
/*SELECT employee_id,
CASE WHEN (employee_id%2<>0) AND (name NOT LIKE "M%") THEN salary
ELSE 0
END
AS bonus
FROM employees
ORDER BY employee_id*/

#query in pyspark
/* from pyspark.sql.functions import col
result = employees.withColumn("bonus",
(col("salary"))*(col(employee_id%2))*(~col("name").startsWith("M")).cast("int")
).select("employee_id","bonus").orderBy("employee_id")*/

