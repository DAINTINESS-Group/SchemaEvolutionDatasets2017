/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : coderun_image

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2015-03-10 20:20:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cr_image`
-- ----------------------------
DROP TABLE IF EXISTS `cr_image`;
CREATE TABLE `cr_image` (
  `Image_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `User_id` bigint(20) NOT NULL,
  `Image_name` varchar(255) NOT NULL,
  `Image_realid` varchar(255) NOT NULL,
  `Star` int(11) DEFAULT NULL,
  `Fork` int(11) DEFAULT NULL,
  PRIMARY KEY (`Image_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cr_image
-- ----------------------------
INSERT INTO `cr_image` VALUES ('1', '1', 'ubuntu', '1', '0', '1');
