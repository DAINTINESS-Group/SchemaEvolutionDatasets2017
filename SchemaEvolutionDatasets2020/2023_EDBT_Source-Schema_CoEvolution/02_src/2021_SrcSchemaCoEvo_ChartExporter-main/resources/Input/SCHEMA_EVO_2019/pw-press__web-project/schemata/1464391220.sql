-- Adminer 4.2.4 MySQL dump

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
  `uploaded_at` datetime NOT NULL,
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
(1,	'starter-template'),
(2,	'justified-nav'),
(3,	'jumbotron'),
(4,	'jumbotron-narrow'),
(5,	'blog'),
(6,	'carousel'),
(7,	'cover'),
(8,	'album');

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
  `label` tinyint(3) unsigned NOT NULL,
  `slug_en` varchar(255) NOT NULL,
  `title_cs` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `body_cs` text NOT NULL,
  `body_en` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug_cs`),
  UNIQUE KEY `title` (`title_cs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `posts` (`id`, `slug_cs`, `label`, `slug_en`, `title_cs`, `title_en`, `body_cs`, `body_en`, `date`) VALUES
(2,	'druhy-prispevek',	6,	'second-post',	'SEO',	'SEO',	'Tři zásady pro tvorbu dobrých SEO URL\n=========\nJaké by měly být dobré adresy, aby zaručily dobrou dohledatelnost informací? Přináším přehled třích hlavních vlastností. \nURL adresy by měly být:\n- trvalé,\n- trvalé\n- a trvalé.\n\nhttp://weblog.jakpsatweb.cz/d/1333060980-tri-zasady-pro-tvorbu-dobrych-seo-url.html\n\nSEO v PHP\n=========\n\nhttp://diskuse.jakpsatweb.cz/?action=vthread&forum=9&topic=107423Keyword Density tool====================http://keywords.jqueryload.com/http://www.live-keyword-analysis.com/a tady nějaký zajímavý script pro jquery:https://github.com/select/scriptsa článek z 4/20157 Online Free Keyword Density Calculator Toolshttp://www.shoutmeloud.com/7-online-tools-to-analyze-keyword-density-seo.html',	'Three SEO URLhttp://weblog.jakpsatweb.cz/d/1333060980-tri-zasady-pro-tvorbu-dobrych-seo-url.html/---code phpecho($var);\\---',	'2015-08-23 13:46:43'),
(3,	'o-nas',	7,	'about',	'O nás',	'About',	'321start\n#######\n\n je *sportovní klub*, team a parta lidí, kteří se rozhodli vzájemně podporovat při sportovních aktivitách, pořádat závody a akce sportovního charakteru bez ohledu na výkonnost a výsledky.321start je tu pro podporu toho co děláš pro svoje zdraví, rozvoj, pohyb, sport, výkon,\n\nZávodníci\n========\n\nSali\n----\nVýkony:\n\n- fwf\n- ere\n- awerf\n\nBuff\n----\n\nSteta\n------\n překonání sebe, motivaci druhých, extrém, …321start pořádá terénní triatlon HnačovMAN, StoneMAN, Strašický BrdMAN a orientační závod na kolech zbloudilej Šumavák.321start Pomáhá pomocným tlapkám.Chceš se připojit k 321start? Můžeš být člen TEAMU 321start a nebo i SK 321start …je to na tobě:-)Člen Sportovního klubu 321start·         Dle stanov SK 321start §3 bod 2 se členem klubu může stát každá fyzická osoba na základě písemné žádosti, kterou schvaluje výbor klubu.·         Výbor při schválení členství vždy přihlédne k organizační aktivitě a členství v TEAMU 321start.·         Členové klubu mají dle stanov SK 321start §4 práva a povinnosti členů (včetně volebního práva, povinnost řádně platit členské příspěvky, atd.).·         Od člena se očekává aktivní přístup při reprezentaci a propagaci klubu, dále aktivní organizace a zajištění závodů a akcí 321start.·         Propaguje a reprezentuje 321start jako svůj team, za který se přihlašuje na akce a závody.·         Jeho umístění na závodech je evidováno a uvedeno ve výsledcích TEAMu 321start.·         Dle finančních možností SK 321start jsou členové odměňováni a podporování v souladu s cíli činnosti klubu.·         Je zván na všechny akce 321start.Člen TEAMu 321start·         Dle stanov SK 321start §3 bod 2 není členem klubu.·         Neplatí členské příspěvky, nevztahují se na něj stanovy SK 321start.·         Propaguje a reprezentuje 321start jako svůj team, za který se přihlašuje na akce a závody.·         Jeho umístění na závodech je evidováno a uvedeno ve výsledcích TEAMU 321start.·         Jeho pomoc při organizaci závodů a akcí 321start je vítána.·         Dle finančních možností SK 321start může získat slevu na závodech a akcích 321start.·         Je zván na všechny akce 321start.Neptej se, co může 321start udělat pro tebe, ale co můžeš ty udělat pro 321start!',	'about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about about',	'2015-08-25 21:52:20'),
(5,	'kontakt',	8,	'contact',	'Kontakt',	'Contact',	'Sportovní klub 321start\n=======================\n\nStaniční ul. 1007/55\n----------------\nPlzeň 312 00\n\nIČO: 26577054\n\nč.ú. 321456789/2010\n\nemail: sk321start@gmail.com\n\nwww.sk321start.cz',	'contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact contact ',	'2015-08-26 21:58:00'),
(6,	'texy',	5,	'texy',	'Texy!',	'Texy!',	'Proč používat Texy!?\n################\nWeb:[https://cs.wikipedia.org/wiki/Internetov%C3%BD_vyhled%C3%A1va%C4%8D] má jiná specifika než tištěný dokument.\n\n<div id=\"links\">\n[* 1.jpg *]::\n</div>\n\n<div id=\"links\">\n    <a href=\"/web-project/web/images/linked/1.jpg\" title=\"Bananaa\" data-gallery>\n        <img src=\"/web-project/web/images/1.jpg\" alt=\"Banana\">\n    </a>\n    <a href=\"images/apple.jpg\" title=\"Apple\" data-gallery>\n        <img src=\"images/thumbnails/apple.jpg\" alt=\"Apple\">\n    </a>\n    <a href=\"images/orange.jpg\" title=\"Orange\" data-gallery>\n        <img src=\"images/thumbnails/orange.jpg\" alt=\"Orange\">\n    </a>\n</div>\n\n\n\n- **u tiskovin** je prioritou **vizuálním uspořádání**, ze které si lidský mozek strukturu odvodí\n- **u webu** je prioritou **strukturovaný text**\nZdroje:\n\"Jak psát texty na Internetu\":[http://www.jakpsatweb.cz/jak-psat.html],\n\"napoveda.seznam.cz\":[http://napoveda.seznam.cz/cz/fulltext-hledani-v-internetu/optimalizace-webu/on-page-faktory/#nadpisy]\n\nTexy! patří do skupiny \"HTML editorů\":[https://cs.wikipedia.org/wiki/HTML_editor], které se nazývají WYSIWYM:[https://en.wikipedia.org/wiki/WYSIWYM] editory (What You See Is What You Mean = \"Co vidíte, to máte na mysli\") a pomáhá vytvářet dobře strukturovaný text pro strojové čtení \n- \n-\nOdkazy\n######\n\n\nObrázky\n#######\n- Má na starosti třída TexyImageModule:http://api.texy.info/TexyImageModule.html\n- Oficiální dokumentace: http://texy.info/cs/syntax-podrobne#toc-obrazky\n- Programátorský manuál: http://texy.info/cs/api\n- API dokumentace: \n\n<span class=\"glyphicon glyphicon-search\"></span>\n\nPomocí\n/---code texy\n[* 1.png *]:#toc-obrazky\n\\---\nvelmi prostě [* 1.png *]:#toc-obrazky výchozí je $texy->imageModule->root\n\n\nCílové url může být také obrázek, třeba \"odkaz\":[* 2.png *]. Potom je jako výchozí adresář $texy->imageModule->linkedRoot.\n\nObojí lze zkombinovat do [* 1.png *]:[* mountains.jpg *]. V tomto případě jsou názvy obou obrázků stejné a liší se jen adresář ($root vs. $linkedRoot) – potom lze použít „naznačený odkaz“, tedy [* image.jpg *]::',	'Why use Texy!?\n#############\n\nHTML\n====\n/---code html\n<div class=\"media\">\n  <div class=\"media-left\">\n    <a href=\"#\">\n      <img class=\"media-object\" src=\"...\" alt=\"...\">\n    </a>\n  </div>\n  <div class=\"media-body\">\n    <h4 class=\"media-heading\">Media heading</h4>\n    ...\n  </div>\n</div>\n\\---\n\n<div class=\"media\">\n  <div class=\"media-left\">\n    [* 1.jpg *]::\n  </div>\n  <div class=\"media-body\">\n    <h4 class=\"media-heading\">Media heading</h4>\n    A raspberry is an aggregate fruit, meaning it has many parts joined together. It is similar to a blackberry, but the fruit is hollow on the inside. There are many different species of raspberry plants, but only a few of them have fruit that are sold in stores. Leaves of the raspberry plant are also used fresh or dried in herbal teas. The raspberry flower can be a source of nectar for honeybees. Raspberries are a popular fruit in some parts of the world.\n  </div>\n</div>\n\n<div class=\"media\">\n  <div class=\"media-body\">\n    <h4 class=\"media-heading\">Media heading</h4>\n    A raspberry is an aggregate fruit, meaning it has many parts joined together. It is similar to a blackberry, but the fruit is hollow on the inside. There are many different species of raspberry plants, but only a few of them have fruit that are sold in stores. Leaves of the raspberry plant are also used fresh or dried in herbal teas. The raspberry flower can be a source of nectar for honeybees. Raspberries are a popular fruit in some parts of the world.\n  </div>\n  <div class=\"media-right\">\n    [* 2.jpg *]::\n  </div>\n</div>\n\n\nImages\n======\n\nSimple\n---------\n`[* 1.jpg *]`\n[* 1.jpg *]\n\nAdd classes to an <img> element\n---------------------------------------------\n`[* 1.jpg .(maliny)[img-circle] *]`\n[* 1.jpg .(maliny)[img-circle] *]\n\nKlikatelný obrázek se vytvoří velmi prostě `[* 2.jpg *]://texy.info`  [* 2.jpg *]://texy.info \n\nCílové url může být také obrázek, třeba pomeranč\n- `\"velký\":[* 2.jpg *]` \"velký\":[* 2.jpg *]` nebo\n- `\"malý\":[* ../2.jpg *]` \"malý\":[* ../2.jpg *]`\n\nČili  `[root]:[linkedRoot]` zkráceně `[* imgName *]::`\nObojí lze zkombinovat do `[* 1.jpg *]:[* 2.jpg *]`:  [* 1.jpg *]:[* 2.jpg *]\n\n- Pro `[* 1.jpg *]` je použit adresář `$texy->imageModule->root`.\n- Pro `[* 2.jpg *]` je použit adresář `$texy->imageModule->linkedRoot`.\n\n\nTo lze využít pro klikatelné náhledy  `[* 1.jpg *]:[* 1.jpg *]`:  [* 1.jpg *]:[* 1.jpg *]\n\nZjednodušeně do `[* 1.jpg *]::`  [* 1.jpg *]::\n\n[* 3.jpg | 2.jpg *]\n\n',	'2015-08-27 13:27:33');

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
(3,	5),
(5,	5),
(6,	5),
(2,	7),
(6,	7);

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
  `themes_id` int(11) unsigned NOT NULL DEFAULT '1',
  `navbar_brand` varchar(30) NOT NULL DEFAULT 'Brand',
  `description` varchar(100) NOT NULL,
  `ga_tracking_id` varchar(15) NOT NULL,
  `eu_cookie` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `noindex_nofollow` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `order_post` varchar(20) NOT NULL DEFAULT 'date DESC',
  `order_tag` varchar(20) NOT NULL DEFAULT 'title ASC',
  PRIMARY KEY (`id`),
  KEY `layouts_id` (`layouts_id`),
  KEY `themes_id` (`themes_id`),
  CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`layouts_id`) REFERENCES `layouts` (`id`),
  CONSTRAINT `settings_ibfk_2` FOREIGN KEY (`themes_id`) REFERENCES `themes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `settings` (`id`, `layouts_id`, `themes_id`, `navbar_brand`, `description`, `ga_tracking_id`, `eu_cookie`, `noindex_nofollow`, `order_post`, `order_tag`) VALUES
(1,	1,	1,	'PolakWeb.com',	'Web o žížalkách.',	'',	0,	1,	'label ASC',	'bg_color DESC');

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `color` varchar(7) NOT NULL,
  `bg_color` varchar(7) NOT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tags` (`id`, `title`, `slug`, `color`, `bg_color`, `active`) VALUES
