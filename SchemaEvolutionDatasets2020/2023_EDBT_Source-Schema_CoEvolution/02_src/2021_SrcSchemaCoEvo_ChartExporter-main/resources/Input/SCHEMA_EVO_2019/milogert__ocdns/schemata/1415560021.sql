
--
-- Table structure for table `Team`
--

DROP TABLE IF EXISTS `Team`;

CREATE TABLE `Team` ( 
	`team_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` CHAR(64) DEFAULT '' NOT NULL
);

INSERT INTO `Team` VALUES (1, 'GoLang');
INSERT INTO `Team` VALUES (2, 'Swift');

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` ( 
	`user_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name_first` CHAR(64)NOT NULL,
	`name_last` CHAR(64)NOT NULL,
	`role` enum('Player', 'Admin', 'Judge') DEFAULT 'Player' NOT NULL,
	`team_id` INTEGER NOT NULL DEFAULT 0
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
	`problem_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`question` CHAR(64) NOT NULL,
	`answer` CHAR(64) NOT NULL
);

INSERT INTO `Problems` VALUES (1, 'What is your team name?', 'GoLang');
INSERT INTO `Problems` VALUES (2, 'What class are you in?', 'ProgLang');

--
-- Table structure for table `Submissions`
--

DROP TABLE IF EXISTS `Submissions`;

CREATE TABLE `Submissions` ( 
	`submission_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`team_id` INTEGER NOT NULL DEFAULT 0,
	`timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO `Submissions` VALUES (1, 1);

--
-- Table structure for table `Language`
--

DROP TABLE IF EXISTS `Language`;

CREATE TABLE `Language` ( 
	`language_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` CHAR(64) NOT NULL,
	`compiler` CHAR(64) DEFAULT '' NOT NULL,
	`interpreter` CHAR(64) NOT NULL,
	`flag` CHAR(64) DEFAULT '' NOT NULL
);

INSERT INTO `Language` VALUES (1, 'Go', 'gcc', 'go', 'run');