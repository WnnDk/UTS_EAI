const express = require('express');
const app = express();
const mysql = require('mysql');

// Buat koneksi database
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'ecommerce'
});

// Koneksi ke database
connection.connect((err) => {
    if (err) {
      console.error('Error connecting to database:', err.stack);
      return;
    }
    console.log('Connected to database as id', connection.threadId);
  });
  
  // Endpoint untuk mendapatkan semua produk
  app.get('/products', (req, res) => {
    connection.query('SELECT * FROM products', (err, results) => {
      if (err) {
        console.error('Error executing query:', err.stack);
        res.status(500).send('Internal Server Error');
        return;
      }
      res.json(results);
    });
  });
  
  // Endpoint untuk mendapatkan produk berdasarkan ID
app.get('/products/:id', (req, res) => {
    const productId = req.params.id;
  
    // Periksa apakah ID produk valid (berupa angka)
    if (isNaN(productId)) {
      res.status(400).send('Invalid product ID');
      return;
    }
  
    // Lakukan query ke database untuk mendapatkan produk berdasarkan ID
    connection.query('SELECT * FROM products WHERE id = ?', [productId], (err, results) => {
      if (err) {
        console.error('Error executing query:', err.stack);
        res.status(500).send('Internal Server Error');
        return;
      }
  
      // Periksa apakah produk dengan ID tersebut ditemukan
      if (results.length === 0) {
        res.status(404).send('Product not found');
        return;
      }
  
      // Kirim respons dengan data produk yang ditemukan
      res.json(results[0]);
    });
  });


  // Tambahkan middleware untuk menangani error 404
  app.use((req, res, next) => {
    res.status(404).send('Not Found');
  });
  
  // Tangani error lainnya
  app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Internal Server Error');
  });
  
  // Jalankan server
  const port = process.env.PORT || 5000;
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });