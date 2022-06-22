/*
 Navicat MySQL Data Transfer

 Source Server         : Antpolis Development
 Source Server Type    : MySQL
 Source Server Version : 50543
 Source Host           : development.a-p.me
 Source Database       : spartan

 Target Server Type    : MySQL
 Target Server Version : 50543
 File Encoding         : utf-8

 Date: 07/12/2015 18:07:19 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `audittrail`
-- ----------------------------
DROP TABLE IF EXISTS `audittrail`;
CREATE TABLE `audittrail` (
  `columnName` varchar(255) DEFAULT NULL,
  `oldValue` varchar(255) DEFAULT NULL,
  `newValue` varchar(255) DEFAULT NULL,
  `modelID` varchar(255) DEFAULT NULL,
  `timestamp` varchar(255) DEFAULT NULL,
  `foreignKey` varchar(255) DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1473 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;
