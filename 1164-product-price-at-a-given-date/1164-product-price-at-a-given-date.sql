# Write your MySQL query statement below
/*select distinct product_id, 10 as price from Products where product_id not in(select distinct product_id from Products where change_date <='2019-08-16' )
union 
select product_id, new_price as price from Products where (product_id,change_date) in (select product_id , max(change_date) as date from Products where change_date <='2019-08-16' group by product_id)*/

/*
SELECT
    p.product_id,
    COALESCE(t.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id
    FROM Products
) p
LEFT JOIN (
    SELECT product_id, new_price
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (
                   PARTITION BY product_id
                   ORDER BY change_date DESC
               ) AS rn
        FROM Products
        WHERE change_date <= '2019-08-16'
    ) x
    WHERE rn = 1
) t
ON p.product_id = t.product_id;*/

SELECT
    p.product_id,
    COALESCE(t.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id
    FROM Products
) p
LEFT JOIN (
    SELECT product_id, new_price
    FROM Products
    WHERE (product_id, change_date) IN (
        SELECT product_id, MAX(change_date)
        FROM Products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    )
) t
ON p.product_id = t.product_id;

