/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : coderun_image

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2015-03-12 21:35:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cr_comment`
-- ----------------------------
DROP TABLE IF EXISTS `cr_comment`;
CREATE TABLE `cr_comment` (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image_id` bigint(20) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `replyto` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cr_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `cr_comments`
-- ----------------------------
DROP TABLE IF EXISTS `cr_comments`;
CREATE TABLE `cr_comments` (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image_id` bigint(20) NOT NULL,
  `author` varchar(255) NOT NULL,
  `replyto` varchar(255) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cr_comments
-- ----------------------------

-- ----------------------------
-- Table structure for `cr_fork`
-- ----------------------------
DROP TABLE IF EXISTS `cr_fork`;
CREATE TABLE `cr_fork` (
  `fork_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `image_id` bigint(20) NOT NULL,
  PRIMARY KEY (`fork_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cr_fork
-- ----------------------------

-- ----------------------------
-- Table structure for `cr_image`
-- ----------------------------
DROP TABLE IF EXISTS `cr_image`;
CREATE TABLE `cr_image` (
  `Image_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `User_id` bigint(20) NOT NULL,
  `Image_name` varchar(255) NOT NULL,
  `Image_realid` varchar(255) NOT NULL,
  `Star` int(11) NOT NULL DEFAULT '0',
  `Fork` int(11) unsigned NOT NULL DEFAULT '0',
  `Description` text NOT NULL,
  PRIMARY KEY (`Image_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cr_image
-- ----------------------------
INSERT INTO `cr_image` VALUES ('1', '1', 'ubuntu', '1', '0', '1', ' ');
INSERT INTO `cr_image` VALUES ('2', '1', 'test', '22', '0', '0', ' ');

-- ----------------------------
-- Table structure for `cr_star`
-- ----------------------------
DROP TABLE IF EXISTS `cr_star`;
CREATE TABLE `cr_star` (
  `star_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `image_id` bigint(20) NOT NULL,
  PRIMARY KEY (`star_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cr_star
-- ----------------------------
