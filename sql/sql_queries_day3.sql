-- Execution order and Indexing
use retail_db;
select distinct order_status
 from orders 
 order by order_status;
 
desc orders;

create index indx_order_status on orders(order_status);
select distinct order_status from orders ;

-- Window function
CREATE DATABASE IF NOT EXISTS retail_analytics;
use retail_analytics;
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50),
    product_name VARCHAR(100),
    total_sales INT
);
INSERT INTO products (category, product_name, total_sales) VALUES
('Electronics', 'iPhone 17', 120),
('Electronics', 'Samsung Galaxy S25', 115),
('Electronics', 'OnePlus Nord CE5', 115),
('Electronics', 'Redmi A4', 100),
('Electronics', 'Vivo V27', 100),
('Electronics', 'Realme Narzo', 95),
('Electronics', 'Samsung Galaxy A55', 90),
('Electronics', 'iPhone 16 Pro', 85);
DESC products;
SELECT * FROM products;
EXPLAIN ANALYZE SELECT *, DENSE_RANK() OVER(ORDER BY total_sales DESC) as Popularity FROM products;
SELECT *, nTILE(3) OVER(ORDER BY total_sales DESC) as Popularity_BUCKET FROM products;

-- Window function (Lead, Lag)

CREATE TABLE sales (
    order_id   INT,
    order_date DATE,
    product    VARCHAR(50),
    amount     INT
);
INSERT INTO sales VALUES
(1, '2025-01-05', 'Laptop', 1000),
(2, '2025-01-10', 'Phone',  500),
(3, '2025-01-20', 'Tablet', 300),
(4, '2025-02-02', 'Laptop', 1200),
(5, '2025-02-05', 'Phone',  600),
(6, '2025-02-15', 'Tablet', 400);
select
date_format(order_date, '%Y-%m') as ORDER_month, sum(amount) as monthly_total
 from sales 
 GROUP BY ORDER_month;
SELECT
	order_id,
    order_date,
    amount,
    product,
    SUM(amount) OVER(
    PARTITION BY date_format(order_date, '%Y-%m')
    order by order_date) as running_total
FROM sales;


-- CASE STATEMENTS
SELECT
	order_id,
    order_date,
    amount,
    product,
    LEAD(amount) OVER(
    PARTITION BY date_format(order_date, '%Y-%m')
    order by order_date) as lead_value_with_partition
FROM sales;
SELECT
    order_id,
    order_date,
    order_status,
	CASE
		WHEN order_status IN ('CLOSED','COMPLETE')
			THEN "NO ACTION NEEDED"
		WHEN order_status IN (
            'PENDING_PAYMENT',
            'PROCESSING',
            'PAYMENT_REVIEW',
            'PENDING',
            'ON_HOLD'
        )
            THEN 'Action Needed'

        WHEN order_status = 'SUSPECTED_FRAUD'
            THEN 'Risky'

        WHEN order_status = 'CANCELED'
            THEN 'Closed / No Action'

        ELSE 'Unknown / Review Required'
        
		END AS order_status_category
	FROM orders
ORDER BY order_date;

-- WITH
WITH orders_needing_action AS (
    SELECT
        order_id,
        order_status
    FROM orders
    WHERE order_status IN (
        'PENDING_PAYMENT',
        'PROCESSING',
        'PAYMENT_REVIEW',
        'ON_HOLD'
    )
)
SELECT *
FROM orders_needing_action;

use Demo1;
WITH max_salary AS (
    SELECT MAX(sal) AS highest_salary
    FROM emp
)
SELECT MAX(sal) AS second_highest_salary
FROM emp
WHERE sal < (
    SELECT highest_salary
    FROM max_salary
);	

-- PIVOT/UNPIVOT
SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  COUNT(*) AS total_orders,
  SUM(CASE WHEN order_status = 'COMPLETE' THEN 1 ELSE 0 END) AS complete_orders,
  SUM(CASE WHEN order_status = 'CLOSED'   THEN 1 ELSE 0 END) AS closed_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

CREATE TABLE sales (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);
     

INSERT INTO sales VALUES
(1, '2025-01-01', 100.00),
(2, '2025-01-01', 150.00),
(3, '2025-01-02', 200.00),
(4, '2025-01-02', 50.00);
     
CREATE TABLE daily_sales_summary AS
SELECT
    order_date,
    SUM(amount) AS daily_total
FROM sales
GROUP BY order_date;
select * from daily_sales_summary;

-- Exercise

CREATE TABLE daily_summary as SELECT 
	date_format(od.order_date,'%Y-%m-%d') as daily_date, round(sum(oi.order_item_subtotal),2) AS daily_revenue 
    FROM order_items oi  JOIN orders od on oi.order_item_order_id = od.order_id 
    where od.order_status IN ('CLOSED','COMPLETE') 
    GROUP BY date_format(od.order_date,'%Y-%m-%d');
SELECT 
date_format(od.order_date,'%Y-%m-%m') as daily_date, oi.order_item_product_id ,round(sum(oi.order_item_subtotal),2) AS daily_revenue 
FROM order_items oi  JOIN orders od 
on oi.order_item_order_id = od.order_id 
where od.order_status IN ('CLOSED','COMPLETE') 
GROUP BY date_format(od.order_date,'%Y-%M-%D'),oi.order_item_product_id;
SELECT *, SUM(daily_revenue) OVER(partition by date_format(daily_date,'%Y-%m')) as monthly_revenue FROM daily_summary;
SELECT 
	oi.order_item_product_id ,round(sum(oi.order_item_subtotal),2) AS daily_revenue ,
	RANK() OVER(order by round(sum(oi.order_item_subtotal),2 ) DESC) AS RANKINGS
	FROM order_items oi  JOIN orders od 
on oi.order_item_order_id = od.order_id 
where od.order_status IN ('CLOSED','COMPLETE') and od.order_date = '2014-01-01' 
GROUP BY date_format(od.order_date,'%Y-%M-%D'),oi.order_item_product_id;

SELECT 
	oi.order_item_product_id ,round(sum(oi.order_item_subtotal),2) AS daily_revenue ,
	DENSE_RANK() OVER(order by round(sum(oi.order_item_subtotal),2 ) DESC) AS RANKINGS
	FROM order_items oi  JOIN orders od 
on oi.order_item_order_id = od.order_id 
where od.order_status IN ('CLOSED','COMPLETE') 
GROUP BY oi.order_item_product_id LIMIT 5;
