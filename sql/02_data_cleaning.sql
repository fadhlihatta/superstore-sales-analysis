-- =========================================
-- DATA CLEANING
-- =========================================

-- REMOVE EXACT DUPLICATES
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id, product_id, sales, quantity, discount, profit
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM superstore_raw
)
DELETE FROM cte WHERE rn > 1;

-- OPTIONAL: CHECK DUPLICATES
SELECT order_id, product_id, COUNT(*) AS duplicate_count
FROM superstore_raw
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;