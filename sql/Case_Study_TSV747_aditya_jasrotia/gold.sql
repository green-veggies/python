create database gold_seller_db_tsv747_aditya_jasrotia;
use gold_seller_db_tsv747_aditya_jasrotia;

-- dim customer
CREATE TABLE gold_seller_db_tsv747_aditya_jasrotia.dim_customer(customer_key INT AUTO_INCREMENT PRIMARY KEY, customer_name varchar(100), city varchar(50), email varchar(50), rn int, last_seen_ts date);
INSERT INTO gold_seller_db_tsv747_aditya_jasrotia.dim_customer
(
  customer_name,
  city,
  email,
  rn,
  last_seen_ts
)
SELECT
  customer_name,
  city,
  email,
  rn,
  last_seen_ts
FROM (
    SELECT
      TRIM(customer_name) AS customer_name,
      city,
      TRIM(email) AS email,
      ROW_NUMBER() OVER (
          PARTITION BY TRIM(LOWER(email))
          ORDER BY load_date DESC
      ) AS rn,
      load_date AS last_seen_ts
    FROM silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source
    WHERE email IS NOT NULL
) abc
WHERE rn = 1;
alter table gold_seller_db_tsv747_aditya_jasrotia.dim_customer drop column rn;
select * from gold_seller_db_tsv747_aditya_jasrotia.dim_customer;

-- dim product
CREATE TABLE gold_seller_db_tsv747_aditya_jasrotia.dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(100) NOT NULL,
    CONSTRAINT uk_product UNIQUE (product_name, product_category)
);
INSERT INTO gold_seller_db_tsv747_aditya_jasrotia.dim_product
(
  product_name,
  product_category
)
SELECT DISTINCT
    trim(product_name),
    trim(product_category)
FROM silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source
WHERE product_name IS NOT NULL
  AND product_category IS NOT NULL;
select * from gold_seller_db_tsv747_aditya_jasrotia.dim_product;

-- fact_sales

CREATE TABLE gold_seller_db_tsv747_aditya_jasrotia.fact_sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10, 2),
    total_amount DECIMAL(12, 2),
    load_timestamp TIMESTAMP,
    CONSTRAINT uk_fact_sales_order UNIQUE (order_id),
    CONSTRAINT fk_fact_customer
        FOREIGN KEY (customer_key)
        REFERENCES gold_seller_db_tsv747_aditya_jasrotia.dim_customer(customer_key),
    CONSTRAINT fk_fact_product
        FOREIGN KEY (product_key)
        REFERENCES gold_seller_db_tsv747_aditya_jasrotia.dim_product(product_key)
);


INSERT INTO gold_seller_db_tsv747_aditya_jasrotia.fact_sales
(
    order_id,
    customer_key,
    product_key,
    sale_date,
    quantity,
    unit_price,
    total_amount,
    load_timestamp
)
SELECT
    s.order_id,
    c.customer_key,
    p.product_key,
    s.sale_date,
    s.quantity,
    s.unit_price,
    ROUND(s.quantity * s.unit_price, 2) AS total_amount,
    s.load_date AS load_timestamp
FROM silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source s
JOIN gold_seller_db_tsv747_aditya_jasrotia.dim_customer c
  ON s.email = c.email
JOIN gold_seller_db_tsv747_aditya_jasrotia.dim_product p
  ON s.product_name = p.product_name
 AND s.product_category = p.product_category
LEFT JOIN gold_seller_db_tsv747_aditya_jasrotia.fact_sales f
  ON s.order_id = f.order_id
WHERE f.order_id IS NULL;

select * from gold_seller_db_tsv747_aditya_jasrotia.fact_sales;

