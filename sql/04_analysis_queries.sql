-- =========================================
-- ANALYSIS QUERIES
-- =========================================

-- TOTAL REVENUE & PROFIT
SELECT
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit,
    SUM(profit) * 1.0 / SUM(sales) AS profit_margin
FROM fact_sales;

-- DISCOUNT IMPACT
SELECT
    discount,
    AVG(profit) AS avg_profit
FROM fact_sales
GROUP BY discount
ORDER BY discount;

-- SALES BY CATEGORY
SELECT
    p.category,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category;

-- TOP CUSTOMERS
SELECT TOP 10
    f.customer_id,
    SUM(f.sales) AS total_sales
FROM fact_sales f
GROUP BY f.customer_id
ORDER BY total_sales DESC;

-- SHIPPING PERFORMANCE
SELECT
    ship_mode,
    AVG(DATEDIFF(DAY, order_date, ship_date)) AS avg_shipping_delay
FROM fact_sales
GROUP BY ship_mode;

-- REGIONAL PERFORMANCE
SELECT
    l.region,
    SUM(f.sales) AS total_sales,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_location l ON f.location_id = l.location_id
GROUP BY l.region;