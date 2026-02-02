
-- 01 — Build Bronze Layer 

DROP DATABASE IF EXISTS bronze;
CREATE DATABASE bronze DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE bronze;

-- crm_cust_info
CREATE TABLE IF NOT EXISTS crm_cust_info (
  cst_id INT,
  cst_key VARCHAR(50),
  cst_firstname VARCHAR(50),
  cst_lastname VARCHAR(50),
  cst_marital_status VARCHAR(50),
  cst_gndr VARCHAR(50),
  cst_create_date DATE
) ENGINE=InnoDB;
TRUNCATE TABLE crm_cust_info;
LOAD DATA LOCAL INFILE '/Users/as-mac-1155/Downloads/cust_info.csv' INTO TABLE crm_cust_info
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
SELECT COUNT(*) AS rows_loaded_cust FROM crm_cust_info;

-- crm_prd_info
CREATE TABLE IF NOT EXISTS crm_prd_info (
  prd_id INT,
  prd_key VARCHAR(50),
  prd_nm VARCHAR(50),
  prd_cost INT,
  prd_line VARCHAR(50),
  prd_start_dt DATETIME,
  prd_end_dt DATETIME
) ENGINE=InnoDB;
TRUNCATE TABLE crm_prd_info;
LOAD DATA LOCAL INFILE '/Users/as-mac-1155/Downloads/prd_info.csv' INTO TABLE crm_prd_info
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
SELECT COUNT(*) AS rows_loaded_prd FROM crm_prd_info;

-- crm_sales_details
CREATE TABLE IF NOT EXISTS crm_sales_details (
  sls_ord_num VARCHAR(50),
  sls_prd_key VARCHAR(50),
  sls_cust_id INT,
  sls_order_dt INT,
  sls_ship_dt INT,
  sls_due_dt INT,
  sls_sales INT,
  sls_quantity INT,
  sls_price INT
) ENGINE=InnoDB;
TRUNCATE TABLE crm_sales_details;
LOAD DATA LOCAL INFILE '/Users/as-mac-1155/Downloads/sales_details.csv' INTO TABLE crm_sales_details
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
SELECT COUNT(*) AS rows_loaded_sales FROM crm_sales_details;

-- erp_loc_a101
CREATE TABLE IF NOT EXISTS erp_loc_a101 (
  cid VARCHAR(50),
  cntry VARCHAR(50)
) ENGINE=InnoDB;
TRUNCATE TABLE erp_loc_a101;
LOAD DATA LOCAL INFILE '/Users/as-mac-1155/Downloads/LOC_A101.csv' INTO TABLE erp_loc_a101
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
SELECT COUNT(*) AS rows_loaded_loc FROM erp_loc_a101;

-- erp_cust_az12
CREATE TABLE IF NOT EXISTS erp_cust_az12 (
  cid VARCHAR(50),
  bdate DATE,
  gen VARCHAR(50)
) ENGINE=InnoDB;
TRUNCATE TABLE erp_cust_az12;
LOAD DATA LOCAL INFILE '/Users/as-mac-1155/Downloads/CUST_AZ12.csv' INTO TABLE erp_cust_az12
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
SELECT COUNT(*) AS rows_loaded_az12 FROM erp_cust_az12;

-- erp_px_cat_g1v2
CREATE TABLE IF NOT EXISTS erp_px_cat_g1v2 (
  id VARCHAR(50),
  cat VARCHAR(50),
  subcat VARCHAR(50),
  maintenance VARCHAR(50)
) ENGINE=InnoDB;
TRUNCATE TABLE erp_px_cat_g1v2;
LOAD DATA LOCAL INFILE '/Users/as-mac-1155/Downloads/PX_CAT_G1V2.csv' INTO TABLE erp_px_cat_g1v2
FIELDS TERMINATED BY ',' IGNORE 1 LINES;
SELECT COUNT(*) AS rows_loaded_cat FROM erp_px_cat_g1v2;

SELECT 
    *
FROM
    crm_prd_info;
desc crm_prd_info;
show tables;

DROP DATABASE IF EXISTS silver;
CREATE DATABASE silver
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE silver;
CREATE TABLE IF NOT EXISTS crm_cust_info (
  cst_id INT,
  cst_key VARCHAR(50),
  cst_firstname VARCHAR(50),
  cst_lastname VARCHAR(50),
  cst_marital_status VARCHAR(50),
  cst_gndr VARCHAR(50),
  cst_create_date DATE,
  dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX ix_crm_cust_info_key (cst_key),
  INDEX ix_crm_cust_info_id (cst_id)
) ENGINE=InnoDB;

