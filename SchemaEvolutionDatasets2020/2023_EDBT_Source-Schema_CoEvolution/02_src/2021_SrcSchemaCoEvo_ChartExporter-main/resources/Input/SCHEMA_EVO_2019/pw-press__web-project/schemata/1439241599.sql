-- Adminer 4.2.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

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

INSERT INTO `images` (`id`, `users_id`, `title`, `origin`, `created_at`) VALUES
(1,	1,	'cookie-tiger.jpg',	'noSet',	'2015-02-19 20:44:08'),
(2,	1,	'fotolia-39971034-m.jpg',	'noSet',	'2015-02-19 20:44:35'),
(3,	1,	'fotolia-48181289-m.jpg',	'noSet',	'2015-02-19 20:49:31'),
(4,	1,	'fotolia-39971034-m.jpg',	'noSet',	'2015-02-20 10:13:27'),
(5,	1,	'fotolia-39971034-m.jpg',	'noSet',	'2015-02-20 10:14:27'),
(6,	1,	'vyber-001.png',	'noSet',	'2015-02-20 10:17:10'),
(7,	1,	'cena-hejtmana2.misto-zzs-pk.jpg',	'noSet',	'2015-03-30 13:08:23'),
(8,	1,	'fotolia-56050305-m.jpg',	'noSet',	'2015-04-09 01:41:14');

