--Task 1 DDL Database Design

CREATE DATABASE TripService

USE TripService

CREATE TABLE Cities
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(20) NOT NULL,
CountryCode CHAR(2) NOT NULL
)


CREATE TABLE Hotels

(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(30) NOT NULL,
CityId INT REFERENCES Cities(Id) NOT NULL,
EmployeeCount INT NOT NULL,
BaseRate DECIMAL(18,2)
)

CREATE TABLE Rooms
(
Id INT PRIMARY KEY IDENTITY,
Price DECIMAL (18,2) NOT NULL,
[Type] NVARCHAR(20) NOT NULL,
Beds INT NOT NULL,
HotelId INT REFERENCES Hotels(Id) NOT NULL
)

CREATE TABLE Trips
(
Id INT PRIMARY KEY IDENTITY,
RoomId INT REFERENCES Rooms (ID) NOT NULL,
BookDate DATE NOT NULL,
ArrivalDate DATE NOT NULL,
ReturnDate DATE NOT NULL,
CancelDate DATE,
CHECK(BookDate < ArrivalDate ),
CHECK(ReturnDate > ArrivalDate)
)


CREATE TABLE Accounts
(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
MiddleName NVARCHAR(20),
LastName NVARCHAR(50) NOT NULL,
CityId INT REFERENCES Cities(Id) NOT NULL,
BirthDate DATE NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE
)


CREATE TABLE AccountsTrips
(
AccountId INT REFERENCES Accounts(Id),
TripId INT REFERENCES Trips(Id),
Luggage INT NOT NULL,
PRIMARY KEY(AccountId, TripId),
CHECK(Luggage >= 0)
)

