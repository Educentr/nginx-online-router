-- MySQL dump 10.13  Distrib 8.0.37, for Linux (aarch64)
--
-- Host: localhost    Database: onlineconf
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mod_auth`
--

DROP TABLE IF EXISTS `mod_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mod_auth` (
  `Name` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mod_auth`
--

LOCK TABLES `mod_auth` WRITE;
/*!40000 ALTER TABLE `mod_auth` DISABLE KEYS */;
INSERT INTO `mod_auth` VALUES ('admin','hCG7NSubpIe8M'),('beaver','iJdvMl0D40I6M'),('hedgehog','6nLwikib1PMAo'),('meerkat','uGruJjKihJ7oI'),('rabbit','JhDoIGtWEfyrc');
/*!40000 ALTER TABLE `mod_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_change_notification`
--

DROP TABLE IF EXISTS `my_change_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_change_notification` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `CTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Origin` varchar(255) NOT NULL,
  `Message` mediumtext NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_change_notification`
--

LOCK TABLES `my_change_notification` WRITE;
/*!40000 ALTER TABLE `my_change_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_change_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_config_activity`
--

DROP TABLE IF EXISTS `my_config_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_config_activity` (
  `Host` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `Time` timestamp NULL DEFAULT NULL,
  `Online` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Package` varchar(32) NOT NULL,
  PRIMARY KEY (`Host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_config_activity`
--

LOCK TABLES `my_config_activity` WRITE;
/*!40000 ALTER TABLE `my_config_activity` DISABLE KEYS */;
INSERT INTO `my_config_activity` VALUES ('nginx-online-router-onlineconf-updater-1.admin_default','2024-08-13 18:14:04','2024-08-13 18:14:18','3.5.0');
/*!40000 ALTER TABLE `my_config_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_config_group`
--

DROP TABLE IF EXISTS `my_config_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_config_group` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_config_group`
--

LOCK TABLES `my_config_group` WRITE;
/*!40000 ALTER TABLE `my_config_group` DISABLE KEYS */;
INSERT INTO `my_config_group` VALUES (3,'gopher-developer'),(1,'root'),(4,'squirrel-developer'),(5,'squirrel-manager'),(2,'sysadmin');
/*!40000 ALTER TABLE `my_config_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_config_tree`
--

DROP TABLE IF EXISTS `my_config_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_config_tree` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(256) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ParentID` bigint unsigned DEFAULT NULL,
  `Path` varchar(512) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `Value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `ContentType` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT 'application/x-null',
  `Summary` varchar(255) NOT NULL DEFAULT '',
  `Description` varchar(8192) NOT NULL DEFAULT '',
  `Version` int NOT NULL DEFAULT '1',
  `MTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  `Notification` enum('none','no-value','with-value') CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  UNIQUE KEY `Path` (`Path`),
  UNIQUE KEY `Name` (`ParentID`,`Name`),
  CONSTRAINT `my_config_tree_ibfk_1` FOREIGN KEY (`ParentID`) REFERENCES `my_config_tree` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_config_tree`
--

LOCK TABLES `my_config_tree` WRITE;
/*!40000 ALTER TABLE `my_config_tree` DISABLE KEYS */;
INSERT INTO `my_config_tree` VALUES (1,'',NULL,'/',NULL,'application/x-null','','',1,'2019-08-05 17:01:16',0,'none'),(2,'onlineconf',1,'/onlineconf',NULL,'application/x-null','','',1,'2019-08-05 17:01:16',0,NULL),(3,'module',2,'/onlineconf/module','[{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/gopher\",\"service\":\"gopher\"},{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/squirrel\",\"service\":\"squirrel\"},{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/nginx\",\"service\":\"nginx\"}]','application/x-case','','',4,'2024-05-26 14:25:53',0,NULL),(4,'service',2,'/onlineconf/service',NULL,'application/x-null','','',1,'2019-08-05 17:01:16',0,NULL),(5,'gopher',4,'/onlineconf/service/gopher','9cc1ee455a3363ffc504f40006f70d0c8276648a5d3eb3f9524e94d1b7a83aef','text/plain','','',1,'2019-08-05 17:13:00',0,NULL),(6,'squirrel',4,'/onlineconf/service/squirrel','960a38ace75a2fe9426aa5d48b536cc6db18a2023b9bdd698e562fc3023585a6','text/plain','','',1,'2019-08-05 17:13:35',0,NULL),(7,'gopher',1,'/gopher',NULL,'application/x-null','Gopher project','',1,'2019-08-05 17:17:01',0,NULL),(8,'squirrel',1,'/squirrel',NULL,'application/x-null','Squirrel project','',1,'2019-08-05 17:17:16',0,NULL),(9,'chroot',2,'/onlineconf/chroot',NULL,'application/x-null','','',1,'2019-08-05 17:17:50',0,NULL),(10,'gopher',9,'/onlineconf/chroot/gopher','delimiter: /','application/x-yaml','','',1,'2019-08-05 17:18:12',0,NULL),(11,'TREE',10,'/onlineconf/chroot/gopher/TREE',NULL,'application/x-null','','',1,'2019-08-05 17:19:38',0,NULL),(12,'gopher',11,'/onlineconf/chroot/gopher/TREE/gopher','/gopher','application/x-symlink','','',1,'2019-08-05 17:20:15',0,NULL),(13,'infrastructure',1,'/infrastructure',NULL,'application/x-null','Sysadmin stuff','All IP addresses, hosts, credentials and offer infrastructure information should live here.\nParameters from this hierarchy should not be used directly but through symlinks in project subtrees only.',1,'2019-08-05 17:24:45',0,NULL),(14,'postgresql',13,'/infrastructure/postgresql',NULL,'application/x-null','','',1,'2019-08-05 17:25:54',0,NULL),(15,'tarantool',13,'/infrastructure/tarantool',NULL,'application/x-null','','',1,'2019-08-05 17:26:04',0,NULL),(16,'gopher-main',14,'/infrastructure/postgresql/gopher-main',NULL,'application/x-null','Main gopher database','',1,'2019-08-05 17:27:13',0,NULL),(17,'host',16,'/infrastructure/postgresql/gopher-main/host','db1.gopher.example.com','text/plain','','',1,'2019-08-05 17:27:53',0,NULL),(18,'user',16,'/infrastructure/postgresql/gopher-main/user','gopher','text/plain','','',1,'2019-08-05 17:28:13',0,NULL),(19,'password',16,'/infrastructure/postgresql/gopher-main/password','gopher-gopher-gopher-gopher','text/plain','','',1,'2019-08-05 17:28:41',0,NULL),(20,'base',16,'/infrastructure/postgresql/gopher-main/base','gopher','text/plain','','',1,'2019-08-05 17:29:01',0,NULL),(21,'gopher-stat',14,'/infrastructure/postgresql/gopher-stat',NULL,'application/x-null','Gopher statistics','',1,'2019-08-05 17:30:18',0,NULL),(22,'base',21,'/infrastructure/postgresql/gopher-stat/base','gopher_stat','text/plain','','',1,'2019-08-05 17:30:51',0,NULL),(23,'host',21,'/infrastructure/postgresql/gopher-stat/host','statdb1.gopher.example.com','text/plain','','',1,'2019-08-05 17:31:15',0,NULL),(24,'user',21,'/infrastructure/postgresql/gopher-stat/user','gopher','text/plain','','',1,'2019-08-05 17:31:30',0,NULL),(25,'password',21,'/infrastructure/postgresql/gopher-stat/password','gopher-gopher-gopher-gopher','text/plain','','',1,'2019-08-05 17:32:03',0,NULL),(26,'gopher-user',15,'/infrastructure/tarantool/gopher-user','userkvs1.gopher.example.com','text/plain','','',1,'2019-08-05 17:33:21',0,NULL),(27,'replica',26,'/infrastructure/tarantool/gopher-user/replica','userkvs2.gopher.example.com','text/plain','','',1,'2019-08-05 17:33:56',0,NULL),(28,'user',7,'/gopher/user',NULL,'application/x-null','','',1,'2019-08-05 17:34:39',0,NULL),(29,'box',28,'/gopher/user/box','/infrastructure/tarantool/gopher-user','application/x-symlink','','',1,'2019-08-05 17:35:34',0,NULL),(30,'statistics',7,'/gopher/statistics',NULL,'application/x-null','','',1,'2019-08-05 17:36:02',0,NULL),(31,'database',30,'/gopher/statistics/database','/infrastructure/postgresql/gopher-stat','application/x-symlink','','',1,'2019-08-05 17:36:24',0,NULL),(32,'squirrel',9,'/onlineconf/chroot/squirrel','delimiter: /','application/x-yaml','','',1,'2019-08-05 17:38:49',0,NULL),(33,'graphite',13,'/infrastructure/graphite',NULL,'application/x-null','','',1,'2019-08-05 17:50:37',0,NULL),(34,'host',33,'/infrastructure/graphite/host','graphite1.example.com','text/plain','','',1,'2019-08-05 17:51:06',0,NULL),(35,'port',33,'/infrastructure/graphite/port',NULL,'application/x-null','','',1,'2019-08-05 17:51:19',0,NULL),(36,'carbon',35,'/infrastructure/graphite/port/carbon','2003','text/plain','','',1,'2019-08-05 17:51:53',0,NULL),(37,'carbide',35,'/infrastructure/graphite/port/carbide','2004','text/plain','','',1,'2019-08-05 17:52:07',0,NULL),(38,'graphite',30,'/gopher/statistics/graphite','${/infrastructure/graphite/host}:${/infrastructure/graphite/port/carbide}','application/x-template','','',1,'2019-08-05 17:53:12',0,NULL),(39,'sms-verification',28,'/gopher/user/sms-verification','[{\"mime\":\"text/plain\",\"value\":\"1\"},{\"mime\":\"text/plain\",\"value\":\"0\",\"group\":\"gopher-alpha\"}]','application/x-case','Require SMS verification','',2,'2019-08-05 18:06:54',0,NULL),(40,'group',2,'/onlineconf/group',NULL,'application/x-null','','',1,'2019-08-05 18:05:39',0,NULL),(41,'gopher-alpha',40,'/onlineconf/group/gopher-alpha','alpha*.gopher.example.com','text/plain','Gopher Alpha','',1,'2019-08-05 18:06:18',0,NULL),(42,'content',7,'/gopher/content',NULL,'application/x-null','','',1,'2019-08-05 18:08:26',0,NULL),(43,'database',42,'/gopher/content/database','/infrastructure/postgresql/gopher-main','application/x-symlink','','',1,'2019-08-05 18:08:44',0,NULL),(44,'gopherizator-percent',42,'/gopher/content/gopherizator-percent','42','text/plain','','',1,'2019-08-05 18:10:44',0,NULL),(45,'squirrel-user',15,'/infrastructure/tarantool/squirrel-user','userkvs1.squirrel.example.com','text/plain','','',1,'2019-08-05 18:15:40',0,NULL),(46,'replica',45,'/infrastructure/tarantool/squirrel-user/replica','userkvs2.squirrel.example.com','text/plain','','',1,'2019-08-05 18:16:04',0,NULL),(47,'user',8,'/squirrel/user',NULL,'application/x-null','','',1,'2019-08-05 18:16:50',0,NULL),(48,'box',47,'/squirrel/user/box','/infrastructure/tarantool/squirrel-user','application/x-symlink','','',1,'2019-08-05 18:17:09',0,NULL),(49,'statistics',8,'/squirrel/statistics',NULL,'application/x-null','','',1,'2019-08-05 18:18:14',0,NULL),(50,'graphite',49,'/squirrel/statistics/graphite','${/infrastructure/graphite/host}:${/infrastructure/graphite/port/carbide}','application/x-template','','',2,'2019-08-05 18:30:28',0,NULL),(51,'nut',8,'/squirrel/nut',NULL,'application/x-null','','',1,'2019-08-05 18:19:37',0,NULL),(52,'mashroom',8,'/squirrel/mashroom',NULL,'application/x-null','','',1,'2019-08-05 18:19:53',0,NULL),(54,'collect-huzelnut',51,'/squirrel/nut/collect-huzelnut','1','text/plain','','',1,'2019-08-05 18:21:32',0,NULL),(55,'collect-amanita',52,'/squirrel/mashroom/collect-amanita','0','text/plain','','',1,'2019-08-05 18:22:22',0,NULL),(56,'collect-boletus',52,'/squirrel/mashroom/collect-boletus','1','text/plain','','',1,'2019-08-05 18:23:36',0,NULL),(57,'red',32,'/onlineconf/chroot/squirrel/red',NULL,'application/x-null','','',1,'2019-08-05 18:24:37',0,NULL),(58,'gray',32,'/onlineconf/chroot/squirrel/gray',NULL,'application/x-null','','',1,'2019-08-05 18:26:29',0,NULL),(59,'user',58,'/onlineconf/chroot/squirrel/gray/user','/squirrel/user','application/x-symlink','','',1,'2019-08-05 18:26:50',0,NULL),(60,'mashroom',58,'/onlineconf/chroot/squirrel/gray/mashroom','/squirrel/mashroom','application/x-symlink','','',1,'2019-08-05 18:27:18',0,NULL),(61,'user',57,'/onlineconf/chroot/squirrel/red/user','/squirrel/user','application/x-symlink','','',1,'2019-08-05 18:27:34',0,NULL),(62,'statistics',57,'/onlineconf/chroot/squirrel/red/statistics','/squirrel/statistics','application/x-symlink','','',1,'2019-08-05 18:27:55',0,NULL),(63,'nut',57,'/onlineconf/chroot/squirrel/red/nut','/squirrel/nut','application/x-symlink','','',1,'2019-08-05 18:28:11',0,NULL),(64,'promocode',8,'/squirrel/promocode','{\n  \"BELKA5\": {\n    \"action\": \"discount\",\n    \"percent\": 5,\n    \"from\": \"2019-09-01\",\n    \"till\": \"2019-12-01\"\n  },\n  \"BELKA15\": {\n    \"premiumCard\": true,\n    \"action\": \"discount\",\n    \"percent\": 15,\n    \"from\": \"2019-09-01\",\n    \"till\": \"2019-12-01\"\n  },\n  \"STRELKA200\": {\n    \"action\": \"bonus\",\n    \"value\": 200,\n    \"from\": \"2019-01-01\",\n    \"till\": \"2020-01-01\"\n  }\n}','application/json','Active promocodes','',1,'2019-09-16 16:23:11',0,NULL),(65,'promocode',58,'/onlineconf/chroot/squirrel/gray/promocode','/squirrel/promocode','application/x-symlink','','',1,'2019-09-16 16:26:42',0,NULL),(66,'ephemeral-ip',2,'/onlineconf/ephemeral-ip','172.0.0.0/8','text/plain','','',1,'2022-10-24 18:15:21',0,NULL),(67,'nginx',1,'/nginx',NULL,'application/x-null','Nginx','',1,'2024-05-17 17:01:00',0,NULL),(68,'serviceB',67,'/nginx/serviceB',NULL,'application/x-null','','',2,'2024-05-26 14:19:35',0,NULL),(69,'using',68,'/nginx/serviceB/using','1','text/plain','','',2,'2024-05-26 14:43:33',0,NULL),(70,'endpoints',68,'/nginx/serviceB/endpoints',NULL,'application/x-null','','',1,'2024-05-26 11:37:11',0,NULL),(71,'GET_api_v1_users',70,'/nginx/serviceB/endpoints/GET_api_v1_users','on','application/x-list','','',4,'2024-05-26 15:11:25',0,NULL),(72,'nginx',4,'/onlineconf/service/nginx','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','text/plain','','',1,'2024-05-26 11:38:20',0,NULL),(73,'nginx',9,'/onlineconf/chroot/nginx','delimiter: .','application/x-yaml','','',1,'2024-05-26 11:39:07',0,NULL),(74,'nginx',73,'/onlineconf/chroot/nginx/nginx','/nginx','application/x-symlink','','',1,'2024-05-26 11:39:21',0,NULL),(75,'GET_api_v1_payout_{ID}',70,'/nginx/serviceB/endpoints/GET_api_v1_payout_{ID}','on','text/plain','','',2,'2024-09-24 09:54:14',0,NULL),(76,'list',70,'/nginx/serviceB/endpoints/list','/api/v1/users,/api/v1/payout/{ID}','application/x-list','','',1,'2024-09-24 09:53:58',0,NULL);
/*!40000 ALTER TABLE `my_config_tree` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `my_config_tree_path` BEFORE INSERT ON `my_config_tree` FOR EACH ROW BEGIN
    DECLARE cnt int;
    DECLARE parent_path varchar(512);
    IF NEW.ParentID IS NULL THEN
        SELECT count(*) INTO cnt FROM my_config_tree WHERE ParentID IS NULL;
        IF cnt = 0 THEN
            SET NEW.Name = '';
            SET NEW.Path = '/';
        ELSE
            SET NEW.Name = NULL;
        END IF;
    ELSEIF NEW.Name LIKE '%/%' THEN
        SET NEW.Name = NULL;
    ELSE
        SELECT `Path` INTO parent_path FROM `my_config_tree` where `ID` = NEW.`ParentID`;
        IF parent_path = '/' THEN
            SET NEW.Path = CONCAT('/', NEW.Name);
        ELSE
            SET NEW.Path = CONCAT(parent_path, '/', NEW.Name);
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `my_config_tree_move` BEFORE UPDATE ON `my_config_tree` FOR EACH ROW BEGIN
    DECLARE parent_path varchar(512);
    IF NEW.Path <> OLD.Path OR NEW.Name <> OLD.Name OR NEW.ParentID <> OLD.ParentID THEN
        SELECT `Path` INTO parent_path FROM `my_config_tree` where `ID` = NEW.`ParentID`;
        IF parent_path = '/' THEN
            SET NEW.Path = CONCAT('/', NEW.Name);
        ELSE
            SET NEW.Path = CONCAT(parent_path, '/', NEW.Name);
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `my_config_tree_group`
--

DROP TABLE IF EXISTS `my_config_tree_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_config_tree_group` (
  `NodeID` bigint unsigned NOT NULL,
  `GroupID` int NOT NULL,
  `RW` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`NodeID`,`GroupID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `my_config_tree_group_ibfk_1` FOREIGN KEY (`NodeID`) REFERENCES `my_config_tree` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `my_config_tree_group_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `my_config_group` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_config_tree_group`
--

LOCK TABLES `my_config_tree_group` WRITE;
/*!40000 ALTER TABLE `my_config_tree_group` DISABLE KEYS */;
INSERT INTO `my_config_tree_group` VALUES (1,1,1),(3,3,0),(3,4,0),(7,3,1),(8,4,1),(10,3,1),(13,2,1),(32,4,1),(51,5,1),(52,5,1),(64,5,1);
/*!40000 ALTER TABLE `my_config_tree_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_config_tree_log`
--

DROP TABLE IF EXISTS `my_config_tree_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_config_tree_log` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `NodeID` bigint unsigned NOT NULL,
  `Version` int NOT NULL,
  `Value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `ContentType` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT 'application/x-null',
  `Author` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `MTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Comment` varchar(512) DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NodeID` (`NodeID`,`Version`),
  KEY `MTime` (`MTime`),
  CONSTRAINT `my_config_tree_log_ibfk_1` FOREIGN KEY (`NodeID`) REFERENCES `my_config_tree` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_config_tree_log`
--

LOCK TABLES `my_config_tree_log` WRITE;
/*!40000 ALTER TABLE `my_config_tree_log` DISABLE KEYS */;
INSERT INTO `my_config_tree_log` VALUES (1,1,1,NULL,'application/x-null','onlineconf','2019-08-05 17:01:16',NULL,0),(2,2,1,NULL,'application/x-null','onlineconf','2019-08-05 17:01:16',NULL,0),(3,3,1,NULL,'application/x-null','onlineconf','2019-08-05 17:01:16',NULL,0),(4,4,1,NULL,'application/x-null','onlineconf','2019-08-05 17:01:16',NULL,0),(5,5,1,'9cc1ee455a3363ffc504f40006f70d0c8276648a5d3eb3f9524e94d1b7a83aef','text/plain','admin','2019-08-05 17:13:00','Add account for gopher service',0),(6,6,1,'960a38ace75a2fe9426aa5d48b536cc6db18a2023b9bdd698e562fc3023585a6','text/plain','admin','2019-08-05 17:13:35','Add account for squirrel service',0),(7,7,1,NULL,'application/x-null','admin','2019-08-05 17:17:01','Initialize gopher',0),(8,8,1,NULL,'application/x-null','admin','2019-08-05 17:17:16','Squirrel project root',0),(9,9,1,NULL,'application/x-null','admin','2019-08-05 17:17:50','Initialize chroot',0),(10,10,1,'delimiter: /','application/x-yaml','admin','2019-08-05 17:18:12','Initialize gopher',0),(11,11,1,NULL,'application/x-null','admin','2019-08-05 17:19:38','Initialize gopher',0),(12,12,1,'/gopher','application/x-symlink','admin','2019-08-05 17:20:15','Initialize gopher',0),(13,13,1,NULL,'application/x-null','admin','2019-08-05 17:24:45','Init infra',0),(14,14,1,NULL,'application/x-null','admin','2019-08-05 17:25:54','Init infra',0),(15,15,1,NULL,'application/x-null','admin','2019-08-05 17:26:04','Init infra',0),(16,16,1,NULL,'application/x-null','admin','2019-08-05 17:27:13','Init gopher',0),(17,17,1,'db1.gopher.example.com','text/plain','admin','2019-08-05 17:27:53','Init gopher',0),(18,18,1,'gopher','text/plain','admin','2019-08-05 17:28:13','Init gopher',0),(19,19,1,'gopher-gopher-gopher-gopher','text/plain','admin','2019-08-05 17:28:41','Init gopher',0),(20,20,1,'gopher','text/plain','admin','2019-08-05 17:29:01','Init gopher',0),(21,21,1,NULL,'application/x-null','admin','2019-08-05 17:30:18','Init gopher',0),(22,22,1,'gopher_stat','text/plain','admin','2019-08-05 17:30:51','Init gopher',0),(23,23,1,'statdb1.gopher.example.com','text/plain','admin','2019-08-05 17:31:15','Init gopher',0),(24,24,1,'gopher','text/plain','admin','2019-08-05 17:31:30','Init gopher',0),(25,25,1,'gopher-gopher-gopher-gopher','text/plain','admin','2019-08-05 17:32:03','Init gopher',0),(26,26,1,'userkvs1.gopher.example.com','text/plain','admin','2019-08-05 17:33:21','Init gopher',0),(27,27,1,'userkvs2.gopher.example.com','text/plain','admin','2019-08-05 17:33:56','Init gopher',0),(28,28,1,NULL,'application/x-null','admin','2019-08-05 17:34:39','Init gopher',0),(29,29,1,'/infrastructure/tarantool/gopher-user','application/x-symlink','admin','2019-08-05 17:35:34','Init gopher',0),(30,30,1,NULL,'application/x-null','admin','2019-08-05 17:36:02','Init gopher',0),(31,31,1,'/infrastructure/postgresql/gopher-stat','application/x-symlink','admin','2019-08-05 17:36:24','Init gopher',0),(32,32,1,'delimiter: /','application/x-yaml','admin','2019-08-05 17:38:49','Init squirrel',0),(33,3,2,'[{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/gopher\",\"service\":\"gopher\"},{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/squirrel\",\"service\":\"squirrel\"}]','application/x-case','admin','2019-08-05 17:39:43','Init chrooted module',0),(34,33,1,NULL,'application/x-null','admin','2019-08-05 17:50:37','Init infra',0),(35,34,1,'graphite1.example.com','text/plain','admin','2019-08-05 17:51:06','Init infra',0),(36,35,1,NULL,'application/x-null','admin','2019-08-05 17:51:19','Init infra',0),(37,36,1,'2003','text/plain','admin','2019-08-05 17:51:53','Init infra',0),(38,37,1,'2004','text/plain','admin','2019-08-05 17:52:07','Init infra',0),(39,38,1,'${/infrastructure/graphite/host}:${/infrastructure/graphite/port/carbide}','application/x-template','admin','2019-08-05 17:53:12','Init gopher',0),(40,39,1,'1','text/plain','admin','2019-08-05 18:02:17','Init gopher',0),(41,40,1,NULL,'application/x-null','admin','2019-08-05 18:05:39','Init infra',0),(42,41,1,'alpha*.gopher.example.com','text/plain','admin','2019-08-05 18:06:18','Init gopher',0),(43,39,2,'[{\"mime\":\"text/plain\",\"value\":\"1\"},{\"mime\":\"text/plain\",\"value\":\"0\",\"group\":\"gopher-alpha\"}]','application/x-case','admin','2019-08-05 18:06:54','Disable SMS verification on alpha',0),(44,42,1,NULL,'application/x-null','admin','2019-08-05 18:08:26','Init gopher',0),(45,43,1,'/infrastructure/postgresql/gopher-main','application/x-symlink','admin','2019-08-05 18:08:44','Init gopher',0),(46,44,1,'42','text/plain','admin','2019-08-05 18:10:44','Enable gopherizator for 42% of users',0),(47,45,1,'userkvs1.squirrel.example.com','text/plain','admin','2019-08-05 18:15:40','Init squirrel',0),(48,46,1,'userkvs2.squirrel.example.com','text/plain','admin','2019-08-05 18:16:04','Init squirrel',0),(49,47,1,NULL,'application/x-null','admin','2019-08-05 18:16:50','Init squirrel',0),(50,48,1,'/infrastructure/tarantool/squirrel-user','application/x-symlink','admin','2019-08-05 18:17:09','Init squirrel',0),(51,49,1,NULL,'application/x-null','admin','2019-08-05 18:18:14','Init squirrel',0),(52,50,1,'${/infrasructure/graphite/host}:${/infrastucture/graphite/port/carbide}','application/x-template','admin','2019-08-05 18:18:53','Init squirrel',0),(53,51,1,NULL,'application/x-null','admin','2019-08-05 18:19:37','Init squirrel',0),(54,52,1,NULL,'application/x-null','admin','2019-08-05 18:19:53','Init squirrel',0),(55,54,1,'1','text/plain','admin','2019-08-05 18:21:32','Init squirrel',0),(56,55,1,'0','text/plain','admin','2019-08-05 18:22:22','Init squirrel',0),(57,56,1,'1','text/plain','admin','2019-08-05 18:23:36','Init squirrel',0),(58,57,1,NULL,'application/x-null','admin','2019-08-05 18:24:37','Init squirrel',0),(59,58,1,NULL,'application/x-null','admin','2019-08-05 18:26:29','Init squrrel',0),(60,59,1,'/squirrel/user','application/x-symlink','admin','2019-08-05 18:26:50','Init squirrel',0),(61,60,1,'/squirrel/mashroom','application/x-symlink','admin','2019-08-05 18:27:18','Init squirrel',0),(62,61,1,'/squirrel/user','application/x-symlink','admin','2019-08-05 18:27:34','Init squirrel',0),(63,62,1,'/squirrel/statistics','application/x-symlink','admin','2019-08-05 18:27:55','Init squirrel',0),(64,63,1,'/squirrel/nut','application/x-symlink','admin','2019-08-05 18:28:11','Init squirrel',0),(65,50,2,'${/infrastructure/graphite/host}:${/infrastructure/graphite/port/carbide}','application/x-template','admin','2019-08-05 18:30:28','Fix misprint',0),(66,64,1,'{\n  \"BELKA5\": {\n    \"action\": \"discount\",\n    \"percent\": 5,\n    \"from\": \"2019-09-01\",\n    \"till\": \"2019-12-01\"\n  },\n  \"BELKA15\": {\n    \"premiumCard\": true,\n    \"action\": \"discount\",\n    \"percent\": 15,\n    \"from\": \"2019-09-01\",\n    \"till\": \"2019-12-01\"\n  },\n  \"STRELKA200\": {\n    \"action\": \"bonus\",\n    \"value\": 200,\n    \"from\": \"2019-01-01\",\n    \"till\": \"2020-01-01\"\n  }\n}','application/json','admin','2019-09-16 16:23:11','json example',0),(67,65,1,'/squirrel/promocode','application/x-symlink','admin','2019-09-16 16:26:42','json example',0),(68,66,1,'172.0.0.0/8','text/plain','admin','2022-10-24 18:15:21','',0),(69,68,1,'','text/plain','admin','2024-05-26 11:36:42','add',0),(70,69,1,'0','text/plain','admin','2024-05-26 11:36:54','add',0),(71,70,1,NULL,'application/x-null','admin','2024-05-26 11:37:11','add',0),(72,71,1,'100,list','application/x-list','admin','2024-05-26 11:37:37','add',0),(73,72,1,'5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','text/plain','admin','2024-05-26 11:38:20','add',0),(74,3,3,'[{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/gopher\",\"service\":\"gopher\"},{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/squirrel\",\"service\":\"squirrel\"},{\"mime\":\"application/x-symlink\",\"value\":\"/nginx\",\"service\":\"nginx\"}]','application/x-case','admin','2024-05-26 11:38:46','add',0),(75,73,1,'delimiter: .','application/x-yaml','admin','2024-05-26 11:39:07','add',0),(76,74,1,'/nginx','application/x-symlink','admin','2024-05-26 11:39:21','add',0),(77,68,2,NULL,'application/x-null','admin','2024-05-26 14:19:35','update',0),(78,3,4,'[{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/gopher\",\"service\":\"gopher\"},{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/squirrel\",\"service\":\"squirrel\"},{\"mime\":\"application/x-symlink\",\"value\":\"/onlineconf/chroot/nginx\",\"service\":\"nginx\"}]','application/x-case','admin','2024-05-26 14:25:53','update',0),(79,71,2,'0','application/x-list','admin','2024-05-26 14:42:54','add',0),(80,69,2,'1','text/plain','admin','2024-05-26 14:43:33','add',0),(81,71,3,'switcher','application/x-list','admin','2024-05-26 14:45:12','update',0),(82,71,4,'on','application/x-list','admin','2024-05-26 15:11:25','update',0),(83,75,1,'on','text/plain','admin','2024-08-13 18:14:04','on',0),(84,76,1,'/api/v1/users,/api/v1/payout/{ID}','application/x-list','admin','2024-09-24 09:53:58','add',0),(85,75,2,'on','text/plain','admin','2024-09-24 09:54:14','Moved from /nginx/serviceB/endpoints/GET_api_v1_payout_{AnyID}. mv',0);
/*!40000 ALTER TABLE `my_config_tree_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_config_user_group`
--

DROP TABLE IF EXISTS `my_config_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_config_user_group` (
  `User` varchar(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `GroupID` int NOT NULL,
  UNIQUE KEY `User_Group` (`User`,`GroupID`),
  KEY `User` (`User`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `my_config_user_group_ibfk_1` FOREIGN KEY (`GroupID`) REFERENCES `my_config_group` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_config_user_group`
--

LOCK TABLES `my_config_user_group` WRITE;
/*!40000 ALTER TABLE `my_config_user_group` DISABLE KEYS */;
INSERT INTO `my_config_user_group` VALUES ('admin',1),('hedgehog',2),('meerkat',3),('rabbit',4),('beaver',5);
/*!40000 ALTER TABLE `my_config_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'onlineconf'
--
/*!50003 DROP FUNCTION IF EXISTS `my_config_tree_access` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `my_config_tree_access`(`node_id` bigint(20) unsigned, `username` varchar(256)) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE `result` boolean;
    DECLARE `current_node_id` bigint(20) unsigned;
    DECLARE `group_id` int(11);
    DECLARE `rw` boolean;
    DECLARE `done` boolean DEFAULT false;
    DECLARE `group_cur` CURSOR FOR
        SELECT ug.`GroupID`
        FROM `my_config_user_group` ug
        WHERE ug.`User` = `username`;

    OPEN `group_cur`;
    group_loop: LOOP
        BEGIN
            DECLARE EXIT HANDLER FOR NOT FOUND BEGIN SET `done` = true; END;
            FETCH `group_cur` INTO `group_id`;
        END;
        IF `done` THEN
            LEAVE group_loop;
        END IF;

        SET `current_node_id` = `node_id`;
        node_loop: WHILE `current_node_id` IS NOT NULL DO
            BEGIN
                DECLARE `current_result` boolean;
                DECLARE EXIT HANDLER FOR NOT FOUND BEGIN END;

                SELECT tg.`RW` INTO `current_result`
                FROM `my_config_tree_group` tg
                WHERE tg.`NodeID` = `current_node_id`
                AND tg.`GroupID` = `group_id`;

                IF `current_result` IS NOT NULL AND (`result` IS NULL OR `current_result` > `result`) THEN
                    SET `result` = `current_result`;
                    IF `result` THEN
                        LEAVE group_loop;
                    END IF;
                END IF;
                LEAVE node_loop;
            END;
            SELECT `ParentID` INTO `current_node_id` FROM `my_config_tree` WHERE `ID` = `current_node_id`;
        END WHILE;
    END LOOP;
    CLOSE `group_cur`;

    RETURN `result`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `my_config_tree_group_access` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `my_config_tree_group_access`(`node_id` bigint(20) unsigned, `group_id` int(11)) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE `result` boolean;

    WHILE `node_id` IS NOT NULL DO
        BEGIN
            DECLARE EXIT HANDLER FOR SQLSTATE '02000' BEGIN END;

            SELECT `RW` INTO `result`
            FROM `my_config_tree_group` tg
            WHERE tg.`NodeID` = `node_id` AND tg.`GroupID` = `group_id`
            ORDER BY `RW` DESC
            LIMIT 1;

            RETURN `result`;
        END;

        SELECT `ParentID` INTO `node_id` FROM `my_config_tree` WHERE `ID` = `node_id`;
    END WHILE;

    RETURN `result`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `my_config_tree_notification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `my_config_tree_notification`(`node_id` bigint(20) unsigned) RETURNS enum('none','no-value','with-value') CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE `notification` enum('none', 'no-value', 'with-value');

    WHILE `node_id` IS NOT NULL DO
        SELECT t.`ParentID`, t.`Notification` INTO `node_id`, `notification`
        FROM `my_config_tree` t
        WHERE t.`ID` = `node_id`;

        IF `notification` IS NOT NULL THEN
            RETURN `notification`;
        END IF;
    END WHILE;

    RETURN NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-24  9:55:34
