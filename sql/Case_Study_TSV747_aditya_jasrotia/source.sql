create database seller_db_tsv747_aditya_jasrotia;
use seller_db_tsv747_aditya_jasrotia;
CREATE TABLE sales_raw_source1 (
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
CREATE TABLE sales_raw_source2 (
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
show tables;
desc sales_raw_source1;
select * from seller_db_tsv747_aditya_jasrotia.sales_raw_source2;
select * from seller_db_tsv747_aditya_jasrotia.sales_raw_source2;