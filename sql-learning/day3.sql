query:
Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.

Input: 
Input: 
Scores table:
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+

Logic:
We can use Correlated Subquery Ranking Pattern or windows function

Pattern: window function

Code :

SELECT score, DENSE_RANK() OVER(ORDER BY score DESC) as "rank" FROM scores

How it runs:
It will give ranks based on scores in descending order.
ROW_NUMBER numbers rows
RANK ranks with gaps
DENSE_RANK ranks without gaps


Alternate method using window function:

code:

SELECT s1.score,
       (
         SELECT COUNT(DISTINCT s2.score)
         FROM scores s2
         WHERE s2.score > s1.score
       ) + 1 AS rnk
FROM scores s1;



How it runs:

sub-query returns ranks for each score using count.
count-->0 rank -->1
count-->1 rank -->2
count-->2 rank -->3
it is correlated sub query because it is depends on outer query.

Comparison of both

| Aspect         | Window Function | Correlated Subquery |
| -------------- | --------------- | ------------------- |
| Window support | Required        | Not required        |
| Performance    | ✅ Fast          | ❌ Slow              |
| Scalability    | ✅ High          | ❌ Low               |
| Readability    | ✅ Clean         | ❌ Complex           |
| Production use | ✅ Yes           | ❌ Avoid             |


Window functions are more optimized and scalable for ranking problems, while correlated subqueries are mainly fallback solutions for older databases.

