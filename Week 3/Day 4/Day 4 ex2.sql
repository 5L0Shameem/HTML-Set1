CREATE DATABASE CustomerDb
GO

USE CustomerDb
GO

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50)
)

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_amount DECIMAL(10,2)
)

INSERT INTO customers VALUES
(1,'John','Doe'),
(2,'Sara','Ali'),
(3,'Michael','Smith'),
(4,'Emma','Brown')

INSERT INTO orders VALUES
(101,1,6000),
(102,1,5000),
(103,2,3000),
(104,3,12000)

-- Customers with orders
SELECT CONCAT(c.first_name,' ',c.last_name) AS full_name,
       SUM(o.order_amount) AS total_order_value,
       CASE 
           WHEN SUM(o.order_amount) > 10000 THEN 'Premium'
           WHEN SUM(o.order_amount) BETWEEN 5000 AND 10000 THEN 'Regular'
           ELSE 'Basic'
       END AS customer_class
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name

UNION

-- Customers without orders
SELECT CONCAT(c.first_name,' ',c.last_name) AS full_name,
       0 AS total_order_value,
       'Basic' AS customer_class
FROM customers c
WHERE c.customer_id NOT IN (SELECT DISTINCT customer_id FROM orders)
ORDER BY full_name