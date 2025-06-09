-- Customer Segmentation by Purchase Behavior
WITH CustomerSpend AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM Transactions
    GROUP BY customer_id
),

SpendSegments AS (
    SELECT
        customer_id,
        total_spent,
        CASE
            WHEN total_spent < 100 THEN 'Low'
            WHEN total_spent BETWEEN 100 AND 500 THEN 'Medium'
            ELSE 'High'
        END AS spend_segment
    FROM CustomerSpend
)

SELECT
    spend_segment,
    COUNT(customer_id) AS customer_count,
    AVG(total_spent) AS avg_spent_per_customer
FROM SpendSegments
GROUP BY spend_segment
ORDER BY FIELD(spend_segment, 'Low', 'Medium', 'High');


-- 🧠 Insights:
-- - Helps identify where most customers fall — typically skewed toward Low or Medium.
-- - 'High' spenders, though fewer in number, contribute disproportionately to total sales.
-- - Enables focused marketing: upsell Low → Medium, and retain High with loyalty programs.
-- - Useful for creating customer personas and lifecycle strategies.

/* Top Categories by Sales per Mall*/

WITH MallCategorySales AS (
    SELECT
        sm.shopping_mall,
        t.category,
        SUM(t.quantity * t.price) AS sales_amount,
        ROW_NUMBER() OVER (PARTITION BY sm.shopping_mall ORDER BY SUM(t.quantity * t.price) DESC) AS rankk
    FROM Transactions t
    JOIN ShoppingMalls sm ON t.mall_id = sm.mall_id
    GROUP BY sm.shopping_mall, t.category
)

SELECT
    shopping_mall,
    category,
    sales_amount
FROM MallCategorySales
WHERE rankk <= 3
ORDER BY shopping_mall, sales_amount DESC;


-- 🧠 Insights:
-- - Highlights top 3 selling product categories per mall.
-- - Can inform mall-specific stocking, promotions, or displays.
-- - Helps detect location-based customer preferences and trends.
-- - Potential for partnerships with suppliers/vendors for top categories in top-performing locations.


-- Repeat Purchase Rate by Customer
WITH CustomerInvoiceCounts AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS invoice_count
    FROM Transactions
    GROUP BY customer_id
)

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN invoice_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(100.0 * SUM(CASE WHEN invoice_count > 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS repeat_purchase_rate_pct
FROM CustomerInvoiceCounts;

-- 4.  Payment Method Preference by Age Group

WITH AgeGroups AS (
    SELECT
        customer_id,
        CASE
            WHEN age < 25 THEN '<25'
            WHEN age BETWEEN 25 AND 40 THEN '25-40'
            WHEN age BETWEEN 41 AND 60 THEN '41-60'
            ELSE '60+'
        END AS age_group
    FROM Customers
)

SELECT
    ag.age_group,
    t.payment_method,
    COUNT(DISTINCT t.invoice_no) AS transaction_count,
    SUM(t.quantity * t.price) AS total_sales
FROM Transactions t
JOIN AgeGroups ag ON t.customer_id = ag.customer_id
GROUP BY ag.age_group, t.payment_method
ORDER BY ag.age_group, total_sales DESC;

-- 🧠 Insights:
-- - Younger age groups (<25, 25–40) may favor digital wallets or cards.
-- - Older groups may show higher usage of cash or traditional methods.
-- - Helps optimize POS (Point of Sale) systems and offer age-specific incentives (e.g., cashback on UPI for Gen Z).
-- - Supports user experience design in digital commerce and in-store experience.



