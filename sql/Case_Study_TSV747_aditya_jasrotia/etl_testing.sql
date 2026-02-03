create database qa_db;
use qa_db; 
SET @test_run_id = DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s');
drop table if exists qa_db.test_results;

create table qa_db.test_results(test_run_id varchar(20) primary key, test_name varchar(100), test_status varchar(50), actual_value varchar(50), expected_desc varchar(100), details varchar(100), rn_timestamp timestamp default current_timestamp);


-- Problems to solve

-- 1) Bronze: Duplicate order_id Check

INSERT INTO qa_db.test_results
(test_run_id, test_name, test_status, actual_value, expected_desc, details)
SELECT
  @test_run_id,
  'Bronze: Duplicate order_id Check',
  CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS test_status,
  COUNT(*) AS actual_value,
  '0 expected',
  'order_id values that appear more than once in Bronze.'
FROM (
    SELECT order_id
    FROM bronze_seller_db_tsv747_aditya_jasrotia.bronze_sales_raw_source
    GROUP BY order_id
    HAVING COUNT(*) > 1
) dup;


-- 2) Silver: Null/Blank City Check

INSERT INTO qa_db.test_results
(test_run_id, test_name, test_status, actual_value, expected_desc, details)
SELECT
  @test_run_id,
  'Silver: Null/Blank City Check',
  CASE WHEN count(*) =0 THEN 'PASS' ELSE 'FAIL' END AS test_status,
  COUNT(*) AS actual_value,
  '0 expected',
  'Ensure city is not NULL or blank after Silver standardization.'
FROM silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source
    where city IS NULL OR TRIM(city) = '';
    
-- Silver: Beauty exclusion rule

INSERT INTO qa_db.test_results (test_run_id, test_name, test_status, actual_value, expected_desc, details)
SELECT
  @test_run_id,
  'Silver: Beauty exclusion rule',
  CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
  COUNT(*),
  '0 expected',
  'Beauty rows should not be promoted to Silver'
FROM silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source
WHERE product_category = 'Beauty';

-- Silver: Invalid Email Format Check
INSERT INTO qa_db.test_results (test_run_id, test_name, test_status, actual_value, expected_desc, details)
SELECT
  @test_run_id,
  'Silver: Invalid Email Format Check',
  CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
  COUNT(*),
  '0 expected',
  'Identify invalid email values which do not have @ or .'
FROM silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source
WHERE email IS NOT NULL
  AND (
        email NOT LIKE '%@%'
        OR email NOT LIKE '%.%'
      );

-- Gold Fact: total_amount Calculation Check
INSERT INTO qa_db.test_results (test_run_id, test_name, test_status, actual_value, expected_desc, details)
SELECT
  @test_run_id,
  'Gold Fact: total_amount Calculation Check',
  CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
  COUNT(*),
  '0 expected',
  'Validate total_amount matches quantity * unit_price within tolerance.'
FROM gold_seller_db_tsv747_aditya_jasrotia.fact_sales
WHERE  total_amount <> quantity * unit_price ;

--  Completeness: Silver → Gold Missing order_id Check


INSERT INTO qa_db.test_results (test_run_id, test_name, test_status, actual_value, expected_desc, details)

SELECT
    @test_run_id AS test_run_id,
    ' Completeness: Silver → Gold Missing order_id Checkk' AS test_name,
    CASE
        WHEN COUNT(*) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS status,
    COUNT(*) AS actual_value,
    '0_expected' AS expected_desc,
    'count of order_ids which are not present in gold fact_sales table ' AS details
from silver_seller_db_tsv747_aditya_jasrotia.silver_sales_raw_source a left join gold_seller_db_tsv747_aditya_jasrotia.fact_sales b on a.order_id = b.order_id where b.order_id is NULL;


select * from qa_db.test_results;

