use CurtDev;

DROP TABLE IF EXISTS ActivatedWarranties;
CREATE TABLE `ActivatedWarranties` (
	`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`fname` varchar(255),
	`lname` varchar(255),
	`email` varchar(255),
	`part` int(10),
	`date_added` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `Part_FK` FOREIGN KEY (`part`) REFERENCES `Part` (`partID`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Warranty Activation';

##
# Survey Data Structure
##

DROP TABLE IF EXISTS SurveyUser;
DROP TABLE IF EXISTS SurveyUserAnswer;
DROP TABLE IF EXISTS Survey;
DROP TABLE IF EXISTS Survey_Revisions;

DROP TABLE IF EXISTS SurveyQuestion_Revisions;
DROP TABLE IF EXISTS SurveyQuestion;

DROP TABLE IF EXISTS SurveyAnswer;
DROP TABLE IF EXISTS SurveyAnswer_Revisions;


# Survey
CREATE TABLE `Survey` (
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
CREATE TABLE `Survey_Revisions` (
	`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int NOT NULL,
	`new_name` varchar(500),
	`old_name` varchar(500),
	`date` datetime NOT NULL,
	`changeType` enum('NEW','EDIT','DELETE') NOT NULL,
	`surveyID` int(10),
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Revision Tracking for Surveys';




# Question Revision Tracking
CREATE TABLE `SurveyQuestion_Revisions` (
	`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
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
CREATE TABLE `SurveyQuestion` (
	`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`question` varchar(500) NOT NULL,
	`date_modified` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`date_added` datetime NOT NULL,
	`userID` int NOT NULL,
	`surveyID` int NOT NULL,
	`answerID` int NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Survey Questions';




# Survey Answers
CREATE TABLE `SurveyAnswer` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int(11) NOT NULL,
	`answer` varchar(500) NOT NULL,
	`data_type` varchar(100) NOT NULL,
	`date_added` datetime NOT NULL,
	`date_modified` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Answers to Survey Questions';

# Answer Revision Tracking
CREATE TABLE `SurveyAnswer_Revisions` (
	`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`userID` int NOT NULL,
	`new_answer` varchar(500),
	`old_answer` varchar(500),
	`date` datetime NOT NULL,
	`changeType` enum('NEW','EDIT','DELETE') NOT NULL,
	`answerID` int(10),
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='Revision Tracking for Survey Answers';



# User Answers
CREATE TABLE `SurveyUser` (
	`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`fname` varchar(500),
	`lname` varchar(500),
	`email` varchar(500),
	`date_added` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='User Information for taking surveys';

CREATE TABLE `SurveyUserAnswer` (
	`id` int(11) NOT NULL,
	`userID` int(11) NOT NULL,
	`surveyID` int(11) UNSIGNED NOT NULL,
	`questionID` int(11) UNSIGNED NOT NULL,
	`answer` varchar(500),
	`date_answered` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	CONSTRAINT `Survey_FK` FOREIGN KEY (`surveyID`) REFERENCES `Survey` (`id`),
	CONSTRAINT `SurveyQuestion_FK` FOREIGN KEY (`questionID`) REFERENCES `SurveyQuestion` (`id`)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=`InnoDB` COMMENT='';
