/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : Student Management System
Topic              : RDBMS & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Workshop Problem Statement

A college wants to develop a Student Management System to
maintain student records, available courses, and course
enrollments.

The system stores information about students, courses,
and marks obtained by students in each course.

Tables:

1. Student
   - StudentID
   - StudentName
   - Email
   - Mobile
   - City

2. Course
   - CourseID
   - CourseName
   - Duration
   - Faculty

3. Enrollment
   - EnrollmentID
   - StudentID
   - CourseID
   - Marks

Generate the required reports using SQL queries.

=====================================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS StudentManagementSystem;

USE StudentManagementSystem;

-- =====================================================
-- Create Student Table
-- =====================================================

CREATE TABLE Student
(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Email VARCHAR(100),
    Mobile VARCHAR(15),
    City VARCHAR(50)
);

-- =====================================================
-- Create Course Table
-- =====================================================

CREATE TABLE Course
(
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Duration VARCHAR(50),
    Faculty VARCHAR(100)
);

-- =====================================================
-- Create Enrollment Table
-- =====================================================

CREATE TABLE Enrollment
(
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Marks INT,

    FOREIGN KEY(StudentID)
    REFERENCES Student(StudentID),

    FOREIGN KEY(CourseID)
    REFERENCES Course(CourseID)
);

-- =====================================================
-- Insert Student Data
-- =====================================================

INSERT INTO Student VALUES
(101,'Rahul Patel','rahul@gmail.com','9876543210','Ahmedabad'),
(102,'Priya Shah','priya@gmail.com','9876543211','Surat'),
(103,'Amit Kumar','amit@gmail.com','9876543212','Rajkot'),
(104,'Neha Joshi','neha@gmail.com','9876543213','Vadodara'),
(105,'Karan Mehta','karan@gmail.com','9876543214','Bhavnagar');

-- =====================================================
-- Insert Course Data
-- =====================================================

INSERT INTO Course VALUES
(1,'Python Programming','3 Months','Dr. Sharma'),
(2,'Database Management System','4 Months','Prof. Patel'),
(3,'Java Programming','3 Months','Prof. Mehta'),
(4,'Data Structures','4 Months','Dr. Desai'),
(5,'Web Development','2 Months','Prof. Joshi');

-- =====================================================
-- Insert Enrollment Data
-- =====================================================

INSERT INTO Enrollment VALUES
(1001,101,1,85),
(1002,101,2,78),
(1003,102,1,92),
(1004,102,3,88),
(1005,103,2,75),
(1006,103,4,83),
(1007,104,3,95),
(1008,104,5,89),
(1009,105,1,67),
(1010,105,4,81);

-- =====================================================
-- Q1
-- Display List of All Students
-- =====================================================

SELECT *
FROM Student;

-- =====================================================
-- Q2
-- Display Courses Enrolled by Each Student
-- =====================================================

SELECT
    Student.StudentName,
    Course.CourseName
FROM Enrollment
JOIN Student
ON Enrollment.StudentID = Student.StudentID
JOIN Course
ON Enrollment.CourseID = Course.CourseID
ORDER BY Student.StudentName;

-- =====================================================
-- Q3
-- Display Students Who Scored Above 80 Marks
-- =====================================================

SELECT
    Student.StudentName,
    Course.CourseName,
    Enrollment.Marks
FROM Enrollment
JOIN Student
ON Enrollment.StudentID = Student.StudentID
JOIN Course
ON Enrollment.CourseID = Course.CourseID
WHERE Enrollment.Marks > 80
ORDER BY Enrollment.Marks DESC;

-- =====================================================
-- Q4
-- Display Total Number of Courses Taken
-- by Each Student
-- =====================================================

SELECT
    Student.StudentName,
    COUNT(Enrollment.CourseID) AS TotalCourses
FROM Enrollment
JOIN Student
ON Enrollment.StudentID = Student.StudentID
GROUP BY Student.StudentName;

-- =====================================================
-- Q5
-- Display Marks Obtained in Each Course
-- =====================================================

SELECT
    Student.StudentName,
    Course.CourseName,
    Enrollment.Marks
FROM Enrollment
JOIN Student
ON Enrollment.StudentID = Student.StudentID
JOIN Course
ON Enrollment.CourseID = Course.CourseID
ORDER BY Student.StudentName;

-- =====================================================
-- End of Workshop
-- =====================================================