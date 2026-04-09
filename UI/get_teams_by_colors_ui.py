import streamlit as st
from fetch_data import fetch_data

def get_teams_by_colors_ui():
    st.subheader("Get Teams by Color")
    color = st.text_input("Enter Color:")

    if st.button("Fetch Teams"):
        if not color.strip():
            st.warning("Please enter a color.")
        else:
            input_params = {
                "color": color.strip()
            }

            df = fetch_data("get_teams_by_color/", input_params)

            if df is not None and not df.empty:
                st.subheader(f"Teams with {color} in their colors:")
                st.dataframe(df, use_container_width=True, hide_index=True)
            else:
                st.info(f"No teams found with {color} in their colors.")