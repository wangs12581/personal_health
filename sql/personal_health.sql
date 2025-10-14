/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : personal_health

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 05/10/2025 12:26:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `user_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `user_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `user_role` int NULL DEFAULT NULL COMMENT '用户角色',
  `is_login` tinyint(1) NULL DEFAULT NULL COMMENT '可登录状态(0：可用，1：不可用)',
  `is_word` tinyint(1) NULL DEFAULT NULL COMMENT '禁言状态(0：可用，1：不可用)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '用户注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'B站辰星', '14e1b600b1fd579f47433b88e8d85291', '/api/personal-heath/v1.0/file/getFile?fileName=1ecfe5apic_8.jpg', '1343243@qq.com', 1, 0, 0, '2024-07-09 12:53:05');
INSERT INTO `user` VALUES (3, 'yangshu', '黄河以北', '14e1b600b1fd579f47433b88e8d85291', '/api/personal-heath/v1.0/file/getFile?fileName=0b868a1pic_2.jpg', '1134123@qq.com', 2, 0, 0, '2024-07-14 12:53:05');
INSERT INTO `user` VALUES (8, 'aiqin', '爱琴', '14e1b600b1fd579f47433b88e8d85291', '/api/personal-heath/v1.0/file/getFile?fileName=b49c75fpic_1.jpg', '123@qq.coom', 2, 1, 0, '2024-07-11 12:53:05');
INSERT INTO `user` VALUES (9, 'wanghai', '实战项目营', '14e1b600b1fd579f47433b88e8d85291', '/api/personal-heath/v1.0/file/getFile?fileName=b743550pic_6.jpg', '1243@qq.com', 2, 0, 0, '2024-07-14 13:56:44');

SET FOREIGN_KEY_CHECKS = 1;
