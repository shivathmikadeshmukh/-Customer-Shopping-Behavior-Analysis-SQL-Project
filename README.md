# -Customer-Shopping-Behavior-Analysis-SQL-Project
This project explores and analyzes customer shopping behavior using structured SQL queries on a normalized retail dataset. The objective is to derive actionable business insights that could help in improving customer engagement, optimizing inventory, and increasing revenue.

# 🧾 Customer Shopping Behavior SQL Project

## 📌 Overview

This project analyzes retail customer transactions to generate actionable business insights using MySQL. The dataset contains transactional, demographic, and mall-level sales information.

The project is split into three parts for clarity:
1. Schema Design & Normalization
2. Exploratory Data Analysis
3. Advanced Customer Behavior Analysis

---

## 📂 File Structure

| File | Description |
|------|-------------|
| `1_schema_and_normalization.sql` | Normalizes raw data into 3 relational tables |
| `2_exploratory_analysis.sql`     | Performs basic sales, mall, and demographic analysis |
| `3_advanced_analysis.sql`        | Covers segmentation, repeat purchases, and advanced metrics |

---

## 📊 Business Questions Answered

- Who are the top 10 customers by spend?
- What is the total revenue and quantity sold?
- Which malls and product categories perform best?
- What are the payment trends across age groups?
- How loyal are our customers (repeat rate)?
- How do customer segments differ by spend level?

---

## 🧠 Techniques Used

- CTEs (Common Table Expressions)
- Joins between normalized tables
- Window functions (`ROW_NUMBER`)
- Conditional logic using `CASE`
- Aggregates: `SUM`, `COUNT`, `AVG`
- Sorting, filtering, and grouping

---

## ✅ Tools

- MySQL Workbench 8.x
- Dataset from Kaggle: [Customer Shopping Dataset](https://www.kaggle.com/datasets/mehmettahiraslan/customer-shopping-dataset)
