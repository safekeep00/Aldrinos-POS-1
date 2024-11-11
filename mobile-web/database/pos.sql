-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 11, 2024 at 03:48 AM
-- Server version: 10.5.25-MariaDB
-- PHP Version: 8.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos`
--
CREATE DATABASE IF NOT EXISTS `pos` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `pos`;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Pending',
  `gcash_ref_no` varchar(100) NOT NULL,
  `order_details` text NOT NULL,
  `subtotal` decimal(9,2) NOT NULL DEFAULT 0.00,
  `vat` decimal(9,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `barcode` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `qty_unit` varchar(45) NOT NULL DEFAULT 'piece',
  `qty_stock_threshold` int(11) NOT NULL DEFAULT 0,
  `image` varchar(100) DEFAULT 'placeholder.png',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `barcode`, `name`, `category`, `code`, `price`, `qty`, `qty_unit`, `qty_stock_threshold`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '111222', 'Coke zero (can)', 'Beverages', 'ZERO', 50.00, 995, 'piece', 100, 'coke%20in%20can%20zero.jpg', '2024-09-02 20:24:09', NULL, NULL),
(2, '1112221', 'Coke zero (can) Senior', 'Beverages', 'COKEZCS001', 30.00, 997, 'piece', 100, 'coke%20in%20can%20zero.jpg', '2024-09-02 20:28:39', NULL, '2024-09-04 11:05:09'),
(3, '2145692640016', 'Special Bibingka', 'Baking', 'SBIBINGKA', 120.00, 27, 'piece', 30, 'bibingka.jpg', '2024-09-02 20:53:09', NULL, NULL),
(4, '1122313', 'Special Bibingka (Senior,PWD) discount', 'Baking', 'SBBK313', 100.00, 1000, 'piece', 100, 'bibingka.jpg', '2024-09-02 20:55:52', NULL, '2024-09-04 11:04:39'),
(5, '2145692640023', 'Puto Bumbong', 'Baking', 'PBUMBONG', 100.00, 490, 'piece', 100, 'putobumbong.jpg', '2024-09-02 21:00:45', NULL, NULL),
(6, '2131231', 'barry', 'Canned Goods', '41241', 111111.00, 14, 'piece', 2, 'BARRY2.jpg', '2024-09-02 21:02:06', NULL, '2024-09-02 21:02:37'),
(7, '4897038373055', 'Brewed Coffee', 'Beverages', 'BCOFFEE', 50.00, 90, 'piece', 10, 'brewed%20coffee.jpg', '2024-09-02 21:06:51', NULL, NULL),
(8, '2145692640030', 'Iced Coffee', 'Beverages', 'ICOFFEE', 50.00, 66, 'piece', 10, 'iced%20coffee.jpg', '2024-09-02 21:07:40', NULL, NULL),
(9, '2145692640047', 'Kapetsoko', 'Beverages', 'KCHOCO', 60.00, 9, 'piece', 10, 'kapetsoko.jpg', '2024-09-02 21:08:21', NULL, NULL),
(10, '4897038373062', 'Hot Choco', 'Beverages', 'HCHOCO', 50.00, 103, 'piece', 12, 'hto%20choco.jpg', '2024-09-02 21:09:10', NULL, NULL),
(11, '4897038373079', 'Mineral Water (500ml)', 'Beverages', 'MWATER500', 25.00, 690, 'piece', 100, 'water%20500ml.jpg', '2024-09-02 21:10:02', NULL, NULL),
(12, '14512', 'Mineral Water (1000ml)', 'Beverages', 'MWTR1000', 50.00, 1000, 'piece', 12, 'water%201000ml.jpg', '2024-09-02 21:11:05', NULL, '2024-09-04 11:05:00'),
(13, '4897038373925', 'Yema', 'Deli', 'YEMA', 5.00, 893, 'piece', 100, 'yema.jpg', '2024-09-02 21:12:23', NULL, NULL),
(14, '489703837363', 'Niyog', 'Dairy', 'NIYOG', 10.00, 79, 'piece', 20, 'Coconut-Flakes.jpg', '2024-09-02 22:19:20', NULL, NULL),
(15, '3672819', 'Mashed Potato', 'Vegetables', 'MSP819', 65.00, 189, 'piece', 20, 'design1.png', '2024-10-05 10:44:47', NULL, '2024-10-21 07:16:25'),
(16, '4897038373758', 'Switch', 'Canned Goods', 'TST9982', 100.00, -9, 'piece', 20, '', '2024-10-14 13:46:46', NULL, '2024-10-14 14:07:41'),
(17, '4234567849840', 'Discounted Puto Bumbong', 'Baking', 'DPBUMBONG', 80.00, 98, 'piece', 12, 'putobumbong.jpg', '2024-11-04 23:00:08', NULL, NULL),
(18, '1234151', 'ice', 'Canned Goods', 'ice', 12.00, 10, 'piece', 6, '', '2024-11-04 23:39:30', NULL, '2024-11-04 23:39:45'),
(19, '45430982302111111', 'Blah Blah sample product', 'Canned Goods', '355532321', 20.00, 20, 'piece', 10, '', '2024-11-05 17:04:13', NULL, '2024-11-05 17:04:27'),
(20, '523425254235435', 'Blah Blah sample product', 'Canned Goods', '3453453', 400.00, 30, 'piece', 6, 'caiden_in_feathers_by_princessshay09_di0ck1t.jpg', '2024-11-05 23:13:24', NULL, '2024-11-05 23:13:42'),
(21, ' 4234567849758----aasdas', 'Discounted Bibingka', 'Baking', 'DBIBINGKA', -96.00, -40, 'piece', -20, 'bibingka%20(1).jpg', '2024-11-09 10:21:41', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `transaction_no` varchar(45) NOT NULL,
  `current_date` varchar(45) NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `amount_paid` decimal(8,2) NOT NULL,
  `change` decimal(8,2) NOT NULL,
  `cart` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_no`, `current_date`, `subtotal`, `amount_paid`, `change`, `cart`) VALUES
