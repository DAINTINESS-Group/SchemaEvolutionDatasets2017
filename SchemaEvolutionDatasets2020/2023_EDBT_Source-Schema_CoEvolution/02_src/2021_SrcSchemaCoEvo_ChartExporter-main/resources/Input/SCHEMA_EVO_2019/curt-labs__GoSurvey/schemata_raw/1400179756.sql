use CurtDev;

DROP TABLE IF EXISTS ActivatedWarranties;
CREATE TABLE `CurtDev`.`ActivatedWarranties` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`fname` varchar(255),
	`lname` varchar(255),
	`email` varchar(255),
	`part` int(11),
	`date_added` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `Part_FK` FOREIGN KEY (`part`) REFERENCES `CurtDev`.`Part` (`partID`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Warranty Activation';

##
# Survey Data Structure
##

DROP TABLE IF EXISTS SurveyUser;
DROP TABLE IF EXISTS SurveyUserAnswer;
DROP TABLE IF EXISTS SurveyAnswer;
DROP TABLE IF EXISTS SurveyAnswer_Revisions;
DROP TRIGGER IF EXISTS SurveyAnswers_Insert;
DROP TRIGGER IF EXISTS SurveyAnswers_Update;
DROP TABLE IF EXISTS Survey;
DROP TABLE IF EXISTS Survey_Revisions;
DROP TRIGGER IF EXISTS Survey_Insert;
DROP TRIGGER IF EXISTS Survey_Update;
DROP TABLE IF EXISTS SurveyQuestion_Revisions;
DROP TABLE IF EXISTS SurveyQuestion;
DROP TRIGGER IF EXISTS SurveyQuestion_Insert;
DROP TRIGGER IF EXISTS SurveyQuestion_Update;

# Survey
CREATE TABLE `CurtDev`.`Survey` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(255),
	`description` varchar(1000),
	`date_added` datetime NOT NULL,
	`date_modifed` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`userID` int(11) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Survey Declaration';

# Survey Revision Tracking
CREATE TABLE `CurtDev`.`Survey_Revisions` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int NOT NULL,
	`new_name` varchar(500),
	`old_name` varchar(500),
	`date` datetime NOT NULL,
	`changeType` enum('NEW','EDIT','DELETE') NOT NULL,
	`surveyID` int(11),
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Revision Tracking for Surveys';

delimiter |
# Triggers for Survey Revision Tracking
CREATE TRIGGER `Survey_Insert` AFTER INSERT ON `Survey` FOR EACH ROW BEGIN
	IF NEW.deleted THEN SET @changeType = 'DELETE'; ELSE SET @changeType = 'NEW'; END IF;

	INSERT INTO Survey_Revisions(userID, new_name, date, changeType, surveyID)
	VALUES(NEW.userID, NEW.name, CURRENT_TIMESTAMP, @changeType, NEW.id);
END;
|

CREATE TRIGGER `Survey_Update` AFTER UPDATE ON `Survey` FOR EACH ROW BEGIN
	IF NEW.deleted THEN SET @changeType = 'DELETE'; ELSE SET @changeType = 'EDIT'; END IF;

	INSERT INTO Survey_Revisions(userID, new_name, old_name, date, changeType, surveyID)
	VALUES(NEW.userID, NEW.name, OLD.name, NOW(), @changeType, NEW.id);
END;
|

delimiter ;

# Question Revision Tracking
CREATE TABLE `CurtDev`.`SurveyQuestion_Revisions` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int NOT NULL,
	`new_question` varchar(500),
	`old_question` varchar(500),
	`date` datetime NOT NULL,
	`changeType` enum('NEW','EDIT','DELETE') NOT NULL,
	`questionID` int(10),
	`new_answer` int(11) NOT NULL DEFAULT 0,
	`old_answer` int(11) NOT NULL DEFAULT 0,
	`new_survey` int(11) NOT NULL DEFAULT 0,
	`old_survey` int(11) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Revision Tracking for Survey Questions';

# Survey Questions
CREATE TABLE `CurtDev`.`SurveyQuestion` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`question` varchar(500) NOT NULL,
	`date_modified` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`date_added` datetime NOT NULL,
	`userID` int NOT NULL,
	`surveyID` int NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Survey Questions';


delimiter |
# Triggers for Question Revision Tracking
CREATE TRIGGER `SurveyQuestion_Insert` AFTER INSERT ON `SurveyQuestion` FOR EACH ROW BEGIN
	IF NEW.deleted THEN
		SET @changeType = 'DELETE';
		ELSE SET @changeType = 'NEW';
	END IF;

	INSERT INTO SurveyQuestion_Revisions(userID, new_question, date, changeType, questionID, new_survey)
	VALUES(NEW.userID, NEW.question, CURRENT_TIMESTAMP, @changeType, NEW.id, NEW.surveyID);
END
|

CREATE TRIGGER `SurveyQuestion_Update` AFTER UPDATE ON `SurveyQuestion` FOR EACH ROW BEGIN
	IF NEW.deleted THEN
		SET @changeType = 'DELETE';
	ELSE
		SET @changeType = 'EDIT';
	END IF;

	INSERT INTO SurveyQuestion_Revisions(userID, new_question, old_question, date, changeType, questionID, new_survey, old_survey)
	VALUES(NEW.userID, NEW.question, OLD.question, NOW(), @changeType, NEW.id, NEW.surveyID, OLD.surveyID);
END
|

delimiter ;

# Survey Answers
CREATE TABLE `CurtDev`.`SurveyAnswer` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int(11) NOT NULL,
	`answer` varchar(500) NOT NULL,
	`data_type` varchar(100) NOT NULL,
	`date_added` datetime NOT NULL,
	`date_modified` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`questionID` int(11) UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `SurveyQuestion_FK` FOREIGN KEY (`questionID`) REFERENCES `CurtDev`.`SurveyQuestion` (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Answers to Survey Questions';

# Answer Revision Tracking
CREATE TABLE `CurtDev`.`SurveyAnswer_Revisions` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int NOT NULL,
	`new_answer` varchar(500),
	`old_answer` varchar(500),
	`date` datetime NOT NULL,
	`changeType` enum('NEW','EDIT','DELETE') NOT NULL,
	`answerID` int(11),
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Revision Tracking for Survey Answers';

delimiter |
# Triggers for Answer Revision Tracking
CREATE TRIGGER `SurveyAnswers_Insert` AFTER INSERT ON `SurveyAnswer` FOR EACH ROW BEGIN
	IF NEW.deleted THEN SET @changeType = 'DELETE'; ELSE SET @changeType = 'NEW'; END IF;

	INSERT INTO SurveyAnswer_Revisions(userID, new_answer, date, changeType, answerID)
	VALUES(NEW.userID, NEW.answer, NOW(), @changeType, NEW.id);
END
|

CREATE TRIGGER `SurveyAnswers_Update` AFTER UPDATE ON `SurveyAnswer` FOR EACH ROW BEGIN
	IF NEW.deleted THEN
		SET @changeType = 'DELETE';
	ELSE
		SET @changeType = 'EDIT';
	END IF;

	INSERT INTO SurveyAnswer_Revisions(userID, new_answer, old_answer, date, changeType, answerID)
	VALUES(NEW.userID, NEW.answer, OLD.answer, NOW(), @changeType, NEW.id);
END
|

delimiter ;

# User Answers
CREATE TABLE `CurtDev`.`SurveyUser` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`fname` varchar(500),
	`lname` varchar(500),
	`email` varchar(500),
	`date_added` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='User Information for taking surveys';

CREATE TABLE `CurtDev`.`SurveyUserAnswer` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int(11) NOT NULL,
	`surveyID` int(11) UNSIGNED NOT NULL,
	`questionID` int(11) UNSIGNED NOT NULL,
	`answer` varchar(500),
	`date_answered` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `Survey_FK` FOREIGN KEY (`surveyID`) REFERENCES `CurtDev`.`Survey` (`id`),
	CONSTRAINT `SurveyQuestionAnswer_FK` FOREIGN KEY (`questionID`) REFERENCES `CurtDev`.`SurveyQuestion` (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='';

# Survey Prize
CREATE TABLE `CurtDev`.`SurveyPrize` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`title` varchar(500),
	`part` int(11) NOT NULL,
	`description` varchar(1000),
	`image` varchar(500),
	`winner` int(11) UNSIGNED,
	`date_added` datetime NOT NULL,
	`date_modified` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`userID` int(11) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`current` tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY(`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Prize for survey';

CREATE TABLE `CurtDev`.`SurveyPrize_Revisions`(
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int NOT NULL,
	`new_title` varchar(500),
	`old_title` varchar(500),
	`new_description` varchar(1000),
	`old_description` varchar(1000),
	`new_image` varchar(500),
	`old_image` varchar(500),
	`date` datetime NOT NULL,
	`changeType` enum('NEW','EDIT','DELETE') NOT NULL,
	`prizeID` int(11),
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Revisions for SurveyPrize';

delimiter |
# Triggers for Prize Revision Tracking
CREATE TRIGGER `SurveyPrize_Insert` AFTER INSERT ON `SurveyPrize` FOR EACH ROW BEGIN
	IF NEW.deleted THEN SET @changeType = 'DELETE'; ELSE SET @changeType = 'NEW'; END IF;

	INSERT INTO SurveyPrize_Revisions(userID, new_title, new_description, new_image, date, changeType, prizeID)
	VALUES(NEW.userID, NEW.title, NEW.description, NEW.image, NOW(), @changeType, NEW.id);
END
|

CREATE TRIGGER `SurveyPrize_Update` AFTER UPDATE ON `SurveyPrize` FOR EACH ROW BEGIN
	IF NEW.deleted THEN
		SET @changeType = 'DELETE';
	ELSE
		SET @changeType = 'EDIT';
	END IF;

	INSERT INTO SurveyPrize_Revisions(userID, new_title, old_title, new_description, old_description, new_image, old_image, date, changeType, prizeID)
	VALUES(NEW.userID, NEW.title, OLD.title, NEW.description, OLD.description, NEW.image, OLD.image, NOW(), @changeType, NEW.id);
END
|

delimiter ;
