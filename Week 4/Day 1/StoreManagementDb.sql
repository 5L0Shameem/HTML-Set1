CREATE DATABASE StockManagementDB
GO

USE StockManagementDB
GO

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100)
)
GO

CREATE TABLE Stocks(
ProductID INT PRIMARY KEY,
StockQuantity INT,
FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
)
GO

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
OrderDate DATE
)
GO

CREATE TABLE OrderItems(
OrderItemID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
)
GO

CREATE TRIGGER trg_UpdateStockAfterInsert
ON OrderItems
AFTER INSERT
AS
BEGIN
BEGIN TRY

IF EXISTS(
SELECT 1
FROM inserted i
JOIN Stocks s ON i.ProductID = s.ProductID
WHERE s.StockQuantity < i.Quantity
)
BEGIN
THROW 50001, 'Insufficient stock available', 1
ROLLBACK TRANSACTION
RETURN
END

UPDATE s
SET s.StockQuantity = s.StockQuantity - i.Quantity
FROM Stocks s
JOIN inserted i
ON s.ProductID = i.ProductID

END TRY

BEGIN CATCH
ROLLBACK TRANSACTION
THROW
END CATCH

END
GO

INSERT INTO Products VALUES (1,'Laptop')
INSERT INTO Products VALUES (2,'Mobile')
GO

INSERT INTO Stocks VALUES (1,20)
INSERT INTO Stocks VALUES (2,15)
GO

INSERT INTO Orders VALUES (1,'2024-01-01')
GO

INSERT INTO OrderItems VALUES (1,1,1,5)
GO

SELECT * FROM Stocks
GO