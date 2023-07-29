CREATE DATABASE  IF NOT EXISTS `blog_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog_project`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blog_project
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board_category`
--

DROP TABLE IF EXISTS `board_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_category` (
  `category_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '임시저장' COMMENT '''게시판 카테고리 이름''',
  `category_post_cnt` int NOT NULL DEFAULT '0' COMMENT '카테고리에 속하는 게시글 개수',
  `category_num` int NOT NULL DEFAULT '0' COMMENT '게시판 카테고리 번호, 관리자가 바꿀 수 있음',
  PRIMARY KEY (`category_name`),
  UNIQUE KEY `category_name_UNIQUE` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_category`
--

LOCK TABLES `board_category` WRITE;
/*!40000 ALTER TABLE `board_category` DISABLE KEYS */;
INSERT INTO `board_category` VALUES ('JAVA',0,3),('Jquery',0,4),('JSP',0,1),('MySQL',0,2),('tempSaved',0,0);
/*!40000 ALTER TABLE `board_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_comment`
--

DROP TABLE IF EXISTS `board_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_comment` (
  `comment_pk` int NOT NULL AUTO_INCREMENT,
  `comment_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `comment_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `comment_pass` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `comment_datetime` datetime NOT NULL,
  `comment_edited` int DEFAULT NULL,
  `comment_relpy_pk` int DEFAULT NULL,
  `comment_post` int NOT NULL,
  `comment_reply_cnt` int NOT NULL DEFAULT '0',
  `comment_num` int DEFAULT NULL,
  `comment_manager` int DEFAULT NULL,
  `comment_deleted` int DEFAULT NULL,
  PRIMARY KEY (`comment_pk`),
  KEY `comment_relpy_pk_idx` (`comment_relpy_pk`),
  KEY `comment_post_idx` (`comment_post`),
  CONSTRAINT `comment_post` FOREIGN KEY (`comment_post`) REFERENCES `board_post` (`post_pk`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_relpy_pk` FOREIGN KEY (`comment_relpy_pk`) REFERENCES `board_comment` (`comment_pk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='댓글 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_comment`
--

LOCK TABLES `board_comment` WRITE;
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
INSERT INTO `board_comment` VALUES (15,'1','1','1','2023-06-09 00:00:00',NULL,NULL,39,1,1,NULL,NULL),(16,'11111','1','1','2023-05-28 14:29:52',1,NULL,39,-1,1,0,NULL),(19,'3','1','3','2023-05-28 15:33:06',NULL,NULL,39,0,2,17,NULL),(20,'흠','1','1','2023-05-29 00:12:35',NULL,NULL,42,1,3,17,NULL),(21,'dd','1','1','2023-05-29 00:53:58',NULL,NULL,42,-1,3,17,NULL),(22,'삭제된 글입니다.','-','1','2023-05-29 01:00:22',NULL,NULL,42,1,4,17,1),(23,'ㅇㅇ','ㅇㅇ','1','2023-05-29 01:45:15',NULL,NULL,42,-1,4,0,NULL),(24,'1','1','1','2023-05-29 22:10:50',NULL,NULL,34,1,5,0,NULL),(25,'12341234','1','1','2023-05-29 22:11:05',NULL,NULL,34,-1,5,17,NULL),(26,'댓글\r\n','댓글','1','2023-05-31 10:44:39',NULL,NULL,64,2,6,0,NULL),(28,'답글\r\n','ㅇㅇ','1','2023-05-31 10:45:17',NULL,NULL,64,-1,6,0,NULL),(29,'답글22','ㅇㅇ','1','2023-05-31 10:45:36',1,NULL,64,-1,6,0,NULL),(30,'1','manager','1','2023-05-31 11:41:15',NULL,NULL,64,0,7,17,NULL),(31,'1수정','1','1','2023-05-31 13:49:01',1,NULL,65,2,8,0,NULL),(32,'2','2','2','2023-05-31 13:49:09',NULL,NULL,65,0,9,0,NULL),(34,'4 수정','4','4','2023-05-31 13:49:35',1,NULL,65,-1,8,0,NULL),(35,'5','5','5','2023-05-31 13:49:54',NULL,NULL,65,-1,8,0,NULL),(39,'qwer 수정','qwer','qwer','2023-07-26 18:40:12',1,NULL,67,1,11,0,NULL),(40,'qwerrr','qwer','qwer','2023-07-26 18:40:19',NULL,NULL,67,-1,11,0,NULL),(41,'1234','1234','1234','2023-07-26 18:49:05',NULL,NULL,67,2,12,0,NULL),(42,'12345수정','12345수정','12345','2023-07-26 18:49:20',1,NULL,67,-1,12,0,NULL),(43,'123456','123456','123456','2023-07-26 18:49:32',NULL,NULL,67,-1,12,0,NULL),(44,'삭제된 글입니다.','-','123','2023-07-26 18:50:10',NULL,NULL,67,1,13,0,1),(45,'1234','1234','1234','2023-07-26 18:50:15',NULL,NULL,67,-1,13,0,NULL);
/*!40000 ALTER TABLE `board_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_post`
--

DROP TABLE IF EXISTS `board_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_post` (
  `post_pk` int NOT NULL AUTO_INCREMENT COMMENT '게시글 번호\n',
  `post_category` varchar(45) DEFAULT NULL COMMENT '게시판 카테고리 이름',
  `post_title` varchar(200) NOT NULL COMMENT '게시글 제목\\\\n',
  `post_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '게시글 내용\n',
  `post_writer` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '게시글 작성자\\n',
  `post_datetime` datetime NOT NULL COMMENT '작성 날짜\n',
  `post_open` varchar(45) NOT NULL COMMENT '공개/비밀글/비공개',
  `post_ofile` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '원본파일명\n',
  `post_sfile` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '서버에 저장된 파일명\n',
  `post_pass` varchar(45) DEFAULT NULL COMMENT '비밀글인 경우 패스워드\\n',
  `post_edited` int DEFAULT NULL COMMENT '수정되었을경우 1\n',
  `post_visit` int NOT NULL DEFAULT '0' COMMENT '조회수\n',
  `post_comment_cnt` int NOT NULL DEFAULT '0' COMMENT '댓글 개수\n',
  `post_like` int DEFAULT '0',
  PRIMARY KEY (`post_pk`),
  KEY ` category_idx` (`post_category`),
  KEY `post_writer_idx` (`post_writer`),
  CONSTRAINT ` category` FOREIGN KEY (`post_category`) REFERENCES `board_category` (`category_name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_post`
--

LOCK TABLES `board_post` WRITE;
/*!40000 ALTER TABLE `board_post` DISABLE KEYS */;
INSERT INTO `board_post` VALUES (4,NULL,'JSPJSPfadsfd','1234','1','2023-05-22 00:00:00','1',NULL,NULL,NULL,1,3,0,1),(6,NULL,'JSP','1234','1','2023-05-22 00:00:00','2',NULL,NULL,'1234',1,6,0,0),(28,'JAVA','jsp글쓰기','ㄹㅇㄹㄴ','1','2023-05-24 09:41:55','2',NULL,NULL,'1234',1,21,0,11),(29,NULL,'qwer','qwer','1','2023-05-24 17:55:20','1',NULL,NULL,NULL,NULL,1,0,0),(31,'JAVA','임시','저장','1','2023-05-24 17:55:39','3',NULL,NULL,NULL,NULL,2,0,0),(32,NULL,'비밀그ㅡ','ㄹㄹㄹㄹ','1','2023-05-24 17:55:58','2',NULL,NULL,'1234',NULL,29,0,0),(33,'JAVA','null category','1','1','2023-05-24 17:55:58','1',NULL,NULL,NULL,NULL,13,0,46),(34,'JAVA','1','1','1','2023-05-24 17:55:58','1',NULL,NULL,NULL,NULL,16,0,34),(35,NULL,'왜안됨','1234','1','2023-05-25 09:25:40','3',NULL,NULL,NULL,NULL,17,0,0),(36,NULL,'임시저장 비밀글','1','1','2023-05-25 14:05:08','2',NULL,NULL,'1234',NULL,0,0,0),(37,'JAVA','임시저장 비공개','ㄹㄹ','1','2023-05-25 14:05:19','3',NULL,NULL,NULL,NULL,0,0,19),(38,NULL,'임시저장 공개','1','1','2023-05-25 14:05:34','1',NULL,NULL,NULL,NULL,0,0,0),(39,NULL,'jsp 공개','1','1','2023-05-25 14:05:45','1',NULL,NULL,NULL,1,108,0,0),(41,NULL,'jsp 비공개에서 공개로 수정','1','1','2023-05-25 14:06:10','2',NULL,NULL,'1234',1,25,0,0),(42,'JAVA','file','fff','1','2023-05-25 15:15:48','1','파일테스트2.jpg','20230525_151548.jpg',NULL,1,72,0,140),(44,NULL,'30자가넘는제목의경우이렇게표시되는기능이있다30자가넘는제목의경우이렇게표시되는기능이있다30자가넘는제목의경우이렇게표시되는기능이있다','30자가넘는제목의경우이렇게표시되는기능이있다','1','2023-05-26 22:28:37','2',NULL,NULL,'',1,32,0,0),(45,NULL,'첨부파일 nullcate','123124','1','2023-05-27 21:36:04','2','SciTE4AHK_v3.1.0_Install.exe','20230527_213604.exe','',NULL,57,0,0),(46,'Jquery','eeeee','eeeeeeeeeeeeee','1','2023-05-29 23:54:02','2',NULL,NULL,'1234',NULL,0,0,0),(47,'JSP','12341234123','12341244','1','2023-05-29 23:54:55','2','파일테스트2.jpg','20230529_235455.jpg','',1,0,0,0),(48,NULL,'123124','123124','1','2023-05-29 23:55:21','2',NULL,NULL,'',NULL,0,0,0),(49,'JSP','jsp 공개','1234','1','2023-05-30 00:03:49','2',NULL,NULL,'',NULL,0,0,0),(50,'JSP','gstgresg','hstrhsrthrth','1','2023-05-30 01:07:23','2',NULL,NULL,'',NULL,3,0,0),(51,'JSP','safasfefasfe','afasefaefaefsfe','1','2023-05-30 01:10:08','2',NULL,NULL,'',NULL,3,0,0),(52,'JSP','e7uu7e7','ue7ue7u7','1','2023-05-30 01:13:24','1',NULL,NULL,NULL,NULL,3,0,1),(53,'Jquery','afgadfgasg','adfgadfg','1','2023-05-30 01:23:54','1',NULL,NULL,NULL,NULL,3,0,1),(54,'Jquery','1','1','1','2023-05-30 01:29:58','2',NULL,NULL,'1',NULL,6,0,1),(55,'JSP','232','1232','1','2023-05-30 01:30:14','1',NULL,NULL,NULL,1,0,0,0),(58,'JSP','파일테스트','12312','manager','2023-05-30 22:35:48','1','SciTE4AHK_v3.1.0_Install.exe','20230530_223548.exe',NULL,NULL,4,0,0),(59,'JSP','agerwg er','gaerger','manager','2023-05-30 23:06:50','1',NULL,NULL,NULL,1,0,0,0),(60,'JSP','jsp 공개ff','ㄹㄹㄹ','manager','2023-05-30 23:51:10','3',NULL,NULL,NULL,1,3,0,3),(61,NULL,'htyhttt','thththt','manager','2023-05-31 00:06:52','1',NULL,NULL,NULL,NULL,0,0,0),(62,'JAVA','제목이30자를넘으면이렇게표시된다제목이30자를넘으면이렇게표시된다제목이30자를넘으면이렇게표시된다제목이30자를넘으면이렇게표시된다','제목이30자를넘으면이렇게표시된다제목이30자를넘으면이렇게표시된다','manager','2023-05-31 00:54:53','1',NULL,NULL,NULL,NULL,2,0,0),(63,'tempSaved','제목이 30 자를 넘으면 이렇게 표시된다 제목이 30 자를 넘으면 이렇게 표시된다 제목이 30 자를 넘으면 이렇게 표시된다','ㄹ제목이 30 자를 넘으면 이렇게 표시된다','manager','2023-05-31 00:55:55','1',NULL,NULL,NULL,NULL,0,0,0),(64,'JAVA','제목이 30 자를 넘으면 이렇게 표시된다 제목이 30 자를 넘으면 이렇게 표시된다 제목이 30 자를 넘으면 이렇게 표시된다','제목이 30 자를 넘으면 이렇게 표시된다','manager','2023-05-31 00:56:45','1',NULL,NULL,NULL,NULL,14,0,16),(65,'Jquery','네','ㅇㅇ','manager','2023-05-31 11:37:31','1','파일테스트2.jpg','20230531_114655.jpg',NULL,1,9,0,23),(66,'Jquery','비밀글입니다','ㅇ','manager','2023-05-31 11:38:42','2',NULL,NULL,'`',NULL,5,0,0),(67,'MySQL','비밀글','1','manager2','2023-05-31 12:35:52','1',NULL,NULL,NULL,1,20,0,27),(68,'JSP','테스트 게시글 ','첨부파일이 없는 경우','1234','2023-07-26 19:20:02','1',NULL,NULL,NULL,NULL,0,0,0),(69,'JSP','파일','파일','1234','2023-07-26 20:48:55','1','파일테스트2.jpg','20230726_204855.jpg',NULL,NULL,0,0,0);
/*!40000 ALTER TABLE `board_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guestbook`
--

DROP TABLE IF EXISTS `guestbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guestbook` (
  `guestbook_pk` int NOT NULL AUTO_INCREMENT,
  `guestbook_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `guestbook_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `guestbook_pass` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `guestbook_datetime` datetime NOT NULL,
  `guestbook_deleted` int DEFAULT NULL,
  `guestbook_reply_cnt` int NOT NULL DEFAULT '0',
  `guestbook_edited` int DEFAULT '0',
  `guestbook_num` int NOT NULL DEFAULT '0',
  `guestbook_manager` int DEFAULT '0',
  PRIMARY KEY (`guestbook_pk`),
  UNIQUE KEY `guestbook_pk_UNIQUE` (`guestbook_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guestbook`
--

LOCK TABLES `guestbook` WRITE;
/*!40000 ALTER TABLE `guestbook` DISABLE KEYS */;
INSERT INTO `guestbook` VALUES (114,'삭제된 글입니다.','-','1','2023-05-31 10:45:58',1,2,0,1,0),(115,'2','ㅇㅇ','1','2023-05-31 10:49:35',NULL,-1,0,1,0),(116,'3','ㅇㅇ','1','2023-05-31 10:49:54',NULL,-1,0,1,0),(117,'4','ㅇㅇㅇ','1','2023-05-31 10:50:06',NULL,0,0,2,0),(118,'5','manager','5','2023-05-31 11:42:18',NULL,0,0,3,17),(119,'6','manager','6','2023-05-31 11:42:24',NULL,0,0,4,17);
/*!40000 ALTER TABLE `guestbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_number` int NOT NULL AUTO_INCREMENT,
  `manager_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `manager_email` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `manager_pw` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '1234',
  `manager_datetime` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`manager_number`),
  UNIQUE KEY `manager_email_UNIQUE` (`manager_email`),
  UNIQUE KEY `manager_name_UNIQUE` (`manager_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (16,'1234','1234','1234','2023-05-25 21:32:06'),(17,'manager2','1','1','2023-05-25 21:32:43'),(18,'2','2','2','2023-05-31 12:35:11');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor` (
  `date` datetime NOT NULL,
  `total` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES ('2023-05-27 00:00:00',30),('2023-05-28 00:00:00',40),('2023-05-29 00:00:00',119),('2023-05-30 00:00:00',151),('2023-05-31 00:00:00',158),('2023-07-26 00:00:00',159);
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'blog_project'
--

--
-- Dumping routines for database 'blog_project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-26 20:56:49
