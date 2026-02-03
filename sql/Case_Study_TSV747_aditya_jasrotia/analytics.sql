-- Analytics
select dc.city as city, sum(total_amount) as revenue from fact_sales f join dim_customer dc on f.customer_key = dc.customer_key group by dc.city;
select dp.product_category as category, sum(total_amount) as revenue from fact_sales f join dim_product dp on f.product_key = dp.product_key group by dp.product_category;
select sale_date, sum(total_amount) as revenue from fact_sales group by sale_date;