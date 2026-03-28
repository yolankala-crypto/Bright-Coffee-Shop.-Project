 -- Checkng if the table is laoded correctly and properly readable
+ SELECT *
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
+ LIMIT 100;
+ 
+ ------------------------------------------------------
+ -- 1. Checking the date range
+ -----------------------------------------------------
+ 
+ -- They started collection the data on 2023-01-01
+ SELECT MIN(transaction_date) as start_date
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ -- They stoped collecting data on the 2023-06-30
+ SELECT MAX(transaction_date) as latest_data
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ --------------------------------------------------------------------
+ -- 2. Checking store location names
+ --------------------------------------------------------------------
+ 
+ -- 3 store locations; Lower Manhattan, Hell's Kitchen, Astoria
+ SELECT DISTINCT store_location
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ --------------------------------------------------------------------
+ -- 3. Product category sold in each store Coffee, Tea, Drinking Chocolate, Bakery,Flavours,Loose Tea, Coffee beans, Packaged Chocolate,Branded   
+ --------------------------------------------------------------------
+ 
+ SELECT DISTINCT product_category
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ --------------------------------------------------------------------
+ --4. Product name sold in each store
+ --------------------------------------------------------------------
+ 
+ SELECT DISTINCT product_detail
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ -------------------------------------------------------------------
+ -- 5. Product type; Gourmet brewed coffee
+ ------------------------------------------------------------------
+ 
+ SELECT DISTINCT product_type
+ From workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ -----------------------------------------------------------------
+ -- 6. What products belong to which product category;
+ ----------------------------------------------------------------
+ 
+ SELECT DISTINCT product_category as category,
+                 product_type,
+                 product_detail as product_name
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ 
+ --------------------------------------------------------------- 
+ -- 7. Product cost
+ ---------------------------------------------------------------             
+ SELECT DISTINCT transaction_id,
+                 product_category,
+                 unit_price
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
+ LIMIT 50; 
+ 
+ ---------------------------------------------------------------
+ SELECT product_category as category,
+        unit_price as price
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
+ LIMIT 50;
+ -------------------------------------------------------------
+ -- Find the minimum unit price; 0.8
+ ------------------------------------------------------------
+ SELECT min (unit_price) as min_price
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ ------------------------------------------------------------
+ -- Find max price; 45
+ -----------------------------------------------------------
+ SELECT max (unit_price) as max_price
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1;
+ -----------------------------------------------------------
+ -- Store performance: Which store location generates the highest total revenue?
+ -----------------------------------------------------------
+ SELECT store_location,
+        SUM(unit_price) as total_revenue
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY store_location
+ ORDER BY total_revenue DESC;
+ -----------------------------------------------------------
+ -- How many transactions does each store location have?
+ -----------------------------------------------------------
+ 
+ SELECT store_location,
+        COUNT(transaction_id) AS total_transactions
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY store_location
+ ORDER BY total_transactions DESC;
+ ----------------------------------------------------------
+ -- Product Analysis: Which product category has the highest average unit price?
+ ----------------------------------------------------------
+ 
+ SELECT product_category,
+        AVG(unit_price) AS avg_unit_price
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY product_category
+ ORDER BY avg_unit_price DESC;
+ ----------------------------------------------------------
+ -- What are the top 5 best-selling products by quantity?
+ ---------------------------------------------------------
+ SELECT product_category,
+        COUNT(*) AS total_sold
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY product_category
+ ORDER BY total_sold DESC
+ LIMIT 5;
+ -----------------------------------------------------------
+ -- Sales & Revenue: What is the total revenue generated across all locations?
+ -----------------------------------------------------------
+ SELECT SUM(unit_price) AS overall_revenue
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`;
+ ------------------------------------------------------------
+ -- Which transactions are above the average unit price?
+ -----------------------------------------------------------
+ SELECT transaction_id,
+        product_category,
+        unit_price
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ WHERE unit_price > (SELECT AVG(unit_price) 
+                     FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`)
+ ORDER BY unit_price DESC;
+ ---------------------------------------------------------------
+ -- Sales & Revenue: What is the total revenue generated across all locations?
+ ---------------------------------------------------------------
+ SELECT SUM(unit_price) AS overall_revenue
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`;
+ ---------------------------------------------------------------
+ -- Which transactions are above the average unit price?
+ ---------------------------------------------------------------
+ SELECT transaction_id,
+        product_category,
+        unit_price
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ WHERE unit_price > (SELECT AVG(unit_price) 
+                     FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`)
+ ORDER BY unit_price DESC;
+ ---------------------------------------------------------------
+ --  Time-Based Trends: How do sales vary by month?
+ ---------------------------------------------------------------
+ SELECT DATE_FORMAT(transaction_date, 'yyyy-MM') AS month,
+        COUNT(transaction_id)                     AS total_transactions,
+        SUM(unit_price)                 AS monthly_revenue
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY month
+ ORDER BY month ASC;
+ ---------------------------------------------------------------
+ -- Which day of the week has the highest transactions?
+ ---------------------------------------------------------------
+ SELECT DAYOFWEEK(transaction_date) AS day_of_week,
+        COUNT(transaction_id)       AS total_transactions
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY day_of_week
+ ORDER BY total_transactions DESC;
+ ----------------------------------------------------------------
+ -- Data Quality Checks: Are there any duplicate transaction IDs?
+ ----------------------------------------------------------------
+ SELECT transaction_id,
+        COUNT(*) AS occurrences
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ GROUP BY transaction_id
+ HAVING occurrences > 1;
+ ---------------------------------------------------------------
+ -- Are there any NULL values in key columns?
+ ---------------------------------------------------------------
+ SELECT COUNT(*) AS null_count
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ WHERE transaction_id IS NULL
+    OR unit_price     IS NULL
+    OR product_category IS NULL
+    OR store_location  IS NULL;
+ --------------------------------------------------------------
+ -- Are store location names consistent with no spelling variations?
+ -------------------------------------------------------------
+ SELECT DISTINCT store_location
+ FROM `workspace`.`default`.`BrightCoffeeShop_analysis_case_study_1`
+ ORDER BY store_location ASC;
+ WHERE store_location='lower_manhattan' OR '';
+ 
+ SELECT *
+ FROM workspace.default.BrightCoffeeShop_analysis_case_study_1
+ WHERE store_location='Lower Manhattan' OR store_location='Astoria';
+ 
+ 
