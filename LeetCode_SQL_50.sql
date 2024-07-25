-- LEETCODE SQL 50 QUESTIONS
-- Q1.)  Write the SQL query to find the IDs of products that are both low fat and recyclable

-- CREATE DATABASE LEETCODE;
CREATE TABLE Products(
product_id INT PRIMARY KEY,
low_fats ENUM('Y','N'),
recyclable ENUM('Y','N'));

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES
(0, 'Y', 'N'),
(1, 'Y', 'Y'),
(2, 'N', 'Y'),
(3, 'Y', 'Y'),
(4, 'N', 'N');

-- ANSEWER
SELECT product_id FROM products WHERE low_fats = 'Y' and recyclable = 'Y';

-- -----------------------------------------------------------------------------------------------------

-- Q2.) Find the names of the customer that are not referred by the customer with id = 2.

CREATE TABLE Customer(
id INT PRIMARY KEY,
name VARCHAR(255),
referee_id INT);

INSERT INTO Customer (id, name, referee_id) VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2);

SELECT name FROM Customer 
WHERE referee_id!=2 or referee_id IS NULL;

-- ---------------------------------------------------------------------------------------------
-- Q3) A country is big if:
-- it has an area of at least three million (i.e., 3000000 km2), or
-- it has a population of at least twenty-five million (i.e., 25000000).
-- Write a solution to find the name, population, and area of the big countries.

CREATE TABLE World(
name VARCHAR(255) PRIMARY KEY,
continent VARCHAR(255),
area INT,
population INT,
gdp BIGINT
);

INSERT INTO World (name, continent, area, population, gdp) VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000);

SELECT name,population,area  FROM World
WHERE area >= 3000000 or population >= 25000000;

-- ------------------------------------------------------------------------------------------
-- Q4.) Write a solution to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

CREATE TABLE Views(
article_id INT,
author_id INT,
viewer_id INT,
view_date DATE
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

SELECT DISTINCT author_id id FROM Views 
WHERE author_id = viewer_id
ORDER BY author_id;


-- ----------------------------------------------------------------------------------
-- Q5.) Write a solution to find the IDs of the invalid tweets. The tweet is invalid 
-- if the number of characters used in the content of the tweet is strictly greater than 15.

CREATE TABLE Tweets(
tweet_id INT PRIMARY KEY,
content VARCHAR(255)
);

INSERT INTO Tweets(tweet_id,content)
VALUES(1,'Vote for Biden'),
(2,'Let us make America great again!');

SELECT tweet_id  FROM Tweets
WHERE LENGTH(content) > 15; 
-- -------------------------------------------------------------------------------------
-- Q6.) Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

CREATE TABLE Employees
(id INT PRIMARY KEY,
name VARCHAR(255));

CREATE TABLE EmployeeUNI(
id INT,
unique_id INT,
PRIMARY KEY(id,unique_id));

INSERT INTO Employees (id, name) VALUES
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');

INSERT INTO EmployeeUNI (id, unique_id) VALUES
(3, 1),
(11, 2),
(90, 3);

SELECT unique_id,name FROM employees e
LEFT JOIN employeeuni euni ON e.id = euni.id;

-- ----------------------------------------------------------------

-- Q7.) Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
CREATE TABLE product(
product_id INT PRIMARY KEY,
product_name VARCHAR(255));

CREATE TABLE Sales(
sale_id INT,
product_id INT,
year INT,
quantity INT,
price INT,
PRIMARY KEY(sale_id,year),
FOREIGN KEY (product_id) REFERENCES product(product_id));


INSERT INTO Product (product_id, product_name) VALUES
(100, 'Nokia'),
(200, 'Apple'),
(300, 'Samsung');

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);









