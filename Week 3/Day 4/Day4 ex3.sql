CREATE DATABASE StorePerformanceDb
GO

USE StorePerformanceDb
GO

CREATE TABLE stores(
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100)
)

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    list_price DECIMAL(10,2)
)

CREATE TABLE stocks(
    stock_id INT PRIMARY KEY,
    store_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
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
    product_id INT,
    quantity INT,
    discount DECIMAL(4,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
)

-- Sample Data
INSERT INTO stores VALUES
(1,'Chennai Store'),
(2,'Hyderabad Store')

INSERT INTO products VALUES
(101,'Laptop',1500),
(102,'Mobile',800),
(103,'Tablet',600)

INSERT INTO stocks VALUES
(1,1,101,0),
(2,1,102,10),
(3,2,103,0),
(4,2,101,5)

INSERT INTO orders VALUES
(201,1,4),
(202,2,4)

INSERT INTO order_items VALUES
(1,201,101,2,0.10),
(2,201,102,3,0.05),
(3,202,103,1,0.00),
(4,202,101,2,0.05)

-- Query: Sold products per store that have zero stock
;WITH SoldProducts AS (
    SELECT o.store_id, oi.product_id, SUM(oi.quantity) AS total_sold
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.store_id, oi.product_id
),
ZeroStock AS (
    SELECT store_id, product_id
    FROM stocks
    WHERE quantity = 0
)
SELECT s.store_name, p.product_name, sp.total_sold,
       sp.total_sold * p.list_price * (1 - COALESCE(MAX(oi.discount),0)) AS total_revenue
FROM SoldProducts sp
INNER JOIN stores s ON sp.store_id = s.store_id
INNER JOIN products p ON sp.product_id = p.product_id
LEFT JOIN order_items oi 
       ON sp.product_id = oi.product_id AND sp.store_id = oi.order_id
WHERE EXISTS (
    SELECT 1 
    FROM ZeroStock zs
    WHERE zs.store_id = sp.store_id AND zs.product_id = sp.product_id
)
GROUP BY s.store_name, p.product_name, sp.total_sold, p.list_price

-- Simulate stock update to 0 for discontinued products
UPDATE st
SET st.quantity = 0
FROM stocks st
INNER JOIN ZeroStock zs ON st.store_id = zs.store_id AND st.product_id = zs.product_id