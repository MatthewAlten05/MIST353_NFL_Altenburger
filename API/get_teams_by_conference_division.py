from get_db_connection import get_db_connection

def get_teams_by_conference_division(conference=None, division=None):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute(
        "EXEC dbo.procGetTeamsByConferenceDivision @Conference=%s, @Division=%s",
        (conference, division)
    )

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return {"data": rows}


if __name__ == "__main__":
    teams = get_teams_by_conference_division("NFC", "North")
    print(teams)