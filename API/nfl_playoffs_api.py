from fastapi import FastAPI
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division_as_specified_team import (
    get_teams_in_same_conference_division_as_specified_team
)

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "NFL Playoffs API is running"}

@app.get("/teams/by-division")
def teams_by_division(conference_name: str = None, division_name: str = None):
    return get_teams_by_conference_division(conference_name, division_name)

@app.get("/teams/same-division/{team_name}")
def teams_same_division(team_name: str):
    return get_teams_in_same_conference_division_as_specified_team(team_name)
