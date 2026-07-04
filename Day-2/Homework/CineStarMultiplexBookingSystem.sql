/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : CineStar Multiplex Booking System
Topic              : RDBMS & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Workshop Problem Statement

CineStar Multiplex wants to develop a Movie Ticket Booking
System to manage movie information, screen details, and
customer ticket bookings.

Currently, all records are maintained manually using
registers and Excel sheets, resulting in incorrect movie
details, overbooked shows, and difficulty generating reports.

The system should maintain proper information about movies,
screens, and customer bookings.

Database Tables

1. Movie
   - MovieID
   - Title
   - Genre
   - Language
   - Duration
   - ReleaseDate

2. Screen
   - ScreenID
   - ScreenNumber
   - SeatingCapacity
   - ScreenType

3. Booking
   - BookingID
   - MovieID
   - ScreenID
   - CustomerName
   - ShowDate
   - ShowTime
   - SeatsBooked

Generate the required reports using SQL queries.

=====================================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS CineStarMultiplex;

USE CineStarMultiplex;

-- =====================================================
-- Create Movie Table
-- =====================================================

CREATE TABLE Movie
(
    MovieID INT PRIMARY KEY,

    Title VARCHAR(100) NOT NULL,

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

    ScreenNumber INT NOT NULL,

    SeatingCapacity INT,

    ScreenType VARCHAR(30)
);

-- =====================================================
-- Create Booking Table
-- =====================================================

CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,

    MovieID INT,

    ScreenID INT,

    CustomerName VARCHAR(100),

    ShowDate DATE,

    ShowTime TIME,

    SeatsBooked INT,

    FOREIGN KEY (MovieID)
    REFERENCES Movie(MovieID),

    FOREIGN KEY (ScreenID)
    REFERENCES Screen(ScreenID)
);

-- =====================================================
-- Display Movie Table Structure
-- =====================================================

DESC Movie;

-- =====================================================
-- Display Screen Table Structure
-- =====================================================

DESC Screen;

-- =====================================================
-- Display Booking Table Structure
-- =====================================================

DESC Booking;

-- =====================================================
-- Display All Tables
-- =====================================================

SHOW TABLES;


-- =====================================================
-- Insert Movie Records
-- =====================================================

INSERT INTO Movie VALUES
(101,'Pushpa 2','Action','Hindi',182,'2025-12-05'),
(102,'Sitaare Zameen Par','Drama','Hindi',165,'2025-06-20'),
(103,'Mission Impossible','Action','English',169,'2025-05-23'),
(104,'Kalki 2898 AD','Sci-Fi','Hindi',181,'2025-06-27'),
(105,'Dragon','Comedy','Tamil',155,'2025-03-15'),
(106,'Kantara','Thriller','Kannada',148,'2025-01-10'),
(107,'Avengers Endgame','Action','English',181,'2019-04-26'),
(108,'Leo','Action','Tamil',164,'2023-10-19'),
(109,'3 Idiots','Comedy','Hindi',170,'2009-12-25'),
(110,'Interstellar','Sci-Fi','English',169,'2014-11-07');

-- =====================================================
-- Display Movie Records
-- =====================================================

SELECT *
FROM Movie;

-- =====================================================
-- Insert Screen Records
-- =====================================================

INSERT INTO Screen VALUES
(1,1,200,'Dolby Atmos'),
(2,2,150,'2D'),
(3,3,80,'3D'),
(4,4,120,'2D'),
(5,5,180,'Dolby Atmos');

-- =====================================================
-- Display Screen Records
-- =====================================================

SELECT *
FROM Screen;

-- =====================================================
-- Insert Booking Records
-- =====================================================

INSERT INTO Booking VALUES
(1001,101,1,'Rahul Patel','2026-07-10','19:00:00',4),
(1002,102,2,'Priya Shah','2026-07-10','16:00:00',2),
(1003,103,3,'Amit Mehta','2026-07-10','21:00:00',3),
(1004,104,5,'Neha Joshi','2026-07-11','18:30:00',5),
(1005,105,4,'Karan Desai','2026-07-11','14:00:00',2),
(1006,106,2,'Sneha Patel','2026-07-11','20:00:00',4),
(1007,107,1,'Vikram Shah','2026-07-12','19:00:00',6),
(1008,108,3,'Pooja Mehta','2026-07-12','17:00:00',2),
(1009,109,4,'Ankit Joshi','2026-07-12','15:30:00',3),
(1010,110,5,'Riya Patel','2026-07-12','21:30:00',2),
(1011,101,1,'Mohit Shah','2026-07-13','19:00:00',5),
(1012,103,3,'Ankit Joshi','2026-07-13','18:00:00',4),
(1013,104,5,'Krishna Patel','2026-07-13','20:30:00',3),
(1014,102,2,'Bhavesh Mehta','2026-07-14','16:30:00',2),
(1015,110,5,'Komal Shah','2026-07-14','19:30:00',4);

-- =====================================================
-- Display Booking Records
-- =====================================================

SELECT *
FROM Booking;

-- =====================================================
-- Verify Complete Database
-- =====================================================

SELECT *
FROM Movie;

SELECT *
FROM Screen;

SELECT *
FROM Booking;




-- =====================================================
-- Q1
-- Display Today's Show Schedule
-- (Movie Title, Screen Number and Show Time)
-- =====================================================

SELECT
    Movie.Title,
    Screen.ScreenNumber,
    Booking.ShowDate,
    Booking.ShowTime
FROM Booking
JOIN Movie
ON Booking.MovieID = Movie.MovieID
JOIN Screen
ON Booking.ScreenID = Screen.ScreenID
WHERE Booking.ShowDate = CURDATE();

