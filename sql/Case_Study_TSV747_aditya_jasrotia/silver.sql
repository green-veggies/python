create database silver_seller_db_tsv747_aditya_jasrotia;
use silver_seller_db_tsv747_aditya_jasrotia;

CREATE TABLE silver_sales_raw_source (
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(50),
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    sale_date DATE,
    unit_price DECIMAL(10 , 2 ),
    quantity INT,
    load_date DATE
);
drop table silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source;

-- silver operations
CREATE TABLE silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source SELECT * FROM (
	SELECT order_id, customer_name
	,
		CASE
			WHEN city = 'NY' THEN 'New York'
			WHEN city = 'Hyd' THEN 'Hyderabad'
			WHEN city IS NULL
				 OR LOWER(city) IN ('null', 'n/a')
				 OR TRIM(city) = '' THEN 'Delhi'
			ELSE TRIM(city)
		END AS city,
        trim(email) as email, ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY load_date DESC) as rn, trim(product_name) as product_name, trim(product_category) as product_category, sale_date, unit_price, quantity, load_date, source_system
	FROM bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source
	WHERE product_category <> 'Beauty') abc where rn = 1;
    
SELECT 
    *
FROM
    silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source;
alter table silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source drop column rn;

show tables;
desc bronze_sales_raw_source;
drop table bronze_sales_raw_source1;
select distinct product_category from  bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source;
select distinct source_system from bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source;

SELECT source_system, COUNT(*) AS rows_count
FROM bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source
GROUP BY source_system;