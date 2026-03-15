CREATE DATABASE SalesDb
GO

USE SalesDb
GO

CREATE TABLE stores(
store_id INT PRIMARY KEY,
store_name VARCHAR(100)
)

CREATE TABLE orders(
order_id INT PRIMARY KEY,
store_id INT,
order_status INT,
FOREIGN KEY (store_id) REFERENCES stores(store_id)
)

CREATE TABLE order_items(
item_id INT PRIMARY KEY,
order_id INT,
quantity INT,
list_price DECIMAL(10,2),
discount DECIMAL(4,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
)

INSERT INTO stores VALUES
(1,'Chennai Store'),
(2,'Hyderabad Store'),
(3,'Bangalore Store')

INSERT INTO orders VALUES
(101,1,4),
(102,2,4),
(103,3,1)

INSERT INTO order_items VALUES
(1,101,2,1000,0.10),
(2,101,1,500,0.05),
(3,102,3,700,0.00),
(4,103,1,900,0.15)

SELECT s.store_name,
SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM stores s
INNER JOIN orders o ON s.store_id = o.store_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 4
GROUP BY s.store_name
ORDER BY total_sales DESC