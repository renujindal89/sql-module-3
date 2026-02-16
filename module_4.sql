-- Create Database
CREATE DATABASE module_4;
drop database module_4;
-- Use Database
USE module_4;

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- Insert dummy data into employees
INSERT INTO employees (employee_id, name, department, salary, hire_date) VALUES
(1, 'Alice', 'HR', 50000, '2020-01-15'),
(2, 'Bob', 'IT', 70000, '2019-03-22'),
(3, 'Charlie', 'IT', 72000, '2021-07-01'),
(4, 'Diana', 'Finance', 65000, '2018-11-30'),
(5, 'Eva', 'HR', 52000, '2022-05-10');

-- View data

SELECT * FROM employees;
select  department from employees ;

-- Select specific columns
SELECT name, salary 
FROM employees;

-- Select distinct departments
SELECT DISTINCT department 
FROM employees;

-- CLAUSES
-- SELECT
-- WHERE
-- ORDER BY
-- DISTINCT
-- GROUP BY
-- HAVING
-- LIMIT

-- Order by salary (Descending)
SELECT * 
FROM employees
ORDER BY salary DESC;

-- Order by salary (Ascending)
SELECT * 
FROM employees
ORDER BY salary ASC
limit 1 offset 2;

-- Select all records
SELECT * 
FROM employees;

-- Use of WHERE clause to filter the record/rows
-- Operators:
-- Arithmetic
-- Comparison
-- Logical
-- Operators
-- Arithmetic, Comparison, Logical


DROP TABLE products;

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(10,2),
    available BOOLEAN
);

-- Insert data into products
INSERT INTO products (product_id, name, category, price, quantity, discount, available) VALUES
(1, 'Laptop', 'Electronics', 7500, 10, 500, TRUE),
(2, 'Smartphone', 'Electronics', 4500, 25, 300, TRUE),
(3, 'Desk Chair', 'Furniture', 800, 15, 50, FALSE),
(4, 'Coffee Table', 'Furniture', 1200, 5, 100, TRUE),
(5, 'Headphones', 'Electronics', 300, 50, 20, TRUE);

-- View all records
SELECT * FROM products;



-- Arithmetic Operators

-- Addition
SELECT name, price, discount, 
       price + discount as updated_price
FROM products
where  price + discount >1500;


select category,max(price+discount) as max_updated from products

group by category
having max_updated >1500 ;

select * from products;

-- Subtraction
SELECT name, price, discount, 
       price - discount AS final_price_after_sub
FROM products;

-- Multiplication
SELECT name, price, quantity, 
       price * quantity AS total_inventory_value_after_mul
FROM products;

-- Division
SELECT name, price, quantity, 
       price / quantity AS price_per_unit_after_div
FROM products;



-- Comparison Operator (Price greater than 1000)
SELECT Name, Price
FROM Products
WHERE Price > 1000;

-- Not equal operator
SELECT Name, Price, category
FROM Products
WHERE category <> 'furniture';
-- WHERE category <> 'furniture';

-- View all records
SELECT * 
FROM products;

-- Price greater than 800
SELECT Name
FROM Products
WHERE Price > 800;

-- Practice with <, <=, >=, <>
-- Logical Operators (AND, OR, NOT)

-- AND operator
SELECT Name, Price, quantity
FROM Products
WHERE Price > 800 AND category = 'furniture';

-- OR operator (practice example)
SELECT Name
FROM Products
WHERE Price > 800 OR category = 'furniture';

-- NOT operator
SELECT Name
FROM Products
WHERE NOT category = 'furniture';

WHERE NOT category = 'furniture';

-- ADVANCE VERSION OF OR OPERATOR (LIKE)
-- The LIKE operator is used to search for patterns in text.
-- Instead of looking for an exact match,
-- it helps you find values that are similar or partially match what you're looking for.

CREATE TABLE pattern (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    email VARCHAR(50)
);

INSERT INTO pattern (ProductID, ProductName, Category, Price, email)
VALUES
(1, 'Apple iPhone', 'Electronics', 999.00, 'renugoel@gmail.com'),
(2, 'Banana Smoothie', 'Beverages', 4.99, 'sahil@gmail.com'),
(3, 'Grapes', 'Fruits', 2.50, 'yuvaan@outlook.com'),
(4, 'Apple Watch', 'Electronics', 399.00, 'ritu@gmail.com'),
(5, 'Pineapple Juice', 'Beverages', 3.99, 'addu@gmail.com');

-

-- Insert data
INSERT INTO pattern (ProductID, ProductName, Category, Price, Email) VALUES

(6, 'Laptop Stand', 'Accessories', 29.99, 'amit@outlook.com'),
(7, 'Orange Juice', 'Beverages', 3.49, 'manya@outlook.com'),
(8, 'Apple laptop', 'Electronics', 999.00, 'sumit@gmail.com'),
(9, 'Banana fruit', 'Fruit', 4.99, 'tushar@gmail.com'),
(10, 'Grapes juice', 'Beverages', 2.50, 'anshika@gmail.com'),
(11, 'Guava', 'Fruit', 4.50, 'prashant@outlook.com'),
(12, 'Karela juice', 'Vegetable', 3.50, 'sishant@gmail.com');

-- Retrieve all data
SELECT * FROM pattern;

-- Retrieve all data ordered by product name
SELECT * FROM pattern
ORDER BY ProductName ASC;

-- Filter only Apple family products using OR




select productname,category 
from pattern where productname='apple iphone' 
or productname='apple laptop'
or productname='apple watch';



SELECT * FROM pattern
WHERE ProductName = 'Apple iPhone'
   OR ProductName = 'Apple laptop'
   OR ProductName = 'Apple watch';
   
   -- Better Way (Using IN operator)
SELECT * 
FROM pattern
WHERE ProductName IN ('Apple iphone', 'Apple laptop', 'Apple watch');

-- Alternative: use LIKE with wildcard for Apple family
SELECT * FROM pattern
WHERE ProductName LIKE '%jindal';

-- Let’s try with different patterns:
-- %  → matches any number of characters
-- _  → matches exactly one character
-- 'grapes%'
-- '%x'
-- '%juice'
-- 'juice and fruit'
-- '%gmail'
-- '%gmail.com'


-- Starts with "apple"
SELECT * 
FROM pattern
WHERE ProductName LIKE 'apple%';

-- Ends with "ple"
SELECT * 
FROM pattern
WHERE ProductName LIKE '%ple';

-- Contains "grapes"
SELECT *
FROM pattern
WHERE ProductName LIKE '%grapes%';

-- Starts with exactly one character before "juice"
SELECT *
FROM pattern
WHERE ProductName LIKE '_rapes';

-- Ends with "mail"
SELECT *
FROM pattern
WHERE email LIKE '%mail';

-- Ends with "gmail.com"
SELECT *
FROM pattern
WHERE email LIKE '%gmail.com';

Here is all the comment part from your latest screenshot written properly:

-- '%juice'
-- '%juice and fruit'
-- '%gmail%'
-- '%@gmail.com'

-- 'A_5' : Matches codes like "AB5", "AC5", etc.
--         where the second character can be anything.

-- '_a__i%' : Second letter is "a"

-- First letter is "j"

-- Followed by any number of characters


-- 'a__e'
-- '_pple%'
-- 'a_____i'
