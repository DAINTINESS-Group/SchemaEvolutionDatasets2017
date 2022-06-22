/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : localhost
 Source Database       : aeris-particle

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : utf-8

 Date: 01/14/2016 16:36:22 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `core`
-- ----------------------------
DROP TABLE IF EXISTS `core`;
CREATE TABLE `core` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `core_id` varchar(255) NOT NULL,
  `registrar` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_id` (`core_id`) USING BTREE,
  KEY `user_id` (`registrar`) USING BTREE,
  KEY `create_time` (`timestamp`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `core_key`
-- ----------------------------
DROP TABLE IF EXISTS `core_key`;
CREATE TABLE `core_key` (
  `core_id` varchar(255) NOT NULL,
  `public_key` text NOT NULL,
  PRIMARY KEY (`core_id`),
  UNIQUE KEY `cidindex` (`core_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
