import requests

def fetch_data(endpoint: str, params: dict = None):
    base_url = "http://localhost:8000"
    url = f"{base_url}/{endpoint}"

    try:
        response = requests.get(url, params=params)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        print(e)
        return None