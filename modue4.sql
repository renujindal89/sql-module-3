create database module_4;
use module_4;
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

INSERT INTO employees (employee_id, name, department, salary, hire_date) VALUES
(7, 'da', 'HR', 52000, '2022-05-10');

SELECT * FROM employees;

SELECT name, salary FROM employees;

select distinct department from employees;

-- CLAUSES 
-- SELECT
-- WHERE  
-- ORDERBY
-- DISTINCT
-- GROUPBY
-- HAVING
SELECT * FROM EMPLOYEES 
ORDER BY SALARY DESC;

SELECT * FROM EMPLOYeeS 
ORDER BY SALARY ASC;

-- use of where clause to filter the record
-- operators
-- airthematic ,comparison,logical
 -- airthematic operators
 -- addition,subtraction,multiplication,division,modulas%
 CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Category VARCHAR(50),
    quantity int,
    Price DECIMAL(10, 2),
    Discount DECIMAL(5, 2)  -- percentage discount
);
INSERT INTO Products (ProductID, Name, Category,qantity, Price, Discount)
VALUES
(1, 'Smartphone X', 'Electronics', 5,600.00, 10.00),
(2, 'Running Shoes', 'Footwear', 10,300.00, 15.00),
(3, 'Leather Wallet', 'Accessories',10, 90.00, 5.00),
(4, 'LED TV 42"', 'Electronics',5, 300.00, 20.00),
(5, 'Office Chair', 'Furniture',10, 500.00, 10.00),
(6, 'Cookware Set', 'Kitchen', 200.00, 10.00),
(7, 'Bluetooth Headphones', 'Electronics', 100.00, 10.00);
select * from products;

select name,price,price+50 as newprice from products; 

SELECT name,price,discount,price + discount AS total_cost_after_add from products;          -- Addition
SELECT name ,price,discount, price - discount AS final_price_after_sub from products;          -- Subtraction
SELECT name,price,quantity, price * quantity AS total_inventory_value_after_mul from products; -- Multiplication
SELECT name ,price,quantity, price / quantity AS price_per_unit_after_div from products;           -- Division

SELECT  *,
       CASE WHEN MOD(productid, 2) = 0 THEN 'Even' ELSE 'Odd' END AS order_type
FROM products;

-- use of where clause to filter the record base on condition
-- with in where clause we use operators 
-- comparision (<,>,<=,>=,<>,and,or,not,like,in,between)

SELECT Name
FROM Products
WHERE Price > 300;
-- do practice with <,<=,>=,<>
-- do practice with numerical columns

-- AND  The AND operator is used to combine multiple conditions in a WHERE clause.
 -- All conditions must be true

select Name, Price
FROM Products
WHERE Price > 300 AND category='furniture';

-- OR OPERATOR
-- used to combine multiple conditions where at least one must be true.

SELECT * FROM Products
WHERE Category = 'Electronics' OR Discount > 15;


SELECT Name
FROM Products
WHERE NOT Category = 'furniture';

SELECT Name, Price,category
FROM Products
WHERE category <> 'furniture';




drop table pattern;
CREATE TABLE pattern(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    email varchar(50)
);

INSERT INTO pattern (ProductID, ProductName, Category, Price,email)
VALUES
(1, 'Apple iPhone', 'Electronics', 999.00,'renugoel@gmail.com'),
(2, 'Banana Smoothie', 'Beverages', 4.99,'sahil@gmail.com'),
(3, 'Grapes', 'Fruits', 2.50,'yuvaan@outlook.com'),
(4, 'Apple Watch', 'Electronics', 399.00,'ritu@gmail.com'),
(5, 'Pineapple Juice', 'Beverages', 3.99,'addu@gmail.com'),
(6, 'Laptop Stand', 'Accessories', 29.99,'amit@outlook.com'),
(7, 'Orange Juice', 'Beverages', 3.49,'manya@outlook.com');
INSERT INTO pattern (ProductID, ProductName, Category, Price,email)
VALUES
(8, 'Apple laptop', 'Electronics', 999.00,'sumit@gmail.com'),
(9, 'Banana fruit', 'fruit', 4.99,'tushar@gmail.com'),
(10, 'Grapes juice', 'beverages', 2.50,'anshika@gmail.com'),
(11,'Guava','fruit',4.50,'prashant@outlook.com'),
(12,'karela juice','vegetable',3.50,'sishant@gmail.com');

select * from pattern;
select * from pattern 
order by productname asc;

-- i want to filter the data only apple family(using or)

select * from pattern
where productname = 'apple iphone' or productname='apple laptop' or productname='apple watch';

-- IN OPERATOR ( check if a value exists within a list or set of values)
-- exact match
select * from pattern
where productname in ('apple iphone','apple laptop','apple watch');

SELECT * FROM pattern
WHERE price  IN (999.00,4.99) AND Category = 'Electronics';

 SELECT * FROM employees
WHERE department IN ('hr', 'it');

-- LIKE OPERATOR 
-- - ADVANCE VERSION OF = OPERATOR  (LIKE)
-- The LIKE operator is used to search for patterns in text. 
-- Instead of looking for an exact match, 
-- it helps you find values that are similar or partially match what you're looking for.
 -- % match any number of character
-- "_' match exactly one character

select * from pattern
where productname = 'apple iphone' or productname='apple laptop' or productname='apple watch';

select * from pattern
where productname in ('apple iphone','apple laptop','apple watch');

select * from pattern
where productname like 'apple%';

-- %com means end with comm
-- apple% means start with apple followed by any character
-- %gmail% means string contain gmail 
-- a__d means first letter is a,forth letter must be deallocate prepare


-- lets try with
-- 'grapes%'
-- 'g%'
-- '%juice'
-- '%juice and %fruit
-- '%gmail%  contain gmail
-- '%@gmail.com';
-- Address LIKE '%Delhi%' AND Name LIKE 'C%';
-- 'A_5'; Matches codes like “AB5”, “AC5”, etc.—where the second character can be anything.
-- 'a___e
-- '_pple%';
-- 'a_____i'
--  '_a__i%';- Second letter is “a”
-- Fifth letter is “i”
-- Followed by any number of characters
SELECT * FROM pattern
WHERE ProductName LIKE 'apPle%';
SELECT * FROM pattern
WHERE ProductName LIKE '_ple%';

--  first names start with 'S' but do not start with 'Sh':

SELECT employee_id, first_name, last_name
FROM employees
WHERE first_name LIKE 'S%' AND first_name NOT LIKE 'Sh%'
ORDER BY first_name;




--  BINARY 'apple%'  (case sensitive)

-- The BETWEEN operator is a powerful way to filter values that fall within a specific range—
-- and it works with numbers, dates, and even text (depending on the database).

select * from pattern
where productname between 'a' and 'b';

select * from employees;

select * from employees
where name between 'a' and 'd';

select * from employees;

select * from employees
where hire_date  between '2018-1-1' and '2019-03-22';

select * from employees
where salary  between '52000' and '72000';

select * from employees
where salary  not between '52000' and '72000';


-- FUNCTIONS
select * from pattern;
select sum(price) as total,category from pattern
where category='beverages';
select sum(price) as total,category from pattern
where category='fruits';

select category
from pattern
group by category;

select count(productid) from pattern;


select distinct category from pattern;


SET sql_safe_updates = 0;


 update pattern
 set category ='fruit'
where category='fruits';