DROP TABLE IF EXISTS `localization`;
CREATE TABLE `localization` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `text_id` int(1) unsigned NOT NULL,
  `lang` char(2) NOT NULL,
  `variant` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `translation` varchar(255) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text_id` (`text_id`,`lang`,`variant`),
  CONSTRAINT `x` FOREIGN KEY (`text_id`) REFERENCES `localization_text` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='text translations';

INSERT INTO `localization` (`id`, `text_id`, `lang`, `variant`, `translation`, `ts`) VALUES
(1,	1,	'cs',	0,	'Ahoj, Sali!',	'2014-08-11 16:02:36'),
(2,	2,	'cs',	0,	'Úspěšně jste vytvořili',	'2014-07-12 19:50:12'),
(3,	3,	'cs',	0,	'Přihlásit',	'2014-07-12 19:53:47'),
(4,	4,	'cs',	0,	'Odhlásit',	'2014-07-12 19:53:55'),
(5,	5,	'cs',	0,	'Uživatelské jméno:',	'2014-07-12 19:58:26'),
(6,	6,	'cs',	0,	'Vložte prosím uživatelské jméno.',	'2014-07-12 19:59:08'),
(7,	7,	'cs',	0,	'Heslo:',	'2014-07-12 19:59:16'),
(8,	8,	'cs',	0,	'Vložte prosím vaše heslo.',	'2014-07-12 19:59:43'),
(9,	9,	'cs',	0,	'Pamatovat přihlášení',	'2014-07-12 20:00:06'),
(10,	10,	'cs',	0,	'Jazyk',	'2014-07-13 16:24:49'),
(11,	11,	'cs',	0,	'čeština',	'2014-07-13 16:25:07'),
(12,	12,	'cs',	0,	'angličtina',	'2014-07-13 16:25:14'),
(13,	13,	'cs',	0,	'Registrovat',	'2014-07-13 16:39:14'),
(14,	14,	'cs',	0,	'Kontakt',	'2014-07-13 22:18:13'),
(15,	15,	'cs',	0,	'Úvod',	'2014-07-13 22:18:27'),
(16,	16,	'cs',	0,	'Napište nám',	'2014-07-13 22:26:09'),
(17,	17,	'cs',	0,	'Celé jméno',	'2014-07-13 22:55:11'),
(18,	18,	'cs',	0,	'Nahrát obrázek',	'2014-07-15 14:14:36'),
(19,	19,	'cs',	0,	'Registrovat',	'2014-07-15 14:15:41'),
(20,	20,	'cs',	0,	'Potvrďte heslo:',	'2014-07-15 14:16:08'),
(21,	21,	'cs',	0,	'Zkontrolujte prosím odlišná hesla.',	'2014-07-15 14:17:43'),
(22,	22,	'cs',	0,	'Fotografie',	'2014-08-07 16:31:35'),
(23,	23,	'cs',	0,	'Přihlásit',	'2014-08-07 16:41:55'),
(24,	24,	'cs',	0,	'Zapomněl(a) jste své heslo?',	'2014-08-07 16:49:28'),
(25,	25,	'cs',	0,	'Obnova uživatelského hesla',	'2014-08-07 16:54:00'),
(26,	26,	'cs',	0,	'Váš registrační email:',	'2014-08-07 16:54:57'),
(27,	27,	'cs',	0,	'Odeslat',	'2014-08-07 16:55:06'),
(28,	28,	'cs',	0,	'Uživatelské jméno:',	'2014-08-10 12:13:59');

DROP TABLE IF EXISTS `localization_text`;
CREATE TABLE `localization_text` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `ns` varchar(24) DEFAULT NULL,
  `text` varchar(255) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ns` (`ns`,`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='default texts for translations';

INSERT INTO `localization_text` (`id`, `ns`, `text`, `ts`) VALUES
(1,	NULL,	'Hello, world!',	'2014-07-12 19:45:20'),
(2,	NULL,	'You have successfully created your',	'2014-07-12 19:50:12'),
(3,	NULL,	'Sign in',	'2014-07-12 19:53:47'),
(4,	NULL,	'Sign out',	'2014-07-12 19:53:55'),
(5,	NULL,	'Username:',	'2014-07-12 19:58:26'),
(6,	NULL,	'Please enter your username.',	'2014-07-12 19:59:08'),
(7,	NULL,	'Password:',	'2014-07-12 19:59:16'),
(8,	NULL,	'Please enter your password.',	'2014-07-12 19:59:43'),
(9,	NULL,	'Keep me signed in',	'2014-07-12 20:00:06'),
(10,	NULL,	'Language',	'2014-07-13 16:24:49'),
(11,	NULL,	'Czech',	'2014-07-13 16:25:07'),
(12,	NULL,	'English',	'2014-07-13 16:25:14'),
(13,	NULL,	'Sign up',	'2014-07-13 16:39:14'),
(14,	NULL,	'Contact',	'2014-07-13 22:18:13'),
(15,	NULL,	'Home',	'2014-07-13 22:18:27'),
(16,	NULL,	'Write to us',	'2014-07-13 22:26:09'),
(17,	NULL,	'Full Name',	'2014-07-13 22:55:10'),
(18,	NULL,	'Upload Image',	'2014-07-15 14:14:36'),
(19,	NULL,	'Register',	'2014-07-15 14:15:41'),
(20,	NULL,	'Confirm password:',	'2014-07-15 14:16:08'),
(21,	NULL,	'Please check your different password.',	'2014-07-15 14:17:43'),
(22,	NULL,	'Photos',	'2014-08-07 16:31:35'),
(23,	NULL,	'Log In',	'2014-08-07 16:41:55'),
(24,	NULL,	'Forgot your password?',	'2014-08-07 16:49:28'),
(25,	NULL,	'User Password Recovery Page',	'2014-08-07 16:52:19'),
(26,	NULL,	'Your register email:',	'2014-08-07 16:54:57'),
(27,	NULL,	'Send',	'2014-08-07 16:55:06'),
(28,	NULL,	'Login username:',	'2014-08-10 12:13:59');

DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`page_id`),
  KEY `action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `page` (`page_id`, `action`, `parent_id`, `name`, `sort`) VALUES
(1,	1,	0,	'Test page 1',	0),
(2,	1,	0,	'Test page 2',	80),
(3,	0,	4,	'Test page 3',	70),
(4,	0,	8,	'Test page 4',	60),
(5,	1,	8,	'Test page 5',	50),
(6,	1,	7,	'Test page 6',	30),
(7,	0,	9,	'Test page 7',	20),
(8,	0,	0,	'Test page 8',	40),
(9,	1,	0,	'Test page 9',	10),
(10,	1,	0,	'Test page 10',	90);

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


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `order` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user` (`user_id`, `action`, `name`, `surname`, `email`, `order`) VALUES
(1,	0,	'John',	'Doe',	'john.doe@test.xx',	100),
(2,	1,	'Peter',	'Larson',	'peter.larson@test.xx',	160),
(3,	1,	'Claude',	'Graves',	'claude.graves@test.xx',	180),
(4,	0,	'Stuart',	'Norman',	'stuart.norman@test.xx',	120),
(5,	1,	'Kathy',	'Arnold',	'kathy.arnold@test.xx',	140),
(6,	0,	'Jan',	'Wilson',	'jan.wilson@test.xx',	150),
(7,	0,	'Alberta',	'Erickson',	'alberta.erickson@test.xx',	110),
(8,	1,	'Ada',	'Wells',	'ada.wells@test.xx',	70),
(9,	0,	'Ethel',	'Figueroa',	'ethel.figueroa@test.xx',	30),
(10,	1,	'Ian',	'Goodwin',	'ian.goodwin@test.xx',	130),
(11,	1,	'Francis',	'Hayes',	'francis.hayes@test.xx',	0),
(12,	0,	'Erma',	'Burns',	'erma.burns@test.xx',	60),
(13,	1,	'Kristina',	'Jenkins',	'kristina.jenkins@test.xx',	10),
(14,	0,	'Virgil',	'Hunt',	'virgil.hunt@test.xx',	40),
(15,	1,	'Max',	'Martin',	'max.martin@test.xx',	170),
(16,	1,	'Melody',	'Manning',	'melody.manning@test.xx',	50),
(17,	1,	'Catherine',	'Todd',	'catherine.todd@test.xx',	20),
(18,	0,	'Douglas',	'Stanley',	'douglas.stanley@test.xx',	90),
(19,	1,	'Patti',	'Diaz',	'patti.diaz@test.xx',	80);

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
(1,	'buffus',	'$2y$10$Y1fnlvtgmi5TntnX5GBCQeQ1hqOM4NrGrwfs0T5gGPuH.rYxJoXfK',	7,	'title ASC',	'title ASC',	'Petr Polák',	'buffus@seznam.cz',	'2015-02-15 14:40:04',	'0000-00-00 00:00:00',	'127.0.0.1',	'',	'2015-02-15 14:40:04',	'',	'');

-- 2015-08-10 20:31:09