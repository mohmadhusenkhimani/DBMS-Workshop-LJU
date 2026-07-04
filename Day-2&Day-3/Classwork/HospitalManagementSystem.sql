/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : Hospital Management System
Topic              : RDBMS & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Workshop Problem Statement

A hospital wants to develop a Hospital Management System (HMS)
to manage patient records, doctor information, and appointment
schedules.

Currently, the hospital maintains all records manually, which
often leads to duplicate appointments, missing patient details,
and difficulty in generating reports.

The Hospital Management System should maintain proper records
of patients, doctors, and appointments.

Database Tables

1. Patient
   - PatientID
   - PatientName
   - Gender
   - Age
   - Phone
   - City

2. Doctor
   - DoctorID
   - DoctorName
   - Specialization
   - Department
   - ConsultationFee

3. Appointment
   - AppointmentID
   - PatientID
   - DoctorID
   - AppointmentDate
   - AppointmentTime
   - Status

Generate the required reports using SQL queries.

=====================================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS HospitalManagementSystem;

USE HospitalManagementSystem;

-- =====================================================
-- Create Patient Table
-- =====================================================

CREATE TABLE Patient
(
    PatientID INT PRIMARY KEY,

    PatientName VARCHAR(100) NOT NULL,

    Gender VARCHAR(10),

    Age INT,

    Phone VARCHAR(15),

    City VARCHAR(50)
);

-- =====================================================
-- Create Doctor Table
-- =====================================================

CREATE TABLE Doctor
(
    DoctorID INT PRIMARY KEY,

    DoctorName VARCHAR(100) NOT NULL,

    Specialization VARCHAR(100),

    Department VARCHAR(100),

    ConsultationFee DECIMAL(10,2)
);

-- =====================================================
-- Create Appointment Table
-- =====================================================

CREATE TABLE Appointment
(
    AppointmentID INT PRIMARY KEY,

    PatientID INT,

    DoctorID INT,

    AppointmentDate DATE,

    AppointmentTime TIME,

    Status VARCHAR(30),

    FOREIGN KEY (PatientID)
    REFERENCES Patient(PatientID),

    FOREIGN KEY (DoctorID)
    REFERENCES Doctor(DoctorID)
);

-- =====================================================
-- Patient Table Structure
-- =====================================================

DESC Patient;

-- =====================================================
-- Doctor Table Structure
-- =====================================================

DESC Doctor;

-- =====================================================
-- Appointment Table Structure
-- =====================================================

DESC Appointment;

-- =====================================================
-- Show All Tables
-- =====================================================

SHOW TABLES;


-- =====================================================
-- Insert Patient Records
-- =====================================================

INSERT INTO Patient VALUES
(101,'Rahul Sharma','Male',25,'9876543210','Ahmedabad'),
(102,'Priya Patel','Female',30,'9876543211','Surat'),
(103,'Amit Shah','Male',45,'9876543212','Vadodara'),
(104,'Neha Joshi','Female',52,'9876543213','Rajkot'),
(105,'Karan Mehta','Male',19,'9876543214','Bhavnagar'),
(106,'Sneha Desai','Female',34,'9876543215','Ahmedabad'),
(107,'Vikram Singh','Male',67,'9876543216','Surat'),
(108,'Pooja Verma','Female',28,'9876543217','Jamnagar'),
(109,'Rohan Kumar','Male',39,'9876543218','Gandhinagar'),
(110,'Anjali Gupta','Female',60,'9876543219','Mehsana');

-- =====================================================
-- Display Patient Records
-- =====================================================

SELECT *
FROM Patient;

-- =====================================================
-- Insert Doctor Records
-- =====================================================

INSERT INTO Doctor VALUES
(201,'Dr. Mehul Shah','Cardiologist','Cardiology',1200),
(202,'Dr. Rina Patel','Dermatologist','Dermatology',800),
(203,'Dr. Jay Mehta','Orthopedic','Orthopedic',1000),
(204,'Dr. Neha Joshi','Neurologist','Neurology',1500),
(205,'Dr. Amit Trivedi','Pediatrician','Pediatrics',700),
(206,'Dr. Hiral Desai','Gynecologist','Gynecology',900),
(207,'Dr. Karan Shah','ENT Specialist','ENT',650),
(208,'Dr. Pooja Patel','Ophthalmologist','Eye',850),
(209,'Dr. Rahul Bhatt','General Physician','General Medicine',600),
(210,'Dr. Vivek Singh','Dentist','Dental',500);

-- =====================================================
-- Display Doctor Records
-- =====================================================

SELECT *
FROM Doctor;

-- =====================================================
-- Insert Appointment Records
-- =====================================================

INSERT INTO Appointment VALUES
(1001,101,201,'2026-07-01','09:00:00','Completed'),
(1002,102,202,'2026-07-01','09:30:00','Completed'),
(1003,103,203,'2026-07-01','10:00:00','Completed'),
(1004,104,204,'2026-07-02','10:30:00','Pending'),
(1005,105,205,'2026-07-02','11:00:00','Completed'),
(1006,106,206,'2026-07-02','11:30:00','Cancelled'),
(1007,107,201,'2026-07-03','09:00:00','Completed'),
(1008,108,208,'2026-07-03','09:45:00','Pending'),
(1009,109,209,'2026-07-03','10:15:00','Completed'),
(1010,110,210,'2026-07-03','11:00:00','Completed'),
(1011,101,202,'2026-07-04','09:15:00','Pending'),
(1012,102,203,'2026-07-04','10:00:00','Completed'),
(1013,103,204,'2026-07-04','10:45:00','Completed'),
(1014,104,205,'2026-07-05','11:30:00','Pending'),
(1015,105,209,'2026-07-05','12:00:00','Completed');

