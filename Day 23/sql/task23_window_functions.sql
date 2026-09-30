-- TASK 23: SQL Window Functions Intro
-- Dataset: Synthetic sales dataset (SQLite-compatible)
-- 12 business queries using ROW_NUMBER, RANK, DENSE_RANK and LAG.

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    sale_date TEXT,
    customer TEXT,
    category TEXT,
    product TEXT,
    quantity INTEGER,
    unit_price REAL,
    sales_amount REAL
);

INSERT INTO sales VALUES (1, '2026-01-05', 'Alice', 'Electronics', 'Laptop', 2, 800, 1600);
INSERT INTO sales VALUES (2, '2026-01-08', 'Bob', 'Electronics', 'Monitor', 3, 220, 660);
INSERT INTO sales VALUES (3, '2026-01-12', 'Charlie', 'Office', 'Chair', 5, 90, 450);
INSERT INTO sales VALUES (4, '2026-01-18', 'Diana', 'Electronics', 'Keyboard', 10, 35, 350);
INSERT INTO sales VALUES (5, '2026-01-22', 'Ethan', 'Office', 'Desk', 2, 300, 600);
INSERT INTO sales VALUES (6, '2026-01-27', 'Fiona', 'Electronics', 'Laptop', 1, 800, 800);
INSERT INTO sales VALUES (7, '2026-02-03', 'Alice', 'Electronics', 'Monitor', 4, 220, 880);
INSERT INTO sales VALUES (8, '2026-02-07', 'Bob', 'Office', 'Desk', 3, 300, 900);
INSERT INTO sales VALUES (9, '2026-02-11', 'Charlie', 'Office', 'Chair', 8, 90, 720);
INSERT INTO sales VALUES (10, '2026-02-16', 'Diana', 'Electronics', 'Laptop', 2, 800, 1600);
INSERT INTO sales VALUES (11, '2026-02-21', 'Ethan', 'Office', 'Desk', 1, 300, 300);
INSERT INTO sales VALUES (12, '2026-02-26', 'Fiona', 'Electronics', 'Keyboard', 12, 35, 420);
INSERT INTO sales VALUES (13, '2026-03-04', 'Alice', 'Electronics', 'Laptop', 3, 800, 2400);
INSERT INTO sales VALUES (14, '2026-03-09', 'Bob', 'Electronics', 'Monitor', 5, 220, 1100);
INSERT INTO sales VALUES (15, '2026-03-14', 'Charlie', 'Office', 'Desk', 2, 300, 600);
INSERT INTO sales VALUES (16, '2026-03-18', 'Diana', 'Office', 'Chair', 10, 90, 900);
INSERT INTO sales VALUES (17, '2026-03-23', 'Ethan', 'Electronics', 'Laptop', 1, 800, 800);
INSERT INTO sales VALUES (18, '2026-03-28', 'Fiona', 'Electronics', 'Monitor', 6, 220, 1320);
INSERT INTO sales VALUES (19, '2026-04-02', 'Alice', 'Office', 'Desk', 4, 300, 1200);
INSERT INTO sales VALUES (20, '2026-04-07', 'Bob', 'Electronics', 'Laptop', 2, 800, 1600);
INSERT INTO sales VALUES (21, '2026-04-12', 'Charlie', 'Electronics', 'Keyboard', 15, 35, 525);
INSERT INTO sales VALUES (22, '2026-04-17', 'Diana', 'Electronics', 'Monitor', 7, 220, 1540);
INSERT INTO sales VALUES (23, '2026-04-22', 'Ethan', 'Office', 'Chair', 6, 90, 540);
INSERT INTO sales VALUES (24, '2026-04-27', 'Fiona', 'Electronics', 'Laptop', 2, 800, 1600);
INSERT INTO sales VALUES (25, '2026-05-03', 'Alice', 'Electronics', 'Monitor', 8, 220, 1760);
INSERT INTO sales VALUES (26, '2026-05-08', 'Bob', 'Office', 'Desk', 2, 300, 600);
INSERT INTO sales VALUES (27, '2026-05-13', 'Charlie', 'Electronics', 'Laptop', 1, 800, 800);
INSERT INTO sales VALUES (28, '2026-05-18', 'Diana', 'Office', 'Chair', 12, 90, 1080);
INSERT INTO sales VALUES (29, '2026-05-23', 'Ethan', 'Electronics', 'Monitor', 4, 220, 880);
INSERT INTO sales VALUES (30, '2026-05-28', 'Fiona', 'Office', 'Desk', 3, 300, 900);
INSERT INTO sales VALUES (31, '2026-06-04', 'Alice', 'Electronics', 'Laptop', 2, 800, 1600);
INSERT INTO sales VALUES (32, '2026-06-09', 'Bob', 'Electronics', 'Keyboard', 20, 35, 700);
INSERT INTO sales VALUES (33, '2026-06-14', 'Charlie', 'Office', 'Chair', 7, 90, 630);
INSERT INTO sales VALUES (34, '2026-06-19', 'Diana', 'Office', 'Desk', 3, 300, 900);
INSERT INTO sales VALUES (35, '2026-06-24', 'Ethan', 'Electronics', 'Laptop', 2, 800, 1600);
INSERT INTO sales VALUES (36, '2026-06-29', 'Fiona', 'Electronics', 'Monitor', 5, 220, 1100);

