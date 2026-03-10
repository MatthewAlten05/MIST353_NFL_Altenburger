USE NFL_RDB_Altenburger;
GO

-- Drop tables if they exist
IF OBJECT_ID('Team', 'U') IS NOT NULL
    DROP TABLE Team;
IF OBJECT_ID('ConferenceDivision', 'U') IS NOT NULL
    DROP TABLE ConferenceDivision;
GO

-- Create ConferenceDivision table
CREATE TABLE ConferenceDivision (
    ConferenceID INT IDENTITY(1,1) PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        CONSTRAINT CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        CONSTRAINT CK_DivisionNames CHECK (Division IN ('North', 'South', 'East', 'West')),
    CONSTRAINT UQ_ConferenceDivision UNIQUE (Conference, Division)
);
GO

-- Optionally add additional check (if needed)
-- ALTER TABLE ConferenceDivision
--     ADD CONSTRAINT CK_ConferenceDivision CHECK (
--         -- Example: ensure combination logic, if needed
--     );
-- GO

-- Create Team table
CREATE TABLE Team (
    TeamID INT IDENTITY(1,1) PRIMARY KEY,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(50) NOT NULL,
    ConferenceDivisionID INT NOT NULL
        CONSTRAINT FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceID)
);
GO