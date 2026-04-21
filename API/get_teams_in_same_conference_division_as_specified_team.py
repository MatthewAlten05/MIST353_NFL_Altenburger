from get_db_connection import get_db_connection

def get_teams_in_same_conference_division_as_specified_team(team_name):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        "EXEC dbo.procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName=?",
        (team_name,)
    )

    rows = cursor.fetchall()

    results = []
    for row in rows:
        print(row)  # DEBUG - remove later

        results.append({
            "TeamName": row[0],
            "Conference": row[1],
            "Division": row[2]
        })

    conn.close()
    return results

if __name__ == "__main__":
    teams = get_teams_in_same_conference_division_as_specified_team("Pittsburgh Steelers")
    for team in teams:
        print(team)