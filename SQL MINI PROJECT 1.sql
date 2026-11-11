 -- ============================================
-- SQL MINI PROJECT 1: SALES & ORDER ANALYSIS
-- Database: BA_Sales_Project
-- Purpose: Analyze sales, customers, products,
-- orders, revenue and profitability.
-- ============================================
 
CREATE DATABASE BA_Sales_Project;
 
 USE BA_Sales_Project;
 
 -- ============================================
-- 1. TABLE CREATION
-- ============================================
 
 CREATE TABLE Customers (
 CustomerID INT PRIMARY KEY,
 CustomerName VARCHAR(100),
 City VARCHAR(50),
 Region VARCHAR(50)
 );

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2)
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
Status VARCHAR(20),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Order_Details (
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
UnitPrice DECIMAL(10,2),
CostPerUnit DECIMAL(10,2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ============================================
-- 2. INSERTING SAMPLE DATA
-- ============================================

INSERT INTO Customers VALUES
(1,'Amit Sharma','Delhi','North'),
(2,'Priya Singh','Mumbai','West'),
(3,'Rahul Verma','Lucknow','North'),
(4,'Neha Gupta','Pune','West'),
(5,'Arjun Mehta','Bengaluru','South'),
(6,'Sneha Patel','Ahmedabad','West'),
(7,'Vikas Kumar','Jaipur','North'),
(8,'Riya Das','Kolkata','East'),
(9,'Karan Shah','Hyderabad','South'),
(10,'Pooja Nair','Chennai','South');

SELECT* FROM Customers;

INSERT INTO Products VALUES
(101,'Laptop','Electronics',70000),
(102,'Monitor','Electronics',25000),
(103,'Keyboard','Accessories',3000),
(104,'Mouse','Accessories',1500),
(105,'Office Chair','Furniture',12000),
(106,'Desk','Furniture',18000),
(107,'Printer','Office Equipment',22000),
(108,'Headphones','Electronics',5000);

SELECT* FROM Products;

INSERT INTO Orders VALUES
(1001,1,'2026-01-05','Completed'),
(1002,2,'2026-01-12','Completed'),
(1003,3,'2026-01-20','Completed'),
(1004,4,'2026-02-03','Completed'),
(1005,5,'2026-02-15','Cancelled'),
(1006,6,'2026-03-02','Completed'),
(1007,7,'2026-03-18','Completed'),
(1008,8,'2026-04-05','Completed'),
(1009,9,'2026-04-22','Pending'),
(1010,10,'2026-05-10','Completed'),
(1011,1,'2026-05-25','Completed'),
(1012,2,'2026-06-08','Completed'),
(1013,5,'2026-06-20','Completed'),
(1014,7,'2026-07-04','Completed'),
(1015,8,'2026-07-19','Completed'),
(1016,9,'2026-08-01','Completed'),
(1017,3,'2026-08-14','Completed'),
(1018,4,'2026-08-25','Completed');

SELECT* FROM Orders;

INSERT INTO Order_Details VALUES
(1,1001,101,2,68000,52000),
(2,1001,103,3,2800,1800),
(3,1002,102,2,24000,17000),
(4,1002,104,4,1400,800),
(5,1003,105,5,11500,7500),
(6,1004,101,1,69000,52000),
(7,1004,108,4,4800,3000),
(8,1005,106,2,17500,12000),
(9,1006,107,3,21000,14500),
(10,1007,101,2,67500,52000),
(11,1007,104,5,1350,800),
(12,1008,102,3,23500,17000),
(13,1009,105,2,11800,7500),
(14,1010,106,4,17500,12000),
(15,1011,101,1,70000,52000),
(16,1011,108,5,4700,3000),
(17,1012,107,2,21500,14500),
(18,1013,102,4,24000,17000),
(19,1014,101,3,68000,52000),
(20,1015,105,4,12000,7500),
(21,1016,108,6,4900,3000),
(22,1017,103,8,2900,1800),
(23,1018,106,3,18000,12000);

-- ============================================
-- 3. DATA EXPLORATION
-- ============================================

SELECT* FROM Order_Details;

SELECT COUNT(*) FROM Customers;

SELECT COUNT(*) FROM Products;

SELECT COUNT(*) FROM Orders;

SELECT COUNT(*) FROM Order_Details;

SELECT ProductName, Category, Price
FROM Products;

SELECT* FROM PRODUCTS
WHERE Price>20000;

SELECT* FROM ORDERS
WHERE Status='Completed';

SELECT* FROM ORDERS
WHERE OrderDate > '2026-03-01';

SELECT* FROM PRODUCTS
WHERE Category = 'Electronics';

SELECT* FROM CUSTOMERS
WHERE Region = 'North';

-- ============================================
-- 4. FILTERING, SORTING AND LIMITING
-- ============================================

SELECT* FROM Products
ORDER BY Price DESC;

SELECT* FROM Products
ORDER BY Price DESC
LIMIT 5;

SELECT* FROM Orders
WHERE Status IN ('Pending', 'Cancelled');

SELECT* FROM Products
WHERE Price BETWEEN 5000 AND 25000;

SELECT* FROM Customers
WHERE CustomerName LIKE 'A%';

-- ============================================
-- 5. AGGREGATE FUNCTIONS
-- ============================================

SELECT COUNT(*) AS TotalOrders
FROM ORDERS;

SELECT SUM(Quantity) AS TotalQuantitySold 
FROM Order_Details;

SELECT SUM(Quantity*UnitPrice) AS TotalRevenue
FROM Order_Details;

SELECT SUM(Quantity*CostPerUnit) AS TotalCost
FROM order_details;

SELECT SUM(Quantity*UnitPrice)-SUM(Quantity*CostPerUnit) AS TotalProfit
FROM Order_Details;

SELECT AVG(Price) AS AveragePrice
FROM Products;

SELECT MAX(Price) AS MaximumPrice
FROM Products;

SELECT MIN(Price) AS MinimumPrice
FROM Products;

-- ============================================
-- 6. GROUP BY AND HAVING
-- ============================================

SELECT PRODUCTID, SUM(Quantity*UnitPrice) AS TotalRevenue
FROM order_details
GROUP BY ProductID;

SELECT p.Category, SUM(od.Quantity*od.UnitPrice) AS TotalRevenue
FROM order_details od
JOIN Products  p
ON od.ProductId=p.ProductID
GROUP BY p.Category;

SELECT p.Category, SUM(od.Quantity*od.UnitPrice)-SUM(od.Quantity*od.CostPerUnit) AS TotalProfit
FROM order_details od
JOIN Products  p
ON od.ProductId=p.ProductID
GROUP BY p.Category;

SELECT Region, COUNT(CustomerID) AS TotalCustomers 
FROM Customers 
GROUP BY Region;

SELECT Status, COUNT(OrderID) AS TotalOrders 
FROM Orders 
GROUP BY Status;

SELECT p.Category, SUM(od.Quantity) AS TotalQuantitySold 
FROM Order_Details od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.Category;

SELECT p.Category, SUM(od.Quantity*od.UnitPrice) AS TotalRevenue
FROM order_details od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
HAVING TotalRevenue > 50000;

SELECT CustomerID, COUNT(OrderID) AS TotalOrders 
FROM Orders 
GROUP BY CustomerID 
HAVING COUNT(OrderID) > 1;

SELECT c.Region, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Order_Details od ON o.OrderID = od.OrderID 
GROUP BY c.Region 
HAVING SUM(od.Quantity * od.UnitPrice) > 100000;

-- ============================================
-- 7. JOINS
-- ============================================

SELECT OrderID, CustomerName, OrderDate, Region, Status
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID;

SELECT OrderID, ProductName, Quantity, UnitPrice
FROM order_details od
JOIN products p ON od.ProductID = p.ProductID;

SELECT o.OrderID, c.CustomerName, p.ProductName, od.Quantity, (od.Quantity * od.UnitPrice) AS Revenue 
FROM Order_Details od 
JOIN Orders o ON od.OrderID = o.OrderID 
JOIN Customers c ON o.CustomerID = c.CustomerID 
JOIN Products p ON od.ProductID = p.ProductID;

SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Order_Details od ON o.OrderID = od.OrderID 
GROUP BY c.CustomerID, c.CustomerName;

SELECT c.CustomerID, c.CustomerName, SUM((od.Quantity * od.UnitPrice) - (od.Quantity * od.CostPerUnit)) AS TotalProfit 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Order_Details od ON o.OrderID = od.OrderID 
GROUP BY c.CustomerID, c.CustomerName;

SELECT c.Region, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Order_Details od ON o.OrderID = od.OrderID 
GROUP BY c.Region;

SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Order_Details od ON o.OrderID = od.OrderID 
GROUP BY c.CustomerID, c.CustomerName 
ORDER BY TotalRevenue DESC 
LIMIT 1;

-- ============================================
-- 8. CASE STATEMENTS
-- ============================================

SELECT ProductName, Price,
	   CASE
           WHEN Price >= 50000 THEN 'Premium'
           WHEN Price >= 20000 THEN 'Standard'
           ELSE 'Budget'
	   END AS PriceCategory
FROM Products;

SELECT OrderDetailID, ((Quantity * UnitPrice) - (Quantity * CostPerUnit)) AS Profit,
	   CASE
           WHEN ((Quantity * UnitPrice) - (Quantity * CostPerUnit)) >= 20000 THEN 'High Profit'
           WHEN ((Quantity * UnitPrice) - (Quantity * CostPerUnit)) >= 5000 THEN 'Medium Profit'
           ELSE 'Low Profit'
		END AS ProfitClassification
FROM order_details;

SELECT OrderID, Status, 
       CASE 
           WHEN Status = 'Completed' THEN 'Successful' 
           WHEN Status = 'Pending' THEN 'In Progress' 
           WHEN Status = 'Cancelled' THEN 'Lost' 
       END AS OrderStatusClass 
FROM Orders;

-- ============================================
-- 9. SUBQUERIES
-- ============================================

SELECT *
FROM products
WHERE PRICE > (SELECT AVG(Price) FROM Products);

SELECT CustomerID, COUNT(OrderID) AS TotalOrders 
FROM Orders 
GROUP BY CustomerID 
HAVING COUNT(OrderID) > (
    SELECT AVG(OrderCount) 
    FROM (
        SELECT COUNT(OrderID) AS OrderCount 
        FROM Orders 
        GROUP BY CustomerID
    ) AS CustomerOrderCounts
);

SELECT ProductID, SUM(Quantity * UnitPrice) AS TotalRevenue 
FROM Order_Details 
GROUP BY ProductID 
HAVING SUM(Quantity * UnitPrice) > (
    SELECT AVG(ProductRevenue) 
    FROM (
        SELECT SUM(Quantity * UnitPrice) AS ProductRevenue 
        FROM Order_Details 
        GROUP BY ProductID
    ) AS RevenuePerProduct
);

-- ============================================
-- 10. COMMON TABLE EXPRESSIONS (CTEs)
-- ============================================

WITH ProductRevenue AS (
    SELECT p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
    FROM order_details od
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY p.ProductName
)
SELECT *
FROM ProductRevenue
ORDER BY TotalRevenue DESC;

WITH CustomerRevenue AS (
    SELECT c.CustomerName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
    FROM customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN order_details od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerName
)
SELECT *
FROM CustomerRevenue
ORDER BY TotalRevenue DESC
LIMIT 5;

WITH CategoryMetrics AS(
    SELECT p.Category, SUM(od.Quantity * od.UnitPrice) AS Revenue, SUM((od.Quantity * od.UnitPrice) - (od.Quantity * od.CostPerUnit)) AS Profit
    FROM order_details od
    JOIN products p ON od.ProductID = p.ProductID
    GROUP BY p.Category
)
SELECT *
FROM CategoryMetrics
WHERE Profit > 20000;

-- ============================================
-- 11. WINDOW FUNCTIONS
-- ============================================

SELECT p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue, 
       RANK() OVER (ORDER BY SUM(od.Quantity * od.UnitPrice) DESC) AS RevenueRank 
FROM Order_Details od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.ProductName;

SELECT p.Category, SUM((od.Quantity * od.UnitPrice) - (od.Quantity * od.CostPerUnit)) AS TotalProfit,
       DENSE_RANK() OVER (ORDER BY SUM((od.Quantity * od.UnitPrice) - (od.Quantity * od.CostPerUnit)) DESC) AS ProfitRank 
FROM Order_Details od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.Category;

SELECT p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue, 
       row_number() OVER (ORDER BY SUM(od.Quantity * od.UnitPrice) DESC) AS RowNum
FROM Order_Details od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.ProductName;

WITH DailySales AS (
    SELECT o.OrderDate, 
           SUM(od.Quantity * od.UnitPrice) AS DailyRevenue 
    FROM Orders o 
    JOIN Order_Details od ON o.OrderID = od.OrderID 
    GROUP BY o.OrderDate
)
SELECT OrderDate, 
       DailyRevenue, 
       SUM(DailyRevenue) OVER (ORDER BY OrderDate) AS RunningTotal 
FROM DailySales;

-- ============================================
-- 12. COMPLETED ORDERS REVENUE ANALYSIS
-- ============================================

SELECT
    SUM(od.Quantity * od.UnitPrice) AS Completed_Revenue,
    SUM(od.Quantity * od.CostPerUnit) AS Total_Cost,
    SUM(od.Quantity * (od.UnitPrice - od.CostPerUnit)) AS Total_Profit
FROM Order_Details od
JOIN Orders o
    ON od.OrderID = o.OrderID
WHERE o.Status = 'Completed';
