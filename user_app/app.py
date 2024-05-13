from flask import Flask, request, jsonify
import mysql.connector


# Konfigurasi koneksi ke database MySQL
db_config = {
    'user': 'root',  
    'password': '',  
    'host': 'localhost',  
    'database': 'ecommerce'  
}

app = Flask(__name__)

# Fungsi untuk membuat koneksi ke database MySQL
def get_db_connection():
    return mysql.connector.connect(**db_config)

# Endpoint untuk mendapatkan semua pengguna
@app.route('/users', methods=['GET'])
def get_users():
    try:
        # Membuat koneksi ke database
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)

        # Eksekusi query untuk mendapatkan semua pengguna
        cursor.execute("SELECT * FROM users")

        # Mendapatkan hasil query
        users = cursor.fetchall()

        # Menutup kursor dan koneksi
        cursor.close()
        db.close()
       
        # Mengembalikan hasil dalam format JSON
        return jsonify(users), 200

    except mysql.connector.Error as err:
        print("Error:", err)
        return jsonify({'error': 'Internal Server Error'}), 500
    
    
# Endpoint untuk mendapatkan informasi pengguna berdasarkan ID
@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    # Membuat koneksi ke database
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    
    # Kueri untuk mendapatkan informasi pengguna berdasarkan ID
    query = "SELECT * FROM users WHERE id = %s"
    cursor.execute(query, (user_id,))
    user = cursor.fetchone()
    
    # Menutup kursor dan koneksi
    cursor.close()
    db.close()
    
    # Jika pengguna ditemukan, kembalikan data pengguna sebagai JSON
    if user:
        return jsonify(user)
    else:
        return jsonify({'message': 'Pengguna tidak ditemukan'}), 404
    

app.run(debug=True, port=5002)

