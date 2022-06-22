
--
-- Table structure for table `Team`
--

DROP TABLE IF EXISTS `Team`;

CREATE TABLE `Team` (
	`team_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` CHAR(64) DEFAULT '' NOT NULL
);

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
	`user_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`username` TEXT NOT NULL,
	`password` TEXT NOT NULL,
	`name_first` TEXT NOT NULL,
	`name_last` TEXT NOT NULL,
	`role` TEXT DEFAULT 'player' NOT NULL,
	`team_id` INTEGER NOT NULL DEFAULT 0
);

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

INSERT INTO `Problem` VALUES (0, 'Bad question', 'What is your team name?', 'GoLang');
INSERT INTO `Problem` VALUES (1, 'class quest', 'What class are you in?', 'ProgLang');

--
-- Table structure for table `Submissions`
--

DROP TABLE IF EXISTS `Submission`;

CREATE TABLE `Submission` (
	`submission_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	`team_id` INTEGER NOT NULL DEFAULT 0,
	`problem_id` INTEGER NOT NULL DEFAULT 0,
	`judge_id` INTEGER NOT NULL DEFAULT -1,
	`judged` INTEGER NOT NULL DEFAULT 0,
	`correct` INTEGER NOT NULL DEFAULT 0,
	`timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP
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
	`i_flags` TEXT DEFAULT '' NOT NULL,
	`i_type` TEXT DEFAULT '' NOT NULL
);

INSERT INTO `Language` VALUES (0, 'python2', '', '', '', 'python2', '', 'py');
INSERT INTO `Language` VALUES (1, 'java 7', 'javac', '', 'java', 'java', '', 'class');

