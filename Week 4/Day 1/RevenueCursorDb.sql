CREATE DATABASE RevenueCursorDB
GO

USE RevenueCursorDB
GO

CREATE TABLE Stores(
StoreID INT PRIMARY KEY,
StoreName VARCHAR(100)
)
GO

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
StoreID INT,
Order_Status INT,
Discount DECIMAL(5,2),
FOREIGN KEY(StoreID) REFERENCES Stores(StoreID)
)
GO

CREATE TABLE OrderItems(
OrderItemID INT PRIMARY KEY,
OrderID INT,
ProductName VARCHAR(100),
Quantity INT,
UnitPrice DECIMAL(10,2),
FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
)
GO

INSERT INTO Stores VALUES (1,'Store A')
INSERT INTO Stores VALUES (2,'Store B')
GO

INSERT INTO Orders VALUES (1,1,4,10)
INSERT INTO Orders VALUES (2,1,4,5)
INSERT INTO Orders VALUES (3,2,4,0)
GO

INSERT INTO OrderItems VALUES (1,1,'Laptop',2,50000)
INSERT INTO OrderItems VALUES (2,1,'Mouse',3,500)
INSERT INTO OrderItems VALUES (3,2,'Keyboard',2,1500)
INSERT INTO OrderItems VALUES (4,3,'Monitor',1,12000)
GO

CREATE TABLE #RevenueTemp(
StoreID INT,
OrderID INT,
Revenue DECIMAL(12,2)
)

BEGIN TRY
BEGIN TRANSACTION

DECLARE @OrderID INT
DECLARE @StoreID INT
DECLARE @Discount DECIMAL(5,2)
DECLARE @Revenue DECIMAL(12,2)

DECLARE OrderCursor CURSOR FOR
SELECT OrderID, StoreID, Discount
FROM Orders
WHERE Order_Status = 4

OPEN OrderCursor

FETCH NEXT FROM OrderCursor INTO @OrderID,@StoreID,@Discount

WHILE @@FETCH_STATUS = 0
BEGIN

SELECT @Revenue = SUM(Quantity * UnitPrice)
FROM OrderItems
WHERE OrderID = @OrderID

IF @Discount IS NULL
SET @Discount = 0

SET @Revenue = @Revenue - (@Revenue * @Discount / 100)

INSERT INTO #RevenueTemp VALUES (@StoreID,@OrderID,@Revenue)

FETCH NEXT FROM OrderCursor INTO @OrderID,@StoreID,@Discount
END

CLOSE OrderCursor
DEALLOCATE OrderCursor

COMMIT TRANSACTION

END TRY

BEGIN CATCH
ROLLBACK TRANSACTION
PRINT 'Error occurred during revenue calculation'
END CATCH

SELECT StoreID,SUM(Revenue) AS TotalRevenue
FROM #RevenueTemp
GROUP BY StoreID