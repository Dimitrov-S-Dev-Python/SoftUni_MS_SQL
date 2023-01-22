-- Task 2

SELECT *
FROM Departments


-- Task 3

SELECT
	[Name]
  FROM Departments

-- Task 4

SELECT [FirstName],
	   [LastName],
	   [Salary]
	FROM Employees

-- Task 5

SELECT [FirstName],
	   [MiddleName],
	   [LastName]
	FROM Employees

-- Task 6

SELECT CONCAT([FirstName], '.', [LastName], '@', 'softuni.bg')
		AS [Full Email Address]
	FROM Employees

-- Task 7

SELECT
	DISTINCT Salary
	FROM Employees

-- Task 8

SELECT
	*
	FROM Employees
	WHERE JobTitle = 'Sales Representative'

-- Task 9

SELECT
		FirstName,
		LastName,
		JobTitle
	FROM Employees
	WHERE Salary BETWEEN 20000 AND 30000

-- Task 10

SELECT
	CONCAT(FirstName, ' ', MiddleName, ' ', LastName)
	AS [Full Name]
	FROM Employees
	WHERE Salary = 25000 OR Salary = 14000 OR Salary = 12500 OR Salary = 23600

-- Task 11

SELECT FirstName,
	   LastName
	FROM Employees
	WHERE ManagerID IS NULL

-- Task 12

SELECT FirstName,
	   LastName,
	   Salary
	FROM Employees
	WHERE Salary > 50000
	ORDER BY Salary DESC

-- Task 13

SELECT TOP(5)
	   FirstName,
	   LastName
	FROM Employees
	ORDER BY Salary DESC

-- Task 14

SELECT FirstName,
	   LastName
	FROM Employees
	WHERE DepartmentID != 4

-- Task 15

SELECT *
	FROM Employees
	ORDER BY Salary DESC,
			FirstName,
			LastName DESC,
			MiddleName

-- Task 16

CREATE VIEW V_EmployeesSalaries AS
	SELECT FirstName,
		   LastName,
		   Salary
		FROM Employees

-- Task 17

CREATE VIEW V_EmployeeNameJobTitle AS
	SELECT CONCAT(FirstName,' ', MiddleName, ' ', LastName) AS [Full Name],
			JobTitle
		FROM Employees

--CREATE VIEW V_EmployeeNameJobTitle AS
	--SELECT CONCAT_WS(' ',FirstName,MiddleName,LastName) AS [Full Name],
			JobTitle
		FROM Employees

-- Task 18

SELECT
	DISTINCT JobTitle
	FROM Employees


-- Task 19

SELECT
	TOP(10) *
	FROM Projects
	ORDER BY StartDate,
			 [Name]

-- Task 20

SELECT TOP(7)
		FirstName,
		LastName,
		HireDate
	FROM Employees
	ORDER BY HireDate DESC

-- Task 21

UPDATE Employees
	SET Salary *= 1.12
	WHERE DepartmentID IN(1, 4, 2, 11)

SELECT Salary
	FROM Employees

-- Task 22

SELECT PeakName
	FROM Peaks
	ORDER BY PeakName ASC

-- Task 23

SELECT TOP(30)
		CountryName,
		[Population]
	FROM Countries
	WHERE ContinentCode = 'EU'
	ORDER BY [Population] DESC,
			CountryName

-- Task 24

SELECT CountryName, CountryCode, Currency =
CASE CurrencyCode
WHEN 'EUR' THEN 'Euro'
ELSE 'Not Euro'
END
FROM Countries
ORDER BY CountryName


-- Task 25
USE Diablo

SELECT Name
	FROM Characters
	ORDER BY [Name]
