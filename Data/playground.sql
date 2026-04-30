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
SELECT name
FROM sys.procedures
WHERE name = 'procScheduleGame';