-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Bulan Mei 2024 pada 15.26
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `quantity`, `created_at`) VALUES
(1, 8, 3, 2, '2024-05-10 15:01:45'),
(2, 1, 1, 2, '2024-05-11 17:13:08'),
(3, 1, 2, 1, '2024-05-11 17:13:08'),
(4, 2, 3, 3, '2024-05-11 17:13:08'),
(5, 3, 1, 1, '2024-05-11 17:13:08'),
(6, 3, 2, 2, '2024-05-11 17:13:08'),
(7, 1, 4, 2, '2024-05-11 17:17:43'),
(8, 2, 5, 1, '2024-05-11 17:17:43'),
(9, 3, 6, 3, '2024-05-11 17:17:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `created_at`, `updated_at`) VALUES
(1, 'Meja', 'Meja Plastik', 50.00, 10, '2024-05-10 13:29:42', '2024-05-10 13:29:42'),
(2, 'Kursi', 'Kursi Kantor', 60.00, 15, '2024-05-10 13:29:42', '2024-05-10 13:29:42'),
(3, 'Lampu', 'Lampu Baca', 55.00, 16, '2024-05-10 13:29:42', '2024-05-10 16:04:27'),
(4, 'Kipas Angin', 'Kipas Berdiri', 75.00, 5, '2024-05-10 13:29:42', '2024-05-10 13:29:42'),
(5, 'Dispenser', 'Dispenser Hot n Cold', 85.00, 10, '2024-05-10 13:29:42', '2024-05-10 16:04:27'),
(6, 'Bantal', 'Bantal microfiber', 45.00, 30, '2024-05-10 14:11:31', '2024-05-10 15:57:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `review`
--

CREATE TABLE `review` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `review`
--

INSERT INTO `review` (`id`, `user_id`, `product_id`, `review`, `created_at`) VALUES
(11, 1, 1, 'Produk sangat bagus, tetapi sedikit mahal.', '2024-05-11 12:24:25'),
(12, 2, 1, 'Sangat puas dengan produk ini, sangat direkomendasikan!', '2024-05-11 12:24:25'),
(13, 3, 2, 'Produknya bagus, tetapi pengirimannya agak lambat.', '2024-05-11 12:24:25'),
(14, 4, 3, 'Saya tidak puas dengan produk ini, kualitasnya rendah.', '2024-05-11 12:24:25'),
(15, 6, 3, 'Sangat kecewa dengan produk ini, tidak sesuai ekspektasi.', '2024-05-11 12:24:25'),
(16, 7, 1, 'Saya sangat menyukai produk ini, sangat berkualitas!', '2024-05-11 12:24:25'),
(17, 8, 3, 'Harganya terlalu mahal untuk kualitas yang ditawarkan.', '2024-05-11 12:24:25'),
(18, 9, 2, 'Produknya baik, tapi pengiriman agak lambat.', '2024-05-11 12:24:25'),
(19, 10, 1, 'Sangat puas dengan pembelian ini, terima kasih banyak!', '2024-05-11 12:24:25'),
(20, 1, 4, 'Produk ini sangat bagus, saya sangat puas dengan kualitasnya.', '2024-05-11 17:16:54'),
(21, 2, 5, 'Sangat direkomendasikan! Produknya berkualitas dan pengirimannya cepat.', '2024-05-11 17:16:54'),
(22, 3, 6, 'Saya kecewa dengan produk ini, kualitasnya rendah dan tidak sesuai ekspektasi.', '2024-05-11 17:16:54');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(1, 'john_doe', 'scrypt:32768:8:1$ly7Rv1chmDA6s6yM$5c3a60967c955b17a4632dc35ed93f22a9107cbbf7720098c08089d796adf0883f', 'john_doe@example.com', '2024-05-10 14:02:53', '2024-05-10 14:02:53'),
(2, 'jane_doe', 'scrypt:32768:8:1$gI1anNcaNr39LIeq$15a71991b29d63460164ce57ed2d5db4a70f05da58e0e0e232e61b37e66c5614fd', 'jane_doe@example.com', '2024-05-10 14:07:23', '2024-05-10 14:07:23'),
(3, 'mark_smith', 'scrypt:32768:8:1$AOb9O8PRWBtEUni7$62577dbfb8efeb8ca4f8dc57f778b78b9c1d425101aef0309f6645557924fa315b', 'mark_smith@example.com', '2024-05-10 14:07:32', '2024-05-10 14:07:32'),
(4, 'lucy_jones', 'scrypt:32768:8:1$gIhCaMvNjrNSlhar$99506fafdaa7d272e4156007615c0f562ff441886d85b5721ce75fffc630bc1858', 'lucy_jones@example.com', '2024-05-10 14:07:47', '2024-05-10 14:07:47'),
(6, 'michael_white', 'scrypt:32768:8:1$FwKmBcdRXyRoTFET$b787da47d9616c3c2670ed00aaa14dd795ce7d3bebf0143c332107c3b6131e7fc4', 'michael_white@example.com', '2024-05-10 14:08:09', '2024-05-10 14:08:09'),
(7, 'windy', 'scrypt:32768:8:1$VTxQXYA3EkG2Xfzm$5e45b1c5c5ee960c39b8a6bbeb8f1a0a3728be022ebe4b3fb0896faa3cb2cf71fe', 'windy@example.com', '2024-05-10 14:19:41', '2024-05-10 14:19:41'),
(8, 'windy2', 'scrypt:32768:8:1$6UxU4nFTXXf95TnZ$e0ffeac232aabb7362130be33914ca8037e810af0d5affd2c40964dc52d3dbec7a', 'windy2@example.com', '2024-05-10 14:31:14', '2024-05-10 14:31:14'),
(9, 'windy3', 'scrypt:32768:8:1$5OHU111M5xVswbtg$f1415d65527b31c527c87b901c7dc599e6ea9b6e6b15278d5918fc7c50ad1d5e4f', 'windy3@example.com', '2024-05-10 14:38:34', '2024-05-10 14:38:34'),
(10, 'windy4', 'scrypt:32768:8:1$7whnYVExkKDCuzQ8$4d78769c9f326cc5459051e2ced3255a1f305ca8c6b5f35da18dd02d87b6988c41', 'windy4@example.com', '2024-05-10 14:39:23', '2024-05-10 14:39:23'),
(11, 'windy5', 'scrypt:32768:8:1$fDqueEPbcLHSH4pw$de32703ffcfcec9129f1c8852c6a7345dcd9c3dcc3bab01aea3ae7497bf625b2dc', 'windy5@example.com', '2024-05-10 14:40:35', '2024-05-10 14:40:35');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `review`
--
ALTER TABLE `review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Ketidakleluasaan untuk tabel `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
