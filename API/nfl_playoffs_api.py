from datetime import date, time

from fastapi import FastAPI

from schedule_game import schedule_game
from get_all_teams import get_all_teams
from get_all_stadiums import get_all_stadiums
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team
from validate_user import validate_user
from get_teams_for_specified_fan import get_teams_for_specified_fan
from get_teams_by_color import get_teams_by_color


app = FastAPI()


@app.get("/get_teams_by_conference_division/")
def get_teams_by_conference_division_api(conference: str = None, division: str = None):
    try:
        return get_teams_by_conference_division(conference, division)
    except Exception as e:
        return {"error": str(e)}


@app.get("/get_teams_in_same_conference_division_as_specified_team/")
def get_teams_in_same_conference_division_as_specified_team_api(team_name: str):
    try:
        return get_teams_in_same_conference_division_as_specified_team(team_name)
    except Exception as e:
        return {"error": str(e)}


@app.get("/validate_user/")
def validate_user_api(email: str, password_hash: str):
    try:
        return validate_user(email, password_hash)
    except Exception as e:
        return {"error": str(e)}


@app.get("/get_teams_for_specified_fan/")
def get_teams_for_specified_fan_api(NFLFanID: int):
    try:
        return get_teams_for_specified_fan(NFLFanID)
    except Exception as e:
        return {"error": str(e)}


@app.get("/get_teams_by_color/")
def get_teams_by_color_api(color: str):
    try:
        return get_teams_by_color(color)
    except Exception as e:
        return {"error": str(e)}


@app.get("/get_all_teams/")
def get_all_teams_api():
    try:
        return get_all_teams()
    except Exception as e:
        return {"error": str(e)}


@app.get("/get_all_stadiums/")
def get_all_stadiums_api():
    try:
        return get_all_stadiums()
    except Exception as e:
        return {"error": str(e)}


@app.post("/schedule_game/")
def schedule_game_api(
    home_team_id: int,
    away_team_id: int,
    game_round: str,
    game_date: date,
    game_start_time: time,
    stadium_id: int,
    nfl_admin_id: int
):
    try:
        return schedule_game(
            home_team_id=home_team_id,
            away_team_id=away_team_id,
            game_round=game_round,
            game_date=game_date,
            game_start_time=game_start_time,
            stadium_id=stadium_id,
            nfl_admin_id=nfl_admin_id
        )
    except Exception as e:
        return {"error": str(e)}