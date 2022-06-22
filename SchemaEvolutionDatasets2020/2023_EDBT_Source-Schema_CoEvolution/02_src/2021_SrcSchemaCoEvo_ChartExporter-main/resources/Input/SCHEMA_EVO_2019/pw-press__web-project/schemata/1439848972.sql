-- Adminer 4.2.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `web_project`;
CREATE DATABASE `web_project` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `web_project`;

DROP TABLE IF EXISTS `bootstraps`;
CREATE TABLE `bootstraps` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(6) NOT NULL DEFAULT 'noname',
  `gray_base` varchar(7) NOT NULL DEFAULT '#000000',
  `brand_primary` varchar(7) NOT NULL DEFAULT '#428bca',
  `brand_success` varchar(7) NOT NULL DEFAULT '#5cb85c',
  `brand_info` varchar(7) NOT NULL DEFAULT '#5bc0de',
  `brand_warning` varchar(7) NOT NULL DEFAULT '#f0ad4e',
  `brand_danger` varchar(7) NOT NULL DEFAULT '#d9534f',
  `body_bg` varchar(7) NOT NULL DEFAULT '#ffffff',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `bootstraps` (`id`, `active`, `name`, `gray_base`, `brand_primary`, `brand_success`, `brand_info`, `brand_warning`, `brand_danger`, `body_bg`) VALUES
(1,	1,	'noname',	'#2f55be',	'#cf276e',	'#5cb85c',	'#5bc0de',	'#f0ad4e',	'#d9534f',	'#030d81'),
(2,	0,	'noname',	'#e700d8',	'#1aff00',	'#5cb85c',	'#5bc0de',	'#f0ad4e',	'#d9534f',	'#ffffff'),
(3,	0,	'noname',	'#000000',	'#ff0000',	'#007b02',	'#a09b00',	'#9ccc00',	'#d40000',	'#ffffff'),
(4,	0,	'noname',	'#043d00',	'#d108a6',	'#5cb85c',	'#5bc0de',	'#f0ad4e',	'#d9534f',	'#ffffff'),
(5,	0,	'noname',	'#000000',	'#000000',	'#5cb85c',	'#5bc0de',	'#f0ad4e',	'#d9534f',	'#ffffff');

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(11) unsigned NOT NULL,
  `title` varchar(80) NOT NULL,
  `origin` varchar(80) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  CONSTRAINT `images_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `obligations`;
CREATE TABLE `obligations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title_cs` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `body_cs` text NOT NULL,
  `body_en` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(5) NOT NULL,
  `title` text NOT NULL,
  `slug` text NOT NULL,
  `body` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`),
  UNIQUE KEY `slug` (`slug`(255)),
  UNIQUE KEY `title` (`title`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `posts_tags`;
CREATE TABLE `posts_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_id_post_id` (`tag_id`,`post_id`),
  KEY `tag_id` (`tag_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `posts_tags_ibfk_3` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `posts_tags_ibfk_4` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `roles` (`id`, `role`) VALUES
(1,	'guest'),
(2,	'registered'),
(3,	'subscriber'),
(4,	'contributor'),
(5,	'author'),
(6,	'editor'),
(7,	'administrator'),
(8,	'superadministrator');

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `color` varchar(6) NOT NULL,
  `active` bit(1) NOT NULL,
  `nav1` bit(1) NOT NULL,
  `nav2` bit(1) NOT NULL,
  `nav3` bit(1) NOT NULL,
  `nav4` bit(1) NOT NULL,
  `align` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `roles_id` int(3) unsigned NOT NULL DEFAULT '1',
  `sorting_tags` varchar(20) NOT NULL DEFAULT 'title ASC',
  `sorting_posts` varchar(20) NOT NULL DEFAULT 'title ASC',
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `registered` datetime NOT NULL,
  `last_logged` datetime NOT NULL,
  `last_logged_ip` varchar(39) NOT NULL,
  `last_logged_dns` varchar(255) NOT NULL,
  `token_created` datetime NOT NULL,
  `token_temporary` varchar(100) NOT NULL,
  `token_request_from_dns` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `roles_id` (`roles_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `username`, `password`, `roles_id`, `sorting_tags`, `sorting_posts`, `fullname`, `email`, `registered`, `last_logged`, `last_logged_ip`, `last_logged_dns`, `token_created`, `token_temporary`, `token_request_from_dns`) VALUES
(5,	'kathy',	'$2y$10$GXkWfxYHnI1.cVmduvPIzeql.oHPx25b6jx48DzwJChaIIK71U4Fy',	7,	'title ASC',	'title ASC',	'Kathy',	'info@polakweb.com',	'2015-08-17 23:48:51',	'0000-00-00 00:00:00',	'0',	'',	'2015-08-17 23:48:51',	'umkowt6i2daa1ggu7af6bx8so7eaf8pb955c2uxm71r05kiqud97baw4cibbarf0qy03pmvugkek',	'');

-- 2015-08-17 21:56:27