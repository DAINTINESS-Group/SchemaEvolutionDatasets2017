-- phpMyAdmin SQL Dump
-- version 4.2.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 10, 2014 at 02:23 PM
-- Server version: 5.5.39-MariaDB
-- PHP Version: 5.5.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(72) NOT NULL,
  `slug` varchar(32) DEFAULT NULL,
  `numberPosts` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `numberPosts`) VALUES
(1, 'Phalcon php', 'phalcon-php', 5),
(2, 'Code', 'code', 1),
(3, 'Tutorial', 'tutorial', 1000),
(4, 'Firefox', 'firefox', 20),
(5, 'Security', 'security', 12),
(6, 'New', 'new', 12),
(7, 'Tips', 'tip', 11),
(8, 'Review', 'review', 11),
(9, 'Video', 'video', 32);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(70) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(70) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `comments` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `comments`, `created_at`) VALUES
(1, 'fc', 'fcduythien@gmail.com', 'cccccccccc', '2013-11-19 23:58:10'),
(2, 'fc', 'fcduythien@gmail.com', 'sdfd', '2013-11-19 23:59:39');

-- --------------------------------------------------------

--
-- Table structure for table `email_confirmations`
--

CREATE TABLE IF NOT EXISTS `email_confirmations` (
`id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `code` char(32) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `confirmed` char(1) DEFAULT 'N'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `email_confirmations`
--

INSERT INTO `email_confirmations` (`id`, `usersId`, `code`, `createdAt`, `modifiedAt`, `confirmed`) VALUES
(3, 61, '6HeqIwOy7hcACFRPeEK7SgT9N2SMmPG5', 1388720270, NULL, 'N');

-- --------------------------------------------------------

--
-- Table structure for table `failed_logins`
--

CREATE TABLE IF NOT EXISTS `failed_logins` (
`id` int(11) unsigned NOT NULL,
  `usersId` int(10) unsigned DEFAULT NULL,
  `ipAddress` char(15) NOT NULL,
  `attempted` int(11) unsigned NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

--
-- Dumping data for table `failed_logins`
--

INSERT INTO `failed_logins` (`id`, `usersId`, `ipAddress`, `attempted`) VALUES
(1, 2, '::1', 1366995290),
(2, 2, '::1', 1366995304),
(3, 2, '::1', 1366995309),
(4, 0, '::1', 1366995331),
(5, 2, '::1', 1366995342),
(6, 14, '::1', 1366995687),
(7, 14, '::1', 1366995825),
(8, 14, '::1', 1366996310),
(9, 2, '::1', 1366996324),
(10, 2, '127.0.0.1', 1367000208),
(11, 14, '127.0.0.1', 1367012708),
(12, 2, '::1', 1367014700),
(13, 14, '::1', 1367014714),
(14, 14, '::1', 1367014724),
(15, 14, '::1', 1367014830),
(16, 14, '::1', 1367014843),
(17, 2, '::1', 1367014916),
(18, 2, '::1', 1367014926),
(19, 2, '::1', 1367015303),
(20, 14, '::1', 1367015786),
(21, 2, '127.0.0.1', 1367099996),
(22, 0, '127.0.0.1', 1380900593),
(23, 1, '127.0.0.1', 1380909311),
(24, 0, '127.0.0.1', 1381119065),
(25, 0, '127.0.0.1', 1381119073),
(26, 2, '127.0.0.1', 1381215566),
(27, 2, '127.0.0.1', 1381242211),
(28, 0, '127.0.0.1', 1381464997),
(29, 0, '127.0.0.1', 1381465005),
(30, 0, '127.0.0.1', 1381465020),
(31, 0, '127.0.0.1', 1381466598),
(32, 1, '127.0.0.1', 1381480185),
(33, 2, '127.0.0.1', 1381480307),
(34, 2, '127.0.0.1', 1381480319),
(35, 1, '127.0.0.1', 1381480656),
(36, 2, '127.0.0.1', 1381482232),
(37, 1, '127.0.0.1', 1381484997),
(38, 1, '127.0.0.1', 1381502665),
(39, 0, '127.0.0.1', 1381506277),
(40, 0, '127.0.0.1', 1381506288),
(41, 2, '127.0.0.1', 1381626673),
(42, 2, '127.0.0.1', 1381626685),
(43, 1, '127.0.0.1', 1381676620),
(44, 0, '127.0.0.1', 1382325790),
(45, 0, '127.0.0.1', 1384420961),
(46, 6, '127.0.0.1', 1384440292),
(47, 6, '127.0.0.1', 1384535898),
(48, 6, '127.0.0.1', 1384535904),
(49, 4, '127.0.0.1', 1384537197),
(50, 4, '127.0.0.1', 1384537199),
(51, 4, '127.0.0.1', 1384537204),
(52, 0, '127.0.0.1', 1384572122),
(53, 4, '127.0.0.1', 1384669686),
(54, 0, '127.0.0.1', 1386205216),
(55, 4, '127.0.0.1', 1386205222),
(56, 0, '127.0.0.1', 1387740305),
(57, 0, '127.0.0.1', 1391609211),
(58, 0, '127.0.0.1', 1391609232),
(59, 62, '127.0.0.1', 1391609615),
(60, 62, '127.0.0.1', 1391609629),
(61, 0, '127.0.0.1', 1391609867),
(62, 64, '127.0.0.1', 1391609948);

-- --------------------------------------------------------

--
-- Table structure for table `file_store`
--

CREATE TABLE IF NOT EXISTS `file_store` (
`id` int(10) NOT NULL,
  `fileName` varchar(200) NOT NULL,
  `fileCaption` varchar(200) NOT NULL,
  `mimeType` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `fileData` mediumblob,
  `categoriesId` int(10) NOT NULL,
  `userId` int(10) NOT NULL,
  `created` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `password_changes`
--

CREATE TABLE IF NOT EXISTS `password_changes` (
`id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `password_changes`
--

INSERT INTO `password_changes` (`id`, `usersId`, `ipAddress`, `userAgent`, `createdAt`) VALUES
(1, 2, '::1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 ', 1367014804),
(2, 2, '::1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 ', 1367014986),
(3, 15, '::1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 ', 1367505457),
(4, 2, '::1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 ', 1367511911);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
`id` int(10) unsigned NOT NULL,
  `profilesId` int(10) unsigned NOT NULL,
  `resource` varchar(16) NOT NULL,
  `action` varchar(16) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT=' users access resource' AUTO_INCREMENT=389 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `profilesId`, `resource`, `action`) VALUES
