if (OBJECT_ID('FanTeam') is not null)
    drop table FanTeam;
if (OBJECT_ID('NFLFan') is not null)
    drop table NFLFan;
if (OBJECT_ID('NFLAdmin') is not null)
    drop table NFLAdmin;
if (object_ID('Team') is not null)
    drop table Team;
if (object_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;
if (OBJECT_ID('AppUser') is not null)
    drop table AppUser;


create table ConferenceDivision(
    CDID INT IDENTITY(1,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL,
        CONSTRAINT CK_ConferenceNames Check (Conference IN ('AFC','NFC')),
    Division NVARCHAR(50) NOT NULL 
        CONSTRAINT CK_DivisionNames Check (Division in ('North','East','South','West'))   
);

alter table ConferenceDivision
    add CONSTRAINT UQ_ConferenceDivision UNIQUE (Conference, Division);

create table Team (
    TeamID INT identity(1,1)
        CONSTRAINT PK_Team PRIMARY KEY,
    Tname NVARCHAR(50) NOT NULL,
    TcityState NVARCHAR(50) NOT NULL,
    Tcolors NVARCHAR(100) NOT NULL,
    Tlogo NVARCHAR(50) NOT NULL,
    CDID INT NOT NULL
        CONSTRAINT FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(CDID)
);

GO

create table AppUser(
    AppUserID int IDENTITY(1,1)
        constraint pk_AppUser primary key,
    Firstname NVARCHAR(50) NOT NULL,
    Lastname NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL
        CONSTRAINT UK_AppUser_Email UNIQUE,
    PasswordHash varbinary(255) NOT NULL,
    Phone NVARCHAR(25) NOT NULL,
    UserRole NVARCHAR(50) NOT NULL
        constraint CK_AppUser_UserRole check (UserRole in (N'NFLAdmin',N'NFLFan'))
);

select * from AppUser;

GO

create table NFLFan(
    NFLFanID int
        constraint PK_NFLFan primary key   
        constraint FK_NFLFan_AppUser foreign key REFERENCES AppUser(AppUserID)
);

GO

create table NFLAdmin(
    NFLAdminID int
        constraint PK_NFLAdmin primary key
        constraint FK_NFLAdmin_AppUser foreign key REFERENCES AppUser(AppUserID)
);

GO

create table FanTeam(
    FanTeamID int IDENTITY(1,1)
        constraint PK_FanTeam primary key,
    NFLFanID int not null
        constraint FK_FanTeam_NFLFan foreign key REFERENCES NFLFan(NFLFanID),
    TeamID int not null
        constraint FK_FanTeam_Team foreign key REFERENCES Team(TeamID),
    constraint UK_FanTeam UNIQUE (NFLFanID, TeamID),
    PrimaryTeam BIT NOT NULL
);

GO

CREATE OR ALTER PROCEDURE dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
    @TeamName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t2.Tname AS TeamName,
        cd.Conference,
        cd.Division
    FROM Team t1
    INNER JOIN Team t2
        ON t1.CDID = t2.CDID
    INNER JOIN ConferenceDivision cd
        ON t2.CDID = cd.CDID
    WHERE t1.Tname = @TeamName
      AND t2.Tname <> @TeamName;
END;
GO

