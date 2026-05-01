import streamlit as st
from fetch_data import fetch_data


def validate_user_ui():
    st.header("Validate User")

    email = st.text_input("Enter Email:")
    password_hash = st.text_input("Enter Password:", type="password")

    if st.button("Validate User"):
        input_params = {}

        if not email.strip():
            st.error("Email is required.")
            return
        else:
            input_params["email"] = email.strip()

        if not password_hash.strip():
            st.error("Password is required.")
            return
        else:
            input_params["password_hash"] = password_hash.strip()

        df = fetch_data("validate_user/", input_params)

        if df is not None and not df.empty:
            st.success("Login successful!")
            st.subheader(f"User {email} is valid:")
            st.dataframe(df, use_container_width=True, hide_index=True)

            st.session_state["user_id"] = int(df.iloc[0]["AppUserID"])
            st.session_state["app_user_id"] = int(df.iloc[0]["AppUserID"])
            st.session_state["full_name"] = df.iloc[0]["FullName"]
            st.session_state["user_role"] = df.iloc[0]["UserRole"]

            st.write("Logged in as:", st.session_state["full_name"])
            st.write("Role:", st.session_state["user_role"])

        else:
            st.info(f"User {email} not found. Please check inputs and try again.")