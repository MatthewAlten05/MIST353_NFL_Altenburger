import streamlit as st
from fetch_data import fetch_data

def get_teams_in_same_conference_division_as_specified_team_ui():
    st.header("Teams in Same Division")

    team_name = st.text_input("Team Name")

    if st.button("Fetch Teams"):
        endpoint = f"teams/same-division/{team_name}"
        data = fetch_data(endpoint)

        if isinstance(data, list) and len(data) > 0:
            st.dataframe(data)
        else:
            st.warning("No results found")