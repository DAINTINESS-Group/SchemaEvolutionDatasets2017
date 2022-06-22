-- --------------------------------------------------------

--
-- Structure de la table `article`
--

CREATE TABLE IF NOT EXISTS `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `title` varchar(128) NOT NULL,
  `summary` text NOT NULL,
  `content` text NOT NULL,
  `publish` int(10) NOT NULL,
  `author_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;

--
-- Contenu de la table `article`
--

INSERT INTO `article` (`id`, `timestamp`, `title`, `summary`, `content`, `publish`, `author_id`) VALUES
(1, '2013-09-29 01:42:29', 'fullcalendar', '<p><span style="font-family: Arial, ''Liberation Sans'', ''DejaVu Sans'', sans-serif; font-size: 14px; line-height: 18px;">Using jquery mobile+phonegap, trying to <strong>POST</strong> to a Slim application, I have this code:</span></p>', '<p><span style="font-family: Arial, ''Liberation Sans'', ''DejaVu Sans'', sans-serif; font-size: 14px; line-height: 18px;">Using jquery <b>mobile+phonegap</b>, trying to POST to a Slim application, I have this code:</span></p>', 1, 1)
-- --------------------------------------------------------

--
-- Structure de la table `author`
--

CREATE TABLE IF NOT EXISTS `author` (
  `id` bigint(21) NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  `email` tinytext NOT NULL,
  `login` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `pass` tinytext NOT NULL,
  `statut` varchar(255) NOT NULL DEFAULT '0',
  `maj` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `htpass` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login` (`login`),
  KEY `statut` (`statut`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;

--
-- Contenu de la table `author`
--

INSERT INTO `author` (`id`, `nom`, `email`, `login`, `pass`, `statut`, `maj`, `htpass`) VALUES
(1, 'Superman', 'superman@superman.com', 'superman', '84d961568a65073a3bcf0eb216b2a576', '1', '2013-09-29 13:13:55', '');