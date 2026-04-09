import streamlit as st
from fetch_data import fetch_data

def get_teams_in_same_conference_division_as_specified_team_ui():
    st.header("Teams in Same Division")

    team_name = st.text_input("Team Name")

    if st.button("Fetch Teams"):
        if not team_name.strip():
            st.warning("Please enter a team name.")
            return

        params = {
            "team_name": team_name.strip()
        }

        df = fetch_data("get_teams_in_same_conference_division_as_specified_team/", params)

        if df is not None and not df.empty:
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.warning("No results found.")