-- ==================== 12 WINDOW FUNCTION QUERIES ====================

-- Q01_Row_Number_Overall
SELECT sale_id, sale_date, customer, product, sales_amount,
       ROW_NUMBER() OVER (ORDER BY sales_amount DESC, sale_id) AS row_num
FROM sales
ORDER BY row_num;

-- Q02_Row_Number_By_Customer
SELECT sale_id, sale_date, customer, product, sales_amount,
       ROW_NUMBER() OVER (
           PARTITION BY customer
           ORDER BY sales_amount DESC, sale_date
       ) AS customer_row_num
FROM sales
ORDER BY customer, customer_row_num;

-- Q03_Rank_Overall
SELECT sale_id, customer, product, sales_amount,
       RANK() OVER (ORDER BY sales_amount DESC) AS sales_rank
FROM sales
ORDER BY sales_rank, sale_id;

-- Q04_Dense_Rank_Overall
SELECT sale_id, customer, product, sales_amount,
       DENSE_RANK() OVER (ORDER BY sales_amount DESC) AS dense_sales_rank
FROM sales
ORDER BY dense_sales_rank, sale_id;

-- Q05_Rank_By_Category
SELECT sale_id, category, customer, product, sales_amount,
       RANK() OVER (
           PARTITION BY category
           ORDER BY sales_amount DESC
       ) AS category_rank
FROM sales
ORDER BY category, category_rank, sale_id;

-- Q06_Dense_Rank_By_Customer
SELECT sale_id, customer, product, sales_amount,
       DENSE_RANK() OVER (
           PARTITION BY customer
           ORDER BY sales_amount DESC
       ) AS customer_dense_rank
FROM sales
ORDER BY customer, customer_dense_rank, sale_id;

-- Q07_Lag_Customer_Sales
SELECT sale_id, sale_date, customer, sales_amount,
       LAG(sales_amount) OVER (
           PARTITION BY customer
           ORDER BY sale_date, sale_id
       ) AS previous_customer_sale
FROM sales
ORDER BY customer, sale_date, sale_id;

-- Q08_Sales_Change_From_Previous
WITH x AS (
    SELECT sale_id, sale_date, customer, sales_amount,
           LAG(sales_amount) OVER (
               PARTITION BY customer
               ORDER BY sale_date, sale_id
           ) AS previous_sale
    FROM sales
)
SELECT sale_id, sale_date, customer, sales_amount, previous_sale,
       sales_amount - previous_sale AS change_from_previous
FROM x
ORDER BY customer, sale_date, sale_id;

-- Q09_Lag_Overall_Trend
SELECT sale_id, sale_date, customer, sales_amount,
       LAG(sales_amount) OVER (
           ORDER BY sale_date, sale_id
       ) AS previous_overall_sale
FROM sales
ORDER BY sale_date, sale_id;

-- Q10_Top_2_Sales_Per_Customer
WITH ranked AS (
    SELECT sale_id, sale_date, customer, product, sales_amount,
           ROW_NUMBER() OVER (
               PARTITION BY customer
               ORDER BY sales_amount DESC, sale_date
           ) AS rn
    FROM sales
)
SELECT sale_id, sale_date, customer, product, sales_amount, rn
FROM ranked
WHERE rn <= 2
ORDER BY customer, rn;

-- Q11_Category_Top_Sales
WITH ranked AS (
    SELECT sale_id, category, customer, product, sales_amount,
           DENSE_RANK() OVER (
               PARTITION BY category
               ORDER BY sales_amount DESC
           ) AS rnk
    FROM sales
)
SELECT sale_id, category, customer, product, sales_amount, rnk
FROM ranked
WHERE rnk <= 3
ORDER BY category, rnk, sale_id;

-- Q12_Monthly_Lag_Trend
WITH monthly AS (
    SELECT strftime('%Y-%m', sale_date) AS month,
           SUM(sales_amount) AS monthly_sales
    FROM sales
    GROUP BY strftime('%Y-%m', sale_date)
)
SELECT month, monthly_sales,
       LAG(monthly_sales) OVER (ORDER BY month) AS previous_month_sales,
       monthly_sales - LAG(monthly_sales) OVER (ORDER BY month) AS month_change
FROM monthly
ORDER BY month;

