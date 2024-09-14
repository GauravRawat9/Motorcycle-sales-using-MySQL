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

