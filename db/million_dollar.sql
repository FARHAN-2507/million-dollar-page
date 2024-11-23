-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2024 at 02:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `million_dollar`
--

-- --------------------------------------------------------

--
-- Table structure for table `pixels`
--

CREATE TABLE `pixels` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `owner_name` varchar(255) NOT NULL,
  `image_url` text NOT NULL,
  `target_url` text NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pixels`
--

INSERT INTO `pixels` (`id`, `x`, `y`, `owner_name`, `image_url`, `target_url`, `alt_text`, `created_at`) VALUES
(4, 0, 0, 'FARHAN ', 'https://images.news18.com/ibnlive/uploads/2021/08/1628155334_farhan-akhtar.jpg', 'https://www.masala.com/entertainment/farhan-akhtar-marvel', 'FARHAN AKTHAR', '2024-11-22 20:00:40'),
(5, 0, 0, 'FARHAN ', 'https://images.news18.com/ibnlive/uploads/2021/08/1628155334_farhan-akhtar.jpg', 'https://www.masala.com/entertainment/farhan-akhtar-marvel', 'FARHAN AKTHAR', '2024-11-22 20:00:56'),
(6, 0, 0, 'FARHAN ', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Flyricsily.com%2Fwp-content%2Fuploads%2F2020%2F05%2FFarhan-akhtar.jpeg&f=1&nofb=1&ipt=0e91d875f79d17d7cc53b901d6b51da6c8bb7131d4b09e2ac07d86e60290e52b&ipo=images', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Flyricsily.com%2Fwp-content%2Fuploads%2F2020%2F05%2FFarhan-akhtar.jpeg&f=1&nofb=1&ipt=0e91d875f79d17d7cc53b901d6b51da6c8bb7131d4b09e2ac07d86e60290e52b&ipo=images', 'FARHAN AKTHAR', '2024-11-23 12:38:05'),
(7, 1, 0, 'printest', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpngimg.com%2Fuploads%2Fpinterest%2Fpinterest_PNG63.png&f=1&nofb=1&ipt=df538a1f05b64e6026339abd574f42d44af2b4290407dc391cec7eb092d2996f&ipo=images', 'https://www.pinterest.com/', 'PRINTEST', '2024-11-23 12:52:13'),
(8, 23, 10, 'instagram', 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ffreelogopng.com%2Fimages%2Fall_img%2F1658586823instagram-logo-transparent.png&f=1&nofb=1&ipt=20aaca611f08fc449c011ec171259adadb81ad1ab8948bab746307efa4f0c20a&ipo=images', 'https://www.instagram.com/', 'instagram', '2024-11-23 13:17:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pixels`
--
ALTER TABLE `pixels`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pixels`
--
ALTER TABLE `pixels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
