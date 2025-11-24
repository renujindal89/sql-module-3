create database constr;
use constr;
 drop database constr;


✅ Tip:
For primary keys, the constraint name is always PRIMARY unless you explicitly named it when creating the table.
For other constraints (foreign keys, unique, check), 
MySQL usually generates a name like table_col_foreign if you don’t give one.


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    name VARCHAR(100)
);


CREATE TABLE Students (
    student_id INT NOT NULL,
    name VARCHAR(100),
    age INT,
    CONSTRAINT pk_students PRIMARY KEY (student_id)
);


-- Composite primary key
CREATE TABLE Enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id)
);


-- or we can write in this manner

CREATE TABLE Enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    CONSTRAINT pk_enrollments PRIMARY KEY (student_id, course_id)
);
-- the combination of student_id and course_id ensures uniqueness.


desc students;

-- to see the constraint 


Right-click the table and choose Alter Table…
In the Alter Table window, you’ll see several tabs:

Columns → Shows all columns.

Indexes → Lists PRIMARY KEY and UNIQUE constraints.

Primary key will usually be named PRIMARY.

Unique keys will show their names (system-generated if you didn’t specify).

Foreign Keys → Lists all foreign key constraints with their names (e.g., Enrollments_student_id_foreign) and the referenced table/column.

Checks → (if you have any CHECK constraints; MySQL 8.0+).

Each constraint shows its name, type, and the columns it applies to.


-- Edit / Drop Constraints

ALTER TABLE Enrollments
DROP FOREIGN KEY Enrollments_student_id_foreign;

-- EXAMPLE 

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);


CREATE TABLE Employees (
    emp_id INT NOT NULL,
    dept_id INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL DEFAULT 30000,
    age INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',

    -- Primary Key
    PRIMARY KEY (emp_id),

    -- Unique Constraint
    UNIQUE (email),

    -- Check Constraint
    CHECK (age >= 18),

    -- Foreign Key Constraint
    CONSTRAINT fk_employees_department
        FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    name VARCHAR(100)
);

-- student_id is the primary key (must be unique and not NULL).
-- email must also be unique, but it can be NULL if not provided.


-- as of now no rules break
INSERT INTO Students (student_id, email, name)
VALUES
    (1, 'alice@example.com', 'Alice'),
    (2, 'bob@example.com', 'Bob'),
    (3, 'charlie@example.com', 'Charlie');
    
    INSERT INTO Students (student_id, email, name)
VALUES (4, 'alice@example.com', 'Eve');  -- error

INSERT INTO Students (student_id, email, name)
VALUES (5, NULL, 'Frank');  -- allowed

select * from students;

INSERT INTO Students (student_id, email, name)
VALUES (null, NULL, 'Frank');  -- pk error

INSERT INTO Students (student_id, email, name)
VALUES (5, NULL, 'Frank');  -- pk error duplicate

-- primarykey as composite key(combination of two column)

CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    semester VARCHAR(10),
    PRIMARY KEY (student_id, course_id),
    UNIQUE (student_id, semester)
);

INSERT INTO Enrollments (student_id, course_id, semester)
VALUES
    (1, 101, 'Fall2025'),   -- Student 1 in Course 101, Fall2025
    (2, 102, 'Fall2025'),   -- Student 2 in Course 102, Fall2025
    (3, 103, 'Spring2026'); -- Student 3 in Course 103, Spring2026
    
    -- Violates PRIMARY KEY
    INSERT INTO Enrollments (student_id, course_id, semester)
VALUES (1, 101, 'Fall2025');  -- error
INSERT INTO Enrollments (student_id, course_id, semester)
VALUES (1, 102, 'Fall2025'); -- error

INSERT INTO Enrollments (student_id, course_id, semester)
VALUES (1, 104, 'Spring2026'); -- error unique key

-- NOT NULL 

CREATE TABLE Students1 (
    student_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Students1 (student_id, email, name)
VALUES
    (1, 'alice@example.com', 'Alice'),
    (2, 'bob@example.com', 'Bob');
    
    INSERT INTO Students1 (student_id, email, name)
VALUES (3, NULL, 'Charlie');-- error

INSERT INTO Students1 (student_id, email, name)
VALUES (4, 'david@example.com', NULL); -- error

-- NOTE 
-- Primary key columns are automatically NOT NULL.
-- You can combine NOT NULL with other constraints (UNIQUE, CHECK, DEFAULT).

-- CHECK  

-- The CHECK constraint in SQL is used to enforce a condition on values in a column. 
-- It ensures that only data meeting the specified rule can be inserted into the table.
-- If the condition evaluates to FALSE, the database rejects the insert or update.
CREATE TABLE Students2 (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18)
);



INSERT INTO Students2 (student_id, name, age)
VALUES (1, 'Alice', 20); -- valid

INSERT INTO Students2 (student_id, name, age)
VALUES (2, 'Bob', 16);-- invalid


CREATE TABLE Courses ( 
course_id INT PRIMARY KEY,
 course_name VARCHAR(100), 
credits INT CHECK (credits BETWEEN 1 AND 5));-- 1,2,3,4,5 -- credits >= 1 AND credits <= 5 );


INSERT INTO Courses (course_id, course_name, credits) VALUES
(1, 'Introduction to Programming', 3),
(2, 'Database Systems', 4),
(3, 'Calculus I', 5),
(4, 'English Literature', 2),
(5, 'Physics', 4),
(6, 'Art History', 1);

INSERT INTO Courses (course_id, course_name, credits) VALUES
(7, 'Introduction to Programming', 3),
(8, 'Database Systems', 4.5);


-- The DEFAULT

 -- constraint in SQL is used to automatically assign a value to a column if no value is provided
--  during an INSERT
-- If you don’t insert a value into a column with a DEFAULT, the database fills it in automatically.
-- You can still override the default by explicitly providing a value.

CREATE TABLE Students3(
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20)  DEFAULT 'Active'
);

INSERT INTO Students3 (student_id, name)
VALUES (3, 'Alice');
select * from students3;
INSERT INTO Students3 (student_id, name, status)
VALUES (2, 'Bob', 'Inactive'); -- override


select * from students3;


-- ALTER AND DROP 



ALTER TABLE table_name
ADD CONSTRAINT pk_name PRIMARY KEY (column_name);


ALTER TABLE table_name
ADD CONSTRAINT check_name CHECK (condition);

Add a DEFAULT constraint


Technically defaults are not “constraints” but column attributes:

ALTER TABLE table_name
ALTER COLUMN column_name SET DEFAULT value;


ALTER TABLE orders
ALTER COLUMN status SET DEFAULT 'pending';

Add a NOT NULL constraint
ALTER TABLE table_name
MODIFY column_name datatype NOT NULL;

ALTER TABLE table_name
MODIFY id INT;  -- remove AUTO_INCREMENT


-- DROP 

ALTER TABLE table_name
DROP FOREIGN KEY fk_name;

ALTER TABLE table_name
DROP PRIMARY KEY;

ALTER TABLE table_name
DROP FOREIGN KEY fk_name;

ALTER TABLE table_name
ALTER COLUMN column_name DROP DEFAULT;



ALTER TABLE child_students_enroll1
DROP CONSTRAINT students_enroll1_ibfk_1;


ALTER TABLE child_students_enroll1
ADD CONSTRAINT students_enroll1_ibfk_1
FOREIGN KEY (corsename)





















A UNIQUE constraint ensures that all values in a column (or a set of columns) are distinct.
A table can have both a primary key and one or more unique keys