-- =====================================================
-- Q2
-- Display Title and Duration of
-- Action Movies
-- =====================================================

SELECT
    Title,
    Duration
FROM Movie
WHERE Genre = 'Action';

-- =====================================================
-- Q3
-- Display Total Tickets Sold
-- for Each Movie This Month
-- =====================================================

SELECT
    Movie.Title,
    SUM(Booking.SeatsBooked) AS TotalTicketsSold
FROM Booking
JOIN Movie
ON Booking.MovieID = Movie.MovieID
WHERE MONTH(Booking.ShowDate) = MONTH(CURDATE())
AND YEAR(Booking.ShowDate) = YEAR(CURDATE())
GROUP BY Movie.Title
ORDER BY TotalTicketsSold DESC;

-- =====================================================
-- Q4
-- Display Available Seats for
-- 7:00 PM Show on Screen 2
-- =====================================================

SELECT
    Movie.Title,
    Screen.ScreenNumber,
    Screen.SeatingCapacity,
    SUM(Booking.SeatsBooked) AS BookedSeats,
    (Screen.SeatingCapacity - SUM(Booking.SeatsBooked))
    AS AvailableSeats
FROM Booking
JOIN Movie
ON Booking.MovieID = Movie.MovieID
JOIN Screen
ON Booking.ScreenID = Screen.ScreenID
WHERE Booking.ShowTime = '19:00:00'
AND Screen.ScreenNumber = 2
GROUP BY
    Movie.Title,
    Screen.ScreenNumber,
    Screen.SeatingCapacity;

-- =====================================================
-- Q5
-- Display Total Revenue Generated
-- Per Screen
-- (Ticket Price = ₹250)
-- =====================================================

SELECT
    Screen.ScreenNumber,
    SUM(Booking.SeatsBooked * 250) AS TotalRevenue
FROM Booking
JOIN Screen
ON Booking.ScreenID = Screen.ScreenID
GROUP BY Screen.ScreenNumber
ORDER BY TotalRevenue DESC;



-- =====================================================
-- Q6
-- Display All 3D Screens with
-- Seating Capacity
-- =====================================================

SELECT
    ScreenNumber,
    SeatingCapacity,
    ScreenType
FROM Screen
WHERE ScreenType = '3D';

-- =====================================================
-- Q7
-- Display Most Watched Movie
-- =====================================================

SELECT
    Movie.Title,
    SUM(Booking.SeatsBooked) AS TotalTicketsSold
FROM Movie
JOIN Booking
ON Movie.MovieID = Booking.MovieID
GROUP BY Movie.Title
ORDER BY TotalTicketsSold DESC
LIMIT 1;

-- =====================================================
-- Q8
-- Display All Bookings of
-- Particular Customer (Ankit Joshi)
-- =====================================================

SELECT
    Booking.BookingID,
    Booking.CustomerName,
    Movie.Title,
    Screen.ScreenNumber,
    Booking.ShowDate,
    Booking.ShowTime,
    Booking.SeatsBooked
FROM Booking
JOIN Movie
ON Booking.MovieID = Movie.MovieID
JOIN Screen
ON Booking.ScreenID = Screen.ScreenID
WHERE Booking.CustomerName = 'Ankit Joshi';

-- =====================================================
-- Q9
-- Display Screens Having
-- No Bookings on 2026-07-15
-- =====================================================

SELECT
    Screen.ScreenID,
    Screen.ScreenNumber,
    Screen.ScreenType
FROM Screen
LEFT JOIN Booking
ON Screen.ScreenID = Booking.ScreenID
AND Booking.ShowDate = '2026-07-15'
WHERE Booking.BookingID IS NULL;

-- =====================================================
-- Q10
-- Display Total Bookings and
-- Total Seats Booked for Today
-- =====================================================

SELECT
    COUNT(BookingID) AS TotalBookings,
    SUM(SeatsBooked) AS TotalSeatsBooked
FROM Booking
WHERE ShowDate = CURDATE();

-- =====================================================
-- Additional Query 1
-- Display All Movies Released
-- After 2024
-- =====================================================

SELECT *
FROM Movie
WHERE ReleaseDate >= '2025-01-01';

-- =====================================================
-- Additional Query 2
-- Display Movies Language Wise
-- =====================================================

SELECT
    Language,
    COUNT(MovieID) AS TotalMovies
FROM Movie
GROUP BY Language;

-- =====================================================
-- Additional Query 3
-- Display Screen Wise
-- Total Seats Booked
-- =====================================================

SELECT
    Screen.ScreenNumber,
    SUM(Booking.SeatsBooked) AS TotalSeatsBooked
FROM Screen
JOIN Booking
ON Screen.ScreenID = Booking.ScreenID
GROUP BY Screen.ScreenNumber;

-- =====================================================
-- Additional Query 4
-- Display Customer Wise
-- Total Tickets Booked
-- =====================================================

SELECT
    CustomerName,
    SUM(SeatsBooked) AS TotalTickets
FROM Booking
GROUP BY CustomerName
ORDER BY TotalTickets DESC;

-- =====================================================
-- Additional Query 5
-- Display Average Seats Booked
-- Per Booking
-- =====================================================

SELECT
    AVG(SeatsBooked) AS AverageSeatsBooked
FROM Booking;

-- =====================================================
-- Additional Query 6
-- Display Total Number of Movies
-- =====================================================

SELECT
    COUNT(MovieID) AS TotalMovies
FROM Movie;

-- =====================================================
-- End of Workshop
-- =====================================================

SELECT 'CineStar Multiplex Booking System Completed Successfully...' AS Message;




