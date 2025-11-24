🆚 Quick Side-by-Side Comparison
Feature	           CHAR          	       VARCHAR	                 TEXT
Storage	          Fixed size               Variable	                Large external storage
Speed	          Fastest	                Fast	                Slowest
Max Length	          255	                 65,535	                 Up to 4GB (LONGTEXT)
Default Value	     Yes	                     Yes	                 ❌ No
Indexing	         Fast	                    Fast	             Slow (prefix needed)
Use Case	       Fixed data	                Variable data	         Large text

Memory usage formula:
CHAR(n) ⇒ always uses n bytes  
+ padding bytes if needed (spaces)

CHAR(10)
Always uses 10 bytes, even if you store only "abc"


VARCHAR(50)
Store "abc" (3 characters):

Memory used =
3 bytes + 1 byte = 4 bytes





Memory Best Practices
CHAR is good when the number length is fixed
Use CHAR only when all values have the same length (e.g., country code, gender,pin,year,product code like "A111",otp).

Use VARCHAR for most normal strings (name, email, address,phoneno,).
VARCHAR is good when the length varies
Use TEXT only when storing large text (comments, descriptions, articles).

-- NOTE 
 Numbers that SHOULD NOT be stored in INT
 
These should be stored in VARCHAR, NOT numeric types:

Phone numbers
Aadhaar numbers / SSN
Credit card numbers
Zip codes
Product codes
Employee codes (E101, A77)
Anything with leading zeroes

Because they are identifiers, not mathematical values.

⭐ 5. Example Table
CREATE TABLE UserData (
    user_id INT PRIMARY KEY,
    phone VARCHAR(15),     -- variable
    pin_code CHAR(6),      -- fixed length
    card_number VARCHAR(20)
);








create database complere;
use complere;

-- int unsigned(0 and positive)
-- Range: 0 to 4,294,967,295
CREATE TABLE products (
    quantity INT UNSIGNED
);
INSERT INTO products (quantity) VALUES (3000000000);
select * from products;


-- int range:-  −2,147,483,648 to 2,147,483,647
CREATE TABLE accounts (
    account_id INT,
    balance INT
);

INSERT INTO accounts VALUES (1, -250); 


CREATE TABLE test1 (num INT);  -- signed INT

INSERT INTO test1 VALUES (3000000000);  -- error


-- NOTE 
Storing "0456" in an INT loses data:


-- DECIMAL range: (65,30-65)
-- price DECIMAL(10, 2)  Max: 99999999.99


-- For strings in SQL, memory consumption depends on the datatype (CHAR, VARCHAR, TEXT, etc.) 
-- and the length of the string, unlike integers which have fixed sizes.
-- In MySQL, the range of CHAR is 0–255 characters, while the range of VARCHAR is 0–65,535


-- CHAR (fixed length)  string   #reserved
-- Always reserves n characters storage, even if the string is shorter

create table student1(stuname char(5));
select * from student1;

insert into student1 values('amitfrt'); -- error
insert into student1 values('amit',f,f,f,f,d),('aman');
select * from student;
insert into student values('aditya');


-- VARCHAR
  
create table employee (empname varchar(20));
insert into employee values ('fgkjhfkejgfhehkjfghgfjkhfwfgewhfehwjf'); -- error
select * from employee;

-- TEXT 

-- refers to data types used to store large strings of characters.
-- TEXT is always a variable-length datatype
-- It stores only the characters you insert.
-- MySQL TEXT can store up to 65,535 bytes (≈ 65 thousand characters).

-- eg 
CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT
);
INSERT INTO articles (title, content)
VALUES ('My First Article', 'This is some long text content that can contain many characters...');
SELECT content FROM articles WHERE id = 1;



-- Use TEXT for long descriptions, logs, JSON, XML, etc.
-- For smaller strings (names, titles, emails), use VARCHAR(n).
