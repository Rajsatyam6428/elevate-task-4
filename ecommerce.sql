CREATE DATABASE ecommerce;
USE ecommerce;
-- Rename 
SELECT * FROM`order details`;
ALTER TABLE orders_list RENAME TO orders_details;
SELECT * FROM order_list;
ALTER TABLE `list of orders` RENAME TO order_list;
ALTER TABLE `sales target` RENAME TO sales_targets;

-- Find all orders from Maharashtra, sorted by city
SELECT *
FROM order_list
WHERE state = 'Maharashtra'
ORDER BY city;

-- Total sales and profit per category
SELECT
    od.Category,
    SUM(od.Amount) AS total_sales,
    SUM(od.Profit) AS total_profit
FROM
    orders_details od
GROUP BY
    od.Category;

-- Join to get order, customer, category and amount
SELECT
    ol.`Order ID`,
    ol.`Order Date`,
    ol.CustomerName,
    od.Category,
    od.Amount,
    od.Profit
FROM
    order_list ol
JOIN
    orders_details od ON ol.`Order ID` = od.`Order ID`;


 


-- Create view for top-performing categories
CREATE VIEW top_category_sales AS
SELECT
    od.Category,
    SUM(od.Amount) AS total_sales
FROM
    orders_details od
GROUP BY
    od.Category
ORDER BY
    total_sales DESC;
    
SELECT * FROM top_category_sales;

-- Get categories with sales above average
SELECT Category, SUM(Amount) AS Total_Sales
FROM orders_details
GROUP BY Category
HAVING SUM(Amount) > (
    SELECT AVG(Total_Sales)
    FROM (
        SELECT SUM(Amount) AS Total_Sales
        FROM orders_details
        GROUP BY Category
    ) AS category_totals
);

-- Top 5 Sub-Categories by Total Sales
SELECT 
    `Sub-Category`,
    SUM(Amount) AS Total_Sales
FROM 
    orders_details
GROUP BY 
    `Sub-Category`
ORDER BY 
    Total_Sales DESC
LIMIT 5;

-- City with Highest Total Orders
SELECT 
    City,
    COUNT(DISTINCT ol.`Order ID`) AS Total_Orders
FROM 
    order_list ol
GROUP BY 
    City
ORDER BY 
    Total_Orders DESC
LIMIT 1;


    
-- Customers with Highest Spend
SELECT 
    ol.CustomerName,
    SUM(od.Amount) AS Total_Spent
FROM 
    order_list ol
JOIN 
    orders_details od ON ol.`Order ID` = od.`Order ID`
GROUP BY 
    ol.CustomerName
ORDER BY 
    Total_Spent DESC
LIMIT 10;

-- Products (Sub-Categories) with Negative Total Profit
SELECT 
    `Sub-Category`,
    SUM(Profit) AS Total_Profit
FROM 
    orders_details
GROUP BY 
    `Sub-Category`
HAVING 
    SUM(Profit) < 0;
    


