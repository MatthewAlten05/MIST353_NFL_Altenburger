import streamlit as st
from fetch_data import fetch_data, post_data


def schedule_game_ui():
    st.header("Schedule a New Game")

    if "user_id" not in st.session_state:
        st.error("No admin is currently logged in. Please validate user first.")
        return

    nfl_admin_id = st.session_state["user_id"]

    teams_df = fetch_data("get_all_teams/")
    stadiums_df = fetch_data("get_all_stadiums/")

    if teams_df is None or stadiums_df is None:
        st.error("Could not load teams or stadiums.")
        return

    home_team_name = st.selectbox(
        "Select Home Team:",
        teams_df["TeamName"].tolist()
    )

    away_team_name = st.selectbox(
        "Select Away Team:",
        teams_df["TeamName"].tolist()
    )

    game_round = st.selectbox(
        "Select Game Round:",
        ["Wild Card", "Divisional", "Conference", "Super Bowl"]
    )

    game_date = st.date_input("Enter Game Date:")
    game_start_time = st.time_input("Enter Game Start Time:")

    stadium_name = st.selectbox(
        "Select Stadium:",
        stadiums_df["StadiumName"].tolist()
    )

    home_team_id = int(teams_df.loc[teams_df["TeamName"] == home_team_name, "TeamID"].iloc[0])
    away_team_id = int(teams_df.loc[teams_df["TeamName"] == away_team_name, "TeamID"].iloc[0])
    stadium_id = int(stadiums_df.loc[stadiums_df["StadiumName"] == stadium_name, "StadiumID"].iloc[0])

    st.write(f"Home Team ID: {home_team_id}")
    st.write(f"Away Team ID: {away_team_id}")
    st.write(f"Stadium ID: {stadium_id}")
    st.write(f"Scheduling as Admin ID: {nfl_admin_id}")

    if st.button("Schedule Game"):
        if home_team_id == away_team_id:
            st.error("Home Team and Away Team cannot be the same.")
            return

        result = post_data(
            "schedule_game/",
            {
                "home_team_id": home_team_id,
                "away_team_id": away_team_id,
                "game_round": game_round,
                "game_date": game_date.isoformat(),
                "game_start_time": game_start_time.strftime("%H:%M:%S"),
                "stadium_id": stadium_id,
                "nfl_admin_id": nfl_admin_id
            }
        )

        if result:
            if "status_message" in result:
                st.success(result["status_message"])
            elif "error" in result:
                st.error(result["error"])
            else:
                st.write(result)
        else:
            st.error("No response from API.")