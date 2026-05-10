/*SELECT customer_id, COUNT(customer_id) AS count_no_trans
FROM visits v
LEFT JOIN transactions t
ON v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_id*/

SELECT customer_id,
       COUNT(*) AS count_no_trans
FROM visits v
WHERE NOT EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.visit_id = v.visit_id
)
GROUP BY customer_id;