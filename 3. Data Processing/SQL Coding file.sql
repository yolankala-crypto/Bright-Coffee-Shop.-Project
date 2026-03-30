--1. Running the entire table.
SELECT *
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
LIMIT 1000;


-- 2. Checking the Date Range (6 months of data collection)
-- They started collecting the data 2023-01-01
-- They last collected the data 2023-06-30
SELECT MIN(transaction_date) AS min_date,
       MAX(transaction_date) AS latest_date 
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;


--3. Checking the different stores locations
-- we have 3 stores and their names are Lower Manhattan, Hell's Kitchen, Astoria
SELECT DISTINCT store_location
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;


--4. Checking products sold at our stores 
-- 9 product_categories
SELECT DISTINCT product_category
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- 80 product_detail category
SELECT DISTINCT product_detail
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- 29 product types
SELECT DISTINCT product_type
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- 4. Checking highest and lowest unit price
-- lowest price
SELECT MIN(unit_price) As cheapest_price
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- hghest price
SELECT MAX(unit_price) As expensive_price
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- 5. Extructing Day and Month names
SELECT Dayname (transaction_date) AS Day_name,
       Monthname(transaction_date) AS Month_name
FROM workspace.default.brightcoffeeshop_analysis_case_study_1;

-- 6. Checking for NULLs
SELECT *
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
WHERE unit_price IS NULL
OR transaction_qty IS NULL
OR transaction_date IS NULL;

-- 7. Revenue
SELECT unit_price,
       transaction_qty,
       unit_price*transaction_qty AS Revenue
FROM workspace.default.brightcoffeeshop_analysis_case_study_1;

-- Count number of rows
SELECT 
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      transaction_qty*unit_price AS revenue_per_tnx
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
-----------------------------------------------------
SELECT COUNT(*)
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
---------------------------------------------------------------
SELECT
    -- Dates
    transaction_date AS purchase_date,
    DAYNAME(transaction_date) AS day_name,
    MONTHNAME(transaction_date) AS month_name,
    DAYOFMONTH(transaction_date) AS day_of_month,
    CASE
        WHEN DAYNAME(transaction_date) IN ('Sunday', 'Saturday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_classification,

    -- Time Bucket
    CASE
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
    END AS time_bucket,

    -- Count of IDs
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    COUNT(DISTINCT product_id) AS number_of_products,
    COUNT(DISTINCT store_id) AS number_of_stores,

    -- Revenue
    SUM(transaction_qty * unit_price) AS revenue_per_day,

    -- Categorical Columns
    store_location,
    product_category,
    product_detail

FROM workspace.default.BrightCoffeeShop_analysis_case_study_1

GROUP BY
    transaction_date,
    DAYNAME(transaction_date),
    MONTHNAME(transaction_date),
    DAYOFMONTH(transaction_date),
    CASE
        WHEN DAYNAME(transaction_date) IN ('Sunday', 'Saturday') THEN 'Weekend'
        ELSE 'Weekday'
    END,
    CASE
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
    END,
    store_location,
    product_category,
    product_detail;
---------------------------------------------------------

SELECT transaction_id,
       transaction_date
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT transaction_id,
       transaction_date,
       DAYNAME(transaction_date) AS day_name
FROM   workspace.default.BrightCoffeeShop_analysis_case_study_1;     

SELECT transaction_id,
       transaction_date,
       DAYNAME(transaction_date) AS day_name,
       MONTHNAME(transaction_date) AS month_name
FROM   workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT transaction_id,
       transaction_date,
       DAYNAME(transaction_date) AS day_name,
       MONTHNAME(transaction_date) AS month_name,
       transaction_qty*unit_price AS revenue
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT transaction_id,
       transaction_date,
       DAYNAME(transaction_date) AS day_name,
       MONTHNAME(transaction_date) AS month_name,
       transaction_qty*unit_price AS revenue_per_transaction
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

SELECT 
       transaction_date,
       Dayname(transaction_date) AS day_name,
       Monthname(transaction_date) AS month_name,
       COUNT(DISTINCT transaction_id) AS number_of_sales,
       SUM(transaction_qty*unit_price) AS revenue_per_transaction
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
GROUP BY transaction_date,
         Day_name,
         Month_name;
         

--8. Product name sold in each store


SELECT DISTINCT product_detail
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- 5. Product type; Gourmet brewed coffee


SELECT DISTINCT product_type
From workspace.default.BrightCoffeeShop_analysis_case_study_1;


-- 6. What products belong to which product category;


SELECT DISTINCT product_category as category,
                product_type,
                product_detail as product_name
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;


-- 7. Product cost
            
SELECT DISTINCT transaction_id,
                product_category,
                unit_price
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
LIMIT 50; 


SELECT product_category as category,
       unit_price as price
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
LIMIT 50;

-- Find the minimum unit price; 0.8

SELECT min (unit_price) as min_price
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- Find max price; 45

SELECT max (unit_price) as max_price
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;

-- Store performance: Which store location generates the highest total revenue?

SELECT store_location,
       SUM(unit_price) as total_revenue
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY store_location
ORDER BY total_revenue DESC;

-- How many transactions does each store location have?


SELECT store_location,
       COUNT(transaction_id) AS total_transactions
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY store_location
ORDER BY total_transactions DESC;

-- Product Analysis: Which product category has the highest average unit price?


SELECT product_category,
       AVG(unit_price) AS avg_unit_price
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY product_category
ORDER BY avg_unit_price DESC;

-- What are the top 5 best-selling products by quantity?

SELECT product_category,
       COUNT(*) AS total_sold
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY product_category
ORDER BY total_sold DESC
LIMIT 5;

-- Sales & Revenue: What is the total revenue generated across all locations?

SELECT SUM(unit_price) AS overall_revenue
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`;

-- Which transactions are above the average unit price?

SELECT transaction_id,
       product_category,
       unit_price
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
WHERE unit_price > (SELECT AVG(unit_price) 
                    FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`)
ORDER BY unit_price DESC;

-- Sales & Revenue: What is the total revenue generated across all locations?

SELECT SUM(unit_price) AS overall_revenue
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`;

-- Which transactions are above the average unit price?

SELECT transaction_id,
       product_category,
       unit_price
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
WHERE unit_price > (SELECT AVG(unit_price) 
                    FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`)
ORDER BY unit_price DESC;

--  Time-Based Trends: How do sales vary by month?

SELECT DATE_FORMAT(transaction_date, 'yyyy-MM') AS month,
       COUNT(transaction_id)                     AS total_transactions,
       SUM(unit_price)                 AS monthly_revenue
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY month
ORDER BY month ASC;

-- Which day of the week has the highest transactions?

SELECT DAYOFWEEK(transaction_date) AS day_of_week,
       COUNT(transaction_id)       AS total_transactions
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY day_of_week
ORDER BY total_transactions DESC;

-- Data Quality Checks: Are there any duplicate transaction IDs?

SELECT transaction_id,
       COUNT(*) AS occurrences
FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
GROUP BY transaction_id
HAVING occurrences > 1;

-- Are store location names consistent with no spelling variations?

SELECT *
FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
WHERE store_location='Lower Manhattan' OR store_location='Astoria';
