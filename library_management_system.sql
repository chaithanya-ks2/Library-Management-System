CREATE DATABASE library;

USE library;

CREATE TABLE Branch(
Branch_no INT PRIMARY KEY,
Manager_ID INT NOT NULL,
Branch_address VARCHAR(30),
Contact_no VARCHAR(10) UNIQUE,
FOREIGN KEY(Manager_ID) REFERENCES Employee(Emp_ID) ON DELETE CASCADE
);

CREATE TABLE Employee(
Emp_ID INT PRIMARY KEY,
Emp_name VARCHAR(30),
Position VARCHAR(30),
Salary DECIMAL(8, 2)
);

CREATE TABLE Customer(
Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
Customer_name VARCHAR(30) NOT NULL,
Customer_address VARCHAR(30),
Reg_date DATE
);

CREATE TABLE IssueStatus(
Issue_ID INT PRIMARY KEY,
Issued_cust INT NOT NULL,
Issued_book_name VARCHAR(30),
Issue_date DATE,
ISBN_book VARCHAR(13) NOT NULL,
FOREIGN KEY(Issued_cust) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
FOREIGN KEY(Isbn_book) REFERENCES Books(ISBN) ON DELETE CASCADE
);

CREATE TABLE ReturnStatus(
Return_ID INT PRIMARY KEY,
Return_cust INT NOT NULL,
Return_book_name VARCHAR(30),
Return_date DATE,
ISBN_book2 VARCHAR(13) NOT NULL,
FOREIGN KEY(Return_cust) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
FOREIGN KEY(ISBN_book2) REFERENCES Books(ISBN) ON DELETE CASCADE
);

CREATE TABLE Books(
ISBN VARCHAR(13) PRIMARY KEY,
Book_title VARCHAR(30),
Category VARCHAR(30),
Rental_price DECIMAL(5, 2),
Status VARCHAR(3) DEFAULT 'Yes',
Author VARCHAR(30),
Publisher VARCHAR(30)
);


INSERT INTO Books VALUES
('9781234567890', 'The Great Gatsby', 'Fiction', 13.00 , 'Yes', 'F. Scott Fitzgerald', 'Scribner'),
('9789876543210', 'Pride and Prejudice', 'Fiction', 11.00 , 'No', 'Jane Austen', 'Penguin Classics'),
('9780123456789', 'Introduction to Physics', 'Science', 30.00 , 'Yes', 'John Doe', 'Academic Press'),
('9785432109876', 'The Catcher in the Rye', 'Fiction', 10.00 , 'Yes', 'J.D. Salinger', 'Little, Brown'),
('9782468135792', 'To Kill a Mockingbird', 'Fiction', 12.00 , 'No', 'Harper Lee', 'Grand Central'),
('9780241952475', '1984', 'Fiction', 11.00 , 'Yes', 'George Orwell', 'Penguin Books'),
('9783698521470', 'The Hobbit', 'Fantasy', 15.00 , 'No', ' J.R.R. Tolkien', 'Houghton Mifflin'),
('9781853260001', 'Romeo and Juliet', 'Drama', 10.00 , 'Yes', 'William Shakespeare', 'Wordsworth Editions'),
('9789088888888', 'The Da Vinci Code', 'Mystery/Thriller', 12.99 , 'Yes', 'Dan Brown', 'Doubleday'),
('9789999999999', 'The Lord of the Rings', 'Fantasy', 16.00 , 'Yes', 'J.R.R. Tolkien', 'Allen & Unwin');
INSERT INTO Books VALUES 
('9786543210987', 'A Brief History of Time', 'History', 14.00, 'Yes', 'Stephen Hawking', 'Bantam Books');

SELECT * FROM Books;

INSERT INTO Employee VALUES
(101, 'Arjun', 'Manager', 35000),
(102, 'Suresh', 'Librarian', 18000),
(103, 'Deepa', 'Cataloguer', 28000),
(104, 'Priya', 'Librarian', 19000),
(105, 'Saran', 'Circulation Desk Staff', 29000),
(106, 'Antony', 'Manager', 31000),
(107, 'Afin', 'Manager', 32000),
(108, 'Sana', 'Manager', 30000),
(109, 'Adil', 'Librarian', 18000),
(110, 'Sarah', 'Librarian', 20000),
(111, 'Anoop', 'Manager', 33000),
(112, 'Rajeev', 'Librarian', 19000);

ALTER TABLE Employee ADD COLUMN Branch_no INT, 
ADD FOREIGN KEY(Branch_no) REFERENCES Branch(Branch_no) ON DELETE CASCADE;

UPDATE Employee SET Branch_no = 1 WHERE Emp_ID = 101;
UPDATE Employee SET Branch_no = 2 WHERE Emp_ID = 102;
UPDATE Employee SET Branch_no = 5 WHERE Emp_ID = 103;
UPDATE Employee SET Branch_no = 3 WHERE Emp_ID = 104;
UPDATE Employee SET Branch_no = 1 WHERE Emp_ID = 105;
UPDATE Employee SET Branch_no = 2 WHERE Emp_ID = 106;
UPDATE Employee SET Branch_no = 3 WHERE Emp_ID = 107;
UPDATE Employee SET Branch_no = 4 WHERE Emp_ID = 108;
UPDATE Employee SET Branch_no = 1 WHERE Emp_ID = 109;
UPDATE Employee SET Branch_no = 2 WHERE Emp_ID = 110;
UPDATE Employee SET Branch_no = 5 WHERE Emp_ID = 111;
UPDATE Employee SET Branch_no = 3 WHERE Emp_ID = 112;

