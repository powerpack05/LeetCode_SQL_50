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


SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p ON s.product_id = p.product_id;

-- ----------------------------------------------------------------------------------------------

-- Q8.) Write a solution to find the IDs of the users who visited without making any 
-- transactions and the number of times they made these types of visits.

CREATE TABLE Visits(
visit_id INT PRIMARY KEY,
customer_id INT);

CREATE TABLE Transactions(
transaction_id INT PRIMARY KEY,
	visit_id INT,
    amount INT,
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id));
    
    
INSERT INTO Visits (visit_id, customer_id) VALUES
(1, 23),
(2, 9),
(4, 30),
(5, 54),
(6, 96),
(7, 54),
(8, 54);

INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES
(2, 5, 310),
(3, 5, 300),
(9, 5, 200),
(12, 1, 910),
(13, 2, 970);


SELECT customer_id,count(customer_id) as count_no_trans FROM Visits v
LEFT JOIN Transactions t ON t.visit_id = v.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_ids;


-- -----------------------------------------------------------------------------------------------------------

-- Q9.)Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
CREATE TABLE Weather(
id INT PRIMARY KEY,
recordDate DATE,
temperature INT
);

INSERT INTO Weather (id, recordDate, temperature) VALUES 
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);

SELECT DISTINCT a.Id
FROM Weather a,Weather b
WHERE a.temperature>b.temperature
AND DATEDIFF(a.Recorddate,b.Recorddate) = 1	;
-- ---------------------------------------------------------------------------------------------------------
-- Q10. ) Write a solution to find the average time each machine takes to complete a process.

-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time 
-- to complete every process on the machine divided by the number of processes that were run.

-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

CREATE TABLE Activity(
machine_id INT,
process_id INT,
activity_type ENUM('start','end'),
timestamp FLOAT,
PRIMARY KEY(machine_id,process_id,activity_type));


-- Insert records into the Activity table
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start', 0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.430),
(1, 1, 'end', 1.420),
(2, 0, 'start', 4.100),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.500),
(2, 1, 'end', 5.000);


SELECT * FROM Activity;

WITH CTE AS(
SELECT machine_id,process_id,
	(MAX(CASE WHEN activity_type = 'end' THEN timestamp ELSE NULL END) - MAX(CASE WHEN activity_type = 'start' THEN timestamp ELSE NULL END)) as time_difference
    FROM
       activity 
GROUP BY machine_id,process_id	)

SELECT machine_id,ROUND(AVG(time_difference),3) as processing_time FROM cte
GROUP BY machine_id;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- Q11.) Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

-- Create Employee table
CREATE TABLE Employee (
    empId INT PRIMARY KEY,
    name VARCHAR(100),
    supervisor INT,
    salary INT
);

-- Insert data into Employee table
INSERT INTO Employee (empId, name, supervisor, salary)
VALUES
(3, 'Brad', NULL, 4000),
(1, 'John', 3, 1000),
(2, 'Dan', 3, 2000),
(4, 'Thomas', 3, 4000);

-- Create Bonus table
CREATE TABLE Bonus (
    empId INT PRIMARY KEY,
    bonus INT,
    FOREIGN KEY (empId) REFERENCES Employee(empId)
);

-- Insert data into Bonus table
INSERT INTO Bonus (empId, bonus)
VALUES
(2, 500),
(4, 2000);


SELECT e.name,b.bonus FROM employee e
LEFT JOIN bonus b ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL
ORDER BY e.name;

-- -----------------------------------------------------------------------------------------------------------------------------
-- Q12.)Write a solution to find the number of times each student attended each exam.Return the result table ordered 
-- by student_id and subject_name.

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

-- Insert data into Students table
INSERT INTO Students (student_id, student_name)
VALUES
(1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex');

-- Create Subjects table
CREATE TABLE Subjects (
    subject_name VARCHAR(100) PRIMARY KEY
);

-- Insert data into Subjects table
INSERT INTO Subjects (subject_name)
VALUES
('Math'),
('Physics'),
('Programming');

-- Create Examinations table
CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(100)
);

-- Insert data into Examinations table
INSERT INTO Examinations (student_id, subject_name)
VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(13, 'Math'),
(13, 'Programming'),
(13, 'Physics'),
(2, 'Math'),
(1, 'Math');

SELECT * FROM students;
SELECT * FROM subjects;

WITH student_subject_combinations AS (
    SELECT s.student_id, s.student_name, sub.subject_name
    FROM Students s
    CROSS JOIN Subjects sub
)

-- Join the combinations with the Examinations table and count occurrences
SELECT 
    ss.student_id, 
    ss.student_name, 
    ss.subject_name, 
    COUNT(e.student_id) AS attended_exams
FROM 
    student_subject_combinations ss
LEFT JOIN 
    Examinations e 
ON 
    ss.student_id = e.student_id AND ss.subject_name = e.subject_name
GROUP BY 
    ss.student_id, ss.student_name, ss.subject_name
ORDER BY 
    ss.student_id, ss.subject_name;

-- ---------------------------------------------------------------------------------------------------------
-- Q13.) Managers with at least 5 direct reports.Write a solution to find managers with at least five direct reports.

CREATE TABLE Employeees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    managerId INT
);


INSERT INTO Employeees (id, name, department, managerId) VALUES (101, 'John', 'A', NULL);
INSERT INTO Employeees (id, name, department, managerId) VALUES (102, 'Dan', 'A', 101);
INSERT INTO Employeees (id, name, department, managerId) VALUES (103, 'James', 'A', 101);
INSERT INTO Employeees (id, name, department, managerId) VALUES (104, 'Amy', 'A', 101);
INSERT INTO Employeees (id, name, department, managerId) VALUES (105, 'Anne', 'A', 101);
INSERT INTO Employeees (id, name, department, managerId) VALUES (106, 'Ron', 'B', 101);


SELECT name
FROM Employeees
WHERE id IN (
    SELECT managerId
    FROM Employeees
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Q14.) Write a solution to find the confirmation rate of each user.Return the result table in any order.
-- The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages.
-- The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

CREATE TABLE Signups (
    user_id INT PRIMARY KEY,
    time_stamp DATETIME
);

INSERT INTO Signups (user_id, time_stamp) VALUES (3, '2020-03-21 10:16:13');
INSERT INTO Signups (user_id, time_stamp) VALUES (7, '2020-01-04 13:57:59');
INSERT INTO Signups (user_id, time_stamp) VALUES (2, '2020-07-29 23:09:44');
INSERT INTO Signups (user_id, time_stamp) VALUES (6, '2020-12-09 10:39:37');

CREATE TABLE Confirmations (
    user_id INT,
    time_stamp DATETIME,
    action ENUM('confirmed', 'timeout'),
    PRIMARY KEY (user_id, time_stamp),
    FOREIGN KEY (user_id) REFERENCES Signups(user_id)
);

INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (3, '2021-01-06 03:30:46', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (3, '2021-07-14 14:00:00', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (7, '2021-06-12 11:57:29', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (7, '2021-06-13 12:58:28', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (7, '2021-06-14 13:59:27', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (2, '2021-01-22 00:00:00', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES (2, '2021-02-28 23:59:59', 'timeout');


SELECT s.user_id,ROUND(AVG(CASE
						WHEN c.action = 'confirmed' THEN 1.0
                        ELSE 0.00
					END),2) as confirmation_rate
	FROM signups s
LEFT JOIN confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;

-- ---------------------------------------------------------------------------------------------------------------------------------------------












