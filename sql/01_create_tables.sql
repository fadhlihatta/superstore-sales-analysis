-- =========================================
-- CREATE DIMENSION & FACT TABLES
-- =========================================

-- DIM CUSTOMER
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

-- DIM PRODUCT
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(150)
);

-- DIM LOCATION
CREATE TABLE dim_location (
    location_id INT IDENTITY(1,1) PRIMARY KEY,
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50)
);

-- FACT SALES
CREATE TABLE fact_sales (
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    location_id INT,
    sales FLOAT,
    quantity INT,
    discount FLOAT,
    profit FLOAT,

    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id)
);