SELECT * FROM Employee;

INSERT INTO Branch VALUES
(1, 101, 'Kochi', '0478936284'),
(2, 106, 'Trivandrum', '7462849372'),
(3, 107, 'Calicut', '5637289451'),
(4, 108, 'Alappuzha', '7845198361'),
(5, 111, 'Kannur', '9816382046');

SELECT * FROM Branch;

INSERT INTO Customer(Customer_name, Customer_address, Reg_date) VALUES
('Aravind', 'Kochi', '2021-05-15'),
('Devika', 'Trivandrum', '2021-07-27'),
('Anjaly', 'Calicut', '2021-09-30'),
('Sreejith', 'Alappuzha', '2021-12-28'),
('Maya', 'Thrissur', '2022-05-02'),
('Hari', 'Palakkad', '2022-05-12'),
('Deepa', 'Kannur', '2022-08-26'),
('Rajesh', 'Kollam', '2022-10-13'),
('Meera', 'Pathanamthitta', '2023-02-01'),
('Vishnu', 'Malappuram', '2023-04-03'),
('Rekha', 'Idukki', '2023-05-10'),
('Prasad', 'Wayanad', '2023-09-17'),
('Sobha', 'Kannur', '2023-11-22'),
('Arjun', 'Kottayam', '2023-11-24'),
('Rima', 'Alappuzha', '2023-12-08');

SELECT * FROM Customer;


DELIMITER $$
CREATE TRIGGER after_insert_IssueStatus
AFTER INSERT ON IssueStatus
FOR EACH ROW
BEGIN
	UPDATE Books SET Status = 'No' WHERE ISBN = NEW.ISBN_book;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_insert_ReturnStatus
AFTER INSERT ON ReturnStatus
FOR EACH ROW
BEGIN
	UPDATE Books SET Status = 'Yes' WHERE ISBN = NEW.ISBN_book2;
END $$
DELIMITER ;


INSERT INTO IssueStatus VALUES
(1, 1, 'The Great Gatsby', '2022-01-05', '9781234567890'),
(2, 2, 'Pride and Prejudice', '2022-02-10', '9789876543210'),
(3, 3, 'Introduction to Physics', '2022-03-15', '9780123456789'),
(4, 4, 'The Catcher in the Rye', '2022-04-20', '9785432109876'),
(5, 5, 'To Kill a Mockingbird', '2022-05-25', '9782468135792');

INSERT INTO IssueStatus VALUES
(6, 3, 'The Great Gatsby', '2022-04-25', '9781234567890'),
(7, 1, 'Pride and Prejudice', '2022-03-17', '9789876543210'),
(8, 5, 'Introduction to Physics', '2022-07-10', '9780123456789');

INSERT INTO IssueStatus VALUES(9, 2, 'Pride and Prejudice', '2023-06-15', '9789876543210');

SELECT * FROM IssueStatus;
SELECT * FROM Books;

INSERT INTO ReturnStatus VALUES
(1, 1, 'The Great Gatsby', '2022-02-10', '9781234567890'),
(2, 2, 'Pride and Prejudice', '2022-03-15', '9789876543210'),
(3, 3, 'Introduction to Physics', '2022-04-20', '9780123456789'),
(4, 4, 'The Catcher in the Rye', '2022-05-25', '9785432109876'),
(5, 5, 'To Kill a Mockingbird', '2022-06-30', '9782468135792');

SELECT * FROM ReturnStatus;
SELECT * FROM Books;

-- Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_price FROM Books WHERE Status = 'Yes';

-- List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary FROM EMPLOYEE ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT i.Issued_book_name, c.Customer_name 
FROM IssueStatus i JOIN Customer c ON i.Issued_cust = c.Customer_ID;

-- Display the total count of books in each category
SELECT Category, count(*) AS No_of_books FROM Books GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

-- List the customer names who registered before 2023-01-01 and have not issued any books yet. 
SELECT Customer_name FROM Customer 
WHERE Reg_date < '2023-01-01' 
	AND
	Customer_ID NOT IN (
		SELECT Issued_cust FROM IssueStatus 
	);

-- Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, count(*) AS Employee_count FROM Employee GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023.
SELECT c.Customer_name 
FROM Customer c JOIN IssueStatus i ON c.Customer_ID = i.Issued_cust
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Retrieve book_title from book table containing history. 
SELECT Book_title FROM Books WHERE Category = 'History';

-- Retrieve the branch numbers along with the count of employees for branches having more than 2 employees.
SELECT Branch_no, count(*) AS Employee_count FROM Employee GROUP BY Branch_no HAVING count(*) > 2;



