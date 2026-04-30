import streamlit as st
from fetch_data import post_data


def schedule_game_ui():
    st.header("Schedule a New Game")

    home_team_id = st.number_input("Enter Home Team ID:", min_value=1, step=1)
    away_team_id = st.number_input("Enter Away Team ID:", min_value=1, step=1)

    game_round = st.selectbox(
        "Select Game Round:",
        ["Wild Card", "Divisional", "Conference", "Super Bowl"]
    )

    game_date = st.date_input("Enter Game Date:")
    game_start_time = st.time_input("Enter Game Start Time:")

    stadium_id = st.number_input("Enter Stadium ID:", min_value=1, step=1)
    nfl_admin_id = st.number_input("Enter NFL Admin ID:", min_value=1, step=1)

    if st.button("Schedule Game"):
        result = post_data(
            "schedule_game/",
            {
                "HomeTeamID": home_team_id,
                "AwayTeamID": away_team_id,
                "GameRound": game_round,
                "GameDate": game_date.isoformat(),
                "GameStartTime": game_start_time.strftime("%H:%M:%S"),
                "StadiumID": stadium_id,
                "NFLAdminID": nfl_admin_id
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