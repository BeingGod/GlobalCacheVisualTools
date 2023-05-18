/*
 Navicat Premium Data Transfer

 Source Server         : 175.34.8.36
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : 175.34.8.36:3306
 Source Schema         : xxl_job

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 10/05/2023 09:41:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xxl_job_group
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_group`;
CREATE TABLE `xxl_job_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行器名称',
  `address_type` tinyint NOT NULL DEFAULT 0 COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行器地址列表，多地址逗号分隔',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_group
-- ----------------------------
INSERT INTO `xxl_job_group` VALUES (3, 'xxl-job-executor-hw', 'HWBackend', 0, 'http://127.0.0.1:8083/', '2023-05-10 09:41:35');

-- ----------------------------
-- Table structure for xxl_job_info
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_info`;
CREATE TABLE `xxl_job_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_group` int NOT NULL COMMENT '执行器主键ID',
  `job_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报警邮件',
  `schedule_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NONE' COMMENT '调度类型',
  `schedule_conf` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '调度配置，值含义取决于调度类型',
  `misfire_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DO_NOTHING' COMMENT '调度过期策略',
  `executor_route_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `glue_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime NULL DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  `trigger_status` tinyint NOT NULL DEFAULT 0 COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint NOT NULL DEFAULT 0 COMMENT '上次调度时间',
  `trigger_next_time` bigint NOT NULL DEFAULT 0 COMMENT '下次调度时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_info
-- ----------------------------
INSERT INTO `xxl_job_info` VALUES (67, 3, 'saveCpuCalender', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'saveCpuCalender', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (68, 3, 'saveDisk', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'saveDisk', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (69, 3, 'saveMemory', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'saveMemory', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (70, 3, 'saveNetwork', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'saveNetwork', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (71, 3, 'saveIprelation', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/30 * * * * ?', 'DO_NOTHING', 'ROUND', 'saveIprelation', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682890000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (72, 3, 'saveHealthList', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '3 0/10 * * * ?', 'DO_NOTHING', 'ROUND', 'saveHealthList', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682803000, 1683683403000);
INSERT INTO `xxl_job_info` VALUES (73, 3, 'saveCpu', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'saveCpu', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (74, 3, 'savePgList', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '5 0/10 * * * ?', 'DO_NOTHING', 'ROUND', 'savePgList', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682805000, 1683683405000);
INSERT INTO `xxl_job_info` VALUES (75, 3, 'savePtList', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '10 0/10 * * * ?', 'DO_NOTHING', 'ROUND', 'savePtList', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682810000, 1683683410000);
INSERT INTO `xxl_job_info` VALUES (76, 3, 'getNetData', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'getNetData', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (77, 3, 'getDiskData', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'getDiskData', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (78, 3, 'getMemoryData', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'getMemoryData', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (79, 3, 'getCpuData', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'getCpuData', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (80, 3, 'getCpuCalender', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '0/5 * * * * ?', 'DO_NOTHING', 'ROUND', 'getCpuCalender', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683682915000, 1683682920000);
INSERT INTO `xxl_job_info` VALUES (81, 3, 'deleteLoginUser', '2023-03-24 23:46:57', '2023-03-24 23:46:57', 'Faker', NULL, 'CRON', '* * 5 * * ?', 'DO_NOTHING', 'ROUND', 'deleteLoginUser', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-03-24 23:46:57', NULL, 1, 1683666000000, 1683752400000);
INSERT INTO `xxl_job_info` VALUES (84, 3, 'deleteData', '2023-05-05 17:37:10', '2023-05-05 17:37:10', 'Faker', NULL, 'CRON', '0 0 0 * * ?', 'DO_NOTHING', 'ROUND', 'deleteData', NULL, 'SERIAL_EXECUTION', 0, 0, 'BEAN', NULL, 'GLUE代码初始化', '2023-05-05 17:37:10', NULL, 1, 1683648000000, 1683734400000);

-- ----------------------------
-- Table structure for xxl_job_lock
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_lock`;
CREATE TABLE `xxl_job_lock`  (
  `lock_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_lock
-- ----------------------------
INSERT INTO `xxl_job_lock` VALUES ('schedule_lock');

-- ----------------------------
-- Table structure for xxl_job_log
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log`;
CREATE TABLE `xxl_job_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_group` int NOT NULL COMMENT '执行器主键ID',
  `job_id` int NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `trigger_time` datetime NULL DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int NOT NULL COMMENT '调度-结果',
  `trigger_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '调度-日志',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int NOT NULL COMMENT '执行-状态',
  `handle_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行-日志',
  `alarm_status` tinyint NOT NULL DEFAULT 0 COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `I_trigger_time`(`trigger_time` ASC) USING BTREE,
  INDEX `I_handle_code`(`handle_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1110766 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_log
-- ----------------------------
INSERT INTO `xxl_job_log` VALUES (1110716, 3, 67, 'http://127.0.0.1:8083/', 'saveCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:35', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110717, 3, 80, 'http://127.0.0.1:8083/', 'getCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:37', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110718, 3, 77, 'http://127.0.0.1:8083/', 'getDiskData', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110719, 3, 78, 'http://127.0.0.1:8083/', 'getMemoryData', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110720, 3, 79, 'http://127.0.0.1:8083/', 'getCpuData', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:35', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110721, 3, 73, 'http://127.0.0.1:8083/', 'saveCpu', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110722, 3, 76, 'http://127.0.0.1:8083/', 'getNetData', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110723, 3, 68, 'http://127.0.0.1:8083/', 'saveDisk', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110724, 3, 69, 'http://127.0.0.1:8083/', 'saveMemory', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110725, 3, 70, 'http://127.0.0.1:8083/', 'saveNetwork', NULL, NULL, 0, '2023-05-10 09:41:35', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:36', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110726, 3, 68, 'http://127.0.0.1:8083/', 'saveDisk', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:41', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110727, 3, 67, 'http://127.0.0.1:8083/', 'saveCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:42', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110728, 3, 70, 'http://127.0.0.1:8083/', 'saveNetwork', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:42', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110729, 3, 73, 'http://127.0.0.1:8083/', 'saveCpu', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:43', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110730, 3, 80, 'http://127.0.0.1:8083/', 'getCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:43', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110731, 3, 79, 'http://127.0.0.1:8083/', 'getCpuData', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:42', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110732, 3, 77, 'http://127.0.0.1:8083/', 'getDiskData', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:42', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110733, 3, 69, 'http://127.0.0.1:8083/', 'saveMemory', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:41', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110734, 3, 76, 'http://127.0.0.1:8083/', 'getNetData', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:42', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110735, 3, 78, 'http://127.0.0.1:8083/', 'getMemoryData', NULL, NULL, 0, '2023-05-10 09:41:40', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:42', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110736, 3, 67, 'http://127.0.0.1:8083/', 'saveCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:45', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110737, 3, 70, 'http://127.0.0.1:8083/', 'saveNetwork', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:47', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110738, 3, 80, 'http://127.0.0.1:8083/', 'getCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:46', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110739, 3, 77, 'http://127.0.0.1:8083/', 'getDiskData', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:47', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110740, 3, 69, 'http://127.0.0.1:8083/', 'saveMemory', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:46', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110741, 3, 73, 'http://127.0.0.1:8083/', 'saveCpu', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:45', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110742, 3, 78, 'http://127.0.0.1:8083/', 'getMemoryData', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:46', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110743, 3, 76, 'http://127.0.0.1:8083/', 'getNetData', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:46', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110744, 3, 68, 'http://127.0.0.1:8083/', 'saveDisk', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:47', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110745, 3, 79, 'http://127.0.0.1:8083/', 'getCpuData', NULL, NULL, 0, '2023-05-10 09:41:45', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:46', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110746, 3, 67, 'http://127.0.0.1:8083/', 'saveCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:50', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110747, 3, 68, 'http://127.0.0.1:8083/', 'saveDisk', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:51', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110748, 3, 76, 'http://127.0.0.1:8083/', 'getNetData', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:51', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110749, 3, 79, 'http://127.0.0.1:8083/', 'getCpuData', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:51', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110750, 3, 78, 'http://127.0.0.1:8083/', 'getMemoryData', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:51', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110751, 3, 73, 'http://127.0.0.1:8083/', 'saveCpu', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:52', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110752, 3, 69, 'http://127.0.0.1:8083/', 'saveMemory', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:51', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110753, 3, 77, 'http://127.0.0.1:8083/', 'getDiskData', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:52', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110754, 3, 70, 'http://127.0.0.1:8083/', 'saveNetwork', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:51', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110755, 3, 80, 'http://127.0.0.1:8083/', 'getCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:50', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:50', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110756, 3, 80, 'http://127.0.0.1:8083/', 'getCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110757, 3, 70, 'http://127.0.0.1:8083/', 'saveNetwork', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110758, 3, 67, 'http://127.0.0.1:8083/', 'saveCpuCalender', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:57', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110759, 3, 76, 'http://127.0.0.1:8083/', 'getNetData', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110760, 3, 78, 'http://127.0.0.1:8083/', 'getMemoryData', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110761, 3, 77, 'http://127.0.0.1:8083/', 'getDiskData', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110762, 3, 79, 'http://127.0.0.1:8083/', 'getCpuData', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:57', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110763, 3, 73, 'http://127.0.0.1:8083/', 'saveCpu', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110764, 3, 68, 'http://127.0.0.1:8083/', 'saveDisk', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (1110765, 3, 69, 'http://127.0.0.1:8083/', 'saveMemory', NULL, NULL, 0, '2023-05-10 09:41:55', 200, '任务触发类型：Cron触发<br>调度机器：175.34.8.36<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://127.0.0.1:8083/]<br>路由策略：轮询<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://127.0.0.1:8083/<br>code：200<br>msg：null', '2023-05-10 09:41:56', 200, '', 0);

-- ----------------------------
-- Table structure for xxl_job_log_report
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log_report`;
CREATE TABLE `xxl_job_log_report`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `trigger_day` datetime NULL DEFAULT NULL COMMENT '调度-时间',
  `running_count` int NOT NULL DEFAULT 0 COMMENT '运行中-日志数量',
  `suc_count` int NOT NULL DEFAULT 0 COMMENT '执行成功-日志数量',
  `fail_count` int NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_trigger_day`(`trigger_day` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_log_report
-- ----------------------------
INSERT INTO `xxl_job_log_report` VALUES (1, '2023-02-26 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (2, '2023-02-25 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (3, '2023-02-24 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (4, '2023-02-27 00:00:00', 3485, 3848, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (5, '2023-03-02 00:00:00', 1053, 59, 4, NULL);
INSERT INTO `xxl_job_log_report` VALUES (6, '2023-03-01 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (7, '2023-02-28 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (8, '2023-03-06 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (9, '2023-03-05 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (10, '2023-03-04 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (11, '2023-03-07 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (12, '2023-03-08 00:00:00', 22, 50328, 8073, NULL);
INSERT INTO `xxl_job_log_report` VALUES (13, '2023-03-09 00:00:00', 10, 2952, 9263, NULL);
INSERT INTO `xxl_job_log_report` VALUES (14, '2023-03-10 00:00:00', 6, 9045, 5789, NULL);
INSERT INTO `xxl_job_log_report` VALUES (15, '2023-03-12 00:00:00', 0, 0, 380, NULL);
INSERT INTO `xxl_job_log_report` VALUES (16, '2023-03-11 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (17, '2023-03-13 00:00:00', 0, 870, 2135, NULL);
INSERT INTO `xxl_job_log_report` VALUES (18, '2023-03-14 00:00:00', 9, 2629, 1432, NULL);
INSERT INTO `xxl_job_log_report` VALUES (19, '2023-03-15 00:00:00', 29, 37612, 11074, NULL);
INSERT INTO `xxl_job_log_report` VALUES (20, '2023-03-16 00:00:00', 128, 66753, 20073, NULL);
INSERT INTO `xxl_job_log_report` VALUES (21, '2023-03-17 00:00:00', 160, 69046, 21635, NULL);
INSERT INTO `xxl_job_log_report` VALUES (22, '2023-03-18 00:00:00', 133, 54490, 27951, NULL);
INSERT INTO `xxl_job_log_report` VALUES (23, '2023-03-19 00:00:00', 31, 38905, 7070, NULL);
INSERT INTO `xxl_job_log_report` VALUES (24, '2023-03-20 00:00:00', 71, 165943, 29907, NULL);
INSERT INTO `xxl_job_log_report` VALUES (25, '2023-03-21 00:00:00', 40, 54994, 30346, NULL);
INSERT INTO `xxl_job_log_report` VALUES (26, '2023-03-22 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (27, '2023-03-23 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (28, '2023-03-24 00:00:00', 0, 1409, 171, NULL);
INSERT INTO `xxl_job_log_report` VALUES (29, '2023-03-25 00:00:00', 71, 3179, 1733, NULL);
INSERT INTO `xxl_job_log_report` VALUES (30, '2023-05-05 00:00:00', 9, 26366, 13984, NULL);
INSERT INTO `xxl_job_log_report` VALUES (31, '2023-05-04 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (32, '2023-05-03 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (33, '2023-05-06 00:00:00', 0, 3156, 4874, NULL);
INSERT INTO `xxl_job_log_report` VALUES (34, '2023-05-07 00:00:00', 0, 27539, 2429, NULL);
INSERT INTO `xxl_job_log_report` VALUES (35, '2023-05-08 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (36, '2023-05-09 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (37, '2023-05-10 00:00:00', 1, 110, 0, NULL);

-- ----------------------------
-- Table structure for xxl_job_logglue
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_logglue`;
CREATE TABLE `xxl_job_logglue`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'GLUE备注',
  `add_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_logglue
-- ----------------------------

-- ----------------------------
-- Table structure for xxl_job_registry
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_registry`;
CREATE TABLE `xxl_job_registry`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registry_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registry_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i_g_k_v`(`registry_group` ASC, `registry_key` ASC, `registry_value` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 465 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_registry
-- ----------------------------
INSERT INTO `xxl_job_registry` VALUES (464, 'EXECUTOR', 'xxl-job-executor-hw', 'http://127.0.0.1:8083/', '2023-05-10 09:42:41');

-- ----------------------------
-- Table structure for xxl_job_user
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_user`;
CREATE TABLE `xxl_job_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `role` tinyint NOT NULL COMMENT '角色：0-普通用户、1-管理员',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_user
-- ----------------------------
INSERT INTO `xxl_job_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;
