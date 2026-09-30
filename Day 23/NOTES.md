# Task 23 – SQL Window Functions Intro

## Objective
Learn analytical SQL patterns using ROW_NUMBER, RANK, DENSE_RANK and LAG.

## Dataset
A synthetic sales dataset with 36 transactions across 6 customers, 2 categories and 5 products.
It is stored in `sales_data.csv` and in the SQLite database `task23_window_functions.db`.

## What was practiced
1. ROW_NUMBER for unique ordering.
2. ROW_NUMBER with PARTITION BY for customer-level ordering.
3. RANK for competition-style ranking with gaps after ties.
4. DENSE_RANK for ranking without gaps after ties.
5. Ranking within categories.
6. Dense ranking within customers.
7. LAG for the previous sale of each customer.
8. Calculating change from the previous customer sale.
9. LAG for overall transaction trend.
10. Finding the top 2 sales per customer.
11. Finding top-ranked sales within each category.
12. Monthly sales comparison using LAG.

## RANK vs DENSE_RANK
- RANK gives the same rank to ties and leaves gaps after the tie.
- DENSE_RANK gives the same rank to ties but does not leave gaps.

Example: values 100, 100, 90
- RANK: 1, 1, 3
- DENSE_RANK: 1, 1, 2

## When to use LAG
Use LAG when a business question needs the previous row's value, such as:
- previous month's sales
- previous purchase amount
- month-over-month change
- customer purchase trends

## How to run
SQLite:
    sqlite3 task23_window_functions.db

Then run the SQL in:
    sql/task23_window_functions.sql

Python/pandas users can also inspect all results in:
    Task23_Window_Functions_Outputs.xlsx
