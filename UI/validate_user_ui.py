import streamlit as st
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

        if df is not None and not df.empty:
            st.success("Login successful!")
            st.dataframe(df, use_container_width=True, hide_index=True)

            # Normalize column names so AppUserID/appuserid/app_user_id all work
            df.columns = [col.lower() for col in df.columns]

            if "appuserid" in df.columns:
                user_id_col = "appuserid"
            elif "app_user_id" in df.columns:
                user_id_col = "app_user_id"
            else:
                st.error(f"Could not find AppUserID column. Columns returned: {list(df.columns)}")
                return

            if "fullname" in df.columns:
                full_name_col = "fullname"
            elif "full_name" in df.columns:
                full_name_col = "full_name"
            else:
                full_name_col = None

            if "userrole" in df.columns:
                user_role_col = "userrole"
            elif "user_role" in df.columns:
                user_role_col = "user_role"
            else:
                st.error(f"Could not find UserRole column. Columns returned: {list(df.columns)}")
                return

            st.session_state["user_id"] = int(df.iloc[0][user_id_col])
            st.session_state["app_user_id"] = int(df.iloc[0][user_id_col])
            st.session_state["user_role"] = df.iloc[0][user_role_col]

            if full_name_col:
                st.session_state["full_name"] = df.iloc[0][full_name_col]
            else:
                st.session_state["full_name"] = email.strip()

            st.write("Logged in as:", st.session_state["full_name"])
            st.write("Role:", st.session_state["user_role"])

        else:
            st.info(f"User {email} not found. Please check inputs and try again.")