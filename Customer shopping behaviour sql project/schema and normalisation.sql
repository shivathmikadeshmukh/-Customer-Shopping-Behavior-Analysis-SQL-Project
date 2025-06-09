USE CUSTOMER_SALES;

SELECT * from customer_shopping_data;

/*lets add a column giving unique id for every shopping mall */

ALTER TABLE customer_shopping_data
ADD mall_id INT;


WITH MallIDs AS (
    SELECT 
        shopping_mall,
        DENSE_RANK() OVER (ORDER BY shopping_mall) AS mall_id
    FROM (
        SELECT DISTINCT shopping_mall
        FROM customer_shopping_data
    ) AS distinct_malls
)

UPDATE customer_shopping_data csd
SET mall_id = (
    SELECT mall_id 
    FROM MallIDs m
    WHERE csd.shopping_mall = m.shopping_mall
);


/* normalization*/


-- Customers table
CREATE TABLE Customers AS
SELECT DISTINCT customer_id, gender, age FROM customer_shopping_data;

-- Shopping Malls table
CREATE TABLE ShoppingMalls AS
SELECT DISTINCT shopping_mall, mall_id  FROM customer_shopping_data;

-- Transactions table
CREATE TABLE Transactions AS
SELECT 
    invoice_no,
    customer_id,
    category,
    quantity,
    price,
    payment_method,
    mall_id,
    invoice_date
FROM customer_shopping_data csd;

select * from Customers;
select * from ShoppingMalls;
select * from Transactions;