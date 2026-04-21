from get_db_connection import get_db_connection

def get_teams_by_conference_division(conference=None, division=None):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        "EXEC dbo.procGetTeamsByConferenceDivision @Conference=?, @Division=?",
        (conference, division)
    )

    rows = cursor.fetchall()

    results = []
    for row in rows:
        results.append({
            "TeamName": row[0],
            "TeamColors": row[1],
            "Conference": row[2],
            "Division": row[3]
        })

    conn.close()
    return results

#this is a test call to the function, you can replace the parameters with actual values

if __name__ == "__main__":
    teams = get_teams_by_conference_division("NFC", "North")
    for team in teams:
        print(team)