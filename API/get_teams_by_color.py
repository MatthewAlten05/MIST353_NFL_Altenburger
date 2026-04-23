from get_db_connection import get_db_connection

def get_teams_by_color(color: str):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute("EXEC procGetTeamsByColor %s", (color,))
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamName": row["Tname"],
            "TeamColors": row["Tcolors"]
        }
        for row in rows
    ]

    return {"data": results}