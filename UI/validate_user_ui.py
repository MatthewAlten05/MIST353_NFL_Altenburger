import streamlit as st
import pandas as pd
from fetch_data import fetch_data


def validate_user_ui():
    st.header("Validate User")

    email = st.text_input("Enter Email:")
    password_hash = st.text_input("Enter Password:", type="password")

    if st.button("Validate User"):
        if not email.strip():
            st.error("Email is required.")
            return

        if not password_hash.strip():
            st.error("Password is required.")
            return

        input_params = {
            "email": email.strip(),
            "password_hash": password_hash.strip()
        }

        df = fetch_data("validate_user/", input_params)

        if df is None or df.empty:
            st.info(f"User {email} not found. Please check inputs and try again.")
            return

        # Fix for API returning {"data": [...]}
        if "data" in df.columns:
            raw_data = df.iloc[0]["data"]

            if isinstance(raw_data, list):
                df = pd.DataFrame(raw_data)
            elif isinstance(raw_data, dict):
                df = pd.DataFrame([raw_data])

        if df is None or df.empty:
            st.error("No valid user data returned.")
            return

        st.success("Login successful!")
        st.dataframe(df, use_container_width=True, hide_index=True)

        df.columns = [col.lower() for col in df.columns]

        if "appuserid" not in df.columns:
            st.error(f"Could not find AppUserID column. Columns returned: {list(df.columns)}")
            return

        if "userrole" not in df.columns:
            st.error(f"Could not find UserRole column. Columns returned: {list(df.columns)}")
            return

        st.session_state["user_id"] = int(df.iloc[0]["appuserid"])
        st.session_state["app_user_id"] = int(df.iloc[0]["appuserid"])
        st.session_state["user_role"] = df.iloc[0]["userrole"]

        if "fullname" in df.columns:
            st.session_state["full_name"] = df.iloc[0]["fullname"]
        else:
            st.session_state["full_name"] = email.strip()

        st.write("Logged in as:", st.session_state["full_name"])
        st.write("Role:", st.session_state["user_role"])