(90, 3, 'users', 'index'),
(91, 3, 'users', 'search'),
(92, 3, 'profiles', 'index'),
(93, 3, 'profiles', 'search'),
(117, 2, 'users', 'index'),
(118, 2, 'users', 'search'),
(119, 2, 'users', 'edit'),
(120, 2, 'users', 'create'),
(121, 2, 'profiles', 'index'),
(122, 2, 'profiles', 'search'),
(162, 8, 'users', 'index'),
(163, 8, 'users', 'search'),
(164, 8, 'users', 'edit'),
(165, 8, 'users', 'create'),
(166, 8, 'users', 'delete'),
(167, 8, 'users', 'changePassword'),
(168, 8, 'users', 'deleteMuti'),
(169, 8, 'profiles', 'index'),
(170, 8, 'profiles', 'search'),
(171, 8, 'profiles', 'edit'),
(172, 8, 'profiles', 'create'),
(173, 8, 'profiles', 'delete'),
(174, 8, 'permissions', 'index'),
(210, 4, 'users', 'index'),
(211, 4, 'users', 'search'),
(212, 4, 'users', 'edit'),
(213, 4, 'users', 'create'),
(214, 4, 'users', 'delete'),
(215, 4, 'users', 'changePassword'),
(216, 4, 'users', 'deleteMuti'),
(218, 4, 'profiles', 'index'),
(219, 4, 'profiles', 'search'),
(220, 4, 'profiles', 'edit'),
(221, 4, 'profiles', 'create'),
(222, 4, 'profiles', 'delete'),
(223, 4, 'permissions', 'index'),
(361, 1, 'users', 'index'),
(362, 1, 'users', 'search'),
(363, 1, 'users', 'edit'),
(364, 1, 'users', 'create'),
(365, 1, 'users', 'delete'),
(366, 1, 'users', 'changePassword'),
(367, 1, 'users', 'deleteMuti'),
(368, 1, 'profiles', 'index'),
(369, 1, 'profiles', 'search'),
(370, 1, 'profiles', 'edit'),
(371, 1, 'profiles', 'create'),
(372, 1, 'profiles', 'delete'),
(373, 1, 'permissions', 'index'),
(374, 1, 'posts', 'index'),
(375, 1, 'posts', 'search'),
(376, 1, 'posts', 'create'),
(377, 1, 'posts', 'edit'),
(378, 1, 'posts', 'delete'),
(379, 1, 'categories', 'index'),
(380, 1, 'categories', 'search'),
(381, 1, 'categories', 'create'),
(382, 1, 'categories', 'edit'),
(383, 1, 'categories', 'delete'),
(384, 1, 'filestore', 'index'),
(385, 1, 'filestore', 'search'),
(386, 1, 'filestore', 'create'),
(387, 1, 'filestore', 'edit'),
(388, 1, 'filestore', 'delete');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
`id` int(10) NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `categoriesId` varchar(50) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `tags` varchar(50) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  `numberViews` int(20) NOT NULL,
  `userId` int(25) NOT NULL COMMENT 'user post article'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `categoriesId`, `slug`, `tags`, `created`, `numberViews`, `userId`) VALUES
(9, 'Huong dan cai dat phalcon tren windown', '<p>Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\r\n\r\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\r\n\r\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.</p>\r\n\r\n<pre><code><?php echo ?>\r\n</code></pre>\r\n', '1', 'huong-dan-cai-dat-phalcon-tren-windown', 'aa', 1391758768, 1, 4),
(11, 'Huong dan cai dat phalcon tren windown', '<p>Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\n\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\n\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.</p>\n\n<p><img src="https://dl.dropboxusercontent.com/u/109046499/sendmail/0.png" alt="enter image description here" /></p>\n\n<pre><code><?php echo ?>\n</code></pre>\n', '1', 'huong-dan-cai-dat-phalcon-tren-windown', 'aa', 1393515407, 1, 2),
(13, 'Huong dan cai dat phalcon tren windown', '<p>Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\r\n\r\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\r\n\r\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.</p>\r\n\r\n<pre><code><?php echo ?>\r\n</code></pre>\r\n', '1', 'huong-dan-cai-dat-phalcon-tren-windown', 'aa', 1391759167, 1, 2),
(14, 'Huong dan cai dat phalcon tren windown', '<p>Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\r\n\r\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.Today’s PHP applications must balance a number of concerns including stability, performance and functionality. Every PHP application is based on a set of common components that are also base for most of the application.</p>\r\n\r\n<p>These common components are libraries/frameworks or a combination of them. Once installed, frameworks rarely change, being the foundation of the application they must be highly functional and also very fast.</p>\r\n\r\n<pre><code><?php echo ?>\r\n</code></pre>\r\n', '1', 'huong-dan-cai-dat-phalcon-tren-windown', 'aa', 1391759041, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `posts_views`
--

CREATE TABLE IF NOT EXISTS `posts_views` (
`id` int(10) unsigned NOT NULL,
  `postsId` int(10) unsigned NOT NULL,
  `ipaddress` varchar(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `posts_views`
--

INSERT INTO `posts_views` (`id`, `postsId`, `ipaddress`) VALUES
(26, 1, '127.0.0.1'),
(27, 2, '127.0.0.1'),
(24, 4, '127.0.0.1'),
(25, 5, '127.0.0.1'),
(29, 6, '127.0.0.1'),
(28, 8, '127.0.0.1'),
(30, 9, '127.0.0.1'),
(33, 11, '127.0.0.1'),
(32, 13, '127.0.0.1'),
(31, 14, '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE IF NOT EXISTS `profiles` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `active` char(1) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='defined permision' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `name`, `active`) VALUES
(1, 'Administrators', 'Y'),
(2, 'Users', 'Y'),
(3, 'Read-Only', 'Y'),
(4, 'UsersOrder', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `remember_tokens`
--

CREATE TABLE IF NOT EXISTS `remember_tokens` (
`id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `token` char(32) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `remember_tokens`
--

INSERT INTO `remember_tokens` (`id`, `usersId`, `token`, `userAgent`, `createdAt`) VALUES
(13, 4, '5d7fb1ba2548c436f6e027510ac97a5f', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 1382585381),
(14, 4, '5d7fb1ba2548c436f6e027510ac97a5f', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 1382585407),
(15, 4, '5d7fb1ba2548c436f6e027510ac97a5f', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 1382690968),
(16, 4, '5d7fb1ba2548c436f6e027510ac97a5f', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 1382889248),
(17, 4, '5d7fb1ba2548c436f6e027510ac97a5f', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 1382952171),
(18, 4, '5d7fb1ba2548c436f6e027510ac97a5f', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 1383272218),
(19, 4, '67003aee13f6b78a1214022540cb07e2', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384157621),
(20, 6, '7d82c314f74f854ead29da0d543f6e16', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384420934),
(21, 6, '7d82c314f74f854ead29da0d543f6e16', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384440470),
(22, 6, '7d82c314f74f854ead29da0d543f6e16', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384440472),
(23, 6, '7d82c314f74f854ead29da0d543f6e16', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384440529),
(24, 6, '7d82c314f74f854ead29da0d543f6e16', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384440553),
(25, 4, '6f3c92440758fca43897fe286a45edcc', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384505645),
(26, 4, '6f3c92440758fca43897fe286a45edcc', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384505906),
(27, 6, '7d2db41b922f78b150006b0dd06057db', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384854557),
(28, 6, '7d2db41b922f78b150006b0dd06057db', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384880415),
(29, 6, '7d2db41b922f78b150006b0dd06057db', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1384880466),
(30, 4, '67003aee13f6b78a1214022540cb07e2', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:25.0) Gecko/20100101 Firefox/25.0', 1385201646),
(31, 4, 'b180674492acbc02e02e338b95923623', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0 FirePHP/0.7.4', 1386685971),
(32, 4, '3b18a419d426050ed53ead4b1c45941e', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:29.0) Gecko/20100101 Firefox/29.0', 1391636590),
(33, 4, '45d84a0996c7019f172157d70e38dd16', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gecko/20100101 Firefox/30.0', 1393517016);

-- --------------------------------------------------------

--
-- Table structure for table `reset_passwords`
--

CREATE TABLE IF NOT EXISTS `reset_passwords` (
`id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `code` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `reset` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `success_logins`
--

CREATE TABLE IF NOT EXISTS `success_logins` (
`id` int(11) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(10) unsigned NOT NULL,
  `username` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` char(60) NOT NULL,
  `mustChangePassword` char(1) DEFAULT NULL,
  `profilesId` int(10) unsigned NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `banned` char(1) NOT NULL,
  `suspended` char(1) NOT NULL,
  `active` char(1) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=65 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `mustChangePassword`, `profilesId`, `fullName`, `banned`, `suspended`, `active`) VALUES
(2, 'pdt', 'pdt@gmal.com', '$2a$08$X0DBRJdOTtY9KzC0P6nnk.ni4QYHQxJrhilBs3wABv97E69wDi4Ve', 'Y', 2, '', 'N', 'N', 'Y'),
(4, 'admin', 'admin@gmail.com', '$2a$08$X0DBRJdOTtY9KzC0P6nnk.ni4QYHQxJrhilBs3wABv97E69wDi4Ve', 'N', 1, '', 'N', 'N', 'Y'),
(54, 'aaaaaa', 'aaaaaaaaaa@gmail.com', '$2a$08$7Baj9TFCqDFqR9pSUS2dyuEIEoKJ130Cq7cjK5e/gwtEY9PVtB.RC', 'N', 2, 'ssssss', 'N', 'N', 'N'),
(63, 'duythien', 'fcduythien@gmail.com', '$2a$08$K7s9Xp3CFnNODcGP7MsXdebp5HPYI9wBqZagz.c18RtSwdTbAYN2i', 'N', 1, 'Tran', 'N', 'N', 'Y'),
(64, '0813118', '0813118@gmail.com', '$2a$08$bcpSOkX8ZzxjzsNeWYRK3OF0/qIu0W9S5Xeziqeqd85pMw0uMobGG', 'N', 1, 'TRan', 'N', 'N', 'Y');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
 ADD PRIMARY KEY (`id`), ADD KEY `number_posts` (`numberPosts`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_confirmations`
--
ALTER TABLE `email_confirmations`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_logins`
--
ALTER TABLE `failed_logins`
 ADD PRIMARY KEY (`id`), ADD KEY `usersId` (`usersId`);

--
-- Indexes for table `file_store`
--
ALTER TABLE `file_store`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_changes`
--
ALTER TABLE `password_changes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
 ADD PRIMARY KEY (`id`), ADD KEY `usersId` (`profilesId`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
 ADD PRIMARY KEY (`id`), ADD KEY `userPost` (`userId`);

--
-- Indexes for table `posts_views`
--
ALTER TABLE `posts_views`
 ADD PRIMARY KEY (`id`), ADD KEY `posts_id` (`postsId`,`ipaddress`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
 ADD PRIMARY KEY (`id`), ADD KEY `active` (`active`);

--
-- Indexes for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
 ADD PRIMARY KEY (`id`), ADD KEY `token` (`token`);

--
-- Indexes for table `reset_passwords`
--
ALTER TABLE `reset_passwords`
 ADD PRIMARY KEY (`id`), ADD KEY `usersId` (`usersId`);

--
-- Indexes for table `success_logins`
--
ALTER TABLE `success_logins`
 ADD PRIMARY KEY (`id`), ADD KEY `usersId` (`usersId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD KEY `profilesId` (`profilesId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `email_confirmations`
--
ALTER TABLE `email_confirmations`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `failed_logins`
--
ALTER TABLE `failed_logins`
MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `file_store`
--
ALTER TABLE `file_store`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `password_changes`
--
ALTER TABLE `password_changes`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=389;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `posts_views`
--
ALTER TABLE `posts_views`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `reset_passwords`
--
ALTER TABLE `reset_passwords`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `success_logins`
--
ALTER TABLE `success_logins`
MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=65;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