TRUNCATE TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info (
  cst_id, cst_key, cst_firstname, cst_lastname,
  cst_marital_status, cst_gndr, cst_create_date
)
SELECT cst_id,
       cst_key,
       TRIM(cst_firstname),
       TRIM(cst_lastname),
       CASE UPPER(TRIM(cst_marital_status))
         WHEN 'S' THEN 'Single'
         WHEN 'M' THEN 'Married'
         ELSE 'n/a'
       END,
       CASE UPPER(TRIM(cst_gndr))
         WHEN 'F' THEN 'Female'
         WHEN 'M' THEN 'Male'
         ELSE 'n/a'
       END,
       cst_create_date
FROM (
   SELECT b.*,
          ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS rn
   FROM bronze.crm_cust_info b
   WHERE cst_id IS NOT NULL and cast(cst_create_date as char) <> '0000-00-00'
) t
WHERE rn = 1;
SELECT COUNT(*) AS rows_loaded FROM silver.crm_cust_info;
SELECT * FROM silver.crm_cust_info;
CREATE TABLE IF NOT EXISTS crm_prd_info (
  prd_id INT,
  cat_id VARCHAR(50),
  prd_key VARCHAR(50),
  prd_nm VARCHAR(50),
  prd_cost INT,
  prd_line VARCHAR(50),
  prd_start_dt DATE,
  prd_end_dt DATE,
  dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX ix_crm_prd_key (prd_key),
  INDEX ix_crm_cat_id (cat_id)
) ENGINE=InnoDB;
TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info (
  prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt
)
SELECT
  prd_id,
  REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
  SUBSTRING(prd_key, 7) AS prd_key,
  prd_nm,
  COALESCE(prd_cost, 0),
  CASE UPPER(TRIM(prd_line))
    WHEN 'M' THEN 'Mountain'
    WHEN 'R' THEN 'Road'
    WHEN 'S' THEN 'Other Sales'
    WHEN 'T' THEN 'Touring'
    ELSE 'n/a'
  END,
  DATE(prd_start_dt),
  DATE( (LEAD(prd_start_dt) OVER (PARTITION BY SUBSTRING(prd_key, 7) ORDER BY prd_start_dt)) - INTERVAL 1 DAY )
FROM bronze.crm_prd_info;
SELECT COUNT(*) AS rows_loaded FROM silver.crm_prd_info;
SELECT * FROM silver.crm_prd_info LIMIT 10;

CREATE TABLE IF NOT EXISTS crm_sales_details (
  sls_ord_num VARCHAR(50),
  sls_prd_key VARCHAR(50),
  sls_cust_id INT,
  sls_order_dt DATE,
  sls_ship_dt DATE,
  sls_due_dt DATE,
  sls_sales INT,
  sls_quantity INT,
  sls_price INT,
  dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX ix_sales_ord (sls_ord_num),
  INDEX ix_sales_prd (sls_prd_key),
  INDEX ix_sales_cust (sls_cust_id)
) ENGINE=InnoDB;
TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details (
  sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt,
  sls_sales, sls_quantity, sls_price
)
SELECT 
  sls_ord_num,
  sls_prd_key,
  sls_cust_id,
  CASE WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt) != 8 THEN NULL
       ELSE STR_TO_DATE(CAST(sls_order_dt AS CHAR), '%Y%m%d') END,
  CASE WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt) != 8 THEN NULL
       ELSE STR_TO_DATE(CAST(sls_ship_dt AS CHAR), '%Y%m%d') END,
  CASE WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt) != 8 THEN NULL
       ELSE STR_TO_DATE(CAST(sls_due_dt AS CHAR), '%Y%m%d') END,
  CASE 
    WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales <> sls_quantity * ABS(sls_price)
      THEN sls_quantity * ABS(sls_price)
    ELSE sls_sales
  END,
  sls_quantity,
  CASE 
    WHEN sls_price IS NULL OR sls_price <= 0 THEN NULLIF(sls_sales,0) / NULLIF(sls_quantity,0)
    ELSE sls_price
  END
FROM bronze.crm_sales_details;
SELECT COUNT(*) AS rows_loaded FROM silver.crm_sales_details;
SELECT * FROM silver.crm_sales_details LIMIT 10;
CREATE TABLE IF NOT EXISTS erp_cust_az12 (
  cid VARCHAR(50),
  bdate DATE,
  gen VARCHAR(50),
  dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX ix_custaz_cid (cid)
) ENGINE=InnoDB;
TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12 (cid, bdate, gen)
SELECT
  CASE WHEN cid LIKE 'NAS%%' THEN SUBSTRING(cid, 4) ELSE cid END,
  CASE WHEN bdate > CURRENT_DATE THEN NULL ELSE bdate END,
  CASE
     WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE')   THEN 'Male'
     ELSE 'n/a'
  END
