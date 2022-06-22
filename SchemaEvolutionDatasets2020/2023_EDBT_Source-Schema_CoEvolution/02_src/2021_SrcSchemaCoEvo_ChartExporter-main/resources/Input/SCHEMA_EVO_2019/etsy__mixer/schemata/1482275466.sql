-- MySQL dump 10.13  Distrib 5.5.41-37.0, for Linux (x86_64)
--
-- Host: localhost    Database: mixer
-- ------------------------------------------------------
-- Server version	5.5.41-37.0-log

--
-- Table structure for table `week`
--

DROP TABLE IF EXISTS `week`;
CREATE TABLE `week` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` bigint(20) NOT NULL,
  `date` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255)  NOT NULL,
  `username` text NOT NULL,
  `assistant` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB ;


--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255)  NOT NULL,
  `description` varchar(1000)  NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;

--
-- Table structure for table `odd_person_out`
--

DROP TABLE IF EXISTS `odd_person_out`;
CREATE TABLE `odd_person_out` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person` bigint(20) NOT NULL DEFAULT '0',
  `week_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;

--
-- Table structure for table `pairs`
--

DROP TABLE IF EXISTS `pairs`;
CREATE TABLE `pairs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person1` bigint(20) NOT NULL DEFAULT '0',
  `person2` bigint(20) NOT NULL DEFAULT '0',
  `week_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;


--
-- Table structure for table `people_groups`
--

DROP TABLE IF EXISTS `people_groups`;
CREATE TABLE `people_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `people_id` bigint(20) NOT NULL,
  `groups_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;


--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `auth_username` varchar(128)  NOT NULL DEFAULT '',
  `staff_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `first_name` varchar(128)  NOT NULL DEFAULT '',
  `last_name` varchar(128)  NOT NULL DEFAULT '',
  `title` varchar(128)  NOT NULL DEFAULT '',
  `is_manager` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `avatar` varchar(127)  DEFAULT NULL,
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  ;


-- Dump completed on 2015-09-15 20:30:33
