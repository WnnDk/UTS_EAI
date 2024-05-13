from flask import Flask, request, jsonify, render_template
import mysql.connector
import requests

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

# Fungsi untuk mengambil detail produk dari layanan produk
def get_product(product_id):
    try:      
        response = requests.get(f'http://localhost:5000/products/{product_id}')
        if response.status_code == 200:
            return response.json()
        else:
            return {'error': 'Failed to fetch product details'}
    except requests.exceptions.RequestException as e:
        return {'error': 'Failed to connect to product service'}

# Fungsi untuk mengambil jumlah terjual dari layanan keranjang
def get_quantity_sold(product_id):
    try:
        response = requests.get(f'http://localhost:5004/cart/products/{product_id}')
        if response.status_code == 200:
            return {'total_quantity': response.json()['total_quantity']}
        else:
            return {'error': 'Failed to fetch quantity sold'}
    except requests.exceptions.RequestException as e:
        return {'error': 'Failed to connect to cart service'}

# Fungsi untuk mengambil review produk dari layanan review
def get_review(product_id):
    try:       
        response = requests.get(f'http://localhost:5003/reviews/{product_id}')
        if response.status_code == 200:
            return response.json()
        else:
            return {'error': 'Failed to fetch product reviews'}
    except requests.exceptions.RequestException as e:
        return {'error': 'Failed to connect to review service'}

@app.route('/products/<int:product_id>', methods=['GET'])
def get_product_details(product_id):
    try:
        # Mengambil detail produk dari layanan produk
        product = get_product(product_id)
        if 'error' in product:
            return jsonify(product), 500
        
        # Mengambil jumlah terjual dari layanan keranjang
        quantity_sold = get_quantity_sold(product_id)
        if 'error' in quantity_sold:
            return jsonify(quantity_sold), 500
        
        # Mengambil review produk dari layanan review
        reviews = get_review(product_id)
        if 'error' in reviews:
            return jsonify(reviews), 500
        
        # Mengembalikan hasil dalam format html
        return render_template('index.html', product_info=product, quantity_sold_info=quantity_sold, reviews_info=reviews)
        # return jsonify({'product': product, 'quantity_sold': quantity_sold, 'reviews': reviews}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5005)
