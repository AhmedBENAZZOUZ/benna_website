-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 10, 2023 at 11:06 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `benna`
--
CREATE DATABASE IF NOT EXISTS `benna` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `benna`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `password`) VALUES
(1, 'admin', 'admin@admin.com', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `rating` int NOT NULL,
  `user_id` int NOT NULL,
  `recipe_id` int NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `recipe_id` (`recipe_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `content`, `rating`, `user_id`, `recipe_id`, `created`) VALUES
(1, 'Tres belle', 0, 1, 2, '2023-05-10 09:45:34'),
(2, 'ezae', 0, 1, 3, '2023-05-10 10:12:36');

-- --------------------------------------------------------

--
-- Table structure for table `deleteduser`
--

DROP TABLE IF EXISTS `deleteduser`;
CREATE TABLE IF NOT EXISTS `deleteduser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `deltime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `feedbackdata` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `sender`, `title`, `feedbackdata`) VALUES
(1, 'bachbech', 'aeer', 'nannieraymond@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Triggers `ingredient`
--
DROP TRIGGER IF EXISTS `name_ing_maj`;
DELIMITER $$
CREATE TRIGGER `name_ing_maj` BEFORE INSERT ON `ingredient` FOR EACH ROW SET NEW.name = UPPER(NEW.name)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `recette`
--

DROP TABLE IF EXISTS `recette`;
CREATE TABLE IF NOT EXISTS `recette` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `prep_time` varchar(20) NOT NULL,
  `nb_people` varchar(20) NOT NULL,
  `difficulty` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `ingredient` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `instructions` varchar(255) NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `recette`
--

INSERT INTO `recette` (`id`, `name`, `prep_time`, `nb_people`, `difficulty`, `type`, `ingredient`, `instructions`, `image`, `video`, `created`, `user_id`) VALUES
(1, 'TEST', 'Test', 'Test', 'Test', 'Test', 'Test', 'Test', 'salade_tortellini.jpg', '', '2023-05-10 02:23:39', 1),
(2, 'SPAGHETTI', '1h', '4', 'facile', 'froid', '500g spaghetti', 'First, cook the tortellini according to the package directions. Then drain well and cool in a very large bowl in the fridge. While the tortellini is cooking, slice the summer squash and the zucchini into 1/4-inch rounds and then quarter the rounds. Add th', 'salade_tortellini.jpg', '', '2023-05-10 09:45:09', 1),
(3, 'MAKROUNA', '30min', '10', 'facile', 'diabetique', 'hard', 'hard', 'troll_dog1.jpg', '', '2023-05-10 10:01:38', 1),
(4, 'TEST', 'test', 'test', 'test', 'Salty Dish', 'test', 'test', 'Tita.jpg', '', '2023-05-10 10:37:54', 3);

--
-- Triggers `recette`
--
DROP TRIGGER IF EXISTS `name_recette_maj`;
DELIMITER $$
CREATE TRIGGER `name_recette_maj` BEFORE INSERT ON `recette` FOR EACH ROW SET NEW.name = UPPER(NEW.name)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `name_recette_maj_sugg`;
DELIMITER $$
CREATE TRIGGER `name_recette_maj_sugg` BEFORE INSERT ON `recette` FOR EACH ROW SET NEW.name = UPPER(NEW.name)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `recette_ingredient`
--

DROP TABLE IF EXISTS `recette_ingredient`;
CREATE TABLE IF NOT EXISTS `recette_ingredient` (
  `recette_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`recette_id`,`ingredient_id`),
  KEY `FK_ingredient_id` (`ingredient_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `recette_suggestions`
--

DROP TABLE IF EXISTS `recette_suggestions`;
CREATE TABLE IF NOT EXISTS `recette_suggestions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `prep_time` varchar(20) NOT NULL,
  `nb_people` varchar(20) NOT NULL,
  `difficulty` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `ingredient` varchar(255) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `video` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `recette_suggestions`
--

INSERT INTO `recette_suggestions` (`id`, `name`, `prep_time`, `nb_people`, `difficulty`, `type`, `ingredient`, `instructions`, `image`, `video`, `created`, `user_id`) VALUES
(1, 'Test', 'Test', 'Test', 'facile', 'froid', 'Test', 'Test', 'salade_tortellini.jpg', NULL, '2023-05-10 02:23:07', 1),
(2, 'Spaghetti', '1h', '4', 'facile', 'froid', '500g spaghetti', 'First, cook the tortellini according to the package directions. Then drain well and cool in a very large bowl in the fridge. While the tortellini is cooking, slice the summer squash and the zucchini into 1/4-inch rounds and then quarter the rounds. Add th', 'salade_tortellini.jpg', NULL, '2023-05-10 09:44:12', 1),
(3, 'makrouna', '30min', '10', 'facile', 'diabetique', 'hard', 'hard', 'troll_dog1.jpg', NULL, '2023-05-10 10:00:59', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(8) NOT NULL,
  `adress` varchar(50) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `phone`, `adress`, `password`, `image`, `created_at`) VALUES
(1, 'nraymond', 'NANNIE RAYMOND', 'nannieraymond@gmail.com', '26359687', 'Grand Tunis', 'cc8c0a97c2dfcd73caff160b65aa39e2', 'admin4.jpg', '2023-05-10 00:57:50'),
(2, 'awells', 'ASHLEY WELLS', 'ashleywells@gmail.com', '45869512', 'Grand Tuni', 'cc8c0a97c2dfcd73caff160b65aa39e2', 'default.png', '2023-05-10 00:58:49'),
(3, 'mmason', 'MIKEY MASON', 'mikeymason@gmail.com', '24158695', 'Grand Tunis', 'cc8c0a97c2dfcd73caff160b65aa39e2', 'friend-avatar9.jpg', '2023-05-10 00:59:37'),
(4, 'aterry', 'ALEXANDRE TERRY', 'alexandreterry@gmail.com', '65958675', 'Grand Tunis', 'cc8c0a97c2dfcd73caff160b65aa39e2', 'friend-avatar3.jpg', '2023-05-10 01:01:31');

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `name_user_maj`;
DELIMITER $$
CREATE TRIGGER `name_user_maj` BEFORE INSERT ON `users` FOR EACH ROW SET NEW.name = UPPER(NEW.name)
$$
DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
