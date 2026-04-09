

CREATE OR ALTER PROCEDURE dbo.procGetTeamsByConferenceDivision
(
    @ConferenceName NVARCHAR(50) = NULL,
    @DivisionName NVARCHAR(50) = NULL
)
AS
BEGIN
    SELECT
        t.TeamName,
        t.TeamColors,
        cd.Conference,
        cd.Division
    FROM Team t
    INNER JOIN ConferenceDivision cd
        ON t.ConferenceDivisionID = cd.ConferenceID
    WHERE
        (@ConferenceName IS NULL OR cd.Conference = @ConferenceName)
        AND (@DivisionName IS NULL OR cd.Division = @DivisionName);
END;
GO
CREATE OR ALTER PROCEDURE dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName NVARCHAR(50)
)
AS
BEGIN
    SELECT
        OtherTeam.TeamName,
        CD.Conference,
        CD.Division
    FROM Team SpecifiedTeam
    INNER JOIN ConferenceDivision CD
        ON SpecifiedTeam.ConferenceDivisionID = CD.ConferenceID
    INNER JOIN Team OtherTeam
        ON OtherTeam.ConferenceDivisionID = CD.ConferenceID
    WHERE SpecifiedTeam.TeamName = @TeamName
      AND OtherTeam.TeamName <> @TeamName;
END;
GO

EXEC dbo.procGetTeamsByConferenceDivision 'AFC', 'North';
GO
EXEC dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam 'Pittsburgh Steelers';
GO