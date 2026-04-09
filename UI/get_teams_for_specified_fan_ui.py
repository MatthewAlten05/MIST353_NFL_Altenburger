import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    st.header("Get Teams for Specified Fan")

    nfl_fan_id = st.text_input("NFL Fan ID")

    if st.button("Fetch Teams for Fan"):
        if not nfl_fan_id.strip():
            st.warning("Please enter an NFL Fan ID.")
            return

        params = {
            "NFLFanID": nfl_fan_id.strip()
        }

        df = fetch_data("get_teams_for_specified_fan/", params)

        if df is not None and not df.empty:
            st.subheader("Teams")
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.warning("No results found.")