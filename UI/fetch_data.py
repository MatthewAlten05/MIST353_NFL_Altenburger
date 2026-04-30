import streamlit as st
import requests
import pandas as pd

FASTAPI_URL = "https://mist353-api-altenburger.azurewebsites.net"


# ======================
# GET REQUEST (existing)
# ======================
def fetch_data(endpoint: str, params: dict = None):
    url = f"{FASTAPI_URL}/{endpoint}"

    try:
        response = requests.get(url, params=params)
        response.raise_for_status()
        data = response.json()

        st.write("Raw API response:", data)

        if isinstance(data, dict) and "error" in data:
            st.error(f"API Error: {data['error']}")
            return None

        if isinstance(data, list):
            if len(data) == 0:
                st.warning("No results found.")
                return None
            return pd.DataFrame(data)

        if isinstance(data, dict):
            return pd.DataFrame([data])

        st.warning("Unexpected response format.")
        return None

    except Exception as e:
        st.error(f"Request failed: {e}")
        return None


# ======================
# POST REQUEST (NEW)
# ======================
def post_data(endpoint: str, data: dict):
    url = f"{FASTAPI_URL}/{endpoint}"

    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()

        st.write("Raw API response:", result)

        if isinstance(result, dict) and "error" in result:
            st.error(f"API Error: {result['error']}")
            return None

        return result

    except Exception as e:
        st.error(f"POST request failed: {e}")
        return None