(39, '173073153821477499', '11/4/2024 10:45 PM', 120.00, 120.00, 0.00, '{\"cart\":[{\"barcode\":\"SBIBINGKA\",\"name\":\"Special Bibingka\",\"code\":\"SBIBINGKA\",\"price\":\"120.00\",\"image\":\"bibingka.jpg\",\"total\":120,\"qty\":1}]}'),
(40, '173073157984653628', '11/4/2024 10:46 PM', 100.00, 100.00, 0.00, '{\"cart\":[{\"barcode\":\"PBUMBONG\",\"name\":\"Puto Bumbong\",\"code\":\"PBUMBONG\",\"price\":\"100.00\",\"image\":\"putobumbong.jpg\",\"total\":100,\"qty\":1}]}'),
(41, '173073159910122892', '11/4/2024 11:07 PM', 180.00, 200.00, 20.00, '{\"cart\":[{\"barcode\":\"PBUMBONG\",\"name\":\"Puto Bumbong\",\"code\":\"PBUMBONG\",\"price\":\"100.00\",\"image\":\"putobumbong.jpg\",\"total\":100,\"qty\":1},{\"barcode\":\"DPBUMBONG\",\"name\":\"Discounted Puto Bumbong\",\"code\":\"DPBUMBONG\",\"price\":\"80.00\",\"image\":\"putobumbong.jpg\",\"total\":80,\"qty\":1}]}'),
(42, '17307635865536066', '11/5/2024 7:42 AM', 30.00, 50.00, 20.00, '{\"cart\":[{\"barcode\":\"13123\",\"name\":\"Niyog\",\"code\":\"NIYOG\",\"price\":\"10.00\",\"image\":\"Coconut-Flakes.jpg\",\"total\":30,\"qty\":\"3\"}]}'),
(43, '173076378875598592', '11/5/2024 7:50 AM', 10.00, 50.00, 40.00, '{\"cart\":[{\"barcode\":\"13123\",\"name\":\"Niyog\",\"code\":\"NIYOG\",\"price\":\"10.00\",\"image\":\"Coconut-Flakes.jpg\",\"total\":10,\"qty\":1}]}'),
(44, '173076792099720879', '11/5/2024 8:53 AM', 600.00, 600.00, 0.00, '{\"cart\":[{\"barcode\":\"ZERO\",\"name\":\"Coke zero (can)\",\"code\":\"ZERO\",\"price\":\"50.00\",\"image\":\"coke%20in%20can%20zero.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"MWATER500\",\"name\":\"Mineral Water (500ml)\",\"code\":\"MWATER500\",\"price\":\"25.00\",\"image\":\"water%20500ml.jpg\",\"total\":25,\"qty\":1},{\"barcode\":\"YEMA\",\"name\":\"Yema\",\"code\":\"YEMA\",\"price\":\"5.00\",\"image\":\"yema.jpg\",\"total\":5,\"qty\":1},{\"barcode\":\"NIYOG\",\"name\":\"Niyog\",\"code\":\"NIYOG\",\"price\":\"10.00\",\"image\":\"Coconut-Flakes.jpg\",\"total\":10,\"qty\":1},{\"barcode\":\"KCHOCO\",\"name\":\"Kapetsoko\",\"code\":\"KCHOCO\",\"price\":\"60.00\",\"image\":\"kapetsoko.jpg\",\"total\":60,\"qty\":1},{\"barcode\":\"ICOFFEE\",\"name\":\"Iced Coffee\",\"code\":\"ICOFFEE\",\"price\":\"50.00\",\"image\":\"iced%20coffee.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"HCHOCO\",\"name\":\"Hot Choco\",\"code\":\"HCHOCO\",\"price\":\"50.00\",\"image\":\"hto%20choco.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"BCOFFEE\",\"name\":\"Brewed Coffee\",\"code\":\"BCOFFEE\",\"price\":\"50.00\",\"image\":\"brewed%20coffee.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"DPBUMBONG\",\"name\":\"Discounted Puto Bumbong\",\"code\":\"DPBUMBONG\",\"price\":\"80.00\",\"image\":\"putobumbong.jpg\",\"total\":80,\"qty\":1},{\"barcode\":\"PBUMBONG\",\"name\":\"Puto Bumbong\",\"code\":\"PBUMBONG\",\"price\":\"100.00\",\"image\":\"putobumbong.jpg\",\"total\":100,\"qty\":1},{\"barcode\":\"SBIBINGKA\",\"name\":\"Special Bibingka\",\"code\":\"SBIBINGKA\",\"price\":\"120.00\",\"image\":\"bibingka.jpg\",\"total\":120,\"qty\":1}]}'),
(45, '173076812380740621', '11/5/2024 8:55 AM', 75.00, 100.00, 25.00, '{\"cart\":[{\"barcode\":\"MWATER500\",\"name\":\"Mineral Water (500ml)\",\"code\":\"MWATER500\",\"price\":\"25.00\",\"image\":\"water%20500ml.jpg\",\"total\":25,\"qty\":1},{\"barcode\":\"ZERO\",\"name\":\"Coke zero (can)\",\"code\":\"ZERO\",\"price\":\"50.00\",\"image\":\"coke%20in%20can%20zero.jpg\",\"total\":50,\"qty\":1}]}'),
(46, '173078300378966695', '11/5/2024 1:34 PM', 5.00, 20.00, 15.00, '{\"cart\":[{\"barcode\":\"341351\",\"name\":\"Yema\",\"code\":\"YEMA\",\"price\":\"5.00\",\"image\":\"yema.jpg\",\"total\":5,\"qty\":1}]}'),
(47, '173081181057685690', '11/5/2024 9:05 PM', 10.00, 20.00, 10.00, '{\"cart\":[{\"barcode\":\"13123\",\"name\":\"Niyog\",\"code\":\"NIYOG\",\"price\":\"10.00\",\"image\":\"Coconut-Flakes.jpg\",\"total\":10,\"qty\":1}]}'),
(48, '173107850641880283', '11/8/2024 11:08 PM', 120.00, 120.00, 0.00, '{\"cart\":[{\"barcode\":\"SBIBINGKA\",\"name\":\"Special Bibingka\",\"code\":\"SBIBINGKA\",\"price\":\"120.00\",\"image\":\"bibingka.jpg\",\"total\":120,\"qty\":1}]}'),
(49, '173107850641880283', '11/8/2024 11:08 PM', 120.00, 120.00, 0.00, '{\"cart\":[{\"barcode\":\"SBIBINGKA\",\"name\":\"Special Bibingka\",\"code\":\"SBIBINGKA\",\"price\":\"120.00\",\"image\":\"bibingka.jpg\",\"total\":120,\"qty\":1}]}'),
(50, '173107861704153519', '11/8/2024 11:10 PM', 160.00, 200.00, 40.00, '{\"cart\":[{\"barcode\":\"1212341\",\"name\":\"Discounted Puto Bumbong\",\"code\":\"DPBUMBONG\",\"price\":\"80.00\",\"image\":\"putobumbong.jpg\",\"total\":160,\"qty\":2}]}'),
(51, '173107882354863823', '11/8/2024 11:16 PM', 80.00, 100.00, 20.00, '{\"cart\":[{\"barcode\":\"DPBUMBONG\",\"name\":\"Discounted Puto Bumbong\",\"code\":\"DPBUMBONG\",\"price\":\"80.00\",\"image\":\"putobumbong.jpg\",\"total\":80,\"qty\":1}]}'),
(52, '173112743995240276', '11/9/2024 12:46 PM', 180.00, 200.00, 20.00, '{\"cart\":[{\"barcode\":\"4897038373055\",\"name\":\"Brewed Coffee\",\"code\":\"BCOFFEE\",\"price\":\"50.00\",\"image\":\"brewed%20coffee.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"4897038373062\",\"name\":\"Hot Choco\",\"code\":\"HCHOCO\",\"price\":\"50.00\",\"image\":\"hto%20choco.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"4234567849840\",\"name\":\"Discounted Puto Bumbong\",\"code\":\"DPBUMBONG\",\"price\":\"80.00\",\"image\":\"putobumbong.jpg\",\"total\":80,\"qty\":1}]}'),
(53, '173112792703028411', '11/9/2024 12:52 PM', 300.00, 500.00, 200.00, '{\"cart\":[{\"barcode\":\"489703837363\",\"name\":\"Niyog\",\"code\":\"NIYOG\",\"price\":\"10.00\",\"image\":\"Coconut-Flakes.jpg\",\"total\":10,\"qty\":1},{\"barcode\":\"4234567849840\",\"name\":\"Discounted Puto Bumbong\",\"code\":\"DPBUMBONG\",\"price\":\"80.00\",\"image\":\"putobumbong.jpg\",\"total\":80,\"qty\":1},{\"barcode\":\"2145692640023\",\"name\":\"Puto Bumbong\",\"code\":\"PBUMBONG\",\"price\":\"100.00\",\"image\":\"putobumbong.jpg\",\"total\":100,\"qty\":1},{\"barcode\":\"2145692640030\",\"name\":\"Iced Coffee\",\"code\":\"ICOFFEE\",\"price\":\"50.00\",\"image\":\"iced%20coffee.jpg\",\"total\":50,\"qty\":1},{\"barcode\":\"2145692640047\",\"name\":\"Kapetsoko\",\"code\":\"KCHOCO\",\"price\":\"60.00\",\"image\":\"kapetsoko.jpg\",\"total\":60,\"qty\":1}]}'),
(54, '173112827529463179', '11/9/2024 12:58 PM', 2400.00, 2500.00, 100.00, '{\"cart\":[{\"barcode\":\"SBIBINGKA\",\"name\":\"Special Bibingka\",\"code\":\"SBIBINGKA\",\"price\":\"120.00\",\"image\":\"bibingka.jpg\",\"total\":2400,\"qty\":\"20\"}]}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `metadata` longtext NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `type`, `metadata`, `created_at`, `updated_at`) VALUES
(1, 'admin', '0192023a7bbd73250516f069df18b500', 'admin', '{}', '2023-01-15 00:14:37', NULL),
(2, 'emp0000001', '482c811da5d5b4bc6d497ffa98491e38', 'emp', '{}', '2023-01-15 00:14:37', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
