
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
	`username` TEXT NOT NULL,
	`password` TEXT NOT NULL,
	`name_first` CHAR(64) NOT NULL,
	`name_last` CHAR(64) NOT NULL,
	`role` TEXT DEFAULT 'Player' NOT NULL,
	`team_id` INTEGER NOT NULL DEFAULT 0
);

INSERT INTO `User` VALUES (1, 'lapasma', 'wowie', 'Luke', 'Pasma', 'Admin', 1);
INSERT INTO `User` VALUES (2, 'mqgertje', 'wowie', 'Milo', 'Gertjejansen', 'Admin', 1);
INSERT INTO `User` VALUES (3, 'test', 'test', 'Kyle', 'Mills', 'Admin', 1);
INSERT INTO `User` VALUES (4, 'test2', 'test', 'Benjamin', 'Kobane', 'Admin', 1);

--
-- Table structure for table `Problems`
--

DROP TABLE IF EXISTS `Problem`;

CREATE TABLE `Problem` (
	`problem_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` TEXT NOT NULL,
	`question` TEXT NOT NULL,
	`answer` TEXT NOT NULL
);

INSERT INTO `Problem` VALUES (1, 'Bad question', 'What is your team name?', 'GoLang');
INSERT INTO `Problem` VALUES (2, 'class quest', 'What class are you in?', 'ProgLang');

--
-- Table structure for table `Submissions`
--

DROP TABLE IF EXISTS `Submissions`;

CREATE TABLE `Submission` (
	`submission_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`team_id` INTEGER NOT NULL DEFAULT 0,
	`problem_id` INTEGER NOT NULL DEFAULT 0,
	`judge_id` INTEGER NOT NULL DEFAULT -1,
	`judged` INTEGER NOT NULL DEFAULT 0,
	`correct` INTEGER NOT NULL DEFAULT 0,
	`timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`team_id`, `problem_id`)
);

--
-- Table structure for table `Language`
--

DROP TABLE IF EXISTS `Language`;

CREATE TABLE `Language` (
	`language_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` TEXT NOT NULL,
	`compiler` TEXT DEFAULT '' NOT NULL,
	`c_flags` TEXT DEFAULT '' NOT NULL,
	`c_type` TEXT DEFAULT '' NOT NULL,
	`interpreter` TEXT NOT NULL,
	`i_flags` TEXT DEFAULT '' NOT NULL
);

INSERT INTO `Language` VALUES (1, 'python2', '', 'python2', '');
INSERT INTO `Language` VALUES (2, 'java 7', 'javac', 'java', '');