(1,	'Strašnický BrdMAN',	'strasnicky-brdman',	'FFFFFF',	'123456',	CONV('1', 2, 10) + 0),
(2,	'HnačovMAN',	'hnacovman',	'FFFFFF',	'80347A',	CONV('1', 2, 10) + 0),
(3,	'O nás',	'o-nas',	'CC0606',	'990000',	CONV('1', 2, 10) + 0),
(4,	'Kontakty',	'kontakt',	'000000',	'E65C5C',	CONV('1', 2, 10) + 0),
(5,	'Navbar Header',	'navbar-header',	'FF0000',	'060056',	CONV('1', 2, 10) + 0),
(6,	'Navbar Footer',	'navbar-footer',	'00FF33',	'060056',	CONV('1', 2, 10) + 0),
(7,	'Promo Post',	'promo-post',	'FFFFFF',	'123456',	CONV('1', 2, 10) + 0),
(8,	'News',	'news',	'FFFFFF',	'000000',	CONV('1', 2, 10) + 0),
(11,	'Propozice',	'propozice',	'2BFF00',	'4F8051',	CONV('1', 2, 10) + 0);

DROP TABLE IF EXISTS `themes`;
CREATE TABLE `themes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `themes` (`id`, `slug`) VALUES
(1,	'cerulean'),
(2,	'cosmo'),
(3,	'cyborg'),
(4,	'darkly'),
(5,	'flatly'),
(6,	'journal'),
(7,	'lumen'),
(8,	'paper'),
(9,	'readable'),
(10,	'sandstone'),
(11,	'simplex'),
(12,	'spacelab'),
(13,	'superhero'),
(14,	'united'),
(15,	'yeti');

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

-- 2016-05-27 23:18:11