/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : Cinema Multiplex Management System
Topic              : RDBMS, ER Diagram & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Problem Statement

Mr. Vikram Rao owns CineStar Multiplex.

The multiplex has five screens showing multiple movies every month.
Each screen has different seating capacities and screen types
(2D / 3D / Dolby Atmos).

Customers book movie tickets.

The system should maintain

• Movie Information
• Screen Information
• Show Schedule
• Customer Information
• Ticket Booking

The system should generate reports like

1. Movie Details
2. Screen Details
3. Available Seats
4. Booked Tickets
5. Total Revenue
6. Most Watched Movie
7. Screen Wise Collection
8. Today's Revenue

=====================================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS CinemaMultiplexDB;

USE CinemaMultiplexDB;

-- =====================================================
-- Movie Table
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
-- Screen Table
-- =====================================================

CREATE TABLE Screen
(
    ScreenID INT PRIMARY KEY,
    ScreenName VARCHAR(30),
    ScreenType VARCHAR(20),
    Capacity INT
);

-- =====================================================
-- Show Table
-- =====================================================

CREATE TABLE MovieShow
(
    ShowID INT PRIMARY KEY,
    MovieID INT,
    ScreenID INT,
    ShowDate DATE,
    ShowTime TIME,
    TicketPrice DECIMAL(10,2),

    FOREIGN KEY(MovieID)
    REFERENCES Movie(MovieID),

    FOREIGN KEY(ScreenID)
    REFERENCES Screen(ScreenID)
);

-- =====================================================
-- Customer Table
-- =====================================================

CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Mobile VARCHAR(15)
);

-- =====================================================
-- Booking Table
-- =====================================================

CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    ShowID INT,
    SeatsBooked INT,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY(CustomerID)
    REFERENCES Customer(CustomerID),

    FOREIGN KEY(ShowID)
    REFERENCES MovieShow(ShowID)
);

-- =====================================================
-- Insert Movie Data
-- =====================================================

INSERT INTO Movie VALUES
(1,'Pushpa 2','Action','Hindi',185,'2026-01-10'),
(2,'Kalki 2898 AD','Sci-Fi','Telugu',175,'2026-02-05'),
(3,'Chhaava','Historical','Hindi',170,'2026-03-15'),
(4,'Mission Impossible','Action','English',165,'2026-04-01'),
(5,'Toy Story','Animation','English',120,'2026-04-20');

-- =====================================================
-- Insert Screen Data
-- =====================================================

INSERT INTO Screen VALUES
(1,'Screen 1','Dolby',200),
(2,'Screen 2','2D',150),
(3,'Screen 3','3D',80),
(4,'Screen 4','2D',120),
(5,'Screen 5','Dolby',180);

-- =====================================================
-- Insert Shows
-- =====================================================

INSERT INTO MovieShow VALUES
(101,1,1,'2026-07-01','10:00:00',250),
(102,2,3,'2026-07-01','02:00:00',300),
(103,3,2,'2026-07-01','06:00:00',220),
(104,4,5,'2026-07-01','09:00:00',350),
(105,5,4,'2026-07-01','12:00:00',180);

-- =====================================================
-- Insert Customers
-- =====================================================

INSERT INTO Customer VALUES
(1,'Rahul','9876543210'),
(2,'Priya','9876543211'),
(3,'Amit','9876543212'),
(4,'Neha','9876543213'),
(5,'Karan','9876543214');

-- =====================================================
-- Insert Booking
-- =====================================================

INSERT INTO Booking VALUES
(1001,1,101,4,1000),
(1002,2,102,2,600),
(1003,3,103,5,1100),
(1004,4,104,3,1050),
(1005,5,101,6,1500);

-- =====================================================
-- Q1 Display All Movies
-- =====================================================

SELECT *
FROM Movie;

-- =====================================================
-- Q2 Display Screen Details
-- =====================================================

SELECT *
FROM Screen;

-- =====================================================
-- Q3 Display Movie Schedule
-- =====================================================

SELECT
Movie.MovieName,
Screen.ScreenName,
MovieShow.ShowDate,
MovieShow.ShowTime
FROM MovieShow
JOIN Movie
ON MovieShow.MovieID = Movie.MovieID
JOIN Screen
ON MovieShow.ScreenID = Screen.ScreenID;

-- =====================================================
-- Q4 Display Customer Booking
-- =====================================================

SELECT
Customer.CustomerName,
Movie.MovieName,
Booking.SeatsBooked,
Booking.TotalAmount
FROM Booking
JOIN Customer
ON Booking.CustomerID = Customer.CustomerID
JOIN MovieShow
ON Booking.ShowID = MovieShow.ShowID
JOIN Movie
ON MovieShow.MovieID = Movie.MovieID;

-- =====================================================
-- Q5 Total Revenue
-- =====================================================

SELECT
SUM(TotalAmount) AS TotalRevenue
FROM Booking;

-- =====================================================
-- Q6 Most Watched Movie
-- =====================================================

SELECT
Movie.MovieName,
SUM(Booking.SeatsBooked) AS TotalAudience
FROM Booking
JOIN MovieShow
ON Booking.ShowID = MovieShow.ShowID
JOIN Movie
ON MovieShow.MovieID = Movie.MovieID
GROUP BY Movie.MovieName
ORDER BY TotalAudience DESC
LIMIT 1;

-- =====================================================
-- Q7 Screen Wise Collection
-- =====================================================

SELECT
Screen.ScreenName,
SUM(Booking.TotalAmount) AS Collection
FROM Booking
JOIN MovieShow
ON Booking.ShowID = MovieShow.ShowID
JOIN Screen
ON MovieShow.ScreenID = Screen.ScreenID
GROUP BY Screen.ScreenName;

-- =====================================================
-- Q8 Today's Revenue
-- =====================================================

SELECT
SUM(Booking.TotalAmount) AS TodayRevenue
FROM Booking
JOIN MovieShow
ON Booking.ShowID = MovieShow.ShowID
WHERE MovieShow.ShowDate='2026-07-01';

-- =====================================================
-- Q9 Movie Wise Revenue
-- =====================================================

SELECT
Movie.MovieName,
SUM(Booking.TotalAmount) AS Revenue
FROM Booking
JOIN MovieShow
ON Booking.ShowID = MovieShow.ShowID
JOIN Movie
ON MovieShow.MovieID = Movie.MovieID
GROUP BY Movie.MovieName;

-- =====================================================
-- Q10 Screen Capacity
-- =====================================================

SELECT
ScreenName,
Capacity
FROM Screen;

-- =====================================================
-- End of Practical
-- =====================================================