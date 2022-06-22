
--
-- Table structure for table `Team`
--

DROP TABLE IF EXISTS `Team`;

CREATE TABLE `Team` ( 
	`team_id` int(3) NOT NULL AUTO_INCREMENT,
	`name` char(99) NOT NULL DEFAULT '',
 	PRIMARY KEY (`team_id`)
);

INSERT INTO `Team` VALUES (1, 'GoLang');
INSERT INTO `Team` VALUES (2, 'Swift');

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` ( 
	`user_id` int(3) NOT NULL AUTO_INCREMENT,
	`name_first` char(52) NOT NULL DEFAULT '',
	`name_last` char(52) NOT NULL DEFAULT '',
	`role` enum('Player', 'Admin', 'Judge') NOT NULL DEFAULT 'Player',
	`team_id` int(3) NOT NULL DEFAULT 0,

 	PRIMARY KEY (`user_id`)
);

INSERT INTO `User` VALUES (1, 'Luke', 'Pasma', 'Admin', 1);
INSERT INTO `User` VALUES (1, 'Milo', 'Gertjejansen', 'Admin', 1);
INSERT INTO `User` VALUES (1, 'Kyle', 'Mills', 'Admin', 1);
INSERT INTO `User` VALUES (1, 'Benjamin', 'Kobane', 'Admin', 1);

--
-- Table structure for table `Problems`
--

DROP TABLE IF EXISTS `Problems`;

CREATE TABLE `Problems` ( 
	`problem_id` int(3) NOT NULL AUTO_INCREMENT,
	`question` char(300) NOT NULL DEFAULT '',
	`answer` char(300) NOT NULL DEFAULT '',
 	PRIMARY KEY (`problem_id`)
);

INSERT INTO `Problems` VALUES (1, 'What is your team name?', 'GoLang');
INSERT INTO `Problems` VALUES (2, 'What class are you in?', 'ProgLang');