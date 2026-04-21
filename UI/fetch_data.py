import streamlit as st
import requests
import pandas as pd

FASTAPI_URL = "https://mist353-api-altenburger.azurewebsites.net/"
def fetch_data(endpoint: str, params: dict = None):
    base_url = "http://localhost:8000"
    url = f"{base_url}/{endpoint}"

    try:
        response = requests.get(url, params=params)
        response.raise_for_status()
        data = response.json()

        if data is None:
            return None

        if isinstance(data, dict) and "data" in data:
            inner_data = data["data"]

            if isinstance(inner_data, list):
                return pd.DataFrame(inner_data)

            if isinstance(inner_data, dict):
                return pd.DataFrame([inner_data])

        if isinstance(data, list):
            return pd.DataFrame(data)

        if isinstance(data, dict):
            return pd.DataFrame([data])

        return None

    except Exception as e:
        print(e)
        return None