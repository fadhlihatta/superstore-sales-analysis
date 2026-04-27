-- =========================================
-- TRANSFORM RAW DATA INTO STAR SCHEMA
-- =========================================

-- INSERT DIM CUSTOMER
INSERT INTO dim_customer (customer_id, customer_name, segment)
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore_raw;

-- INSERT DIM PRODUCT
INSERT INTO dim_product (product_id, category, sub_category, product_name)
SELECT DISTINCT
    product_id,
    category,
    sub_category,
    product_name
FROM superstore_raw;

-- INSERT DIM LOCATION
INSERT INTO dim_location (country, city, state, postal_code, region)
SELECT DISTINCT
    country,
    city,
    state,
    CAST(postal_code AS VARCHAR),
    region
FROM superstore_raw;

-- INSERT FACT SALES
INSERT INTO fact_sales (
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    location_id,
    sales,
    quantity,
    discount,
    profit
)
SELECT
    r.order_id,
    r.order_date,
    r.ship_date,
    r.ship_mode,
    r.customer_id,
    r.product_id,
    l.location_id,
    r.sales,
    r.quantity,
    r.discount,
    r.profit
FROM superstore_raw r
JOIN dim_location l
    ON r.city = l.city
    AND r.state = l.state;