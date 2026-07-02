/*
=====================================================================
                    DBMS Workshop - LJU
---------------------------------------------------------------------
Workshop Name      : Hospital Appointment Management System
Topic              : RDBMS & SQL Queries
Database           : MySQL
Language           : SQL
Course             : Master of Computer Applications (MCA)
University         : Lok Jagruti University (LJU)
Author             : Mohmadhusen Khimani
=====================================================================

Workshop Problem Statement

A hospital administrator wants to develop a Hospital Appointment
Management System.

Currently, patient records are maintained manually in files.
Appointments are also written manually in registers, causing
duplicate bookings for the same doctor at the same date and time.

The hospital wants a computerized system to manage patients,
doctors, and appointments efficiently.

The system stores information about patients, doctors,
and appointments.

---------------------------------------------------------------
Patient Table
---------------------------------------------------------------
• PatientID
• PatientName
• Age
• Gender
• Phone

---------------------------------------------------------------
Doctor Table
---------------------------------------------------------------
• DoctorID
• DoctorName
• Specialization
• RoomNumber

---------------------------------------------------------------
Appointment Table
---------------------------------------------------------------
• AppointmentID
• PatientID
• DoctorID
• AppointmentDate
• AppointmentTime
• Status

The administrator wants to generate reports such as:

Q1. Display all patients.

Q2. Display all doctors.

Q3. Display all appointments.

Q4. Display appointments of a particular patient.

Q5. Display appointments of a particular doctor.

Q6. Display today's appointments.

Q7. Count total appointments handled by each doctor.

Q8. Display completed appointments.

Q9. Display pending appointments.

Q10. Display patient name, doctor name,
     appointment date, time and status.

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
    PatientName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Phone VARCHAR(15)
);

-- =====================================================
-- Create Doctor Table
-- =====================================================

CREATE TABLE Doctor
(
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100),
    Specialization VARCHAR(100),
    RoomNumber INT
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
    Status VARCHAR(20),

    FOREIGN KEY (PatientID)
    REFERENCES Patient(PatientID),

    FOREIGN KEY (DoctorID)
    REFERENCES Doctor(DoctorID)
);

-- =====================================================
-- Insert Patient Data
-- =====================================================

INSERT INTO Patient VALUES
(101,'Rahul Patel',22,'Male','9876543210'),
(102,'Priya Shah',24,'Female','9876543211'),
(103,'Amit Joshi',30,'Male','9876543212'),
(104,'Neha Patel',27,'Female','9876543213'),
(105,'Rohan Mehta',35,'Male','9876543214');

-- =====================================================
-- Insert Doctor Data
-- =====================================================

INSERT INTO Doctor VALUES
(1,'Dr. Rajesh','Cardiologist',101),
(2,'Dr. Sneha','Dermatologist',102),
(3,'Dr. Kunal','Orthopedic',103),
(4,'Dr. Pooja','Neurologist',104),
(5,'Dr. Mehul','General Physician',105);

-- =====================================================
-- Insert Appointment Data
-- =====================================================

INSERT INTO Appointment VALUES
(1001,101,1,'2026-07-01','10:00:00','Completed'),
(1002,102,2,'2026-07-01','11:00:00','Pending'),
(1003,103,3,'2026-07-02','09:30:00','Completed'),
(1004,104,1,'2026-07-02','12:00:00','Pending'),
(1005,105,5,'2026-07-03','03:00:00','Completed');

-- =====================================================
-- Q1
-- Display All Patients
-- =====================================================

SELECT *
FROM Patient;

-- =====================================================
-- Q2
-- Display All Doctors
-- =====================================================

SELECT *
FROM Doctor;

-- =====================================================
-- Q3
-- Display All Appointments
-- =====================================================

SELECT *
FROM Appointment;

-- =====================================================
-- Q4
-- Display Appointments of Particular Patient
-- (Rahul Patel)
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
WHERE Patient.PatientName='Rahul Patel';

-- =====================================================
-- Q5
-- Display Appointments of Particular Doctor
-- (Dr. Rajesh)
-- =====================================================

SELECT
    Doctor.DoctorName,
    Patient.PatientName,
    Appointment.AppointmentDate,
    Appointment.AppointmentTime
FROM Appointment
JOIN Patient
ON Appointment.PatientID=Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID=Doctor.DoctorID
WHERE Doctor.DoctorName='Dr. Rajesh';

-- =====================================================
-- Q6
-- Display Today's Appointments
-- =====================================================

SELECT *
FROM Appointment
WHERE AppointmentDate='2026-07-01';

-- =====================================================
-- Q7
-- Count Total Appointments of Each Doctor
-- =====================================================

SELECT
    Doctor.DoctorName,
    COUNT(Appointment.AppointmentID) AS TotalAppointments
FROM Doctor
JOIN Appointment
ON Doctor.DoctorID=Appointment.DoctorID
GROUP BY Doctor.DoctorName;

-- =====================================================
-- Q8
-- Display Completed Appointments
-- =====================================================

SELECT *
FROM Appointment
WHERE Status='Completed';

-- =====================================================
-- Q9
-- Display Pending Appointments
-- =====================================================

SELECT *
FROM Appointment
WHERE Status='Pending';

-- =====================================================
-- Q10
-- Display Complete Appointment Details
-- =====================================================

SELECT
    Patient.PatientName,
    Doctor.DoctorName,
    Appointment.AppointmentDate,
    Appointment.AppointmentTime,
    Appointment.Status
FROM Appointment
JOIN Patient
ON Appointment.PatientID=Patient.PatientID
JOIN Doctor
ON Appointment.DoctorID=Doctor.DoctorID;

-- =====================================================
-- End of Workshop
-- =====================================================