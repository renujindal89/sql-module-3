create database update_3;



-- DML (INSERT,UPDATE,DELETE,SELECT)
create database module_3;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(101, 'Amit', 'Sharma', 'IT', 75000.00, '2020-03-15'),
(102, 'Neha', 'Verma', 'HR', 62000.00, '2019-07-01'),
(103, 'Raj', 'Singh', 'Finance', 68000.00, '2021-01-10'),
(104, 'Priya', 'Mehta', 'Marketing', 71000.00, '2022-06-25'),
(105, 'Karan', 'Patel', 'IT', 80000.00, '2018-11-30');
 select * from Employees;

UPDATE Employees
SET Salary = Salary + 5000
WHERE Department ='IT';

SET sql_safe_updates = 0;
select * from Employees;


DELETE FROM Employees
WHERE EmployeeID = 104;
select * from Employees;


SELECT FirstName, LastName, Department
FROM Employees
WHERE Salary > 70000;





CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    CourseName VARCHAR(100),
    Semester VARCHAR(10),
    Grade CHAR(2)
);
INSERT INTO Enrollments VALUES
(401, 'Rahul Jain', 'Data Structures', 'Final', 'A'),
(402, 'Sneha Kapoor', 'Operating Systems', 'Final', 'B'),
(403, 'Aman Bhatia', 'Database Systems', 'second', 'A'),
(404, 'Isha Malhotra', 'Computer Networks', 'Second', 'C'),
(405, 'Nikhil Arora', 'Machine Learning', 'Final', NULL);
select * from Enrollments;
UPDATE Enrollments
SET Grade = 'A'
WHERE StudentName = 'Isha Malhotra' AND CourseName = 'Computer Networks';

select * from Enrollments;

UPDATE Orders
SET Status = 'Delivered'
WHERE OrderID = 1002;


-- CRUD OPERATION
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Position NVARCHAR(50),
    Salary DECIMAL(10, 2)
);
INSERT INTO Employees (EmployeeID, Name, Position, Salary)
VALUES 
(1, 'John Doe', 'Manager', 75000.00),
(2, 'Jane Smith', 'Developer', 60000.00),
(3, 'Sam Wilson', 'Designer', 55000.00);

-- Retrieve all employees
SELECT * FROM Employees;

-- Retrieve specific columns
SELECT Name, Position FROM Employees WHERE Salary > 55000;

-- Update salary for a specific employee
UPDATE Employees
SET Salary = 80000.00
WHERE EmployeeID = 1;

-- Update position for all employees earning less than 60000
UPDATE Employees
SET Position = 'Junior Designer'
WHERE Salary < 60000;

-- Delete a specific employee
DELETE FROM Employees
WHERE EmployeeID = 3;

-- Delete all employees with a salary below 60000
DELETE FROM Employees
WHERE Salary < 60000;
