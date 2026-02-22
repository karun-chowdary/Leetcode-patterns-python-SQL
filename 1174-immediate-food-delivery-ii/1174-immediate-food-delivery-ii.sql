# Write your MySQL query statement below
/*SELECT ROUND(((COUNT(t.customer_pref_delivery_date)*100)/COUNT(t.first_date))/2, 2) AS immediate_percentage
FROM (
    SELECT delivery_id, MIN(order_date) as first_date,customer_pref_delivery_date
    FROM delivery
    GROUP BY customer_id
) AS t
INNER JOIN delivery d
ON t.delivery_id = d.delivery_id
WHERE t.first_date = d.customer_pref_delivery_date*/

/*Select 
    round(SUM(order_date = customer_pref_delivery_date)*100/COUNT(*), 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in (
  Select customer_id, min(order_date) 
  from Delivery
  group by customer_id
);*/

SELECT
ROUND(
    100 * AVG(order_date = customer_pref_delivery_date),
    2
) AS immediate_percentage
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM delivery
) t
WHERE rn = 1;
