/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : Order Management System
Topic              : RDBMS & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Workshop Problem Statement

An online shopping company wants to develop an Order Management
System to manage customer orders efficiently.

Currently, the company stores all customer, product and order
information manually, making it difficult to generate reports,
track sales and prepare invoices.

The system should store information about customers, products,
and customer orders.

Tables:

1. Customer
   - CustomerID
   - CustomerName
   - Email
   - Phone
   - City

2. Product
   - ProductID
   - ProductName
   - Category
   - Price

3. Orders
   - OrderID
   - CustomerID
   - ProductID
   - Quantity
   - OrderDate
   - TotalAmount

The company wants to generate an invoice containing:

• Customer Name
• Product Name
• Product Price
• Quantity Purchased
• Total Amount
• Order Date

The management also wants the following reports:

1. Display list of all customers.
2. Display list of all available products.
3. Display total products purchased by each customer.
4. Display quantity of each product purchased by a particular customer.
5. Generate customer invoice.
6. Display customers who purchased products worth more than ₹5,000.
7. Display customer name with purchased product.
8. Display total sales.
9. Display the most expensive product.
10. Display total orders placed by each customer.

=====================================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS OrderManagementSystem;

USE OrderManagementSystem;

-- =====================================================
-- Create Customer Table
-- =====================================================

CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

-- =====================================================
-- Create Product Table
-- =====================================================

CREATE TABLE Product
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2)
);

-- =====================================================
-- Create Orders Table
-- =====================================================

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY(CustomerID)
    REFERENCES Customer(CustomerID),

    FOREIGN KEY(ProductID)
    REFERENCES Product(ProductID)
);

-- =====================================================
-- Insert Customer Records
-- =====================================================

INSERT INTO Customer VALUES
(101,'Johns','johns@gmail.com','9630258741','Ahmedabad'),
(102,'Rahul','rahul@gmail.com','9876543211','Surat'),
(103,'Priya','priya@gmail.com','9876543212','Rajkot'),
(104,'Amit','amit@gmail.com','9876543213','Vadodara'),
(105,'Neha','neha@gmail.com','9876543214','Bhavnagar');

-- =====================================================
-- Insert Product Records
-- =====================================================

INSERT INTO Product VALUES
(1,'Laptop','Electronics',55000),
(2,'Mouse','Electronics',700),
(3,'Keyboard','Electronics',1200),
(4,'Mobile','Electronics',25000),
(5,'Headphone','Accessories',1800);

-- =====================================================
-- Insert Order Records
-- =====================================================

INSERT INTO Orders VALUES
(1001,101,1,1,'2026-06-25',55000),
(1002,101,2,2,'2026-06-25',1400),
(1003,102,4,1,'2026-06-26',25000),
(1004,103,3,2,'2026-06-27',2400),
(1005,104,5,3,'2026-06-28',5400);

-- =====================================================
-- Q1
-- Display List of All Customers
-- =====================================================

SELECT *
FROM Customer;

-- =====================================================
-- Q2
-- Display List of All Products
-- =====================================================

SELECT *
FROM Product;

-- =====================================================
-- Q3
-- Display Total Products Purchased by Each Customer
-- =====================================================

SELECT
Customer.CustomerName,
SUM(Orders.Quantity) AS TotalProductsPurchased
FROM Customer
JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
GROUP BY Customer.CustomerName;

-- =====================================================
-- Q4
-- Display Quantity of Each Product Purchased
-- by Particular Customer (Johns)
-- =====================================================

SELECT
Customer.CustomerName,
Product.ProductName,
Orders.Quantity
FROM Orders
JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
JOIN Product
ON Orders.ProductID = Product.ProductID
WHERE Customer.CustomerName='Johns';

-- =====================================================
-- Q5
-- Customer Invoice
-- =====================================================

SELECT
Customer.CustomerName,
Product.ProductName,
Product.Price,
Orders.Quantity,
Orders.TotalAmount,
Orders.OrderDate
FROM Orders
JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
JOIN Product
ON Orders.ProductID = Product.ProductID;

-- =====================================================
-- Q6
-- Customers Who Purchased Products Worth
-- More Than ₹5000
-- =====================================================

SELECT
Customer.CustomerName,
Orders.TotalAmount
FROM Customer
JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
WHERE Orders.TotalAmount > 5000;

-- =====================================================
-- Q7
-- Display Customer Name and Purchased Product
-- =====================================================

SELECT
Customer.CustomerName,
Product.ProductName
FROM Orders
JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
JOIN Product
ON Orders.ProductID = Product.ProductID;

-- =====================================================
-- Q8
-- Display Total Sales
-- =====================================================

SELECT
SUM(TotalAmount) AS TotalSales
FROM Orders;

-- =====================================================
-- Q9
-- Display Most Expensive Product
-- =====================================================

SELECT *
FROM Product
ORDER BY Price DESC
LIMIT 1;

-- =====================================================
-- Q10
-- Display Total Orders Placed by Each Customer
-- =====================================================

SELECT
Customer.CustomerName,
COUNT(Orders.OrderID) AS TotalOrders
FROM Customer
JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
GROUP BY Customer.CustomerName;

-- =====================================================
-- End of Workshop
-- =====================================================