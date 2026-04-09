from get_db_connection import get_db_connection

def get_teams_by_color(
      color: str
):

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("{call procGetTeamsByColor(?)}", (color,))
    rows = cursor.fetchall()
    conn.close()

    results  = [
        {
            "TeamName": row.Team_Name,
            "TeamColors": row.Colors
        }

        for row in rows
    ]

    return {"data": results}