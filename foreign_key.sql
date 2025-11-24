create database constr;
use constr;
 drop database constr;
 


-- A primary key is a column (or a set of columns) that uniquely identifies each record in a table.
-- It automatically enforces two rules:
-- NOT NULL → No empty values allowed.
-- UNIQUE → No duplicate values allowed.
-- Each table can have only one primary key, but it can consist of multiple columns (called a composite key)



CREATE TABLE Students (
    student_id INT NOT NULL,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (student_id)
);


SHOW CREATE TABLE Students;

  
  
 -- If you want to give a custom name to your primary key, you can do:

CREATE TABLE Students (
    student_id INT NOT NULL,
    name VARCHAR(100),
    age INT,
    CONSTRAINT pk_students PRIMARY KEY (student_id)
);

SELECT 
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Enrollments'
  AND TABLE_SCHEMA = DATABASE();

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

INSERT INTO Enrollments (student_id, course_id)
VALUES
    (1, 101),   -- Student 1 enrolled in Course 101
    (1, 102),   -- Student 1 enrolled in Course 102
    (2, 101),   -- Student 2 enrolled in Course 101
    (2, 103),   -- Student 2 enrolled in Course 103
    (3, 104);   -- Student 3 enrolled in Course 104
    
    
    INSERT INTO Enrollments (student_id, course_id)
VALUES (1, 101);  -- ❌ Duplicate entry 


-- FOREIGN KEY 
-- A foreign key is a column (or set of columns) in one table that refers to the primary key in another table.

-- You cannot insert a value in the foreign key column unless it exists in the parent table’s primary key.

-- If you try to delete or update a parent record,the database checks what happens to child records (depending on the constraint action).
Data consistency: No invalid references.

Integrity: Ensures relationships between tables are meaningful.

create table parent_idea_course(corname varchar(50) primary key);	


create table child_students_enroll (stuid int primary key,firstname varchar(40)
,corsename varchar(10));

insert into parent_idea_course values ('data'),('engg'),('ai');
insert into child_students_enroll values(11,'renu','data'),(12,'ritu','engg'),(13,'sahil','ai');


-- want to insert the new record in child 
insert into child_students_enroll values(14,'amit','data'),(15,'tushar','java'),(16,'manya','python'),
(17,'mohit','sql');

select * from child_students_enroll;
select * from parent_idea_course;


-- can i delete record from both table  "yes"

delete from parent_idea_course
where corname='data';

select * from parent_idea_course;
select* from child_students_enroll;


-- now lets create another table with fk reference
-- idea_course1
-- parent table
create table parent_idea_course1(corname varchar(50) primary key);
insert into parent_idea_course1 values ('data'),('engg'),('ai');
insert into parent_idea_course1 values ('java');

-- child table
create table child_students_enroll1 
(stuid int primary key,firstname varchar(40),
corsename varchar(10),
FOREIGN KEY (corsename)
 REFERENCES parent_idea_course1(corname)
);  -- Prevents deletion if child rows exist.


insert into child_students_enroll1 values
(11,'renu','data'),
(12,'ritu','engg'),
(13,'sahil','ai');


 -- CASE 1   CHILD TABLE ERROR
 
 
 -- ADD A NEW STUDENT  IN NEW COURSE JAVA
insert into child_students_enroll1 values
(14,'renu','java');  -- can not add new course in child  table 


-- ADDA NEW STUDENT IN OLD COURSE 
insert into child_students_enroll1 values
(15,'yuvaan','AI');  -- no issue


select * from child_students_enroll1;
select * from parent_idea_course1;

desc students_enroll1;
desc idea_course1;


-- CASE 2
-- DELETE A COURSE FROM OUR INSTITUTE "DATA"


-- Try deleting a parent row (will give foreign key error)
DELETE FROM parent_idea_course1
WHERE corname = 'engg'; 


UPDATE  parent_idea_course1
SET corname = 'data analyst'
where corname='data'; 


-- ADD ANEW COURSE IN INSTITUTE
insert into parent_idea_course1 values ('java');


DELETE FROM parent_idea_course1
WHERE corname = 'java';  -- Since no student has java, it works


-- trying to delete a student record who have completed the data course 

-- DELETE IN CHILD POSSIBLE 
DELETE FROM child_students_enroll1
WHERE corsename = 'data';   -- sucessfully delete

select * from child_students_enroll1;
select * from parent_idea_course1;


-- CONCLUSION  IS:
-- deletion ,updation in parent not possible 
-- deletion in child is possible 
-- adding new course in child not possible if it is not present in parent table

-- but we can delete a couse from parent table 
-- -- in this case we want to use the cascade delete and update option
-- steps to alter f.k 
-- Drop existing FK constraint
-- Recreate FK with CASCADE options


ALTER TABLE child_students_enroll1
DROP CONSTRAINT students_enroll1_ibfk_1;


ALTER TABLE child_students_enroll1
ADD CONSTRAINT students_enroll1_ibfk_1
FOREIGN KEY (corsename)
REFERENCES parent_idea_course1(corname)
ON UPDATE CASCADE
ON DELETE CASCADE;

desc child_students_enroll1;

select * from students_enroll1;
select * from idea_course1;

-- Now parent deletes will cascade

DELETE FROM idea_course1
WHERE corname = 'engg'; -- This will automatically delete the student enrolled in java.

-- Show data
SELECT * FROM idea_course1;
SELECT * FROM students_enroll1;

-- Problem:
-- If we delete a course, the student record becomes invalid.
-- To keep the student record, we use ON DELETE SET NULL.

-- Step 1: Drop existing foreign key
ALTER TABLE students_enroll1
DROP CONSTRAINT students_enroll1_ibfk_1;

-- Step 2: Add new foreign key with SET NULL on delete
ALTER TABLE students_enroll1
ADD CONSTRAINT fk_1
FOREIGN KEY (corsename)
REFERENCES idea_course1(corname)
ON DELETE SET NULL
ON UPDATE CASCADE;


DELETE FROM idea_course1
WHERE corname = 'ai';


select * from students_enroll1;


-- ✔ Expected Behavior
-- The row for 'ai' is deleted from idea_course1
-- The student 'sahil' keeps his record
-- His coursename becomes NULL in students_enroll1

create database constr;
use constr;
drop database constr;
create table parent_idea_course1(corname varchar(50) primary key);
insert into parent_idea_course1 values ('data'),('engg'),('ai');
insert into parent_idea_course1 values ('java');

select * from parent_idea_course1;

CREATE TABLE child_students_enroll1 (
    stuid INT PRIMARY KEY,
    firstname VARCHAR(40),
    corsename VARCHAR(50),
    FOREIGN KEY (corsename)
        REFERENCES parent_idea_course1(corname)
        -- ON UPDATE CASCADE
        -- ON DELETE  cascade -- SEt null
);

insert into child_students_enroll1 values
(11,'renu','data'),
(12,'ritu','engg'),
(13,'sahil','ai');

select * from parent_idea_course1;
select* from child_students_enroll1;

-- CASE 1
UPDATE parent_idea_course1
SET corname = 'data analyst'  -- new value
WHERE corname = 'data';  -- old value


select * from parent_idea_course1;
select* from child_students_enroll1;

-- CASE 2
DELETE FROM parent_idea_course1
WHERE corname = 'engg'; -- This will automatically delete the student enrolled in engg.

select* from child_students_enroll1;
select * from parent_idea_course1;




















