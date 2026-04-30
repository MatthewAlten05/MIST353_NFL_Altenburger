-- 3 basic queries

SELECT c.Conference, c.Division
FROM ConferenceDivision c
WHERE c.Division = 'North';

SELECT t.Tname, t.TcityState, t.Tcolors
FROM Team t
WHERE t.CDID = 3;

SELECT t.TeamID, t.Tname, t.TcityState, c.Conference, c.Division
FROM Team t
INNER JOIN ConferenceDivision c 
    ON c.CDID = t.CDID
ORDER BY t.TeamID;

GO

CREATE OR ALTER PROCEDURE dbo.procGetTeamsByConferenceDivision
(
    @Conference NVARCHAR(50) = NULL,
    @Division NVARCHAR(50) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Tname,
        T.Tcolors,
        CD.Conference,
        CD.Division
    FROM Team T
    INNER JOIN ConferenceDivision CD 
        ON CD.CDID = T.CDID
    WHERE CD.Conference = ISNULL(@Conference, CD.Conference)
      AND CD.Division = ISNULL(@Division, CD.Division);
END;

GO

CREATE OR ALTER PROCEDURE dbo.procFindAllTeamsInMyConferenceDivision
(
    @Tname NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        OtherTeam.Tname,
        OtherCD.Conference,
        OtherCD.Division
    FROM Team MyTeam
    INNER JOIN Team OtherTeam
        ON MyTeam.CDID = OtherTeam.CDID
    INNER JOIN ConferenceDivision OtherCD
        ON OtherCD.CDID = OtherTeam.CDID
    WHERE MyTeam.Tname = @Tname
      AND OtherTeam.Tname <> @Tname;
END;

GO

CREATE OR ALTER PROCEDURE dbo.procValidateUser
(
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        AppUserID,
        Firstname + ' ' + Lastname AS FullName,
        UserRole
    FROM AppUser
    WHERE Email = @Email
      AND PasswordHash = CONVERT(VARBINARY(200), @PasswordHash, 1);
END;

GO

CREATE OR ALTER PROCEDURE dbo.procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Tname,
        CD.Conference,
        CD.Division,
        T.Tcolors,
        FT.PrimaryTeam
    FROM NFLFan F
    INNER JOIN FanTeam FT
        ON F.NFLFanID = FT.NFLFanID
    INNER JOIN Team T
        ON FT.TeamID = T.TeamID
    INNER JOIN ConferenceDivision CD
        ON T.CDID = CD.CDID
    WHERE F.NFLFanID = @NFLFanID;
END;

GO

CREATE OR ALTER PROCEDURE dbo.procGetTeamsByColor
(
    @TeamColor NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.Tname AS Team_Name,
        T.Tcolors AS Colors
    FROM Team T
    WHERE T.Tcolors LIKE '%' + @TeamColor + '%';
END;

GO

CREATE OR ALTER PROCEDURE dbo.procScheduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR(50),
    @GameDate DATE,
    @GameStartTime TIME,
    @StadiumID INT,
    @NFLAdminID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @context VARBINARY(128) = CAST(@NFLAdminID AS VARBINARY(128));
    SET CONTEXT_INFO @context;

    INSERT INTO Game 
        (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    VALUES 
        (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END;

GO

CREATE OR ALTER TRIGGER dbo.trgTrackChangesOnSchedulingGame
ON Game
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AdminChangesTracker 
        (NFLAdminID, GameID, ChangeType, ChangeDescription)
    SELECT
        CONVERT(INT, CONVERT(BINARY(4), CONTEXT_INFO())) AS NFLAdminID,
        i.GameID,
        N'Insert',
        AU.Firstname + ' ' + AU.Lastname
        + ' scheduled a new game with GameID '
        + CAST(i.GameID AS NVARCHAR(50))
        + ': ' + HT.Tname
        + ' vs ' + AT.Tname
        + ' on ' + CAST(i.GameDate AS NVARCHAR(50))
        + ' at ' + S.StadiumName
        + ' during round ' + i.GameRound
    FROM inserted i
    INNER JOIN Team HT
        ON i.HomeTeamID = HT.TeamID
    INNER JOIN Team AT
        ON i.AwayTeamID = AT.TeamID
    INNER JOIN Stadium S
        ON i.StadiumID = S.StadiumID
    INNER JOIN AppUser AU
        ON AU.AppUserID = CONVERT(INT, CONVERT(BINARY(4), CONTEXT_INFO()));
END;

GO

CREATE OR ALTER PROCEDURE dbo.procEnterScores
(
    @GameID INT,
    @HomeTeamScore INT,
    @AwayTeamScore INT,
    @NFLAdminID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @context VARBINARY(128) = CAST(@NFLAdminID AS VARBINARY(128));
    SET CONTEXT_INFO @context;

    UPDATE Game
    SET 
        HomeTeamScore = @HomeTeamScore,
        AwayTeamScore = @AwayTeamScore,
        WinningTeamID =
            CASE
                WHEN @HomeTeamScore > @AwayTeamScore THEN HomeTeamID
                WHEN @AwayTeamScore > @HomeTeamScore THEN AwayTeamID
                ELSE NULL
            END
    WHERE GameID = @GameID;
END;

GO

CREATE OR ALTER TRIGGER dbo.trgChangesOnEnteringScores
ON Game
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AdminChangesTracker 
        (NFLAdminID, GameID, ChangeType, ChangeDescription)
    SELECT
        CONVERT(INT, CONVERT(BINARY(4), CONTEXT_INFO())) AS NFLAdminID,
        i.GameID,
        N'Update',
        AU.Firstname + ' ' + AU.Lastname
        + ' updated the score for GameID '
        + CAST(i.GameID AS NVARCHAR(50))
        + ': '
        + CAST(i.HomeTeamScore AS NVARCHAR(50))
        + ' - '
        + CAST(i.AwayTeamScore AS NVARCHAR(50))
        + '.'
    FROM inserted i
    INNER JOIN AppUser AU
        ON AU.AppUserID = CONVERT(INT, CONVERT(BINARY(4), CONTEXT_INFO()))
    WHERE i.HomeTeamScore IS NOT NULL
      AND i.AwayTeamScore IS NOT NULL;
END;

GO

CREATE OR ALTER PROCEDURE dbo.procGetAllChangesMadeBySpecifiedAdmin
(
    @NFLAdminID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ACT.ChangeDateTime,
        ACT.ChangeType,
        ACT.ChangeDescription,
        G.GameRound,
        G.GameDate,
        G.GameStartTime,
        HT.Tname AS HomeTeam,
        AT.Tname AS AwayTeam,
        S.StadiumName
    FROM AdminChangesTracker ACT
    INNER JOIN Game G
        ON ACT.GameID = G.GameID
    INNER JOIN Team HT
        ON G.HomeTeamID = HT.TeamID
    INNER JOIN Team AT
        ON G.AwayTeamID = AT.TeamID
    INNER JOIN Stadium S
        ON G.StadiumID = S.StadiumID
    WHERE ACT.NFLAdminID = @NFLAdminID
    ORDER BY ACT.ChangeDateTime DESC;
END;

GO

-- Optional test queries

SELECT * FROM NFLFan;
SELECT * FROM Game;
SELECT * FROM AdminChangesTracker;

