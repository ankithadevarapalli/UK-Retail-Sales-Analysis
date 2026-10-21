-- UK RETAIL SALES ANALYSIS

-- 1. OVERALL SALES KPIs
-- Total orders
select count(*) as total_orders
from uk_retail_sales_sql_dataset;
-- total sales
select
round(sum(net_sales_gbp), 2) as 
total_sales
from uk_retail_sales_sql_dataset;
-- average order value
select
round(sum(net_sales_gbp) / count(*), 2) as
average_order_value
from uk_retail_sales_sql_dataset;
-- 2. SALES PERFORMANCE BY REGION & CATEGORY 
-- sales by region
SELECT
    Region,
    ROUND(SUM(Net_Sales_GBP), 2) AS Total_Sales
FROM uk_retail_sales_sql_dataset
GROUP BY Region
ORDER BY Total_Sales DESC;
  -- sales by category 
select
   category,
   round(sum(net_sales_gbp),2) as 
   total_sales
   from uk_retail_sales_sql_dataset
   group by Category
   order by total_sales desc;
   -- 3. PRODUCT & MONTHLY SALES ANALYSIS
   -- Top 5 Products by Sales
 select
   product_name,
   round(sum(net_sales_gbp),2) as
   total_sales
   from uk_retail_sales_sql_dataset
   group by Product_Name
   order by total_sales desc
   limit 5;
   -- Monthly Sales  Trend 
  select
       left(order_date,7) as sales_month,
       round(sum(net_sales_gbp),2) as
  total_sales
  from uk_retail_sales_sql_dataset
  group by left(order_date,7)
  order by sales_month;
  -- 4. CUSTOMER & SALES CHANNEL ANALYSIS
  -- Sales by Channel
select
    sales_channel,
    count(*) as total_orders,
    round(sum(net_sales_gbp),2) as
 total_sales
 from uk_retail_sales_sql_dataset
 group by Sales_Channel
 order by total_sales desc;
 -- Top 5 Cities by Sales
 SELECT
    City,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Net_Sales_GBP), 2) AS Total_Sales
FROM uk_retail_sales_sql_dataset
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 5;
-- 5. DISCOUNTS, PAYMENT METHODS & ORDER STATUS
-- Discount Analysis
SELECT
    Discount_Pct,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Gross_Sales_GBP), 2) AS Gross_Sales,
    ROUND(SUM(Net_Sales_GBP), 2) AS Net_Sales
FROM uk_retail_sales_sql_dataset
GROUP BY Discount_Pct
ORDER BY Discount_Pct;
-- Payment Method Analysis
SELECT
    Payment_Method,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Net_Sales_GBP), 2) AS Total_Sales
FROM uk_retail_sales_sql_dataset
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;
-- product Sales Ranking
SELECT
    Product_Name,
    ROUND(SUM(Net_Sales_GBP), 2) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Net_Sales_GBP) DESC) AS Sales_Rank
FROM uk_retail_sales_sql_dataset
GROUP BY Product_Name
ORDER BY Sales_Rank;
-- Order Status Analysis
SELECT
    Order_Status,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) 
FROM uk_retail_sales_sql_dataset), 2) AS Percentage
FROM uk_retail_sales_sql_dataset
GROUP BY Order_Status
ORDER BY Total_Orders DESC;

