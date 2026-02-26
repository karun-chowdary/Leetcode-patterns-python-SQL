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