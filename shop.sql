/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-10-21 16:34:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ky_permission
-- ----------------------------
DROP TABLE IF EXISTS `ky_permission`;
CREATE TABLE `ky_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `permission_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `permission_sign` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `sort_id` int(11) unsigned NOT NULL,
  `version` int(11) unsigned NOT NULL DEFAULT '0',
  `create_user_id` int(11) unsigned NOT NULL,
  `last_update_user_id` int(11) unsigned NOT NULL,
  `create_datetime` datetime NOT NULL,
  `last_update_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ky_permission
-- ----------------------------
INSERT INTO `ky_permission` VALUES ('1', '超级权限', '超级权限', '*:*', '0', '1', '1', '1', '2017-08-16 19:45:38', '2017-09-13 20:57:55');

-- ----------------------------
-- Table structure for ky_role
-- ----------------------------
DROP TABLE IF EXISTS `ky_role`;
CREATE TABLE `ky_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `role_sign` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `sort_id` int(11) unsigned NOT NULL,
  `version` int(11) unsigned NOT NULL DEFAULT '0',
  `create_user_id` int(11) unsigned NOT NULL,
  `last_update_user_id` int(11) unsigned NOT NULL,
  `create_datetime` datetime NOT NULL,
  `last_update_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ky_role
-- ----------------------------
INSERT INTO `ky_role` VALUES ('1', '管理员', '管理员', '管理员', '0', '0', '1', '1', '2017-08-16 19:44:25', '2017-08-16 19:44:29');

-- ----------------------------
-- Table structure for ky_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `ky_role_permission`;
CREATE TABLE `ky_role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  UNIQUE KEY `idx_permission_role` (`permission_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ky_role_permission
-- ----------------------------
INSERT INTO `ky_role_permission` VALUES ('1', '1');

-- ----------------------------
-- Table structure for ky_user
-- ----------------------------
DROP TABLE IF EXISTS `ky_user`;
CREATE TABLE `ky_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `password` char(32) COLLATE utf8mb4_bin NOT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_bin NOT NULL,
  `sort_id` int(11) unsigned NOT NULL,
  `version` int(11) unsigned NOT NULL DEFAULT '0',
  `create_user_id` int(11) NOT NULL,
  `last_update_user_id` int(11) NOT NULL,
  `create_datetime` datetime NOT NULL,
  `last_update_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_36ms43yrs7rfdj69jblgg5rl0` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ky_user
-- ----------------------------
INSERT INTO `ky_user` VALUES ('1', 'admin', '6825f86ba597e07b4a450a1e858d5216', '15905712648', '超级管理员', '401782372@qq.com', 'D', '0', '2', '1', '1', '2017-03-02 10:17:51', '2017-08-16 21:18:17');

-- ----------------------------
-- Table structure for ky_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ky_user_role`;
CREATE TABLE `ky_user_role` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  UNIQUE KEY `idx_role_user` (`role_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of ky_user_role
-- ----------------------------
INSERT INTO `ky_user_role` VALUES ('1', '1');
