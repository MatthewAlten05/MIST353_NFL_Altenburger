import os
import pyodbc
from dotenv import load_dotenv

load_dotenv()

def get_db_connection():

    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_LOGIN")
    password = os.getenv("DB_PASSWORD")

    if not all([server, database, username, password]):
        raise Exception("Missing database environment variables")

    connection_string = (
        "DRIVER={ODBC Driver 18 for SQL Server};"
        f"SERVER={server},1433;"
        f"DATABASE={database};"
        f"UID={username};"
        f"PWD={password};"
        "Encrypt=yes;"
        "TrustServerCertificate=yes;"  
        "Connection Timeout=30;"
    )

    conn = pyodbc.connect(connection_string)

    return conn