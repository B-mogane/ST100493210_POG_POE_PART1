IF DB_ID('RaceDay') IS NULL
    CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO



IF OBJECT_ID('dbo.Payment', 'U') IS NOT NULL 
    DROP TABLE dbo.Payment;

IF OBJECT_ID('dbo.Result', 'U') IS NOT NULL 
    DROP TABLE dbo.Result;

IF OBJECT_ID('dbo.Enrolment', 'U') IS NOT NULL 
    DROP TABLE dbo.Enrolment;

IF OBJECT_ID('dbo.Category', 'U') IS NOT NULL 
    DROP TABLE dbo.Category;

IF OBJECT_ID('dbo.Event', 'U') IS NOT NULL 
    DROP TABLE dbo.Event;

IF OBJECT_ID('dbo.[User]', 'U') IS NOT NULL 
    DROP TABLE dbo.[User];
GO



CREATE TABLE dbo.[User] 
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL 
        CHECK (Role IN ('Organiser','Participant')),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO



CREATE TABLE dbo.[Event] 
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL 
        FOREIGN KEY REFERENCES dbo.[User](UserID),
    EventName VARCHAR(100) NOT NULL,
    Description VARCHAR(MAX) NULL,
    EventDate DATETIME2 NOT NULL,
    Location VARCHAR(200) NOT NULL,
    RouteInfo VARCHAR(MAX) NULL,
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0,
    Status VARCHAR(20) NOT NULL DEFAULT 'Draft'
        CHECK (Status IN ('Draft','Published','Cancelled','Completed')),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO



CREATE TABLE dbo.Category 
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL 
        FOREIGN KEY REFERENCES dbo.[Event](EventID) 
        ON DELETE CASCADE,
    CategoryName VARCHAR(50) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL,
    MaxParticipants INT NOT NULL,
    Fee DECIMAL(10,2) NOT NULL DEFAULT 0
);
GO



CREATE TABLE dbo.Enrolment 
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL 
        FOREIGN KEY REFERENCES dbo.[User](UserID),
    CategoryID INT NOT NULL 
        FOREIGN KEY REFERENCES dbo.Category(CategoryID),
    EnrolmentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed'
        CHECK (Status IN ('Confirmed','Cancelled'))
);
GO



CREATE TABLE dbo.Result 
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE 
        FOREIGN KEY REFERENCES dbo.Enrolment(EnrolmentID),
    FinishTime TIME NOT NULL,
    Position INT NULL,
    Notes VARCHAR(MAX) NULL
);
GO



CREATE TABLE dbo.Payment 
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE 
        FOREIGN KEY REFERENCES dbo.Enrolment(EnrolmentID),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    PaymentMethod VARCHAR(50) NOT NULL,
    TransactionID VARCHAR(100) NULL
);
GO



INSERT INTO dbo.[User] 
    (FirstName, LastName, Email, PasswordHash, Role)
VALUES
    ('Thabo', 'Molefe', 'thabo@raceday.co.za', 'hashed_password_1', 'Organiser'),
    ('Sarah', 'Jacobs', 'sarah@raceday.co.za', 'hashed_password_2', 'Organiser'),
    ('Lerato', 'Nkosi', 'lerato@example.com', 'hashed_password_3', 'Participant'),
    ('John', 'Smith', 'john@example.com', 'hashed_password_4', 'Participant');
GO



INSERT INTO dbo.[Event] 
    (OrganiserID, EventName, Description, EventDate, Location, RouteInfo, EntryFee, Status)
VALUES
    (1, 
     'Soweto Marathon', 
     'Iconic marathon through Soweto streets.', 
     '2026-11-01 06:00:00', 
     'Soweto, Johannesburg', 
     'Route details here...', 
     350.00, 
     'Published'),

    (1, 
     'Cape Town Cycle Tour', 
     'World-famous cycling event around the Cape Peninsula.', 
     '2026-03-08 06:00:00', 
     'Cape Town', 
     'Route details here...', 
     500.00, 
     'Published'),

    (2, 
     'Durban Beach Walk', 
     'Family-friendly 5km walk along the beachfront.', 
     '2026-07-18 08:00:00', 
     'Durban Beachfront', 
     'Route details here...', 
     80.00, 
     'Draft');
GO



INSERT INTO dbo.Category 
    (EventID, CategoryName, DistanceKm, MaxParticipants, Fee)
VALUES
    (1, '10km Run', 10.00, 1000, 150.00),
    (1, '21km Half Marathon', 21.10, 800, 250.00),
    (1, '42km Full Marathon', 42.20, 500, 350.00);
GO


INSERT INTO dbo.Category 
    (EventID, CategoryName, DistanceKm, MaxParticipants, Fee)
VALUES
    (2, 'Short Route (47km)', 47.00, 2000, 400.00),
    (2, 'Long Route (109km)', 109.00, 1000, 500.00);
GO

