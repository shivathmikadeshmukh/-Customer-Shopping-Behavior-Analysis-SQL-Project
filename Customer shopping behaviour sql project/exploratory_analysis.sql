/* 1) Basic Data Understanding Queries*/

/*Total sales and qauntity sold overall*/

select 
	sum(quantity * price) as total_sales,
    sum(quantity) as total_quanitity
from Transactions;

-- 🧠 Insights:
-- - Total revenue generated from all transactions.
-- - Overall volume of items sold.
-- - Helps understand business scale and average pricing trends.


/* Number of Unique Customers*/

select count(distinct customer_id) as Unique_Customers from Customers;

-- 🧠 Insights:
-- - Indicates the breadth of customer base.
-- - Useful for calculating KPIs like Average Revenue per Customer (ARPU).
-- - Helps in identifying growth or retention strategies.

/* 2) Sales by Shopping Mall*/

/*Join Transactions with ShoppingMalls to analyze sales per mall: */

select 
 sm.shopping_mall,
 count(distinct t.invoice_no) as total_transactions,
 sum(t.price * t.quantity) as total_sales,
 sum(t.quantity) as total_units_sold 
from Transactions t
join ShoppingMalls sm
	on t.mall_id = sm.mall_id
Group by shopping_mall
order by total_sales desc;

-- 🧠 Insights:
-- - Identifies top-performing malls based on revenue and volume.
-- - Indicates which locations are more commercially viable.
-- - Helps target location-specific inventory and marketing.


/*3: Sales by Customer Demographics*/

SELECT
    c.gender,
    c.age,
    COUNT(DISTINCT t.invoice_no) AS total_transactions,
    SUM(t.quantity * t.price) AS total_spent
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
GROUP BY c.gender, c.age
ORDER BY total_spent DESC;

-- 🧠 Insights:
-- - Understands who your key buyers are by age and gender.
-- - Allows for targeted campaigns based on customer profiles.
-- - Can reveal high-value age brackets or underperforming segments.

/*4: Payment Method Analysis*/

SELECT
    payment_method,
    COUNT(DISTINCT invoice_no) AS transaction_count,
    SUM(quantity * price) AS total_sales
FROM Transactions
GROUP BY payment_method
ORDER BY total_sales DESC;

-- 🧠 Insights:
-- - Shows popularity and effectiveness of different payment methods.
-- - Helps decide where to offer promotions (e.g., credit card discounts).
-- - Identifies potential friction points (e.g., cash dependence).


/* 5: Category Performance*/
SELECT
    category,
    COUNT(DISTINCT invoice_no) AS transaction_count,
    SUM(quantity * price) AS total_sales,
    SUM(quantity) AS total_units_sold
FROM Transactions
GROUP BY category
ORDER BY total_sales DESC;


-- 🧠 Insights:
-- - Reveals best-selling and high-revenue product categories.
-- - Useful for inventory prioritization and vendor negotiations.
-- - Identifies low-performing categories for improvement or removal.

/*Top 10 Customers by Spend*/
SELECT
    t.customer_id,
    SUM(t.quantity * t.price) AS total_spent
FROM Transactions t
GROUP BY t.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 🧠 Insight:
-- - These customers contribute significantly to overall revenue.
-- - Ideal targets for loyalty or personalized campaigns.
-- - Losing them may create a large revenue dip.
-- - Combine with demographics for richer segmentation.


/*Average Basket Size per Transaction*/
SELECT
    invoice_no,
    SUM(quantity * price) AS basket_value
FROM Transactions
GROUP BY invoice_no
ORDER BY basket_value DESC;

-- 🧠 Insight:
-- - Helps understand typical customer spend per visit.
-- - Can be used to measure effectiveness of upselling.
-- - Compare across malls/categories to guide promotions.