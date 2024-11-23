from flask import Flask, render_template, request, jsonify
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# MySQL Configuration
db_config = {
    "host": "localhost",         # Replace with your database host
    "user": "root",              # Replace with your database username
    "password": "", # Replace with your database password
    "database": "million_dollar" # Replace with your database name
}

# Establish database connection
def get_db_connection():
    return mysql.connector.connect(**db_config)

# Ensure the table exists
def init_db():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS pixels (
            id INT AUTO_INCREMENT PRIMARY KEY,
            x INT NOT NULL,
            y INT NOT NULL,
            owner_name VARCHAR(255) NOT NULL,
            image_url TEXT NOT NULL,
            target_url TEXT NOT NULL,
            alt_text VARCHAR(255),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    conn.commit()
    cursor.close()
    conn.close()

init_db()

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/api/get_pixels", methods=["GET"])
def get_pixels():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT x, y, image_url, target_url, alt_text FROM pixels")
    pixels = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(pixels)


@app.route("/api/buy_pixel", methods=["POST"])
def buy_pixel():
    data = request.json
    try:
        x, y = data["x"], data["y"]
        owner_name = data["owner_name"]
        image_url = data["image_url"]
        target_url = data["target_url"]
        alt_text = data["alt_text"]

        conn = get_db_connection()
        cursor = conn.cursor()

        # Check if the pixel is already purchased
        cursor.execute("SELECT * FROM pixels WHERE x = %s AND y = %s", (x, y))
        if cursor.fetchone():
            cursor.close()
            conn.close()
            return jsonify({"status": "error", "message": "Pixel already purchased"}), 400

        # Insert the new pixel
        cursor.execute(
            "INSERT INTO pixels (x, y, owner_name, image_url, target_url, alt_text) VALUES (%s, %s, %s, %s, %s, %s)",
            (x, y, owner_name, image_url, target_url, alt_text),
        )
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"status": "success"})
    except Exception as e:
        print("Error:", e)
        return jsonify({"status": "error", "message": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True , port=5000)
