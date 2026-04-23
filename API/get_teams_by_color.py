from get_db_connection import get_db_connection

def get_teams_by_color(color: str):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute("EXEC dbo.procGetTeamsByColor %s", (color,))
    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return {"data": rows}