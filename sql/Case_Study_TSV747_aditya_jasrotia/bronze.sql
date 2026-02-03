create database bronze_seller_db_tsv747_aditya_jasrotia;
use bronze_seller_db_tsv747_aditya_jasrotia;

CREATE TABLE bronze_sales_raw_source (
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
alter table bronze_sales_raw_source add column source_system varchar(50);
TRUNCATE table bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source;
INSERT INTO bronze_sales_raw_source ((SELECT *,'flipkart'  as source_system FROM seller_db_tsv747_aditya_jasrotia.sales_raw_source1)
union
(select *,'amazon' as source_system from seller_db_tsv747_aditya_jasrotia.sales_raw_source2)
); 
show tables;
desc bronze_sales_raw_source;
drop table bronze_sales_raw_source1;
select * from  bronze_sales_raw_source;
select distinct source_system from bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source;

SELECT source_system, COUNT(*) AS rows_count
FROM bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source
GROUP BY source_system;