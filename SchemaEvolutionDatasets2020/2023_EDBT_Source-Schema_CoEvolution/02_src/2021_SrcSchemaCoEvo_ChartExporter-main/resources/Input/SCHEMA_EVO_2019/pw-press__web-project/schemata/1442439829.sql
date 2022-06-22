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


DROP TABLE IF EXISTS `layouts`;
CREATE TABLE `layouts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `layouts` (`id`, `slug`) VALUES
(1,	'layout'),
(2,	'jumbotron'),
(3,	'coffee');

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

INSERT INTO `obligations` (`id`, `title_cs`, `title_en`, `body_cs`, `body_en`, `date`) VALUES
(1,	'Ochrana soukromí a cookies',	'Privacy policy and Cookies',	'Ochrana soukromí\n################\n\n\nSměrnice Evropského parlamentu a Rady 2002/58/ES\n================================================\n\n> ze dne 12. července 2002\n>\n> o zpracování osobních údajů a ochraně soukromí v odvětví elektronických komunikací (Směrnice o soukromí a elektronických komunikacích)\n> > Článek 5\n> >\n> > **Důvěrný charakter sdělení**\n> >\n> > 3. Členské státy zajistí, aby užívání sítí elektronických komunikací k uchovávání informací nebo získávání přístupu **k informacím uchovávaným v koncovém zařízení** účastníka nebo uživatele **bylo povoleno pouze za podmínky, že dotčený účastník či uživatel** byl jasně a úplně **informován** v souladu se směrnicí 95/46/ES, mimo jiné **o účelech zpracování**, a že je mu správcem údajů nabídnuto **právo odmítnout** takové **zpracování**.\n> >\n> > To nebrání technickému ukládání nebo takovému přístupu, jehož jediným účelem je provedení nebo usnadnění přenosu sdělení prostřednictvím sítí elektronických komunikací nebo, je-li to nezbytně nutné pro poskytování služeb informační společnosti, které si účastník nebo uživatel výslovně vyžádal.\n>:http://eur-lex.europa.eu/\n\n\nHTTP cookie\n###########\n\n\nCo je cookie\n************\n\nDruhy cookie\n************\n\n\n\n\nGoogle Analytics\n################\n\nGoogle AdSence\n################\n\n\n',	'Privacy policy\n##############\n\n\nDirective 2002/58/EC of the European Parliament and of the Council\n==================================================================\n\n> of 12 July 2002\n>\n> concerning the processing of personal data and the protection of privacy in the electronic communications sector (Directive on privacy and electronic communications)\n> > Article 5\n> >\n> > **Confidentiality of the communications**\n> >\n> > 3. Member States shall ensure that the use of electronic communications networks to store information or to gain access **to information stored in the terminal equipment** of a subscriber or user **is only allowed on condition that the subscriber or user concerned** is provided with clear and comprehensive **information** in accordance with Directive 95/46/EC, inter alia about **the purposes of the processing**, and is offered the right **to refuse** such processing by the **data controller**.\n> > This shall not prevent any technical storage or access for the sole purpose of carrying out or facilitating the transmission of a communication over an electronic communications network, or as strictly necessary in order to provide an information society service explicitly requested by the subscriber or user.\n>\n> — **EUR-Lex**,  \"*eur-lex.europa.eu*\":http://eur-lex.europa.eu\n>:http://eur-lex.europa.eu/\n\nTohle není špatné:\nhttp://www.dailystar.co.uk/cookie-policy\n\nRequirements for approval\n=========================\n\n- Specific information. To be valid, consent must be specific and based on appropriate information. In other words, blanket consent without specifying the exact purpose of the processing is not acceptable.\n- Timing. As a general rule, consent has to be given before the processing starts.\n- Active choice. Consent must be unambiguous. Therefore the procedure to seek and to give consent must leave no doubt as to the data subject\'s intention. There are in principle no limits as to the form consent can take. However, for consent to be valid it should be an active indication of the user’s wishes. The minimum expression of an indication could be any kind of signal, sufficiently clear to be capable of indicating a data subject\'s wishes, and to be understandable by the data controller (it could include a handwritten signature affixed at the bottom of a paper form, or an active behavior from which consent can be reasonably concluded).\n- Freely given. Consent can only be valid if the data subject is able to exercise a real choice, and there is no risk of deception, intimidation, coercion or significant negative consequences if he/she does not consent.\n\n\nWhat are cookies?\n=================\n\n\nWhat cookies do we use on our website?\n======================================\n\n.[table table-hover]\n|-----------------------------\n| Cookie name | Cookie expiration | Who has access to information | Purpose\n|----------------------------\n| Google ads    | Christ    | 33 |\n| Google Analytics | ga | 74 |\n\n\nCookies Google AdSence\n-----------------------\n\n\nCookies Google Analytics\n------------------------\n\n\n',	'2015-08-18 12:59:44');

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug_cs` varchar(255) NOT NULL,
  `label` varchar(5) NOT NULL,
  `slug_en` varchar(255) NOT NULL,
  `title_cs` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `body_cs` text NOT NULL,
  `body_en` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`),
  UNIQUE KEY `slug` (`slug_cs`),
  UNIQUE KEY `title` (`title_cs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `posts_tags`;
CREATE TABLE `posts_tags` (
  `posts_id` int(11) NOT NULL,
  `tags_id` int(11) NOT NULL,
  UNIQUE KEY `tag_id_post_id` (`tags_id`,`posts_id`),
  KEY `tag_id` (`tags_id`),
  KEY `post_id` (`posts_id`),
  CONSTRAINT `posts_tags_ibfk_1` FOREIGN KEY (`tags_id`) REFERENCES `tags` (`id`),
  CONSTRAINT `posts_tags_ibfk_2` FOREIGN KEY (`posts_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `posts_tags` (`posts_id`, `tags_id`) VALUES
(2,	1),
(1,	5),
(3,	5),
(5,	5),
(6,	5),
(7,	5);

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

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `layouts_id` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `layouts_id` (`layouts_id`),
  CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`layouts_id`) REFERENCES `layouts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `settings` (`id`, `layouts_id`) VALUES
(1,	1);

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `color` varchar(6) NOT NULL,
  `active` bit(1) NOT NULL,
  `align` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tags` (`id`, `title`, `slug`, `color`, `active`, `align`) VALUES
(1,	'Strašnický BrdMAN',	'strasnicky-brdman',	'',	CONV('0', 2, 10) + 0,	1),
(2,	'HnačovMAN',	'hnacovman',	'',	CONV('0', 2, 10) + 0,	0),
(3,	'O nás',	'o-nas',	'red',	CONV('1', 2, 10) + 0,	0),
(4,	'Kontakt',	'kontakt',	'blue',	CONV('1', 2, 10) + 0,	0),
(5,	'Navbar Header',	'navbar-header',	'red',	CONV('1', 2, 10) + 0,	1),
(6,	'Navbar Footer',	'navbar-footer',	'grey',	CONV('1', 2, 10) + 0,	1);

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

-- 2015-09-16 21:42:28