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

# Endpoint untuk mendapatkan semua review
@app.route('/reviews', methods=['GET'])
def get_reviews():
    try:
        # Membuat koneksi ke database
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)


        # Eksekusi query untuk mendapatkan semua review
        cursor.execute("SELECT * FROM review")

        # Mendapatkan hasil query
        reviews = cursor.fetchall()

        # Menutup kursor dan koneksi
        cursor.close()
        db.close()

        # Mengembalikan hasil dalam format JSON
        return jsonify(reviews), 200

    except mysql.connector.Error as err:
        print("Error:", err)
        return jsonify({'error': 'Internal Server Error'}), 500

# Endpoint untuk mendapatkan review berdasarkan ID produk
@app.route('/reviews/<int:product_id>', methods=['GET'])
def get_reviews_by_product_id(product_id):
    try:
        # Membuat koneksi ke database
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)


        # Eksekusi query untuk mendapatkan review berdasarkan ID produk
        cursor.execute("SELECT * FROM review WHERE product_id = %s", (product_id,))

        # Mendapatkan hasil query
        reviews = cursor.fetchall()

        # Menutup kursor dan koneksi
        cursor.close()
        db.close()
        
        # Jika tidak ada review yang ditemukan, kirim respons 'Product not found'
        if not reviews:
            return jsonify({'message': 'Product not found'}), 404
        # Mengembalikan hasil dalam format JSON
        return jsonify(reviews), 200

    except mysql.connector.Error as err:
        print("Error:", err)
        return jsonify({'error': 'Internal Server Error'}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5003)
   

