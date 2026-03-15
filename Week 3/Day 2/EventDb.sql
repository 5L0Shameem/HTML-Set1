-- Create Database
CREATE DATABASE EventDb;
GO

-- Use Database
USE EventDb;
GO

-- 1. UserInfo Table
CREATE TABLE UserInfo (
    EmailId VARCHAR(100) PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Admin','Participant')),
    Password VARCHAR(20) NOT NULL CHECK (LEN(Password) BETWEEN 6 AND 20)
);
GO

-- 2. EventDetails Table
CREATE TABLE EventDetails (
    EventId INT PRIMARY KEY,
    EventName VARCHAR(50) NOT NULL,
    EventCategory VARCHAR(50) NOT NULL,
    EventDate DATETIME NOT NULL,
    Description VARCHAR(255) NULL,
    Status VARCHAR(10) CHECK (Status IN ('Active','In-Active'))
);
GO

-- 3. SpeakersDetails Table
CREATE TABLE SpeakersDetails (
    SpeakerId INT PRIMARY KEY,
    SpeakerName VARCHAR(50) NOT NULL
);
GO

-- 4. SessionInfo Table
CREATE TABLE SessionInfo (
    SessionId INT PRIMARY KEY,
    EventId INT NOT NULL,
    SessionTitle VARCHAR(50) NOT NULL,
    SpeakerId INT NOT NULL,
    Description VARCHAR(255) NULL,
    SessionStart DATETIME NOT NULL,
    SessionEnd DATETIME NOT NULL,
    SessionUrl VARCHAR(255),
    
    FOREIGN KEY (EventId) REFERENCES EventDetails(EventId),
    FOREIGN KEY (SpeakerId) REFERENCES SpeakersDetails(SpeakerId)
);
GO

-- 5. ParticipantEventDetails Table
CREATE TABLE ParticipantEventDetails (
    Id INT PRIMARY KEY,
    ParticipantEmailId VARCHAR(100) NOT NULL,
    EventId INT NOT NULL,
    SessionId INT NOT NULL,
    IsAttended BIT CHECK (IsAttended IN (0,1)),

    FOREIGN KEY (ParticipantEmailId) REFERENCES UserInfo(EmailId),
    FOREIGN KEY (EventId) REFERENCES EventDetails(EventId),
    FOREIGN KEY (SessionId) REFERENCES SessionInfo(SessionId)
);
GO


-- Sample Insert Queries

INSERT INTO UserInfo VALUES
('admin@gmail.com','AdminUser','Admin','admin123'),
('user1@gmail.com','Rahul','Participant','user123');

INSERT INTO EventDetails VALUES
(1,'Tech Conference','Technology','2026-04-10','Latest Tech Event','Active');

INSERT INTO SpeakersDetails VALUES
(1,'Dr. Sharma');

INSERT INTO SessionInfo VALUES
(1,1,'AI Future',1,'AI discussion','2026-04-10 10:00','2026-04-10 11:00','www.session.com');

INSERT INTO ParticipantEventDetails VALUES
(1,'user1@gmail.com',1,1,1);


-- Retrieval Queries

-- View Users
SELECT * FROM UserInfo;

-- View Events
SELECT * FROM EventDetails;

-- Join Query (Event + Session + Speaker)
SELECT 
E.EventName,
S.SessionTitle,
SP.SpeakerName,
S.SessionStart,
S.SessionEnd
FROM SessionInfo S
JOIN EventDetails E ON S.EventId = E.EventId
JOIN SpeakersDetails SP ON S.SpeakerId = SP.SpeakerId;