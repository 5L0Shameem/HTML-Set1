CREATE DATABASE EcommDb
GO

USE EcommDb
GO

CREATE TABLE categories(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
)

CREATE TABLE brands(
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(50)
)

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
)

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50)
)

CREATE TABLE stores(
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50)
)

INSERT INTO categories VALUES
(1,'Sedan'),
(2,'SUV'),
(3,'Truck'),
(4,'Electric'),
(5,'Hybrid')

INSERT INTO brands VALUES
(1,'Honda'),
(2,'Toyota'),
(3,'Ford'),
(4,'Tesla'),
(5,'BMW')

INSERT INTO products VALUES
(101,'Honda Civic',1,1,20000),
(102,'Toyota Corolla',2,1,22000),
(103,'Ford Explorer',3,2,35000),
(104,'Tesla Model 3',4,4,45000),
(105,'BMW X5',5,2,60000)

INSERT INTO customers VALUES
(1,'John','Doe','Chennai'),
(2,'Sara','Ali','Hyderabad'),
(3,'Michael','Smith','Bangalore'),
(4,'Emma','Brown','Chennai'),
(5,'David','Wilson','Mumbai')

INSERT INTO stores VALUES
(1,'Chennai Store','Chennai'),
(2,'Hyderabad Store','Hyderabad'),
(3,'Bangalore Store','Bangalore'),
(4,'Mumbai Store','Mumbai'),
(5,'Delhi Store','Delhi')

SELECT p.product_id, p.product_name, b.brand_name, c.category_name, p.list_price
FROM products p
INNER JOIN brands b ON p.brand_id = b.brand_id
INNER JOIN categories c ON p.category_id = c.category_id

SELECT customer_id, first_name, last_name, city
FROM customers
WHERE city = 'Chennai'

SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY total_products DESC