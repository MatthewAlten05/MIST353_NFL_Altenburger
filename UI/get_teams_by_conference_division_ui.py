import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    st.header("Get Teams by Conference and Division")

    conference = st.text_input("Conference")
    division = st.text_input("Division")

    if st.button("Fetch Teams"):
        params = {
            "conference_name": conference,
            "division_name": division
        }

        data = fetch_data("teams/by-division", params)

        if isinstance(data, list) and len(data) > 0:
            st.dataframe(data)
        else:
            st.warning("No results found")