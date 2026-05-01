from get_db_connection import get_db_connection

def get_all_teams():
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute("EXEC dbo.procGetAllTeams")
    rows = cursor.fetchall()

    conn.close()

    results = [
        {
            "TeamID": row["TeamID"],
            "TeamName": row["TeamName"]
        }
        for row in rows
    ]

    return {"data": results}