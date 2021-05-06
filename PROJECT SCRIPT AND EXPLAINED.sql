--Creating Database

USE Master;
GO
DROP DATABASE IF EXISTS schooldb;
GO
CREATE DATABASE schooldb;
GO
USE schooldb;


--Table Script

CREATE TABLE CourseList(
	CourseID int IDENTITY(10,1) NOT NULL PRIMARY KEY,
	CourseDescription CHAR(50) NOT NULL,
	CourseCost int,
	CourseDurationYears int,
	Notes CHAR(100)
);

CREATE TABLE ContactType(
	ContactTypeID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ContactType VARCHAR(50) NOT NULL

);

CREATE TABLE StudentInformation(
	StudentID int IDENTITY(100,1) NOT NULL PRIMARY KEY,
	Title VARCHAR(30),
	Firstname VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Address1 CHAR(30),
	Address2 CHAR(30),
	City VARCHAR(30),
	County VARCHAR(30),
	Zip VARCHAR(30),
	Country VARCHAR(30),
	Telephone CHAR(30),
	Email VARCHAR(30),
	Enrolled CHAR(30),
	AltTelephone CHAR(30)

);

CREATE TABLE EmpJobPosition(
	EmpJobPositionID int IDENTITY(1,1) NOT NULL PRIMARY KEY ,
	EmployeePosition CHAR(30) NOT NULL

);


CREATE TABLE Student_Courses(
	StudentCourseID int IDENTITY(1,1) NOT NULL,
	StudentID int NOT NULL,
	CourseID int NOT NULL,
	CourseStartDate DATE NOT NULL,
	CourseComplete DATE,
	CONSTRAINT FK_StdCourse_StdInfo FOREIGN KEY (StudentID) 
        REFERENCES StudentInformation(StudentID),
	CONSTRAINT FK_StdCourse_CourseList FOREIGN KEY (CourseID) 
        REFERENCES CourseList(CourseID),
	CONSTRAINT PK_Student_Course PRIMARY KEY (StudentCourseID)

);

CREATE TABLE Employees(
	EmployeeID int IDENTITY(1000,1) NOT NULL PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	EmpJobPositionID int,
	EmployeePassword CHAR(40),
	Access VARCHAR(50),
	CONSTRAINT FK_Employee_EmpJObPosition FOREIGN KEY (EmpJobPositionID) 
        REFERENCES EmpJobPosition(EmpJobPositionID)

);

CREATE TABLE StudentContacts(
	ContactID int IDENTITY(10000,1) NOT NULL  PRIMARY KEY,
	StudentID int NOT NULL,
	ContactTypeID int NOT NULL,
	ContactDate DATE NOT NULL,
	EmployeeID int NOT NULL,
	ContactDetails CHAR(50) NOT NULL,
	CONSTRAINT FK_StudentContacts_StudentInfo FOREIGN KEY (StudentID) 
        REFERENCES StudentInformation(StudentID),
	CONSTRAINT FK_StudentContacts_ContactType FOREIGN KEY (ContactTypeID) 
        REFERENCES ContactType(ContactTypeID),
	CONSTRAINT FK_StudentContacts_Emplpoyees FOREIGN KEY (EmployeeID) 
        REFERENCES Employees(EmployeeID)

);




--Insert record into tables
--insert record into StudentInformation

INSERT INTO StudentInformation
(FirstName,LastName)
VALUES
('Mickey','Mouse');
INSERT INTO StudentInformation
(FirstName,LastName)
VALUES
('Minnie','Mouse');
INSERT INTO StudentInformation
(FirstName,LastName)
VALUES
('Donald', 'Duck');
SELECT * FROM StudentInformation;



--insert record into CourseList
INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Advanced Math');

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Intermediate Math');

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Beginning Computer Science');

INSERT INTO CourseList
   (CourseDescription)
VALUES
   ('Advanced Computer Science');
select * from CourseList;

--insert record into Student_Courses

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (100, 10, '01/05/2018');

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (101, 11, '01/05/2018');

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (102, 11, '01/05/2018');
INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (100, 11, '01/05/2018');

INSERT INTO Student_Courses
   (StudentID,CourseID,CourseStartDate)
