create database motorcycle_sales;
use motorcycle_sales;
select * from m_sales;

#wholesale sales over time across 3 warehouse sites. Understanding your revenue streams better.

#Step 1 : create view for wholesale data
create view wholesale_data as
select * from m_sales where client_type = "Wholesale";

select * from wholesale_data;
#Step 2 : group by sites
select sum(total), warehouse 
from wholesale_data 
group by warehouse;

#How much net revenue the company will generate across its product lines each month and at each warehouse
SELECT
    warehouse,
    product_line,
    months_name,
    SUM(total) AS net_revenue
FROM
    m_sales
GROUP BY
    warehouse,
    product_line,
    months_name
ORDER BY
    warehouse, product_line;

#Monthly sales trends
select months_name as Month, sum(total) as Monthly_sale
from m_sales
group by months_name;

#warehouse sales performnace
select warehouse, sum(total) as Revenue
from m_sales
group by warehouse;

#sales by client type
select client_type, sum(total) as Revenue
from m_sales
group by client_type;

#payment method analysis
select payment, count(order_number) as total_orders, sum(payment_fee) as total_fees
from m_sales
group by payment;

#best selling products by warehouse
WITH RankedProducts AS (
    SELECT 
        warehouse, 
        product_line, 
        SUM(total) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY warehouse ORDER BY SUM(total) DESC) AS rank_1
    FROM 
        m_sales
    GROUP BY 
        warehouse, product_line
)
SELECT 
    warehouse, 
    product_line, 
    total_revenue
FROM 
    RankedProducts
WHERE 
    rank_1 = 1;

#Top orders
select order_number, warehouse, product_line, total
from m_sales
order by total desc
limit 10;

#average order value
select avg(total) as avg_total_value
from m_sales;

#monthly sales by product line
select product_line, months_name, sum(total) as monthly_sale
from m_sales
group by product_line, months_name;

#revenue contribution by month
select months_name, sum(total) as revenue_month
from m_sales
group by months_name;

#sales by region and client type
select warehouse as region, client_type, sum(total)
from m_sales
group by warehouse, client_type;

#prodcut quantity sold per product line
select product_line, sum(quantity) as total_product
from m_sales
group by product_line;

#sales and payment fee analysis
select payment, product_line,  sum(total) as total_revenue, sum(payment_fee) as total_fee
from m_sales
group by payment, product_line;

