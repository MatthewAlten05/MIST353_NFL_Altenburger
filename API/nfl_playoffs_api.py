from fastapi import FastAPI
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team
from validate_user import validate_user
from get_teams_for_specified_fan import get_teams_for_specified_fan
from get_teams_by_color import get_teams_by_color

app = FastAPI()

@app.get("/get_teams_by_conference_division/")
def get_teams_by_conference_division_api(conference: str = None, division: str = None):
    return get_teams_by_conference_division(conference, division)

@app.get("/get_teams_in_same_conference_division_as_specified_team/")
def get_teams_in_same_conference_division_as_specified_team_api(team_name: str):
    return get_teams_in_same_conference_division_as_specified_team(team_name)

@app.get("/validate_user/")
def validate_user_api(email: str, password_hash: str):
    return validate_user(email, password_hash)

@app.get("/get_teams_for_specified_fan/")
def get_teams_for_specified_fan_api(NFLFanID: int):
    return get_teams_for_specified_fan(NFLFanID)

@app.get("/get_teams_by_color/")
def get_teams_by_color_api(color: str):
    return get_teams_by_color(color)