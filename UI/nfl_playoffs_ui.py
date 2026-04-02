import streamlit as st
from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui

st.title("NFL Playoffs App")

option = st.sidebar.selectbox(
    "Choose a feature",
    [
        "Teams by Division",
        "Teams in Same Division"
    ]
)

if option == "Teams by Division":
    get_teams_by_conference_division_ui()

elif option == "Teams in Same Division":
    get_teams_in_same_conference_division_as_specified_team_ui()