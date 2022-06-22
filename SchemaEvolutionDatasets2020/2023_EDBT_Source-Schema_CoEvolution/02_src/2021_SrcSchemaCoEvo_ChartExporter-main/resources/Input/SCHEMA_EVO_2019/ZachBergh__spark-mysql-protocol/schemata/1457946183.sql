/*
 Navicat MySQL Data Transfer

 Source Server         : qy-aeris
 Source Server Type    : MySQL
 Source Server Version : 50538
 Source Host           : 192.168.1.9
 Source Database       : aeris_particle

 Target Server Type    : MySQL
 Target Server Version : 50538
 File Encoding         : utf-8

 Date: 02/24/2016 10:03:59 AM
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
  `firmware_version` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_id` (`core_id`) USING BTREE,
  KEY `user_id` (`registrar`) USING BTREE,
  KEY `create_time` (`timestamp`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `core_key`
-- ----------------------------
DROP TABLE IF EXISTS `core_key`;
CREATE TABLE `core_key` (
  `core_id` varchar(255) NOT NULL,
  `claim_code` varchar(255) NOT NULL,
  `public_key` text NOT NULL,
  PRIMARY KEY (`core_id`),
  UNIQUE KEY `cidindex` (`core_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `level` tinyint(1) unsigned NOT NULL,
  `access_token` varchar(500) NOT NULL,
  `claim_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `level` (`level`) USING BTREE,
  KEY `last_heard` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
