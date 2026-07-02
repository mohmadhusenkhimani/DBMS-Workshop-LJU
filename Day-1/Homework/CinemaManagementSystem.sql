/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : Cinema Management System
Topic              : RDBMS & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Workshop Problem Statement

Mr. Vikram Rao owns CineStar Multiplex with 5 screens.
Currently all movie, screen and ticket booking information
is managed manually using paper records and Excel sheets.

Problems:
1. Difficult to manage movie details.
2. Difficult to manage multiple screens.
3. Seat overbooking occurs frequently.
4. Unable to generate revenue reports.
5. Unable to know the most watched movie.

Design a database system that stores all information and
generates useful reports.

Tables:

1. Movie
   - MovieID
   - MovieName
   - Genre
   - Language
   - Duration
   - ReleaseDate

2. Screen
   - ScreenID
   - ScreenName
   - Capacity
   - ScreenType

3. Customer
   - CustomerID
   - CustomerName
   - Phone

4. Booking
   - BookingID
   - CustomerID
   - MovieID
   - ScreenID
   - SeatsBooked
   - TicketPrice
   - ShowDate
   - TotalAmount

Generate SQL reports using SELECT queries.

=====================================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS CinemaManagementSystem;

USE CinemaManagementSystem;

-- =====================================================
-- Create Movie Table
-- =====================================================

CREATE TABLE Movie
(
    MovieID INT PRIMARY KEY,
    MovieName VARCHAR(100),
    Genre VARCHAR(50),
    Language VARCHAR(30),
    Duration INT,
    ReleaseDate DATE
);

-- =====================================================
-- Create Screen Table
-- =====================================================

CREATE TABLE Screen
(
    ScreenID INT PRIMARY KEY,
    ScreenName VARCHAR(30),
    Capacity INT,
    ScreenType VARCHAR(30)
);

-- =====================================================
-- Create Customer Table
-- =====================================================

CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Phone VARCHAR(15)
);

-- =====================================================
-- Create Booking Table
-- =====================================================

CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    MovieID INT,
    ScreenID INT,
    SeatsBooked INT,
    TicketPrice DECIMAL(10,2),
    ShowDate DATE,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY(CustomerID)
    REFERENCES Customer(CustomerID),

    FOREIGN KEY(MovieID)
    REFERENCES Movie(MovieID),

    FOREIGN KEY(ScreenID)
    REFERENCES Screen(ScreenID)
);

-- =====================================================
-- Insert Movie Data
-- =====================================================

INSERT INTO Movie VALUES
(1,'Kalki 2898 AD','Sci-Fi','Hindi',180,'2024-06-27'),
(2,'Pushpa 2','Action','Telugu',170,'2024-12-05'),
(3,'Sita Ramam','Romance','Telugu',165,'2022-08-05'),
(4,'Avengers Endgame','Action','English',181,'2019-04-26'),
(5,'3 Idiots','Comedy','Hindi',170,'2009-12-25');

-- =====================================================
-- Insert Screen Data
-- =====================================================

INSERT INTO Screen VALUES
(1,'Screen 1',200,'Dolby Atmos'),
(2,'Screen 2',150,'2D'),
(3,'Screen 3',80,'3D'),
(4,'Screen 4',120,'2D'),
(5,'Screen 5',180,'IMAX');

-- =====================================================
-- Insert Customer Data
-- =====================================================

INSERT INTO Customer VALUES
(101,'Rahul','9876543210'),
(102,'Priya','9876543211'),
(103,'Amit','9876543212'),
(104,'Neha','9876543213'),
(105,'Karan','9876543214');

-- =====================================================
-- Insert Booking Data
-- =====================================================

INSERT INTO Booking VALUES
(1001,101,1,1,4,300,'2026-07-01',1200),
(1002,102,2,5,2,350,'2026-07-01',700),
(1003,103,4,3,5,250,'2026-07-02',1250),
(1004,104,5,2,3,200,'2026-07-02',600),
(1005,105,3,4,2,220,'2026-07-03',440);

-- =====================================================
-- Q1
-- Display All Movies
-- =====================================================

SELECT *
FROM Movie;

-- =====================================================
-- Q2
-- Display All Screens
-- =====================================================

SELECT *
FROM Screen;

-- =====================================================
-- Q3
-- Display Customer Booking Details
-- =====================================================

SELECT
Customer.CustomerName,
Movie.MovieName,
Screen.ScreenName,
Booking.SeatsBooked,
Booking.ShowDate
FROM Booking
JOIN Customer
ON Booking.CustomerID=Customer.CustomerID
JOIN Movie
ON Booking.MovieID=Movie.MovieID
JOIN Screen
ON Booking.ScreenID=Screen.ScreenID;

-- =====================================================
-- Q4
-- Display Total Revenue
-- =====================================================

SELECT
SUM(TotalAmount) AS TotalRevenue
FROM Booking;

-- =====================================================
-- Q5
-- Display Movie Wise Total Seats Booked
-- =====================================================

SELECT
Movie.MovieName,
SUM(Booking.SeatsBooked) AS TotalSeats
FROM Booking
JOIN Movie
ON Booking.MovieID=Movie.MovieID
GROUP BY Movie.MovieName;

-- =====================================================
-- Q6
-- Display Most Watched Movie
-- =====================================================

SELECT
Movie.MovieName,
SUM(Booking.SeatsBooked) AS TotalSeats
FROM Booking
JOIN Movie
ON Booking.MovieID=Movie.MovieID
GROUP BY Movie.MovieName
ORDER BY TotalSeats DESC
LIMIT 1;

-- =====================================================
-- Q7
-- Display Customers Who Booked More Than 2 Seats
-- =====================================================

SELECT
Customer.CustomerName,
Booking.SeatsBooked
FROM Booking
JOIN Customer
ON Booking.CustomerID=Customer.CustomerID
WHERE Booking.SeatsBooked>2;

-- =====================================================
-- Q8
-- Display Movies Running on Dolby Atmos Screen
-- =====================================================

SELECT
Movie.MovieName,
Screen.ScreenName,
Screen.ScreenType
FROM Booking
JOIN Movie
ON Booking.MovieID=Movie.MovieID
JOIN Screen
ON Booking.ScreenID=Screen.ScreenID
WHERE Screen.ScreenType='Dolby Atmos';

-- =====================================================
-- Q9
-- Display Highest Ticket Revenue Booking
-- =====================================================

SELECT *
FROM Booking
ORDER BY TotalAmount DESC
LIMIT 1;

-- =====================================================
-- Q10
-- Display Number of Bookings by Each Customer
-- =====================================================

SELECT
Customer.CustomerName,
COUNT(Booking.BookingID) AS TotalBookings
FROM Booking
JOIN Customer
ON Booking.CustomerID=Customer.CustomerID
GROUP BY Customer.CustomerName;

-- =====================================================
-- End of Workshop
-- =====================================================