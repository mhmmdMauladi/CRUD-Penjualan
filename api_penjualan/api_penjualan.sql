-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2024 at 11:05 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `api_penjualan`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_food`
--

CREATE TABLE `tb_food` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `price` varchar(100) NOT NULL,
  `cookingtime` varchar(50) NOT NULL,
  `rate` decimal(2,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_food`
--

INSERT INTO `tb_food` (`id`, `image`, `nama`, `price`, `cookingtime`, `rate`) VALUES
(1, 'https://riotfest.org/wp-content/uploads/2016/10/151_1stuffed_crust_pizza.jpg', 'Pizzaa', '50.000', '20', 5.0),
(2, 'https://www.blibli.com/friends-backend/wp-content/uploads/2021/06/ilustrasi-seblak-kuah_220315142115-193.jpeg', 'Seblak', '25.000', '15', 4.0),
(3, 'https://cloud.jpnn.com/photo/arsip/normal/2024/04/29/bakso-menggugah-selera-foto-dbakso-osoae-beok.jpg', 'Bakso', '12.000', '10', 3.4),
(17, 'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2023/07/17043644/Praktis-dan-Simpel-Ini-Resep-Soto-Ayam-Lamongan-yang-Menggugah-Selera-.jpg.webp', 'Soto Ayam', '20.000', '15', 5.0),
(18, '', 'tes', '1', '1', 1.0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_food`
--
ALTER TABLE `tb_food`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_food`
--
ALTER TABLE `tb_food`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
