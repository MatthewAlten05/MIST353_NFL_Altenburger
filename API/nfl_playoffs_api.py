from fastapi import FastAPI
import pyodbc

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

# 👇 ADDED THIS
@app.get("/drivers")
def get_drivers():
    try:
        return {"drivers": pyodbc.drivers()}
    except Exception as e:
        return {"error": str(e)}