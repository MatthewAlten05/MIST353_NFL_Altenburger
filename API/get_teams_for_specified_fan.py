from get_db_connection import get_db_connection

def get_teams_for_specified_fan(NFLFanID: int):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute(
        "EXEC dbo.procGetTeamsForSpecifiedFan %s",
        (NFLFanID,)
    )

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return {"data": rows}