VALUES
   (102, 13, '01/05/2018');
select * from Student_Courses;


--insert record into EmpJobPosition

INSERT INTO EmpJobPosition
   (EmployeePosition)
VALUES
   ('Math Instructor');

INSERT INTO EmpJobPosition
   (EmployeePosition)
VALUES
   ('Computer Science');
select * from EmpJobPosition;


--insert record into Employees

INSERT INTO Employees
   (EmployeeName, EmpJobPositionID)
VALUES
   ('Walt Disney', 1);

INSERT INTO Employees
   (EmployeeName, EmpJobPositionID)
VALUES
   ('John Lasseter', 2);

INSERT INTO Employees
   (EmployeeName, EmpJobPositionID)
VALUES
   ('Danny Hillis', 2);
select * from Employees;


--insert record into ContactType

INSERT INTO ContactType
   (ContactType)
VALUES
   ('Tutor');

INSERT INTO ContactType
   (ContactType)
VALUES
   ('Homework Support');

INSERT INTO ContactType
   (ContactType)
VALUES
   ('Conference');
SELECT * from ContactType;


--insert record into StudentContacts

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (100, 1, 1000, '11/15/2017', 'Micky and Walt Math Tutoring');

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (101, 2, 1001, '11/18/2017', 'Minnie and John Homework support');

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (100, 3, 1001, '11/18/2017', 'Micky and Walt Conference');

INSERT INTO StudentContacts
   (StudentID,ContactTypeID,EmployeeID,ContactDate,ContactDetails)
VALUES
   (102, 2, 1002, '11/20/2017', 'Donald and Danny Homework support');

SELECT * from StudentContacts;


--insert record into StudentInformation

INSERT INTO StudentInformation
   (FirstName,LastName,Email)
VALUES
   ('Porky', 'Pig', 'porky.pig@warnerbros.com');
INSERT INTO StudentInformation
   (FirstName,LastName)
VALUES
   ('Snow', 'White');


--You should create one View per table and save the View script for each.

CREATE VIEW  v_CourseList
AS
SELECT CourseDescription, CourseCost, CourseDurationYears
FROM CourseList;


CREATE VIEW  v_ContactType
AS
SELECT ContactTypeID , ContactType
FROM ContactType;

CREATE VIEW  v_StudentInformation
AS
SELECT Title , Firstname, LastName 
FROM StudentInformation;

CREATE VIEW  v_EmpJobPosition
AS
SELECT EmpJobPositionID, EmployeePosition
FROM EmpJobPosition;


CREATE VIEW  v_Student_Courses
AS
SELECT CourseStartDate, CourseComplete 
FROM Student_Courses;


CREATE VIEW  v_Employees
AS
SELECT EmployeeName, EmpJobPositionID 
FROM Employees;


CREATE VIEW  v_StudentContacts
AS
SELECT ContactTypeID , ContactDate 
FROM StudentContacts;



--You should also create one view that shows column information from two related tables using a join.

CREATE VIEW  vtutorContacts AS 

SELECT  StudentInformation.FirstName+' '+StudentInformation.LastName AS 'Name', StudentContacts.ContactDetails, StudentContacts.ContactDate  FROM StudentContacts 

inner join StudentInformation on StudentContacts.StudentID = StudentInformation. StudentID;

--check view
SELECT * FROM vtutorContacts;


--You should create two (2) queries using data from two or more tables; each query to contain calculated fields. At least one of the queries must use GROUP BY and HAVING along with calculated fields. All calculated fields must have Aliases for ease of readability by the users. You will also create at least one function.

SELECT CourseDescription, FirstName, LastName FROM Student_Courses 
	inner join CourseList on Student_Courses .CourseID = CourseList.CourseID 
	inner join StudentInformation on Student_Courses.StudentID  = StudentInformation.StudentID
	WHERE CourseList.CourseDescription =  'Intermediate Math';


SELECT CourseList.CourseID, count(Student_Courses.StudentID) as no_of_student_enrolled_perCourse FROM Student_Courses 
	inner join CourseList on Student_Courses.CourseID = CourseList.CourseID group by CourseList.CourseID having count(Student_Courses.StudentID) > 1;
