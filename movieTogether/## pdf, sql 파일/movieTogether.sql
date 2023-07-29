-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 58.239.58.243    Database: java505_team2_db
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `board_pk` int NOT NULL AUTO_INCREMENT,
  `board_title` varchar(50) NOT NULL,
  `board_writer` varchar(50) NOT NULL COMMENT 'member 테이블의 member_name 을 참조합니다. member_name값 변경시  board_writer의 값도 변경(cascade),  member_name값 삭제시  board_writer값은 그대로(no action) 유지됩니다.',
  `board_content` varchar(2000) NOT NULL,
  `board_date` datetime NOT NULL,
  `board_visit_cnt` int NOT NULL DEFAULT '0',
  `board_delete_yn` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`board_pk`),
  KEY `board_name_idx` (`board_writer`),
  CONSTRAINT `board_name` FOREIGN KEY (`board_writer`) REFERENCES `member` (`member_name`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,'수정된 제목1','test','수정된 내용 1 입니다. 수정했어용','2023-06-30 16:10:58',31,'N'),(2,'재수정된 제목3','test','재수정된 내용 3 입니다.','2023-06-30 16:11:24',27,'N'),(3,'수정된 제목2','test','수정된 내용 2 입니다.','2023-06-30 16:11:59',9,'N'),(4,'테스트 제목4','test','테스트 내용4','2023-07-03 13:59:28',4,'N'),(5,'테스트 글 제목입니다.','test','테스트 글 내용입니다.','2023-07-04 15:39:08',1,'N'),(6,'테스트 글 제목2 입니다.','test','테스트 글 내용2 입니다.','2023-07-04 15:39:30',3,'N'),(7,'긴 글 테스트입니다 ','test','모래뿐일 찬미를 되려니와, 쓸쓸한 그것은 피다. 청춘의 투명하되 밝은 못하다 없으면, 안고, 뛰노는 약동하다. 청춘의 것은 석가는 구할 있을 말이다. 노년에게서 가슴이 구하지 인간이 사는가 위하여, 그들의 얼음 그리하였는가? 그들의 피고, 오아이스도 무엇을 끓는다. 무엇을 아니한 이상의 황금시대의 쓸쓸하랴? 튼튼하며, 그들은 피에 끝까지 우리 커다란 위하여서. 발휘하기 방지하는 있는 사랑의 평화스러운 그들은 할지니, 천자만홍이 놀이 것이다. 아름답고 천지는 행복스럽고 운다.\r\n\r\n행복스럽고 따뜻한 트고, 그들을 방황하였으며, 붙잡아 무엇을 끓는다. 구하지 아름답고 무엇을 가진 않는 있는 그와 이상, 방지하는 부패뿐이다. 트고, 듣기만 있을 고동을 위하여서. 것이 별과 않는 생의 사랑의 많이 듣는다. 힘차게 설레는 하여도 속잎나고, 우리 무엇이 봄바람이다. 방황하였으며, 있는 노래하며 눈이 있다. 싹이 불어 장식하는 수 꾸며 열락의 가치를 물방아 꽃이 약동하다. 많이 인생에 보는 그들은 황금시대다. 두기 생명을 들어 위하여 새가 방황하여도, 피다. 행복스럽고 그들에게 남는 이것이다.\r\n\r\n이상이 끝에 인류의 어디 창공에 있음으로써 품었기 그들은 듣는다. 얼음이 커다란 불어 때문이다. 튼튼하며, 꾸며 곧 위하여서, 이것은 청춘의 바로 무엇을 수 끓는다. 살았으며, 얼음과 소담스러운 운다. 풀이 이상, 꽃이 얼마나 가슴에 풀이 봄바람이다. 자신과 피부가 힘차게 못하다 같으며, 영원히 있는가? 과실이 때에, 꽃이 못하다 인간의 피가 것이다. 이상의 하는 고행을 사막이다. 용기가 할지니, 심장은 그들의 있으며, 작고 것이다. 것은 것이 고행을 그들의 투명하되 위하여 붙잡아 칼이다.','2023-07-04 15:44:09',11,'N'),(8,'수정된 테스트 제목1','test','보내는 무엇을 무한한 하였으며, 현저하게 과실이 꽃 철환하였는가? 간에 석가는 군영과 가지에 이것을 방지하는 풍부하게 아름다우냐? 그들의 꽃이 그림자는 천지는 그들은 싶이 이것이다. 오직 가치를 것은 가치를 아름다우냐? 주며, 웅대한 길을 청춘이 사라지지 위하여서. 싶이 피는 위하여, 운다. 들어 이상은 평화스러운 때에, 되는 인간은 지혜는 얼마나 위하여서 뿐이다. 긴지라 노년에게서 설산에서 운다. 청춘을 방지하는 청춘에서만 끝까지 살 이것이야말로 얼마나 듣는다.\r\n\r\n내려온 하여도 미묘한 가치를 그와 얼마나 원대하고, 기관과 그들을 봄바람이다. 어디 이상의 무엇을 것이다. 설레는 그들에게 그들은 사라지지 피어나기 내는 구하기 듣는다. 기쁘며, 오아이스도 가치를 가치를 낙원을 끝에 있으랴? 같이 피가 같이, 봄날의 인간이 살 이것이다. 거선의 실로 밝은 있다. 별과 커다란 것은 커다란 싹이 원대하고, 꾸며 약동하다. 위하여 풍부하게 품고 끓는 인간의 희망의 웅대한 그들의 있으랴? 속에서 찬미를 방황하여도, 길지 발휘하기 인생에 같이, 미인을 아름다우냐? 몸이 뛰노는 곧 것이다. 것이 풀이 가지에 방황하였으며, 같이, 열매를 사막이다.','2023-07-04 15:45:29',21,'N'),(9,'테스트 제목입니다.','test','테스트 내용입니다.','2023-07-05 11:32:12',8,'N'),(10,'수정된 테스트 제목1','test','수정된 테스트 내용1 ','2023-07-05 11:33:43',17,'Y'),(11,'안녕하세요','test','네','2023-07-05 12:43:40',20,'N'),(12,'관리자 글입니다.','관리자','관리자 글 내용입니다.','2023-07-05 15:05:17',13,'N'),(13,'게시판 파일 테스트','관리자','게시판 파일 테스트','2023-07-07 15:48:36',0,'N'),(14,'게시판 파일 테스트','관리자','게시판 파일 테스트','2023-07-07 15:49:00',7,'N'),(15,'게시판 파일 테스트','관리자','게시판 파일 테스트','2023-07-07 15:49:15',13,'N'),(16,'파일 업로드 테스트 글 제목입니다.','관리자','파일 업로드 테스트 글 내용입니다.','2023-07-07 15:53:52',74,'N'),(17,'안녕하세요','w','네','2023-07-09 22:56:59',25,'N'),(18,'테스트 글쓰기 입니다','test','네','2023-07-13 09:24:34',2,'N'),(19,'테스트 글쓰기','test','네','2023-07-13 09:25:01',0,'N'),(20,'테스트 글쓰기','test','네','2023-07-13 09:25:04',0,'N'),(21,'테스트 글쓰기','test','네','2023-07-13 09:25:12',0,'N'),(22,'테스트 글쓰기','test','네','2023-07-13 09:25:40',7,'N');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_file`
--

DROP TABLE IF EXISTS `board_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_file` (
  `board_file_id` int NOT NULL AUTO_INCREMENT,
  `board_pk` int NOT NULL,
  `board_ofile_name` varchar(200) NOT NULL,
  `board_sfile_name` varchar(100) NOT NULL,
  `board_file_size` int NOT NULL DEFAULT '0',
  `board_created_date` datetime NOT NULL,
  `board_select` int NOT NULL DEFAULT '1' COMMENT '1 : board 게시판\n2: qna 게시판',
  PRIMARY KEY (`board_file_id`),
  KEY `board_pk_idx` (`board_pk`),
  CONSTRAINT `board_pk` FOREIGN KEY (`board_pk`) REFERENCES `board` (`board_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_file`
--

LOCK TABLES `board_file` WRITE;
/*!40000 ALTER TABLE `board_file` DISABLE KEYS */;
INSERT INTO `board_file` VALUES (1,1,'test_image_1.jpg','123456.jpg',12345,'2023-07-04 10:26:12',1),(2,6,'02.jpg','C:/upload/2023-07-04/6359568201000.jpg',123979,'2023-07-04 15:39:30',1),(3,7,'003.jpg','C:/upload/2023-07-04/6639213135400.jpg',87877,'2023-07-04 15:44:09',1),(4,11,'상세페이지.png','C:/upload/2023-07-05/13301917232500.png',89834,'2023-07-05 12:43:40',1),(5,1,'test_file.jpg','1234567.jpg',12345,'2023-07-06 10:17:01',2),(6,7,'food05.jpg','C:/upload/qna/2023-07-06/179710716733900.jpg',23082,'2023-07-06 15:48:33',2),(7,8,'cafe_03.jpg','C:/upload/qna/2023-07-06/179734001614200.jpg',30674,'2023-07-06 15:48:56',2),(8,9,'04.jpg','C:/upload/qna/2023-07-07/246218430565300.jpg',27028,'2023-07-07 10:16:56',2),(9,16,'03.jpg','C:/upload/board/2023-07-07/266434532170200.jpg',161195,'2023-07-07 15:53:52',1),(10,16,'04.jpg','C:/upload/board/2023-07-07/266434533063800.jpg',27028,'2023-07-07 15:53:52',1),(11,22,'파일테스트2.jpg','C:/upload/board/2023-07-13/1331243698300.jpg',52294,'2023-07-13 09:25:40',1);
/*!40000 ALTER TABLE `board_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_pk` int NOT NULL COMMENT '카테고리 번호',
  `category_name` varchar(50) NOT NULL COMMENT '카테고리 이름',
  PRIMARY KEY (`category_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (0,'문의'),(1,'영화'),(2,'회원정보');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_pk` int NOT NULL AUTO_INCREMENT,
  `comment_content` varchar(1000) NOT NULL,
  `comment_id` varchar(50) NOT NULL COMMENT '로그인한 댓글 작성자 ',
  `comment_date` datetime NOT NULL,
  `comment_delete_yn` char(1) NOT NULL DEFAULT 'N',
  `comment_num` int NOT NULL COMMENT '답글 표시할 게시글 번호',
  PRIMARY KEY (`comment_pk`),
  KEY `fk_name_idx` (`comment_id`),
  KEY `fk_board_num_idx` (`comment_num`),
  CONSTRAINT `fk_board_name` FOREIGN KEY (`comment_id`) REFERENCES `member` (`member_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_board_num` FOREIGN KEY (`comment_num`) REFERENCES `board` (`board_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'댓글 입력 테스트입니다.','test','2023-07-10 01:33:14','N',14),(3,'댓글','w','2023-07-10 09:09:47','N',17),(5,'댓글 입력 테스트입니다 1 ','관리자','2023-07-10 09:50:16','Y',16),(6,'댓글 입력 테스트입니다 2','관리자','2023-07-10 09:50:24','N',16),(7,'댓글 입력 테스트입니다 3 ','관리자','2023-07-10 10:28:58','N',16),(8,'테스트 댓글','test','2023-07-13 09:26:03','N',22),(9,'댓글 테스트','test','2023-07-13 10:42:52','N',22);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_cs_0900_as_cs NOT NULL COMMENT '회원의 아이디 값입니다.\nPK',
  `member_pw` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_cs_0900_as_cs NOT NULL COMMENT '회원의 비밀번호입니다.',
  `member_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '회원의 이름입니다. 아마 본명보다 닉네임이 맞을거 같습니다.++ 유니크로 하는게 맞을거같아서 UQ 체크했습니다',
  `member_regidate` datetime NOT NULL COMMENT '회원의 가입날짜입니다. 아마 sql문에서는 now()만 사용될 듯합니다.',
  `member_email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_cs_0900_as_cs NOT NULL COMMENT '회원의 이메일입니다. 딱히 사용하는 곳은 없습니다.',
  `member_birth` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_cs_0900_as_cs NOT NULL COMMENT '회원의 생년월일입니다.\n회원의 성인인지를 확인할 떄 사용합니다. 기본값은 null입니다.',
  `member_like_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_cs_0900_as_cs COMMENT '회원이 좋아요를 누른 영화를 저장하는 테이블입니다.',
  `member_grade` tinyint NOT NULL DEFAULT '0' COMMENT '회원과 관리자를 구분하기 위한 컬럼입니다. 0이 유저 1이 관리자입니다 기본값은 0입니다.',
  `member_liked_review_list` longtext,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_name_UNIQUE` (`member_name`),
  UNIQUE KEY `member_id_UNIQUE` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 정보 테이블입니다.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('0000','1234567','사용자11','2023-07-10 11:05:30','A@naver.com','19990101',NULL,0,NULL),('0001','1234567','공일2','2023-07-10 14:29:01','01@naver.com','19990101',NULL,0,NULL),('0002','123','사용자2','2023-07-10 11:05:58','A@naver.com','19990101',NULL,0,NULL),('1','1','testuser','2023-07-12 09:40:09','','19970101','9,62,59,12',0,''),('1231234','1234','아아아아','2023-07-06 16:34:30','','',NULL,0,NULL),('123456','12345','신','2023-07-04 16:16:21','1@!','19990101',NULL,0,NULL),('7899','1234','가','2023-07-05 10:42:40','aa@aa','19990303',NULL,0,NULL),('admin','1234','관리자','2023-06-30 10:32:09','admin@movietogether.com','19990101','9,10,12',1,'78'),('login','654321','loginlogin','2023-07-03 10:30:02','login@login','19990101',NULL,0,NULL),('q','q','w','2023-07-06 16:37:02','q','19990101','12,11,10,9',0,'68,67,66,78,69,79,98'),('test','1234','test','2023-06-30 10:28:45','test@test.com','19990101','32,9',1,'66,47,72,71,98,100,101'),('test_user5','ch12345','야호','2023-07-05 09:41:02','1234@naver.com','20150505','10,15,40,52,9,12',0,'79'),('test010','123456','tester01','2023-07-12 11:51:25','','',NULL,0,NULL),('test2','12345','test2','2023-06-30 14:25:26','test2@test.com','19990202','32,9',0,'78,98'),('test3','12345','test3','2023-06-30 14:35:21','test3@test.com','19990202',NULL,0,NULL),('test4','12345','test4','2023-06-30 14:36:32','test4@test.com','19990202','',0,NULL),('test65','1212','마마','2023-06-30 14:45:10','s@w','ss',NULL,0,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `movie_pk` int NOT NULL AUTO_INCREMENT,
  `movie_title` varchar(50) NOT NULL,
  `movie_like_cnt` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`movie_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,'테스트영화제목1',0),(8,'테스트영화제목2',0),(9,'엘리멘탈',1568436),(10,'인디아나 존스: 운명의 다이얼',3),(11,'범죄도시3',3),(12,'스파이더맨: 어크로스 더 유니버스',6),(13,'2022 영탁 단독 콘서트 \"탁쇼\"',0),(14,'명탐정코난: 하이바라 아이 이야기 ~흑철의 미스터리 트레인',0),(15,'귀공자',0),(16,'파이어하트',0),(17,'범죄도시',0),(18,'바이스: 범죄도시',0),(19,'애스터로이드 시티',0),(20,'조커',0),(21,'배트맨 비욘드: 돌아온 조커',0),(22,'임프랙티컬 조커스: 더 무비',0),(23,'더 피플스 조커',0),(24,'플래시',0),(25,'여름날 우리',0),(26,'범죄도시4',0),(27,'대범죄도시: 나쁜녀석들',0),(28,'투 캐치 어 킬러',0),(29,'베드 레스트',0),(30,'분노의 질주: 라이드 오어 다이',0),(31,'익스트랙션 2',0),(32,'세인트 세이야: 더 비기닝',3),(33,'해리 포터와 비밀의 방',0),(34,'해리 포터와 불사조 기사단',0),(35,'해리 포터와 마법사의 돌',0),(36,'트랜스포머: 비스트의 서막',0),(37,'슈퍼 마리오 브라더스',0),(38,'더 래스 오브 벡키',0),(39,'인어공주',0),(40,'보 이즈 어프레이드',1),(41,'풍재기시',0),(42,'기적을 믿는 소녀',0),(43,'머신',0),(44,'악마들',0),(45,'미션 임파서블: 데드 레코닝 PART ONE',0),(46,'범죄도시 3',0),(47,'극장판 도라에몽: 진구와 하늘의 유토피아',0),(48,'유랑지구 2',0),(49,'분노의 질주 10: 파트 2',0),(50,'분노의 질주 10: 파트 3',0),(51,'불륜의 바다',0),(52,'미드소마',1),(53,'범죄의 장인',0),(54,'브릭 맨션: 통제불능 범죄구역',0),(55,'어메이징 스파이더맨',0),(56,'블랙 데몬',0),(57,'Sheroes',0),(58,'힙노틱',0),(59,'더 커버넌트',1),(60,'빈틈없는 사이',0),(61,'해리 포터와 혼혈왕자',0),(62,'사운드 오브 프리덤',1),(63,'룰 34',0),(64,'아이언맨 2',0),(65,'범죄도시 2',0),(66,'명탐정코난: 흑철의 어영',0),(67,'핑크퐁 시네마 콘서트3 : 진저브레드맨을 잡아라',0),(68,'밀수',0),(69,'undefined',0),(70,'명탐정 코난: 흑철의 어영',0),(71,'핑크퐁 시네마 콘서트 3 : 진저브레드맨을 잡아라',0);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna` (
  `qna_pk` int NOT NULL AUTO_INCREMENT,
  `qna_title` varchar(50) NOT NULL,
  `qna_writer` varchar(50) NOT NULL,
  `qna_content` varchar(2000) NOT NULL,
  `qna_date` datetime NOT NULL,
  `qna_cnt` int NOT NULL DEFAULT '0',
  `qna_category` int NOT NULL DEFAULT '0' COMMENT 'NN, 기본값 0으로 수정했습니다. category 테이블의 category_pk를 참조합니다. category_pk값 변경시 qna_category값도 변경(cascade), category_pk값 삭제시 해당 값을 참조하는 qna 게시글도 삭제(cascade)합니다.',
  `qna_delete_yn` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`qna_pk`),
  KEY `category_pk_idx` (`qna_category`),
  KEY `member_name_idx` (`qna_writer`),
  CONSTRAINT `category_pk` FOREIGN KEY (`qna_category`) REFERENCES `category` (`category_pk`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `member_name` FOREIGN KEY (`qna_writer`) REFERENCES `member` (`member_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

LOCK TABLES `qna` WRITE;
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
INSERT INTO `qna` VALUES (1,'문의글 테스트1','test','문의글 테스트1 내용입니다','2023-07-05 15:24:48',36,1,'N'),(2,'문의글 테스트2','test','문의글 테스트2 내용입니다','2023-07-05 15:25:07',1,0,'N'),(3,'문의글 테스트3','test','문의글 테스트3 내용입니다','2023-07-05 15:25:20',3,2,'N'),(4,'문의글 테스트4','test','문의글 테스트4 내용입니다','2023-07-05 15:35:42',8,2,'N'),(5,'문의글 테스트5','test','문의글 테스트5 내용입니다','2023-07-06 12:36:12',6,0,'N'),(6,'문의글 테스트6','test','문의글 테스트6 내용입니다','2023-07-06 15:47:31',6,0,'N'),(7,'문의글 테스트 제목입니다.','test','문의글 테스트 내용입니다.','2023-07-06 15:48:33',9,1,'N'),(8,'영화 문의글 테스트입니다.','test','영화 문의글 테스트 내용입니다.','2023-07-06 15:48:56',8,1,'Y'),(9,'회원정보 문의글 테스트 제목입니다.','test','회원정보 문의글 테스트 내용입니다.','2023-07-07 10:16:56',21,2,'N'),(10,'일간 박스오피스가 제대로 안나와요..','test','api문제인거같은데 수정부탁드립니다','2023-07-10 09:20:16',21,0,'N'),(11,'회원정보 문의입니다','test','네','2023-07-13 09:27:04',1,2,'N');
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna_comment`
--

DROP TABLE IF EXISTS `qna_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna_comment` (
  `comment_pk` int NOT NULL AUTO_INCREMENT COMMENT '문의댓글 번호',
  `comment_content` varchar(1000) NOT NULL COMMENT '문의댓글 내용',
  `comment_id` varchar(50) NOT NULL COMMENT '로그인한 댓글 작성자 ',
  `comment_date` datetime NOT NULL COMMENT '작성 날짜',
  `comment_delete_yn` char(1) NOT NULL DEFAULT 'N' COMMENT '댓글 삭제여부',
  `comment_num` int NOT NULL COMMENT '답글 표시할 게시글 번호',
  PRIMARY KEY (`comment_pk`),
  KEY `fk_name_idx` (`comment_id`),
  KEY `fk_qna_num_idx` (`comment_num`),
  CONSTRAINT `fk_name` FOREIGN KEY (`comment_id`) REFERENCES `member` (`member_name`) ON UPDATE CASCADE,
  CONSTRAINT `fk_qna_num` FOREIGN KEY (`comment_num`) REFERENCES `qna` (`qna_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_comment`
--

LOCK TABLES `qna_comment` WRITE;
/*!40000 ALTER TABLE `qna_comment` DISABLE KEYS */;
INSERT INTO `qna_comment` VALUES (1,'테스트 코멘트입니다.1','test','2023-07-07 14:27:14','N',1),(2,'테스트 코멘트입니다.2','test','2023-07-07 14:29:02','N',1),(3,'테스트 코멘트입니다.3','test','2023-07-10 00:10:03','N',1),(4,'댓글 입력 테스트입니다.','test','2023-07-10 01:12:16','N',1),(5,'댓글','test','2023-07-10 09:14:21','N',9),(6,'슬픈 게시글 내용이네요...','관리자','2023-07-10 10:45:18','Y',10),(7,'지금은 수정 됐다는 소식 ','관리자','2023-07-10 10:45:28','N',10);
/*!40000 ALTER TABLE `qna_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna_file`
--

DROP TABLE IF EXISTS `qna_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna_file` (
  `qna_file_id` int NOT NULL AUTO_INCREMENT,
  `qna_pk` int NOT NULL,
  `qna_ofile_name` varchar(200) NOT NULL,
  `qna_sfile_name` varchar(45) NOT NULL,
  `qna_file_size` int NOT NULL DEFAULT '0',
  `qna_created_date` datetime NOT NULL,
  PRIMARY KEY (`qna_file_id`),
  KEY `qna_pk_idx` (`qna_pk`),
  CONSTRAINT `qna_pk` FOREIGN KEY (`qna_pk`) REFERENCES `qna` (`qna_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_file`
--

LOCK TABLES `qna_file` WRITE;
/*!40000 ALTER TABLE `qna_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_pk` int NOT NULL AUTO_INCREMENT,
  `review_title` varchar(50) NOT NULL,
  `review_writer` varchar(50) NOT NULL COMMENT 'member 테이블의 member_name 을 참조합니다. member_name값 변경시  board_writer의 값도 변경(cascade),  member_name값 삭제시  board_writer값은 그대로(no action) 유지됩니다.',
  `review_content` varchar(2000) NOT NULL,
  `review_date` datetime NOT NULL,
  `review_like_cnt` int NOT NULL DEFAULT '0',
  `review_star` int NOT NULL DEFAULT '10',
  `review_movie_pk` int DEFAULT NULL,
  `review_edit` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`review_pk`),
  KEY `review_name_idx` (`review_writer`),
  KEY `review_movie_pk_idx` (`review_movie_pk`),
  CONSTRAINT `review_movie_pk` FOREIGN KEY (`review_movie_pk`) REFERENCES `movie` (`movie_pk`),
  CONSTRAINT `review_name` FOREIGN KEY (`review_writer`) REFERENCES `member` (`member_name`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (16,'엘리멘탈6','w','w','2023-07-07 06:00:00',0,10,NULL,0),(17,'엘리멘탈7','w','w','2023-07-07 16:28:47',0,10,NULL,0),(47,'리뷰 crud','w','네','2023-07-07 21:54:17',1,10,11,1),(66,'11','w','11ㅣㅑㅏ','2023-07-09 16:31:59',2,10,9,1),(67,'ㅂ','w','ㅂ','2023-07-09 18:03:31',1,10,9,1),(68,'ffff','w','ffff','2023-07-09 22:51:51',1,10,45,0),(69,'리뷰테스트','w','아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용아주긴내용','2023-07-10 12:00:38',1,4,9,1),(70,'********10','w','********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10********10','2023-07-10 12:03:15',0,10,9,1),(71,' *******10','w',' *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10 *******10','2023-07-10 12:40:05',1,5,9,1),(72,'영화 후기','test','불, 물, 공기, 흙 4개의 원소들이 살고 있는 엘리멘트 시티. 재치 있고 불처럼 열정 넘치는 앰버','2023-07-10 14:53:28',13461387,8,9,1),(74,'쎄이야','test','세인트 쎼이야','2023-07-10 15:52:32',0,10,32,0),(75,'6점','w','6점','2023-07-10 16:57:19',0,6,9,1),(78,'ㅇㅇ','w','ㅇㅇㅇ','2023-07-10 17:44:28',3,9,9,0),(79,'항상 재밌게 봅니다','야호','거미남자는 항상 옳다','2023-07-11 10:33:58',2,10,12,0),(83,'테스트리뷰','testuser','1','2023-07-12 09:43:07',0,1,11,0),(84,'리뷰테스트','testuser','4','2023-07-12 09:45:07',0,4,44,0),(88,'1','testuser','1','2023-07-12 09:49:31',0,1,9,0),(89,'2','testuser','2','2023-07-12 09:49:44',0,2,9,0),(90,'3','testuser','3','2023-07-12 09:50:06',0,3,9,0),(91,'4','testuser','4','2023-07-12 09:55:41',0,4,9,0),(92,'5','testuser','5','2023-07-12 09:55:46',0,5,9,0),(93,'6','testuser','6','2023-07-12 09:55:49',0,6,9,0),(94,'7','testuser','7','2023-07-12 09:55:58',0,7,9,0),(95,'8','testuser','8','2023-07-12 09:56:05',0,8,9,1),(96,'9','testuser','9','2023-07-12 09:56:10',0,9,9,0),(97,'10','testuser','10','2023-07-12 09:56:25',0,10,9,0),(98,'테스트리뷰','test2','ㅇㅇ','2023-07-12 10:12:33',3,8,9,1),(99,'인디아나 존스','test','인디아나 존스 계속 봐왔는데 재밌어요 ','2023-07-12 17:52:22',0,1,10,0),(100,'5점','test','5점','2023-07-13 09:22:38',1,5,9,0),(101,'제목','test','내용','2023-07-13 10:41:13',1,8,9,0);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theater`
--

DROP TABLE IF EXISTS `theater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theater` (
  `theater_code` varchar(50) NOT NULL,
  `area` varchar(50) NOT NULL,
  `theater_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`theater_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theater`
--

LOCK TABLES `theater` WRITE;
/*!40000 ALTER TABLE `theater` DISABLE KEYS */;
INSERT INTO `theater` VALUES ('0001','서울','CGV강변','cgv'),('0002','인천','CGV인천','cgv'),('0003','경기','CGV야탑','cgv'),('0004','경기','CGV오리','cgv'),('0005','부산/울산','CGV서면','cgv'),('0007','대전/충청','CGV대전','cgv'),('0008','대전/충청/세종','세종청사','megaBox'),('0009','서울','CGV명동','cgv'),('0010','서울','CGV구로','cgv'),('0012','경기','용인기흥','megaBox'),('0013','서울','CGV용산아이파크몰','cgv'),('0014','부산/대구/경상','창원내서','megaBox'),('0015','경기','CGV부천','cgv'),('0017','대전/충청/세종','대전현대아울렛','megaBox'),('0018','대전/충청/세종','논산','megaBox'),('0019','경기','남양주현대아울렛 스페이스원','megaBox'),('0020','광주/전라/제주','CGV익산','cgv'),('0021','인천','CGV부평','cgv'),('0022','부산/대구/경상','대구이시아','megaBox'),('0023','경상','CGV창원','cgv'),('0025','부산/대구/경상','북대구(칠곡)','megaBox'),('0027','인천','청라지젤','megaBox'),('0028','경상','CGV김해','cgv'),('0029','경기','광명AK플라자','megaBox'),('0030','서울','CGV불광','cgv'),('0032','부산/대구/경상','사상','megaBox'),('0033','경상','CGV마산','cgv'),('0034','경기','광명소하','megaBox'),('0035','경기','금정AK플라자','megaBox'),('0036','경기','수원호매실','megaBox'),('0037','강원','춘천석사','megaBox'),('0038','부산/대구/경상','포항','megaBox'),('0039','경기','남양주','megaBox'),('0040','서울','CGV압구정','cgv'),('0041','경기','CGV동수원','cgv'),('0042','부산/울산','CGV동래','cgv'),('0043','인천','CGV계양','cgv'),('0044','대전/충청','CGV천안','cgv'),('0045','부산/대구/경상','진주(중안)','megaBox'),('0046','서울','CGV상봉','cgv'),('0048','부산/대구/경상','창원','megaBox'),('0049','경기','CGV북수원','cgv'),('0050','광주/전라','전주객사','megaBox'),('0052','경기','CGV평택','cgv'),('0053','경상','CGV구미','cgv'),('0054','경기','CGV일산','cgv'),('0055','경기','CGV신세계경기(리뉴얼)','cgv'),('0056','서울','CGV강남','cgv'),('0057','서울','CGV미아','cgv'),('0059','서울','CGV영등포','cgv'),('0061','부산/울산','CGV대연','cgv'),('0063','서울','CGV대학로','cgv'),('0070','강원','CGV춘천','cgv'),('0073','경기','CGV시흥','cgv'),('0074','서울','CGV왕십리','cgv'),('0079','경상','CGV창원더시티','cgv'),('0088','서울','CGV송파','cgv'),('0089','부산/울산','CGV센텀시티','cgv'),('0090','광주/전라/제주','CGV광주터미널','cgv'),('0091','대전/충청','CGV서산','cgv'),('0097','경상','CGV북포항','cgv'),('0105','서울','CGV명동역 씨네라이브러리','cgv'),('0106','경기','CGV동탄','cgv'),('0107','서울','CGV청담씨네시티','cgv'),('0108','대구','CGV대구스타디움','cgv'),('0109','대구','CGV대구현대','cgv'),('0110','대전/충청','CGV천안펜타포트','cgv'),('0112','서울','CGV여의도','cgv'),('0113','경기','CGV의정부','cgv'),('0114','광주/전라/제주','CGV순천','cgv'),('0124','경기','CGV동백','cgv'),('0127','대전/충청','CGV대전터미널','cgv'),('0128','부산/울산','CGV울산삼산','cgv'),('0131','서울','CGV중계','cgv'),('0139','강원','CGV강릉','cgv'),('0142','대전/충청','CGV청주지웰시티','cgv'),('0143','경기','CGV소풍','cgv'),('0144','강원','CGV원주','cgv'),('0145','경기','CGV화정','cgv'),('0147','대구','CGV대구한일','cgv'),('0148','경기','CGV파주문산','cgv'),('0150','서울','CGV신촌아트레온','cgv'),('0154','대전/충청','CGV대전가오','cgv'),('0155','경기','CGV범계','cgv'),('0156','경상','CGV통영','cgv'),('0157','대구','CGV대구수성','cgv'),('0159','부산/울산','CGV화명','cgv'),('0160','부산/울산','CGV아시아드','cgv'),('0164','서울','CGV하계','cgv'),('0179','광주/전라/제주','CGV전주효자','cgv'),('0181','경기','CGV판교','cgv'),('0185','대구','CGV대구아카데미','cgv'),('0186','광주/전라/제주','CGV정읍','cgv'),('0187','경기','CGV의정부태흥','cgv'),('0188','경기','CGV김포운양','cgv'),('0191','서울','CGV홍대','cgv'),('0193','광주/전라/제주','CGV광주상무','cgv'),('0194','경기','CGV부천역','cgv'),('0195','경기','CGV평촌','cgv'),('0196','경기','CGV서현','cgv'),('0198','인천','CGV남주안','cgv'),('0199','서울','CGV천호','cgv'),('0202','대전/충청','CGV대전탄방','cgv'),('0205','경기','CGV이천','cgv'),('0206','대전/충청','CGV유성노은','cgv'),('0207','대전/충청','CGV당진','cgv'),('0210','광주/전라/제주','CGV광주용봉','cgv'),('0211','경기','CGV안산','cgv'),('0213','광주/전라/제주','CGV전주고사','cgv'),('0214','경기','CGV평택소사','cgv'),('0215','광주/전라/제주','CGV광주하남','cgv'),('0216','대구','CGV대구월성','cgv'),('0217','대전/충청','CGV홍성','cgv'),('0218','광주/전라/제주','CGV광주첨단','cgv'),('0219','대전/충청','CGV세종','cgv'),('0220','광주/전라/제주','CGV광양','cgv'),('0221','광주/전라/제주','CGV광양 엘에프스퀘어','cgv'),('0223','서울','CGV피카디리1958','cgv'),('0225','광주/전라/제주','CGV서전주','cgv'),('0226','경기','CGV배곧','cgv'),('0228','대전/충청','CGV청주(서문)','cgv'),('0229','서울','CGV건대입구','cgv'),('0230','서울','CGV등촌','cgv'),('0232','경기','CGV구리','cgv'),('0233','경기','CGV동탄호수공원','cgv'),('0234','경상','CGV양산삼호','cgv'),('0235','인천','CGV청라','cgv'),('0237','광주/전라/제주','CGV나주','cgv'),('0239','경상','CGV김해장유','cgv'),('0240','경상','CGV김천율곡','cgv'),('0242','경기','CGV산본','cgv'),('0244','광주/전라/제주','CGV광주충장로','cgv'),('0245','부산/울산','CGV하단아트몰링','cgv'),('0246','부산/울산','CGV울산진장','cgv'),('0247','인천','CGV연수역','cgv'),('0252','서울','CGV동대문','cgv'),('0255','경기','CGV고양행신','cgv'),('0256','대구','CGV대구죽전','cgv'),('0257','경기','CGV광교','cgv'),('0258','인천','CGV인천연수','cgv'),('0259','광주/전라/제주','CGV제주노형','cgv'),('0260','경기','CGV경기광주','cgv'),('0261','대전/충청','CGV논산','cgv'),('0262','경기','CGV양주옥정','cgv'),('0263','경상','CGV거제','cgv'),('0264','부산/울산','CGV울산신천','cgv'),('0265','경기','CGV동탄역','cgv'),('0266','경기','CGV광교상현','cgv'),('0268','광주/전라/제주','CGV순천신대','cgv'),('0269','인천','CGV인천학익','cgv'),('0270','경기','CGV고양백석','cgv'),('0271','경기','CGV용인','cgv'),('0272','경상','CGV안동','cgv'),('0274','경기','CGV스타필드시티위례','cgv'),('0276','서울','CGV수유','cgv'),('0278','경기','CGV김포','cgv'),('0279','경기','CGV안성','cgv'),('0280','광주/전라/제주','CGV목포평화광장','cgv'),('0281','강원','CGV인제','cgv'),('0282','대전/충청','CGV청주율량','cgv'),('0283','경상','CGV창원상남','cgv'),('0284','대전/충청','CGV충북혁신','cgv'),('0285','부산/울산','CGV서면삼정타워','cgv'),('0286','대전/충청','CGV대전가수원','cgv'),('0287','경기','CGV부천옥길','cgv'),('0288','서울','CGV방학','cgv'),('0289','광주/전라/제주','CGV목포','cgv'),('0292','서울','CGV연남','cgv'),('0293','대전/충청','CGV천안터미널','cgv'),('0295','광주/전라/제주','CGV광주금남로','cgv'),('0296','인천','CGV인천가정(루원시티)','cgv'),('0297','대전/충청','CGV청주성안길','cgv'),('0298','경기','CGV김포한강','cgv'),('0300','서울','CGV성신여대입구','cgv'),('0301','경기','CGV화성봉담','cgv'),('0302','광주/전라/제주','CGV제주','cgv'),('0303','부산/울산','CGV서면상상마당','cgv'),('0304','경기','CGV성남모란','cgv'),('0305','경기','CGV오산','cgv'),('0306','부산/울산','CGV정관','cgv'),('0307','경기','CGV오산중앙','cgv'),('0308','인천','CGV주안역','cgv'),('0309','경기','CGV포천','cgv'),('0310','경기','CGV파주야당','cgv'),('0311','경상','CGV김해율하','cgv'),('0315','광주/전라/제주','CGV여수웅천','cgv'),('0318','부산/울산','CGV해운대','cgv'),('0319','대전/충청','CGV청주터미널','cgv'),('0320','경기','CGV정왕','cgv'),('0323','경상','CGV고성','cgv'),('0324','경상','CGV진주혁신','cgv'),('0325','인천','CGV송도타임스페이스','cgv'),('0326','경기','CGV하남미사','cgv'),('0328','대전/충청','CGV충주교현','cgv'),('0329','경기','CGV남양주 화도','cgv'),('0330','경상','CGV경산','cgv'),('0331','대전/충청','CGV제천','cgv'),('0332','대전/충청','CGV천안시청','cgv'),('0334','경기','CGV평택고덕','cgv'),('0335','부산/울산','CGV울산동구','cgv'),('0336','광주/전라/제주','CGV전주에코시티','cgv'),('0337','부산/울산','CGV부산명지','cgv'),('0338','경기','CGV역곡','cgv'),('0340','인천','CGV인천도화','cgv'),('0343','대구','CGV대구연경','cgv'),('0344','경기','CGV기흥','cgv'),('0345','대구','CGV대구','cgv'),('0346','인천','CGV인천논현','cgv'),('0348','경기','CGV광명역','cgv'),('0351','경기','CGV다산','cgv'),('0352','인천','CGV인천시민공원','cgv'),('0354','강원','CGV원통','cgv'),('0355','강원','CGV기린','cgv'),('0356','대전/충청','CGV아산','cgv'),('0358','경기','CGV구리갈매','cgv'),('0359','경기','CGV동탄그랑파사쥬','cgv'),('0365','경기','DRIVE IN 용인크랙사이드','cgv'),('0367','부산/울산','DRIVE IN 영도','cgv'),('1|1|1001','서울','에비뉴엘(명동)','lotteCinema'),('1|1|1002','서울','영등포','lotteCinema'),('1|1|1003','서울','노원','lotteCinema'),('1|1|1004','서울','건대입구','lotteCinema'),('1|1|1005','서울','홍대입구','lotteCinema'),('1|1|1007','서울','신림','lotteCinema'),('1|1|1008','서울','청량리','lotteCinema'),('1|1|1009','서울','김포공항','lotteCinema'),('1|1|1010','서울','합정','lotteCinema'),('1|1|1012','서울','서울대입구','lotteCinema'),('1|1|1013','서울','가산디지털','lotteCinema'),('1|1|1014','서울','용산','lotteCinema'),('1|1|1015','서울','신도림','lotteCinema'),('1|1|1016','서울','월드타워','lotteCinema'),('1|1|1017','서울','독산','lotteCinema'),('1|1|1021','서울','은평(롯데몰)','lotteCinema'),('1|1|1023','서울','도곡','lotteCinema'),('1|1|1024','서울','신대방(구로디지털역)','lotteCinema'),('1|1|9010','서울','강동','lotteCinema'),('1|1|9056','서울','브로드웨이(신사)','lotteCinema'),('1|1|9083','서울','중랑','lotteCinema'),('1|1|9094','서울','가양','lotteCinema'),('1|1|9099','서울','수락산','lotteCinema'),('1|1|9104','서울','수유','lotteCinema'),('1|101|2004','경남/부산/울산','부산본점','lotteCinema'),('1|101|2006','경남/부산/울산','센텀시티','lotteCinema'),('1|101|2007','경남/부산/울산','동래','lotteCinema'),('1|101|2008','경남/부산/울산','서면(전포동)','lotteCinema'),('1|101|2009','경남/부산/울산','광복','lotteCinema'),('1|101|2010','경남/부산/울산','동부산아울렛','lotteCinema'),('1|101|2011','경남/부산/울산','오투(부산대)','lotteCinema'),('1|101|2012','경남/부산/울산','대영','lotteCinema'),('1|101|5001','경남/부산/울산','울산(백화점)','lotteCinema'),('1|101|5002','경남/부산/울산','창원','lotteCinema'),('1|101|5009','경남/부산/울산','진해','lotteCinema'),('1|101|5011','경남/부산/울산','김해아울렛(장유)','lotteCinema'),('1|101|5014','경남/부산/울산','울산성남','lotteCinema'),('1|101|5015','경남/부산/울산','김해부원','lotteCinema'),('1|101|5017','경남/부산/울산','진주혁신(롯데몰)','lotteCinema'),('1|101|9036','경남/부산/울산','통영','lotteCinema'),('1|101|9042','경남/부산/울산','마산(합성동)','lotteCinema'),('1|101|9059','경남/부산/울산','프리미엄해운대(장산역)','lotteCinema'),('1|101|9072','경남/부산/울산','프리미엄경남대','lotteCinema'),('1|101|9082','경남/부산/울산','거창','lotteCinema'),('1|101|9084','경남/부산/울산','사천','lotteCinema'),('1|101|9092','경남/부산/울산','부산명지','lotteCinema'),('1|101|9103','경남/부산/울산','양산물금','lotteCinema'),('1|101|9105','경남/부산/울산','엠비씨네(진주)','lotteCinema'),('1|2|3003','경기/인천','부평','lotteCinema'),('1|2|3004','경기/인천','안산','lotteCinema'),('1|2|3007','경기/인천','안양(안양역)','lotteCinema'),('1|2|3008','경기/인천','부평역사','lotteCinema'),('1|2|3010','경기/인천','진접','lotteCinema'),('1|2|3011','경기/인천','부천(신중동역)','lotteCinema'),('1|2|3012','경기/인천','센트럴락','lotteCinema'),('1|2|3017','경기/인천','병점','lotteCinema'),('1|2|3018','경기/인천','평촌(범계역)','lotteCinema'),('1|2|3020','경기/인천','광주터미널','lotteCinema'),('1|2|3021','경기/인천','마석','lotteCinema'),('1|2|3024','경기/인천','수원(수원역)','lotteCinema'),('1|2|3025','경기/인천','광명아울렛','lotteCinema'),('1|2|3026','경기/인천','구리아울렛','lotteCinema'),('1|2|3027','경기/인천','광명(광명사거리)','lotteCinema'),('1|2|3028','경기/인천','안산고잔','lotteCinema'),('1|2|3029','경기/인천','송탄','lotteCinema'),('1|2|3030','경기/인천','광교아울렛','lotteCinema'),('1|2|3031','경기/인천','산본피트인','lotteCinema'),('1|2|3032','경기/인천','안양일번가','lotteCinema'),('1|2|3033','경기/인천','의정부민락','lotteCinema'),('1|2|3034','경기/인천','파주운정','lotteCinema'),('1|2|3035','경기/인천','인천아시아드','lotteCinema'),('1|2|3036','경기/인천','향남','lotteCinema'),('1|2|3037','경기/인천','위례','lotteCinema'),('1|2|3038','경기/인천','인천터미널','lotteCinema'),('1|2|3039','경기/인천','용인기흥','lotteCinema'),('1|2|3040','경기/인천','용인역북','lotteCinema'),('1|2|3041','경기/인천','성남중앙(신흥역)','lotteCinema'),('1|2|3043','경기/인천','서수원','lotteCinema'),('1|2|3044','경기/인천','수지','lotteCinema'),('1|2|3045','경기/인천','북수원(천천동)','lotteCinema'),('1|2|3046','경기/인천','별내','lotteCinema'),('1|2|3047','경기/인천','판교(창조경제밸리)','lotteCinema'),('1|2|3048','경기/인천','동탄','lotteCinema'),('1|2|3049','경기/인천','시흥장현','lotteCinema'),('1|2|3050','경기/인천','부평갈산','lotteCinema'),('1|2|9054','경기/인천','부천역','lotteCinema'),('1|2|9075','경기/인천','평택비전(뉴코아)','lotteCinema'),('1|2|9077','경기/인천','영종하늘도시','lotteCinema'),('1|2|9079','경기/인천','오산(원동)','lotteCinema'),('1|2|9087','경기/인천','주엽','lotteCinema'),('1|2|9088','경기/인천','시화(정왕역)','lotteCinema'),('1|2|9095','경기/인천','라페스타','lotteCinema'),('1|2|9100','경기/인천','인덕원','lotteCinema'),('1|2|9106','경기/인천','안성','lotteCinema'),('1|2|9111','경기/인천','하남미사','lotteCinema'),('1|3|4002','충청/대전','대전(백화점)','lotteCinema'),('1|3|4004','충청/대전','서청주(아울렛)','lotteCinema'),('1|3|4005','충청/대전','아산터미널','lotteCinema'),('1|3|4006','충청/대전','대전둔산(월평동)','lotteCinema'),('1|3|4007','충청/대전','청주용암','lotteCinema'),('1|3|4008','충청/대전','대전센트럴','lotteCinema'),('1|3|4009','충청/대전','대전관저','lotteCinema'),('1|3|9044','충청/대전','서산','lotteCinema'),('1|3|9078','충청/대전','충주(모다아울렛)','lotteCinema'),('1|3|9085','충청/대전','당진','lotteCinema'),('1|3|9101','충청/대전','천안불당','lotteCinema'),('1|3|9112','충청/대전','천안청당','lotteCinema'),('1|4|6001','전라/광주','광주(백화점)','lotteCinema'),('1|4|6002','전라/광주','전주(백화점)','lotteCinema'),('1|4|6004','전라/광주','수완(아울렛)','lotteCinema'),('1|4|6006','전라/광주','전주평화','lotteCinema'),('1|4|6007','전라/광주','군산나운','lotteCinema'),('1|4|6009','전라/광주','군산몰','lotteCinema'),('1|4|9047','전라/광주','충장로','lotteCinema'),('1|4|9065','전라/광주','광주광산','lotteCinema'),('1|4|9070','전라/광주','익산모현','lotteCinema'),('1|4|9102','전라/광주','전주송천','lotteCinema'),('1|5|5004','경북/대구','성서','lotteCinema'),('1|5|5005','경북/대구','동성로','lotteCinema'),('1|5|5006','경북/대구','대구율하','lotteCinema'),('1|5|5012','경북/대구','대구광장','lotteCinema'),('1|5|5013','경북/대구','구미공단','lotteCinema'),('1|5|5016','경북/대구','상인','lotteCinema'),('1|5|9057','경북/대구','프리미엄칠곡','lotteCinema'),('1|5|9064','경북/대구','영주','lotteCinema'),('1|5|9066','경북/대구','프리미엄만경','lotteCinema'),('1|5|9067','경북/대구','프리미엄구미센트럴','lotteCinema'),('1|5|9074','경북/대구','프리미엄안동','lotteCinema'),('1|5|9080','경북/대구','상주','lotteCinema'),('1|5|9090','경북/대구','경주','lotteCinema'),('1|5|9091','경북/대구','경주황성','lotteCinema'),('1|5|9097','경북/대구','포항','lotteCinema'),('1|5|9098','경북/대구','영천','lotteCinema'),('1|5|9107','경북/대구','대구현풍','lotteCinema'),('1|6|7002','강원','동해','lotteCinema'),('1|6|7003','강원','원주무실','lotteCinema'),('1|6|9081','강원','춘천','lotteCinema'),('1|6|9089','강원','속초','lotteCinema'),('1|6|9108','강원','남원주','lotteCinema'),('1|7|6010','제주','제주연동','lotteCinema'),('1|7|9013','제주','서귀포','lotteCinema'),('1|7|9068','제주','제주삼화지구','lotteCinema'),('1|7|9071','제주','제주아라','lotteCinema'),('1003','서울','동대문','megaBox'),('1202','서울','신촌','megaBox'),('1211','서울','상암월드컵경기장','megaBox'),('1212','서울','홍대','megaBox'),('1311','서울','상봉','megaBox'),('1321','서울','창동','megaBox'),('1331','서울','성수','megaBox'),('1341','서울','강동','megaBox'),('1351','서울','코엑스','megaBox'),('1371','서울','센트럴','megaBox'),('1372','서울','강남','megaBox'),('1381','서울','송파파크하비오','megaBox'),('1431','서울','군자','megaBox'),('1561','서울','이수','megaBox'),('1562','서울','ARTNINE','megaBox'),('1571','서울','화곡','megaBox'),('1572','서울','마곡','megaBox'),('1581','서울','목동','megaBox'),('2001','강원','남춘천','megaBox'),('2171','강원','속초','megaBox'),('2201','강원','원주','megaBox'),('2202','강원','원주센트럴','megaBox'),('3011','대전/충청/세종','대전중앙로','megaBox'),('3021','대전/충청/세종','대전','megaBox'),('3141','대전/충청/세종','공주','megaBox'),('3301','대전/충청/세종','천안','megaBox'),('3391','대전/충청/세종','세종(조치원)','megaBox'),('3392','대전/충청/세종','세종나성','megaBox'),('3501','대전/충청/세종','홍성내포','megaBox'),('3631','대전/충청/세종','오창','megaBox'),('3651','대전/충청/세종','진천','megaBox'),('4001','인천','영종','megaBox'),('4041','인천','검단','megaBox'),('4051','인천','인천논현','megaBox'),('4062','인천','송도','megaBox'),('4104','경기','백석벨라시타','megaBox'),('4111','경기','일산','megaBox'),('4112','경기','킨텍스','megaBox'),('4115','경기','파주운정','megaBox'),('4121','경기','고양스타필드','megaBox'),('4131','경기','파주출판도시','megaBox'),('4132','경기','파주금촌','megaBox'),('4152','경기','김포한강신도시','megaBox'),('4221','경기','부천스타필드시티','megaBox'),('4253','경기','안산중앙','megaBox'),('4291','경기','시흥배곧','megaBox'),('4431','경기','영통','megaBox'),('4451','경기','동탄','megaBox'),('4462','경기','용인테크노밸리','megaBox'),('4631','경기','분당','megaBox'),('4651','경기','하남스타필드','megaBox'),('4652','경기','미사강변','megaBox'),('4722','경기','별내','megaBox'),('4804','경기','의정부민락','megaBox'),('4821','경기','양주','megaBox'),('5021','광주/전라','광주상무','megaBox'),('5061','광주/전라','광주하남','megaBox'),('5064','광주/전라','첨단','megaBox'),('5302','광주/전라','목포하당(포르모)','megaBox'),('5401','광주/전라','순천','megaBox'),('5552','광주/전라','여수웅천','megaBox'),('5612','광주/전라','전주송천','megaBox'),('6001','부산/대구/경상','부산극장','megaBox'),('6161','부산/대구/경상','덕천','megaBox'),('6191','부산/대구/경상','정관','megaBox'),('6261','부산/대구/경상','양산','megaBox'),('6262','부산/대구/경상','양산증산','megaBox'),('6312','부산/대구/경상','마산','megaBox'),('6642','부산/대구/경상','삼천포','megaBox'),('6811','부산/대구/경상','울산','megaBox'),('6906','부산/대구/경상','부산대','megaBox'),('7011','부산/대구/경상','대구신세계(동대구)','megaBox'),('7122','부산/대구/경상','경산하양','megaBox'),('7303','부산/대구/경상','구미강동','megaBox'),('7401','부산/대구/경상','김천','megaBox'),('7451','부산/대구/경상','문경','megaBox'),('7901','부산/대구/경상','남포항','megaBox');
/*!40000 ALTER TABLE `theater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'java505_team2_db'
--

--
-- Dumping routines for database 'java505_team2_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-28  1:42:52
