from get_db_connection import get_db_connection

def validate_user(email: str, password_hash: str):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    cursor.execute(
        "EXEC dbo.procValidateUser %s, %s",
        (email, password_hash)
    )

    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    return {"data": rows}