FROM bronze.erp_cust_az12;
SELECT COUNT(*) AS rows_loaded FROM silver.erp_cust_az12;
SELECT * FROM silver.erp_cust_az12 LIMIT 10;
CREATE TABLE IF NOT EXISTS erp_loc_a101 (
  cid VARCHAR(50),
  cntry VARCHAR(50),
  dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX ix_loc_cid (cid)
) ENGINE=InnoDB;

TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101 (cid, cntry)
SELECT
  REPLACE(cid, '-', ''),
  CASE
     WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
     ELSE TRIM(cntry)
  END
FROM bronze.erp_loc_a101;
SELECT COUNT(*) AS rows_loaded FROM silver.erp_loc_a101;
SELECT * FROM silver.erp_loc_a101 LIMIT 10;  
CREATE TABLE IF NOT EXISTS erp_px_cat_g1v2 (
  id VARCHAR(50),
  cat VARCHAR(50),
  subcat VARCHAR(50),
  maintenance VARCHAR(50),
  dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX ix_cat_id (id)
) ENGINE=InnoDB;
TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2 (id, cat, subcat, maintenance)
SELECT id, cat, subcat, maintenance FROM bronze.erp_px_cat_g1v2;
SELECT COUNT(*) AS rows_loaded FROM silver.erp_px_cat_g1v2;
SELECT distinct cntry FROM silver.erp_loc_a101;

--

use bronze;
select cst_id from silver.crm_cust_info group by cst_id having count(*)>1; -- uniqueness
select distinct cntry from bronze.erp_loc_a101 where cntry like "U%" ; -- consistency
select * from silver.crm_prd_info ; -- completeness

-- gold layer

DROP DATABASE IF EXISTS gold;
CREATE DATABASE gold DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE gold;

CREATE OR REPLACE VIEW gold.dim_customers AS
SELECT
  ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
  ci.cst_id        AS customer_id,
  ci.cst_key       AS customer_number,
  ci.cst_firstname AS first_name,
  ci.cst_lastname  AS last_name,
  la.cntry         AS country,
  ci.cst_marital_status AS marital_status,
  CASE 
    WHEN ci.cst_gndr <> 'n/a' THEN ci.cst_gndr
    ELSE COALESCE(ca.gen, 'n/a')
  END AS gender,
  ca.bdate         AS birthdate,
  ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid;
SELECT COUNT(*) AS dim_customers_rows FROM gold.dim_customers;

-- dim_products
CREATE OR REPLACE VIEW gold.dim_products AS
SELECT
  ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
  pn.prd_id       AS product_id,
  pn.prd_key      AS product_number,
  pn.prd_nm       AS product_name,
  pn.cat_id       AS category_id,
  pc.cat          AS category,
  pc.subcat       AS subcategory,
  pc.maintenance  AS maintenance,
  pn.prd_cost     AS cost,
  pn.prd_line     AS product_line,
  pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;
SELECT COUNT(*) AS dim_products_rows FROM gold.dim_products;

-- fact_sales
CREATE OR REPLACE VIEW gold.fact_sales AS
SELECT
  sd.sls_ord_num  AS order_number,
  pr.product_key  AS product_key,
  cu.customer_key AS customer_key,
  sd.sls_order_dt AS order_date,
  sd.sls_ship_dt  AS shipping_date,
  sd.sls_due_dt   AS due_date,
  sd.sls_sales    AS sales_amount,
  sd.sls_quantity AS quantity,
  sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu ON sd.sls_cust_id = cu.customer_id;
SELECT COUNT(*) AS fact_sales_rows FROM gold.fact_sales;

-- problem solving

select *, datediff(curdate(),birthdate)/365 as age from dim_customers where birthdate is not null order by birthdate;
select *, datediff(curdate(),birthdate)/365 as age from dim_customers where birthdate is not null order by birthdate desc;
select dp.category as category,sum(sales_amount) as revenue from fact_sales fs join dim_products dp on fs.product_key = dp.product_key group by dp.category;
select dp.country as country, sum(fs.quantity) as units from fact_sales fs join dim_customers dp on fs.customer_key = dp.customer_key group by dp.country;
SELECT 
    customer_key, COUNT(customer_key) AS count
FROM
    fact_sales
GROUP BY customer_key
HAVING COUNT(customer_key) >= 1
ORDER BY COUNT(customer_key) limit 3;
select p.product_id, p.product_name, sum(f.sales_amount) as total_revenue from fact_sales f join dim_products p on f.product_key = p.product_key group by p.product_id, p.product_name order by sum(sales_amount) limit 5;
select product_key,year(order_date), sum(sales_amount) as yearly_revenue from fact_sales where order_date is not null group by year(order_date),product_key;