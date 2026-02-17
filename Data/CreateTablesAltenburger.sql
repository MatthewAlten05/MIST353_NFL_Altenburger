use NFL_RDB_Altenburger;

GO
create table ConferenceDivision (
    ConferenceID int IDENTITY(1,1)
        CONSTRAINT PK_Conference primary key,
    Conference NVARCHAR(50) not null,
        CONSTRAINT CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) not null
        CONSTRAINT CK_DivisionNames CHECK (Division IN ('North', 'South', 'East', 'West'))
);
GO
create table Team (
    TeamID int IDENTITY(1,1)
        CONSTRAINT PK_Team primary key,
    TeamName NVARCHAR(50) not null,
    TeamCityState NVARCHAR(50) not null,
    TeamColors NVARCHAR(50) NOT NULL,
    ConferenceDivisionID int not null
        CONSTRAINT FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceID)
);


    