-- =====================================================
-- Display Appointment Records
-- =====================================================

SELECT *
FROM Appointment;

-- =====================================================
-- Verify Complete Database
-- =====================================================

SELECT *
FROM Patient;

SELECT *
FROM Doctor;

SELECT *
FROM Appointment;

-- =====================================================
-- Q1
-- Display List of All Patients
-- =====================================================

SELECT *
FROM Patient;

-- =====================================================
-- Q2
-- Display List of All Doctors
-- =====================================================

SELECT *
FROM Doctor;

-- =====================================================
-- Q3
-- Display Appointment Schedule
-- =====================================================

SELECT
    Appointment.AppointmentID,
    Patient.PatientName,
    Doctor.DoctorName,
    Appointment.AppointmentDate,
    Appointment.AppointmentTime,
    Appointment.Status
FROM Appointment
JOIN Patient
ON Appointment.PatientID = Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID = Doctor.DoctorID;

-- =====================================================
-- Q4
-- Display Patients Who Have Appointment
-- with Particular Doctor (Dr. Mehul Shah)
-- =====================================================

SELECT
    Patient.PatientName,
    Doctor.DoctorName,
    Appointment.AppointmentDate,
    Appointment.AppointmentTime,
    Appointment.Status
FROM Appointment
JOIN Patient
ON Appointment.PatientID = Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID = Doctor.DoctorID
WHERE Doctor.DoctorName = 'Dr. Mehul Shah';

-- =====================================================
-- Q5
-- Display Total Number of Appointments
-- Booked for Each Doctor
-- =====================================================

SELECT
    Doctor.DoctorName,
    COUNT(Appointment.AppointmentID) AS TotalAppointments
FROM Doctor
JOIN Appointment
ON Doctor.DoctorID = Appointment.DoctorID
GROUP BY Doctor.DoctorName;



-- =====================================================
-- Q6
-- Display Total Revenue Generated
-- from Completed Appointments
-- =====================================================

SELECT
    SUM(Doctor.ConsultationFee) AS TotalRevenue
FROM Appointment
JOIN Doctor
ON Appointment.DoctorID = Doctor.DoctorID
WHERE Appointment.Status = 'Completed';

-- =====================================================
-- Q7
-- Display Senior Citizen Patients
-- (Age 60 or Above)
-- =====================================================

SELECT
    PatientID,
    PatientName,
    Gender,
    Age,
    City
FROM Patient
WHERE Age >= 60;

-- =====================================================
-- Q8
-- Display Doctor Having Highest
-- Consultation Fee
-- =====================================================

SELECT *
FROM Doctor
WHERE ConsultationFee =
(
    SELECT MAX(ConsultationFee)
    FROM Doctor
);

-- =====================================================
-- Q9
-- Display Doctors Who Have
-- No Appointments
-- =====================================================

SELECT
    Doctor.DoctorID,
    Doctor.DoctorName,
    Doctor.Specialization,
    Doctor.Department
FROM Doctor
LEFT JOIN Appointment
ON Doctor.DoctorID = Appointment.DoctorID
WHERE Appointment.AppointmentID IS NULL;

-- =====================================================
-- Q10
-- Display Monthly Appointment Report
-- =====================================================

SELECT
    MONTH(AppointmentDate) AS MonthNumber,
    MONTHNAME(AppointmentDate) AS MonthName,
    COUNT(AppointmentID) AS TotalAppointments
FROM Appointment
GROUP BY
    MONTH(AppointmentDate),
    MONTHNAME(AppointmentDate);

-- =====================================================
-- Additional Query 1
-- Display Patient Name and Doctor Name
-- =====================================================

SELECT
    Patient.PatientName,
    Doctor.DoctorName
FROM Appointment
JOIN Patient
ON Appointment.PatientID = Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID = Doctor.DoctorID;

-- =====================================================
-- Additional Query 2
-- Display Completed Appointments
-- =====================================================

SELECT
    Appointment.AppointmentID,
    Patient.PatientName,
    Doctor.DoctorName,
    Appointment.AppointmentDate
FROM Appointment
JOIN Patient
ON Appointment.PatientID = Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID = Doctor.DoctorID
WHERE Appointment.Status = 'Completed';

-- =====================================================
-- Additional Query 3
-- Display Pending Appointments
-- =====================================================

SELECT
    Appointment.AppointmentID,
    Patient.PatientName,
    Doctor.DoctorName,
    Appointment.AppointmentDate
FROM Appointment
JOIN Patient
ON Appointment.PatientID = Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID = Doctor.DoctorID
WHERE Appointment.Status = 'Pending';

-- =====================================================
-- Additional Query 4
-- Display Number of Patients
-- City Wise
-- =====================================================

SELECT
    City,
    COUNT(PatientID) AS TotalPatients
FROM Patient
GROUP BY City;

-- =====================================================
-- Additional Query 5
-- Display Doctors Department Wise
-- =====================================================

SELECT
    Department,
    COUNT(DoctorID) AS TotalDoctors
FROM Doctor
GROUP BY Department;

-- =====================================================
-- Additional Query 6
-- Display Average Consultation Fee
-- =====================================================

SELECT
    AVG(ConsultationFee) AS AverageConsultationFee
FROM Doctor;

-- =====================================================
-- End of Workshop
-- =====================================================

SELECT 'Hospital Management System Completed Successfully...' AS Message;


