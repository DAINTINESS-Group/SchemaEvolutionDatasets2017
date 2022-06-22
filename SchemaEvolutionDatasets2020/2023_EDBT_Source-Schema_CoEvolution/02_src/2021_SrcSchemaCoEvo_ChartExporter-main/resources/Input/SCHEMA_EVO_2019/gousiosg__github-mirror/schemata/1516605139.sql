

CREATE SCHEMA IF NOT EXISTS `ghtorrent` DEFAULT CHARACTER SET utf8 ;
USE `ghtorrent` ;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `login` VARCHAR(255) NOT NULL COMMENT '',
  `company` VARCHAR(255) NULL DEFAULT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `type` VARCHAR(255) NOT NULL DEFAULT 'USR' COMMENT '',
  `fake` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '',
  `deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '',
  `long` DECIMAL(11,8) COMMENT '',
  `lat` DECIMAL(10,8) COMMENT '',
  `country_code` CHAR(3) COMMENT '',
  `state` VARCHAR(255) COMMENT '',
  `city` VARCHAR(255) COMMENT '',
  `location` VARCHAR(255) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects` ;

SET time_zone='+0:00';
CREATE TABLE IF NOT EXISTS `projects` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `url` VARCHAR(255) NULL DEFAULT NULL COMMENT '',
  `owner_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `name` VARCHAR(255) NOT NULL COMMENT '',
  `description` VARCHAR(255) NULL DEFAULT NULL COMMENT '',
  `language` VARCHAR(255) NULL DEFAULT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `forked_from` INT(11) NULL DEFAULT NULL COMMENT '',
  `deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '',
  `updated_at` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:01' COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `projects_ibfk_1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `projects_ibfk_2`
    FOREIGN KEY (`forked_from`)
    REFERENCES `projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
SET time_zone=@OLD_TIME_ZONE;

-- -----------------------------------------------------
-- Table `commits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commits` ;

CREATE TABLE IF NOT EXISTS `commits` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `sha` VARCHAR(40) NULL DEFAULT NULL COMMENT '',
  `author_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `committer_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `project_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `commits_ibfk_1`
    FOREIGN KEY (`author_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `commits_ibfk_2`
    FOREIGN KEY (`committer_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `commits_ibfk_3`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `commit_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commit_comments` ;

CREATE TABLE IF NOT EXISTS `commit_comments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `commit_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `body` VARCHAR(256) NULL DEFAULT NULL COMMENT '',
  `line` INT(11) NULL DEFAULT NULL COMMENT '',
  `position` INT(11) NULL DEFAULT NULL COMMENT '',
  `comment_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `commit_comments_ibfk_1`
    FOREIGN KEY (`commit_id`)
    REFERENCES `commits` (`id`),
  CONSTRAINT `commit_comments_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `commit_parents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commit_parents` ;

CREATE TABLE IF NOT EXISTS `commit_parents` (
  `commit_id` INT(11) NOT NULL COMMENT '',
  `parent_id` INT(11) NOT NULL COMMENT '',
  CONSTRAINT `commit_parents_ibfk_1`
    FOREIGN KEY (`commit_id`)
    REFERENCES `commits` (`id`),
  CONSTRAINT `commit_parents_ibfk_2`
    FOREIGN KEY (`parent_id`)
    REFERENCES `commits` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `followers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `followers` ;

CREATE TABLE IF NOT EXISTS `followers` (
  `follower_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`follower_id`, `user_id`)  COMMENT '',
  CONSTRAINT `follower_fk1`
    FOREIGN KEY (`follower_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `follower_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `pull_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pull_requests` ;

CREATE TABLE IF NOT EXISTS `pull_requests` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `head_repo_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `base_repo_id` INT(11) NOT NULL COMMENT '',
  `head_commit_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `base_commit_id` INT(11) NOT NULL COMMENT '',
  `pullreq_id` INT(11) NOT NULL COMMENT '',
  `intra_branch` TINYINT(1) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `pull_requests_ibfk_1`
    FOREIGN KEY (`head_repo_id`)
    REFERENCES `projects` (`id`),
  CONSTRAINT `pull_requests_ibfk_2`
    FOREIGN KEY (`base_repo_id`)
    REFERENCES `projects` (`id`),
  CONSTRAINT `pull_requests_ibfk_3`
    FOREIGN KEY (`head_commit_id`)
    REFERENCES `commits` (`id`),
  CONSTRAINT `pull_requests_ibfk_4`
    FOREIGN KEY (`base_commit_id`)
    REFERENCES `commits` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `issues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `issues` ;

CREATE TABLE IF NOT EXISTS `issues` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `repo_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `reporter_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `assignee_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `pull_request` TINYINT(1) NOT NULL COMMENT '',
  `pull_request_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `issue_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `issues_ibfk_1`
    FOREIGN KEY (`repo_id`)
    REFERENCES `projects` (`id`),
  CONSTRAINT `issues_ibfk_2`
    FOREIGN KEY (`reporter_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `issues_ibfk_3`
    FOREIGN KEY (`assignee_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `issues_ibfk_4`
    FOREIGN KEY (`pull_request_id`)
    REFERENCES `pull_requests` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `issue_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `issue_comments` ;

CREATE TABLE IF NOT EXISTS `issue_comments` (
  `issue_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `comment_id` MEDIUMTEXT NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  CONSTRAINT `issue_comments_ibfk_1`
    FOREIGN KEY (`issue_id`)
    REFERENCES `issues` (`id`),
  CONSTRAINT `issue_comments_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `issue_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `issue_events` ;

CREATE TABLE IF NOT EXISTS `issue_events` (
  `event_id` MEDIUMTEXT NOT NULL COMMENT '',
  `issue_id` INT(11) NOT NULL COMMENT '',
  `actor_id` INT(11) NOT NULL COMMENT '',
  `action` VARCHAR(255) NOT NULL COMMENT '',
  `action_specific` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  CONSTRAINT `issue_events_ibfk_1`
    FOREIGN KEY (`issue_id`)
    REFERENCES `issues` (`id`),
  CONSTRAINT `issue_events_ibfk_2`
    FOREIGN KEY (`actor_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `repo_labels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repo_labels` ;

CREATE TABLE IF NOT EXISTS `repo_labels` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `repo_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `name` VARCHAR(24) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `repo_labels_ibfk_1`
    FOREIGN KEY (`repo_id`)
    REFERENCES `projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `issue_labels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `issue_labels` ;

CREATE TABLE IF NOT EXISTS `issue_labels` (
  `label_id` INT(11) NOT NULL COMMENT '',
  `issue_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`issue_id`, `label_id`)  COMMENT '',
  CONSTRAINT `issue_labels_ibfk_1`
    FOREIGN KEY (`label_id`)
    REFERENCES `repo_labels` (`id`),
  CONSTRAINT `issue_labels_ibfk_2`
    FOREIGN KEY (`issue_id`)
    REFERENCES `issues` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `organization_members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organization_members` ;

CREATE TABLE IF NOT EXISTS `organization_members` (
  `org_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`org_id`, `user_id`)  COMMENT '',
  CONSTRAINT `organization_members_ibfk_1`
    FOREIGN KEY (`org_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `organization_members_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `project_commits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_commits` ;

CREATE TABLE IF NOT EXISTS `project_commits` (
  `project_id` INT(11) NOT NULL DEFAULT '0' COMMENT '',
  `commit_id` INT(11) NOT NULL DEFAULT '0' COMMENT '',
  CONSTRAINT `project_commits_ibfk_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`),
  CONSTRAINT `project_commits_ibfk_2`
    FOREIGN KEY (`commit_id`)
    REFERENCES `commits` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `project_members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_members` ;

CREATE TABLE IF NOT EXISTS `project_members` (
  `repo_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `ext_ref_id` VARCHAR(24) NOT NULL DEFAULT '0' COMMENT '',
  PRIMARY KEY (`repo_id`, `user_id`)  COMMENT '',
  CONSTRAINT `project_members_ibfk_1`
    FOREIGN KEY (`repo_id`)
    REFERENCES `projects` (`id`),
  CONSTRAINT `project_members_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `project_languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_languages` ;

CREATE TABLE IF NOT EXISTS `project_languages` (
  `project_id` INT(11) NOT NULL COMMENT '',
  `language` VARCHAR(255) NULL DEFAULT NULL COMMENT '',
  `bytes` INT(11) COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  CONSTRAINT `project_languages_ibfk_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `project_topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_topics` ;

CREATE TABLE IF NOT EXISTS `project_topics` (
  `project_id` INT(11) NOT NULL COMMENT '',
  `topic_name` VARCHAR(255) COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '',
  CONSTRAINT `project_topics_ibfk_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `pull_request_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pull_request_comments` ;

CREATE TABLE IF NOT EXISTS `pull_request_comments` (
  `pull_request_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `comment_id` MEDIUMTEXT NOT NULL COMMENT '',
  `position` INT(11) NULL DEFAULT NULL COMMENT '',
  `body` VARCHAR(256) NULL DEFAULT NULL COMMENT '',
  `commit_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  CONSTRAINT `pull_request_comments_ibfk_1`
    FOREIGN KEY (`pull_request_id`)
    REFERENCES `pull_requests` (`id`),
  CONSTRAINT `pull_request_comments_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `pull_request_comments_ibfk_3`
    FOREIGN KEY (`commit_id`)
    REFERENCES `commits` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `pull_request_commits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pull_request_commits` ;

CREATE TABLE IF NOT EXISTS `pull_request_commits` (
  `pull_request_id` INT(11) NOT NULL COMMENT '',
  `commit_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`pull_request_id`, `commit_id`)  COMMENT '',
  CONSTRAINT `pull_request_commits_ibfk_1`
    FOREIGN KEY (`pull_request_id`)
    REFERENCES `pull_requests` (`id`),
  CONSTRAINT `pull_request_commits_ibfk_2`
    FOREIGN KEY (`commit_id`)
    REFERENCES `commits` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `pull_request_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pull_request_history` ;

CREATE TABLE IF NOT EXISTS `pull_request_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `pull_request_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `action` VARCHAR(255) NOT NULL COMMENT '',
  `actor_id` INT(11) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `pull_request_history_ibfk_1`
    FOREIGN KEY (`pull_request_id`)
    REFERENCES `pull_requests` (`id`),
  CONSTRAINT `pull_request_history_ibfk_2`
    FOREIGN KEY (`actor_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `repo_milestones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repo_milestones` ;

CREATE TABLE IF NOT EXISTS `repo_milestones` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `repo_id` INT(11) NULL DEFAULT NULL COMMENT '',
  `name` VARCHAR(24) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `repo_milestones_ibfk_1`
    FOREIGN KEY (`repo_id`)
    REFERENCES `projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `schema_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schema_info` ;

CREATE TABLE IF NOT EXISTS `schema_info` (
  `version` INT(11) NOT NULL DEFAULT '0' COMMENT '')
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `watchers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `watchers` ;

CREATE TABLE IF NOT EXISTS `watchers` (
  `repo_id` INT(11) NOT NULL COMMENT '',
  `user_id` INT(11) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`repo_id`, `user_id`)  COMMENT '',
  CONSTRAINT `watchers_ibfk_1`
    FOREIGN KEY (`repo_id`)
    REFERENCES `projects` (`id`),
  CONSTRAINT `watchers_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

