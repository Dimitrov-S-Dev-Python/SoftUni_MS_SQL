--Task 1 DDL

CREATE DATABASE CigarShop

GO

USE CigarShop

CREATE TABLE Sizes
(
Id INT PRIMARY KEY IDENTITY,
[Length] INT CHECK([Length] >= 10 AND [Length] <= 25) NOT NULL,
RingRange DECIMAL(18, 2) CHECK(RingRange >= 1.5 AND RingRange <= 7.5) NOT NULL
)

CREATE TABLE Tastes
(
Id INT PRIMARY KEY IDENTITY,
TasteType VARCHAR(20) NOT NULL,
TasteStrength VARCHAR(15) NOT NULL,
ImageURL NVARCHAR(100) NOT NULL
)

CREATE TABLE Brands
(
Id INT PRIMARY KEY IDENTITY,
BrandName VARCHAR(30) UNIQUE NOT NULL,
BrandDescription VARCHAR(MAX)
)

CREATE TABLE Cigars
(
Id INT PRIMARY KEY IDENTITY,
CigarName VARCHAR(80) NOT NULL,
BrandId INT REFERENCES Brands(Id) NOT NULL,
TastId INT REFERENCES Tastes(Id) NOT NULL,
SizeId INT REFERENCES Sizes(Id) NOT NULL,
PriceForSingleCigar MONEY NOT NULL,
ImageURL NVARCHAR(100) NOT NULL
)

CREATE TABLE Addresses
(
Id INT PRIMARY KEY IDENTITY,
Town VARCHAR(30) NOT NULL,
Country NVARCHAR(30) NOT NULL,
Streat NVARCHAR(100) NOT NULL,
ZIP VARCHAR(20) NOT NULL
)

CREATE TABLE Clients
(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
Email NVARCHAR(50) NOT NULL,
AddressId INT REFERENCES Addresses(Id) NOT NULL
)

CREATE TABLE ClientsCigars
(
ClientId INT REFERENCES Clients(Id),
CigarId INT REFERENCES Cigars(Id),
PRIMARY KEY(ClientId, CigarId)
)

--2 Insert

INSERT INTO Cigars(CigarName, BrandId, TastId, SizeId, PriceForSingleCigar, ImageURL) VALUES
('COHIBA ROBUSTO',	9,	1,	5,	15.50,	'cohiba-robusto-stick_18.jpg'),
('COHIBA SIGLO I',	9,	1,	10,	410.00,	'cohiba-siglo-i-stick_12.jpg'),
('HOYO DE MONTERREY LE HOYO DU MAIRE',	14,	5,	11,	7.50,	'hoyo-du-maire-stick_17.jpg'),
('HOYO DE MONTERREY LE HOYO DE SAN JUAN',	14,	4,	15,	32.00, 	'hoyo-de-san-juan-stick_20.jpg'),
('TRINIDAD COLONIALES',	2,	3,	8,	85.21,	'trinidad-coloniales-stick_30.jpg')

INSERT INTO Addresses(Town,	Country, Streat,	ZIP) VALUES
('Sofia',	'Bulgaria',	'18 Bul. Vasil levski',	1000),
('Athens',	'Greece',	'4342 McDonald Avenue',	10435),
('Zagreb',	'Croatia',	'4333 Lauren Drive',	10000)


-- 3 Update

UPDATE Cigars
SET PriceForSingleCigar *= 1.2
WHERE TastId = 1

UPDATE Brands
SET BrandDescription = 'New description'
WHERE BrandDescription IS NULL

-- 4 Delete

-- 5
SELECT
	CigarName,
	PriceForSingleCigar,
	ImageURL
	FROM Cigars
	ORDER BY PriceForSingleCigar,
	CigarName DESC

-- 6

SELECT
	c.Id,
	c.CigarName,
	c.PriceForSingleCigar,
	t.TasteType,
	t.TasteStrength
	FROM Cigars AS c
	JOIN Tastes AS t ON c.TastId = t.Id
	WHERE t.TasteType IN('Earthy','Woody')
	ORDER BY PriceForSingleCigar DESC

-- 7

SELECT
	c.Id,
	CONCAT_WS(' ', c.FirstName, c.LastName) AS ClientName,
	c.Email
	FROM ClientsCigars AS cc
	RIGHT JOIN Cigars AS cr ON cc.CigarId = cr.Id
	RIGHT JOIN Clients AS c ON cc.ClientId = c.Id
	--GROUP BY cr.Id, c.FirstName, c.LastName,c.Email
	WHERE cr.CigarName IS NULL
	ORDER BY ClientName


-- 8

SELECT TOP 5
	c.CigarName,
	c.PriceForSingleCigar,
	c.ImageURL
	FROM Cigars AS c
	JOIN Sizes AS s ON c.SizeId = s.Id
	WHERE s.Length > 12 AND (c.CigarName LIKE '%ci%' OR (c.PriceForSingleCigar > 50 AND s.RingRange > 2.55))
	ORDER BY c.CigarName,
	c.PriceForSingleCigar


-- 9

SELECT
	CONCAT_WS(' ',c.FirstName, c.LastName) AS FullName,
	a.Country,
	a.ZIP,
	CONCAT('$',
		(SELECT MAX(PriceForSingleCigar)
		 FROM Cigars AS cg
		 JOIN ClientsCigars AS cs ON cg.Id = cs.CigarId
		 AND cs.CLientId = c.Id)) AS CigarPrice
	FROM Clients AS c
	JOIN Addresses AS a ON c.AddressId = a.Id
	WHERE ISNUMERIC(a.ZIP) = 1
	ORDER BY CigarPrice DESC