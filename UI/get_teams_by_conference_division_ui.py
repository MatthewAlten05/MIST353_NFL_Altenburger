import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    st.header("Get Teams by Conference and Division")

    conference = st.text_input("Conference")
    division = st.text_input("Division")

    if st.button("Fetch Teams"):
        params = {
            "conference": conference.strip(),
            "division": division.strip()
        }

        df = fetch_data("get_teams_by_conference_division/", params)

        if df is not None and not df.empty:
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.warning("No results found.")