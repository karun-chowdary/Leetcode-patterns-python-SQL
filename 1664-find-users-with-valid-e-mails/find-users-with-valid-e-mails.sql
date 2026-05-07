# Write your MySQL query statement below
select * from Users
where regexp_like(mail, '^[A-Za-z]+[A-Za-z0-9_.-]*@leetcode[.]com$','c')
/*SELECT *
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';*/

#pyspark query
/*from pyspark.sql import functions as F
result = users_df.filter(F.col("mail").rlike("^[A-Za-z]+[A-Za-z0-9_.-]*@leetcode[.]com$"))
result_alt = users_df.filter(F.regexp_like(F.col("mail"), "^[A-Za-z]+[A-Za-z0-9_.-]*@leetcode[.]com$"))

result.show()*/


















