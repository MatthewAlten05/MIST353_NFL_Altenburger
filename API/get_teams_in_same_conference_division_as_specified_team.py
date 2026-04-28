from get_db_connection import get_db_connection

def get_teams_in_same_conference_division_as_specified_team(team_name):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute(
        "EXEC dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName=%s",
        (team_name,)
    )

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return {"data": rows}


if __name__ == "__main__":
    teams = get_teams_in_same_conference_division_as_specified_team("Pittsburgh Steelers")
    print(teams)