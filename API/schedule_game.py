from get_db_connection import get_db_connection
import pymssql
from datetime import date, time


def schedule_game(
    home_team_id: int,
    away_team_id: int,
    game_round: str,
    game_date: date,
    game_start_time: time,
    stadium_id: int,
    nfl_admin_id: int
):
    conn = None
    cursor = None

    try:
        conn = get_db_connection()
        cursor = conn.cursor(as_dict=True)

        cursor.execute(
            """
            EXEC dbo.procScheduleGame
                @HomeTeamID=%s,
                @AwayTeamID=%s,
                @GameRound=%s,
                @GameDate=%s,
                @GameStartTime=%s,
                @StadiumID=%s,
                @NFLAdminID=%s
            """,
            (
                home_team_id,
                away_team_id,
                game_round,
                game_date,
                game_start_time,
                stadium_id,
                nfl_admin_id
            )
        )

        conn.commit()
        return {"status_message": "Game scheduled successfully."}

    except pymssql.OperationalError as e:
        if conn:
            conn.rollback()
        return {"status_message": f"Database connection error: {e}"}

    except Exception as e:
        if conn:
            conn.rollback()

        error_text = str(e)

        if "UK_Game" in error_text or "duplicate key" in error_text.lower():
            return {"status_message": f"Error: Game already scheduled: {e}"}
        elif "CK_Game_Teams" in error_text:
            return {"status_message": "Error: Home team and away team cannot be the same."}
        elif "FK_Game_HomeTeam" in error_text:
            return {"status_message": "Error: HomeTeamID does not exist."}
        elif "FK_Game_AwayTeam" in error_text:
            return {"status_message": "Error: AwayTeamID does not exist."}
        elif "FK_Game_Stadium" in error_text:
            return {"status_message": "Error: StadiumID does not exist."}
        else:
            return {"status_message": f"Error occurred: {e}"}

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()