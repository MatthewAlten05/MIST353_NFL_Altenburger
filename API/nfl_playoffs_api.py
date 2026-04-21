from fastapi import FastAPI
import pyodbc

app = FastAPI()

@app.get("/")
def root():
    return {"message": "api is live"}

@app.get("/drivers")
def get_drivers():
    return {"drivers": pyodbc.drivers()}