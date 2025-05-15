/*
Prepare SQL of MYSQL Exam , 2024.05.22
*/
drop database if exists exam2024;
create database if not exists exam2024;
USE exam2024;

-- ----------------------------
-- Table structure for department
-- ----------------------------
CREATE TABLE `department`  (
  `departmentId` char(3) PRIMARY KEY NOT NULL ,
  `name` varchar(50) NOT NULL
) ;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('101', '数学学院');
INSERT INTO `department` VALUES ('102', '计算机学院');
INSERT INTO `department` VALUES ('103', '外语学院');
INSERT INTO `department` VALUES ('104', '物理学院');
INSERT INTO `department` VALUES ('105', '电气学院');
INSERT INTO `department` VALUES ('106', '马克思主义学院');
INSERT INTO `department` VALUES ('107', '哲学院');

-- ----------------------------
-- Table structure for stu
-- ----------------------------
CREATE TABLE `stu`  (
  `stuid` char(8) NOT NULL,
  `name` varchar(20) NULL DEFAULT NULL,
  `sex` enum('男','女') NULL DEFAULT '男',
  `departmentId` char(3) NOT NULL references department(departmentId),
  `birthday` date NOT NULL,
  `favorite` set('运动', '音乐', '舞蹈', '旅游') NULL,
  PRIMARY KEY (`stuid`) 
) ;

CREATE TABLE `stu2`  (
  `stuid` char(8) NOT NULL,
  `name` varchar(20) NULL DEFAULT NULL,
  PRIMARY KEY (`stuid`) 
) ;

-- ----------------------------
-- Records of stu
-- ----------------------------
INSERT INTO `stu` VALUES ('20191001', '许和雅', '女', '102', '2001-01-12', NULL);
INSERT INTO `stu` VALUES ('20191002', '冯红云', '女', '103', '2001-05-10', NULL);
INSERT INTO `stu` VALUES ('20191003', '冯海', '男', '103', '2000-12-10', NULL);
INSERT INTO `stu` VALUES ('20191004', '刘一凡', '男', '105', '2001-12-02', NULL);
INSERT INTO `stu` VALUES ('20201001', '张三', '男', '101', '2001-08-11', NULL);
INSERT INTO `stu` VALUES ('20201002', '李四', '男', '102', '2001-05-12', NULL);
INSERT INTO `stu` VALUES ('20201003', '王五', '女', '103', '2001-09-26', NULL);
INSERT INTO `stu` VALUES ('20201004', '赵六', '女', '101', '2000-09-12', NULL);
INSERT INTO `stu` VALUES ('20201005', '高兴', '男', '103', '2001-10-09', NULL);
INSERT INTO `stu` VALUES ('20211001', '韦俊豪', '男', '101', '2001-11-07', NULL);
INSERT INTO `stu` VALUES ('20211002', '雷淳雅', '女', '101', '2001-03-20', NULL);
INSERT INTO `stu` VALUES ('20211003', '李磊', '男', '104', '2001-07-16', NULL);

-- ----------------------------
-- Table structure for course
-- ----------------------------
CREATE TABLE `course`  (
  `courseid` int NOT NULL,
  `name` varchar(20) NULL
) ;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (101, '数学');
INSERT INTO `course` VALUES (102, '英语');
INSERT INTO `course` VALUES (103, '计算机');
INSERT INTO `course` VALUES (104, '物理');
INSERT INTO `course` VALUES (105, '政治');
INSERT INTO `course` VALUES (106, '法语');

-- ----------------------------
-- Table structure for score
-- ----------------------------
CREATE TABLE `score`  (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `stuid` char(13) NOT NULL REFERENCES `stu` (`stuid`) ,
  `courseid` int NOT NULL REFERENCES `course` (`courseid`) ,
  `score` int NULL DEFAULT 0
) ;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (1, '20201001', 103, 99);
INSERT INTO `score` VALUES (2, '20201002', 101, 77);
INSERT INTO `score` VALUES (3, '20201001', 101, 65);
INSERT INTO `score` VALUES (4, '20201003', 101, 88);
INSERT INTO `score` VALUES (5, '20201002', 102, 98);
INSERT INTO `score` VALUES (6, '20211001', 103, 91);
INSERT INTO `score` VALUES (7, '20191002', 102, 82);
INSERT INTO `score` VALUES (8, '20191002', 101, 63);
INSERT INTO `score` VALUES (9, '20201003', 103, 71);
INSERT INTO `score` VALUES (10, '20201001', 104, 72);
INSERT INTO `score` VALUES (11, '20201003', 104, 94);
INSERT INTO `score` VALUES (12, '20201003', 102, 77);
INSERT INTO `score` VALUES (13, '20201004', 103, 82);
INSERT INTO `score` VALUES (14, '20211001', 104, 78);
INSERT INTO `score` VALUES (15, '20191003', 104, 74);
INSERT INTO `score` VALUES (16, '20211002', 102, 87);
INSERT INTO `score` VALUES (17, '20211001', 101, 51);
INSERT INTO `score` VALUES (18, '20201004', 101, 86);
INSERT INTO `score` VALUES (19, '20201001', 102, 84);
INSERT INTO `score` VALUES (20, '20201002', 103, 94);
INSERT INTO `score` VALUES (21, '20201002', 104, 48);
INSERT INTO `score` VALUES (29, '20191001', 101, 85);
INSERT INTO `score` VALUES (30, '20211002', 104, 82);
INSERT INTO `score` VALUES (31, '20191001', 103, 90);
INSERT INTO `score` VALUES (34, '20191004', 101, 68);
INSERT INTO `score` VALUES (35, '20211003', 102, 80);
INSERT INTO `score` VALUES (36, '20191004', 103, 83);
INSERT INTO `score` VALUES (37, '20191004', 105, 91);
INSERT INTO `score` VALUES (38, '20211002', 105, 84);
INSERT INTO `score` VALUES (39, '20211001', 105, 70);
INSERT INTO `score` VALUES (40, '20211002', 103, 88);

USE exam2024;