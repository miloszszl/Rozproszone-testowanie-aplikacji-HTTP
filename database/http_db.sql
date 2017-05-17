-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: http_db
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE ucs2_polish_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add batch',7,'add_batch'),(20,'Can change batch',7,'change_batch'),(21,'Can delete batch',7,'delete_batch'),(22,'Can add button',8,'add_button'),(23,'Can change button',8,'change_button'),(24,'Can delete button',8,'delete_button'),(25,'Can add page',9,'add_page'),(26,'Can change page',9,'change_page'),(27,'Can delete page',9,'delete_page'),(28,'Can add page_ connection',10,'add_page_connection'),(29,'Can change page_ connection',10,'change_page_connection'),(30,'Can delete page_ connection',10,'delete_page_connection'),(31,'Can add page_ host',11,'add_page_host'),(32,'Can change page_ host',11,'change_page_host'),(33,'Can delete page_ host',11,'delete_page_host'),(34,'Can add page_ test',12,'add_page_test'),(35,'Can change page_ test',12,'change_page_test'),(36,'Can delete page_ test',12,'delete_page_test'),(37,'Can add t_ p_b',13,'add_t_p_b'),(38,'Can change t_ p_b',13,'change_t_p_b'),(39,'Can delete t_ p_b',13,'delete_t_p_b'),(40,'Can add test',14,'add_test'),(41,'Can change test',14,'change_test'),(42,'Can delete test',14,'delete_test'),(43,'Can add user',15,'add_user'),(44,'Can change user',15,'change_user'),(45,'Can delete user',15,'delete_user');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE ucs2_polish_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE ucs2_polish_ci NOT NULL,
  `first_name` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  `last_name` varchar(30) COLLATE ucs2_polish_ci NOT NULL,
  `email` varchar(254) COLLATE ucs2_polish_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$2S31CQuHlsH0$8etrJdQ0UGHJcwhDyTgys2yKLamgpehBZl9HXDYmLz0=','2017-05-11 09:23:23.436197',1,'milosz','','','miloszszl@interia.pl',1,1,'2017-05-03 16:28:02.980759');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `levels` int(11) NOT NULL,
  `page_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Batch_test_id_6f58cb58_fk_Tests_id` (`test_id`),
  KEY `Batch_page_id_f61792ce_fk_Pages_id` (`page_id`),
  CONSTRAINT `Batch_page_id_f61792ce_fk_Pages_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Batch_test_id_6f58cb58_fk_Tests_id` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES (1,3,1,1),(2,2,3,2),(3,3,1,1),(4,5,3,4),(5,3,1,NULL),(6,3,1,NULL),(7,3,NULL,NULL),(8,3,NULL,NULL),(9,3,1,10),(10,3,1,10),(11,3,1,12),(12,3,1,12),(13,3,1,19),(14,3,1,19),(15,3,1,20),(16,3,1,20),(17,3,1,21),(18,3,1,21),(19,3,1,22),(20,3,1,22),(21,3,1,27),(22,3,1,27),(23,3,1,30),(24,3,1,30),(25,3,1,31),(26,3,1,31),(27,3,1,33),(28,3,1,33),(29,3,1,38),(30,3,1,38),(31,3,1,39),(32,3,1,39),(33,3,1,43),(34,3,1,43),(35,3,1,44),(36,3,1,44),(37,3,1,46),(38,3,1,46),(39,3,1,47),(40,3,1,47),(41,3,1,48),(42,3,1,48),(43,3,1,49),(44,3,1,49),(45,3,1,50),(46,3,1,50),(47,3,1,51),(48,3,1,51),(49,3,1,52),(50,3,1,52),(51,3,1,53),(52,3,1,53),(53,3,1,54),(54,3,1,54),(55,3,1,55),(56,3,1,55),(57,3,1,56),(58,3,1,56),(59,3,1,62),(60,3,1,62),(61,3,1,65),(62,3,1,65),(63,3,1,66),(64,3,1,66),(65,3,1,67),(66,3,1,67),(67,3,1,68),(68,3,1,68),(69,3,1,69),(70,3,1,69),(71,3,1,70),(72,3,1,70),(73,3,1,71),(74,3,1,71),(75,3,1,72),(76,3,1,72),(77,3,1,73),(78,3,1,73),(79,3,1,74),(80,3,1,74),(81,3,1,75),(82,3,1,75),(83,3,1,76),(84,3,1,76),(85,3,1,77),(86,3,1,77),(87,3,1,79),(88,3,1,79),(89,3,1,80),(90,3,1,80),(91,3,1,81),(92,3,1,81),(93,3,1,90),(94,3,1,90);
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buttons`
--

DROP TABLE IF EXISTS `buttons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locator` varchar(5000) COLLATE ucs2_polish_ci NOT NULL,
  `page_id` int(11) DEFAULT NULL,
  `global_working_percentage` decimal(5,2) DEFAULT NULL,
  `last_month_working_percentage` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Buttons_page_id_d863ccc4_fk_Pages_id` (`page_id`),
  CONSTRAINT `Buttons_page_id_d863ccc4_fk_Pages_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buttons`
--

LOCK TABLES `buttons` WRITE;
/*!40000 ALTER TABLE `buttons` DISABLE KEYS */;
INSERT INTO `buttons` VALUES (1,'6456y5fgsh sgfh gfh fgsh fsgh shg',1,100.00,100.00),(2,'hsfghfgs b 54 yhfg hf hsf hsfvs v',1,2.78,2.78),(3,'gf 54w gehbh avfew ttdhagrzz',1,NULL,NULL),(4,'sdf sdf3 sr fd fdd',2,12.00,0.00),(5,'sf dSF 3QFQCF',2,1.00,88.00),(6,'SDF  4QX3 QA',3,33.00,44.00),(7,'6456y5fgsh sgfh gfh fgsh fsgh shg',20,12.00,0.00),(8,'hsfghfgs b 54 yhfg hf hsf hsfvs v',20,77.00,0.00),(9,'gf 54w gehbh avfew ttdhagrzz',20,NULL,NULL),(10,'6456y5fgsh sgfh gfh fgsh fsgh shg',21,12.00,55.00),(11,'6456y5fgsh sgfh gfh fgsh fsgh shg',22,12.00,55.00),(12,'6456y5fgsh sgfh gfh fgsh fsgh shg',23,12.00,55.00),(13,'6456y5fgsh sgfh gfh fgsh fsgh shg',24,12.00,100.00),(14,'hsfghfgs b 54 yhfg hf hsf hsfvs v',24,77.00,0.00),(15,'gf 54w gehbh avfew ttdhagrzz',24,NULL,NULL),(16,'6456y5fgsh sgfh gfh fgsh fsgh shg',25,12.00,100.00),(17,'hsfghfgs b 54 yhfg hf hsf hsfvs v',25,77.00,0.00),(18,'gf 54w gehbh avfew ttdhagrzz',25,NULL,NULL),(19,'6456y5fgsh sgfh gfh fgsh fsgh shg',26,12.00,100.00),(20,'hsfghfgs b 54 yhfg hf hsf hsfvs v',26,77.00,0.00),(21,'gf 54w gehbh avfew ttdhagrzz',26,NULL,NULL),(22,'6456y5fgsh sgfh gfh fgsh fsgh shg',27,12.00,100.00),(23,'hsfghfgs b 54 yhfg hf hsf hsfvs v',27,77.00,0.00),(24,'gf 54w gehbh avfew ttdhagrzz',27,NULL,NULL);
/*!40000 ALTER TABLE `buttons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE ucs2_polish_ci,
  `object_repr` varchar(200) COLLATE ucs2_polish_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE ucs2_polish_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-05-03 16:30:39.721377','1','a',1,'[{\"added\": {}}]',11,1),(2,'2017-05-03 16:30:46.918109','2','a',1,'[{\"added\": {}}]',11,1),(3,'2017-05-03 16:31:05.141415','1','Page object',1,'[{\"added\": {}}]',9,1),(4,'2017-05-04 12:44:23.563437','1','edasdsad : 12e',1,'[{\"added\": {}}]',15,1),(5,'2017-05-04 12:44:29.094907','2','dfsvf : 12ed',1,'[{\"added\": {}}]',15,1),(6,'2017-05-04 12:44:39.325409','1','2017-05-04 14:44:34+02:00',1,'[{\"added\": {}}]',14,1),(7,'2017-05-04 12:44:46.282738','2','2017-05-04 14:44:42+02:00',1,'[{\"added\": {}}]',14,1),(8,'2017-05-04 12:44:51.430889','3','2017-05-04 14:44:48+02:00',1,'[{\"added\": {}}]',14,1),(9,'2017-05-04 12:44:58.665882','4','2017-05-04 14:44:56+02:00',1,'[{\"added\": {}}]',14,1),(10,'2017-05-04 13:07:20.640844','2','Page object',1,'[{\"added\": {}}]',9,1),(11,'2017-05-04 13:07:30.606606','3','Page object',1,'[{\"added\": {}}]',9,1),(12,'2017-05-04 13:08:18.543743','1','Batch object',1,'[{\"added\": {}}]',7,1),(13,'2017-05-04 13:08:28.934979','2','Batch object',1,'[{\"added\": {}}]',7,1),(14,'2017-05-04 13:08:35.564085','3','Batch object',1,'[{\"added\": {}}]',7,1),(15,'2017-05-04 13:08:44.093903','4','Batch object',1,'[{\"added\": {}}]',7,1),(16,'2017-05-04 14:45:51.942417','1','Page_Test object',1,'[{\"added\": {}}]',12,1),(17,'2017-05-04 14:46:02.634443','2','Page_Test object',1,'[{\"added\": {}}]',12,1),(18,'2017-05-04 15:25:08.270087','1','6456y5fgsh sgfh gfh fgsh fsgh shg',1,'[{\"added\": {}}]',8,1),(19,'2017-05-04 15:25:17.128206','2','hsfghfgs b 54 yhfg hf hsf hsfvs v',1,'[{\"added\": {}}]',8,1),(20,'2017-05-04 15:25:23.689012','3','gf 54w gehbh avfew ttdhagrzz',1,'[{\"added\": {}}]',8,1),(21,'2017-05-04 15:25:30.276760','4','sdf sdf3 sr fd fdd',1,'[{\"added\": {}}]',8,1),(22,'2017-05-04 15:25:35.206403','5','sf dSF 3QFQCF',1,'[{\"added\": {}}]',8,1),(23,'2017-05-04 15:25:41.253353','6','SDF  4QX3 QA',1,'[{\"added\": {}}]',8,1),(24,'2017-05-04 16:15:40.643944','1','T_P_B object',1,'[{\"added\": {}}]',13,1),(25,'2017-05-04 16:15:46.471697','2','T_P_B object',1,'[{\"added\": {}}]',13,1),(26,'2017-05-04 16:15:52.062238','3','T_P_B object',1,'[{\"added\": {}}]',13,1),(27,'2017-05-04 16:16:01.564866','4','T_P_B object',1,'[{\"added\": {}}]',13,1),(28,'2017-05-07 17:16:10.943425','3','Page_Test object',1,'[{\"added\": {}}]',12,1),(29,'2017-05-10 11:04:06.978479','1','a',1,'[{\"added\": {}}]',10,1),(30,'2017-05-10 11:04:13.200134','2','a',1,'[{\"added\": {}}]',10,1),(31,'2017-05-10 11:04:20.070720','3','a',1,'[{\"added\": {}}]',10,1),(32,'2017-05-11 16:26:28.920886','1','Page object',2,'[{\"changed\": {\"fields\": [\"global_working_percentage\", \"last_month_working_percentage\", \"redirection_percentage\"]}}]',9,1),(33,'2017-05-11 16:34:40.069905','1','6456y5fgsh sgfh gfh fgsh fsgh shg',2,'[{\"changed\": {\"fields\": [\"global_working_percentage\", \"last_month_working_percentage\"]}}]',8,1),(34,'2017-05-11 16:35:54.580364','1','6456y5fgsh sgfh gfh fgsh fsgh shg',2,'[]',8,1),(35,'2017-05-11 16:35:59.804537','6','SDF  4QX3 QA',2,'[{\"changed\": {\"fields\": [\"global_working_percentage\", \"last_month_working_percentage\"]}}]',8,1),(36,'2017-05-11 16:36:04.669496','5','sf dSF 3QFQCF',2,'[{\"changed\": {\"fields\": [\"global_working_percentage\", \"last_month_working_percentage\"]}}]',8,1),(37,'2017-05-11 16:36:11.398771','4','sdf sdf3 sr fd fdd',2,'[{\"changed\": {\"fields\": [\"global_working_percentage\", \"last_month_working_percentage\"]}}]',8,1),(38,'2017-05-11 16:36:17.604100','2','hsfghfgs b 54 yhfg hf hsf hsfvs v',2,'[{\"changed\": {\"fields\": [\"global_working_percentage\", \"last_month_working_percentage\"]}}]',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE ucs2_polish_ci NOT NULL,
  `model` varchar(100) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'my_app','batch'),(8,'my_app','button'),(9,'my_app','page'),(10,'my_app','page_connection'),(11,'my_app','page_host'),(12,'my_app','page_test'),(13,'my_app','t_p_b'),(14,'my_app','test'),(15,'my_app','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE ucs2_polish_ci NOT NULL,
  `name` varchar(255) COLLATE ucs2_polish_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-05-03 16:25:18.926692'),(2,'auth','0001_initial','2017-05-03 16:25:29.539106'),(3,'admin','0001_initial','2017-05-03 16:25:31.645744'),(4,'admin','0002_logentry_remove_auto_add','2017-05-03 16:25:31.728780'),(5,'contenttypes','0002_remove_content_type_name','2017-05-03 16:25:33.173454'),(6,'auth','0002_alter_permission_name_max_length','2017-05-03 16:25:34.013782'),(7,'auth','0003_alter_user_email_max_length','2017-05-03 16:25:34.784516'),(8,'auth','0004_alter_user_username_opts','2017-05-03 16:25:34.833759'),(9,'auth','0005_alter_user_last_login_null','2017-05-03 16:25:35.721481'),(10,'auth','0006_require_contenttypes_0002','2017-05-03 16:25:35.765477'),(11,'auth','0007_alter_validators_add_error_messages','2017-05-03 16:25:35.826885'),(12,'auth','0008_alter_user_username_max_length','2017-05-03 16:25:36.799751'),(13,'my_app','0001_initial','2017-05-03 16:25:53.990064'),(14,'sessions','0001_initial','2017-05-03 16:25:54.685301'),(15,'my_app','0002_auto_20170504_1521','2017-05-04 13:21:40.589147'),(16,'my_app','0003_auto_20170504_1843','2017-05-04 16:43:19.266888'),(17,'my_app','0004_remove_page_test_with_pictures','2017-05-04 17:37:05.996936'),(18,'my_app','0005_page_weight_w_pictures','2017-05-05 10:37:06.042878'),(19,'my_app','0002_auto_20170507_1858','2017-05-07 16:58:14.771891'),(20,'my_app','0002_page_test_redirection','2017-05-07 17:02:37.937154'),(21,'my_app','0003_auto_20170511_1750','2017-05-11 15:50:36.992822'),(22,'my_app','0004_page_redirection_percentage','2017-05-11 16:05:35.922809'),(23,'my_app','0005_auto_20170513_1148','2017-05-13 09:48:31.954588'),(24,'my_app','0006_auto_20170513_1737','2017-05-13 15:38:09.497059'),(25,'my_app','0007_auto_20170513_1742','2017-05-13 15:42:10.262634'),(26,'my_app','0008_auto_20170513_1816','2017-05-13 16:16:54.953437'),(27,'my_app','0009_auto_20170515_1211','2017-05-15 10:11:53.367538'),(28,'my_app','0010_auto_20170516_1507','2017-05-16 13:07:24.351472');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE ucs2_polish_ci NOT NULL,
  `session_data` longtext COLLATE ucs2_polish_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('n1fawb1918yup105rq6yd0cmdb8hoqz2','NGVmMTljZjhlZDFkM2I2YTk5OWNmODg1MzIzMjEwY2Q1Yjc4MjMzZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYWY2M2Q0ZTVkODdlZmI3ZWJiZmU4NTBiN2UyMjU0MWY3ZjUyODliIn0=','2017-05-25 09:23:23.610031');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_hosts`
--

DROP TABLE IF EXISTS `page_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_hosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(2000) COLLATE ucs2_polish_ci NOT NULL,
  `ipv4` varchar(15) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_hosts`
--

LOCK TABLES `page_hosts` WRITE;
/*!40000 ALTER TABLE `page_hosts` DISABLE KEYS */;
INSERT INTO `page_hosts` VALUES (1,'dsfsd','234243'),(2,'32fsd','234');
/*!40000 ALTER TABLE `page_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(5000) COLLATE ucs2_polish_ci NOT NULL,
  `weight` int(11) DEFAULT NULL,
  `encoding` varchar(50) COLLATE ucs2_polish_ci NOT NULL,
  `cookies_present` tinyint(1) NOT NULL,
  `avg_download_time` decimal(12,2) DEFAULT NULL,
  `force_test` tinyint(1) NOT NULL,
  `host_id` int(11) DEFAULT NULL,
  `weight_w_pictures` int(11) DEFAULT NULL,
  `global_working_percentage` decimal(5,2) DEFAULT NULL,
  `last_month_working_percentage` decimal(5,2) DEFAULT NULL,
  `redirection_percentage` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Pages_host_id_699a9d8b_fk_Page_hosts_id` (`host_id`),
  CONSTRAINT `Pages_host_id_699a9d8b_fk_Page_hosts_id` FOREIGN KEY (`host_id`) REFERENCES `page_hosts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'rgdf1',32,'23',1,10925.05,0,1,NULL,3.00,100.00,19.50),(2,'rgdf',324,'2fds',1,32.00,1,1,NULL,NULL,100.00,NULL),(3,'fbcvb',32,'23',1,3.00,1,NULL,NULL,NULL,100.00,NULL),(4,'kllklll',NULL,'',0,0.00,1,NULL,NULL,NULL,100.00,NULL),(5,'rgdf1',32,'23',1,32.00,0,NULL,NULL,90.00,100.00,NULL),(6,'rgdf1',32,'23',1,32.00,0,NULL,NULL,90.00,100.00,NULL),(7,'rgdf1',32,'23',1,32.00,0,NULL,NULL,90.00,100.00,NULL),(8,'rgdf1',32,'23',1,32.00,0,NULL,NULL,90.00,100.00,NULL),(9,'rgdf1',32,'23',1,32.00,0,NULL,NULL,90.00,100.00,NULL),(10,'rgdf1',32,'23',1,32.00,0,NULL,NULL,90.00,100.00,NULL),(11,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(12,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(13,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(14,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(15,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(16,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(17,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(18,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(19,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(20,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(21,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(22,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(23,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(24,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(25,'rgdf1',32,'23',1,32.00,0,1,NULL,90.00,100.00,NULL),(26,'rgdf12',32,'23',1,32.00,0,1,333,90.00,100.00,NULL),(27,'rgdf133',32,'23',1,32.00,0,1,NULL,NULL,100.00,NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages_connections`
--

DROP TABLE IF EXISTS `pages_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages_connections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_1_id` int(11) NOT NULL,
  `page_2_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Pages_Connections_page_1_id_1f27c1ff_fk_Pages_id` (`page_1_id`),
  KEY `Pages_Connections_page_2_id_209b5a75_fk_Pages_id` (`page_2_id`),
  CONSTRAINT `Pages_Connections_page_1_id_1f27c1ff_fk_Pages_id` FOREIGN KEY (`page_1_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Pages_Connections_page_2_id_209b5a75_fk_Pages_id` FOREIGN KEY (`page_2_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_connections`
--

LOCK TABLES `pages_connections` WRITE;
/*!40000 ALTER TABLE `pages_connections` DISABLE KEYS */;
INSERT INTO `pages_connections` VALUES (1,2,1),(2,3,4),(3,3,1),(4,19,4),(5,19,1),(6,20,4),(7,20,1),(8,21,4),(9,21,1),(10,22,4),(11,22,1),(12,23,4),(13,23,1),(14,24,4),(15,24,1),(16,25,4),(17,25,1),(18,1,4),(19,1,1),(20,1,4),(21,1,1),(22,1,4),(23,1,1),(24,26,4),(25,26,1),(26,26,4),(27,26,1),(28,1,4),(29,1,1),(30,1,4),(31,1,1),(32,1,4),(33,1,1),(34,1,4),(35,1,1),(36,1,4),(37,1,1),(38,27,4),(39,27,1),(40,1,4),(41,1,1),(42,1,4),(43,1,1),(44,1,4),(45,1,1),(46,1,4),(47,1,1),(48,1,4),(49,1,1),(50,1,4),(51,1,1),(52,1,4),(53,1,1),(54,1,4),(55,1,1),(56,1,4),(57,1,1),(58,1,4),(59,1,1),(60,1,4),(61,1,1),(62,1,4),(63,1,1),(64,1,4),(65,1,1),(66,1,4),(67,1,1),(68,1,4),(69,1,1),(70,1,4),(71,1,1),(72,1,4),(73,1,1),(74,1,4),(75,1,1),(76,1,4),(77,1,1),(78,1,4),(79,1,1),(80,1,4),(81,1,1),(82,1,4),(83,1,1),(84,1,4),(85,1,1),(86,1,4),(87,1,1),(88,1,4),(89,1,1),(90,1,4),(91,1,1),(92,1,4),(93,1,1),(94,1,4),(95,1,1);
/*!40000 ALTER TABLE `pages_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages_tests`
--

DROP TABLE IF EXISTS `pages_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_working` tinyint(1) NOT NULL,
  `response_code` int(11) NOT NULL,
  `download_time` int(11) NOT NULL,
  `page_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `redirection_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Pages_Tests_redirection_id_7154725c_fk_Pages_id` (`redirection_id`),
  KEY `Pages_Tests_page_id_4c99f000_fk_Pages_id` (`page_id`),
  KEY `Pages_Tests_test_id_b069bc9c_fk_Tests_id` (`test_id`),
  CONSTRAINT `Pages_Tests_page_id_4c99f000_fk_Pages_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Pages_Tests_redirection_id_7154725c_fk_Pages_id` FOREIGN KEY (`redirection_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Pages_Tests_test_id_b069bc9c_fk_Tests_id` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_tests`
--

LOCK TABLES `pages_tests` WRITE;
/*!40000 ALTER TABLE `pages_tests` DISABLE KEYS */;
INSERT INTO `pages_tests` VALUES (1,1,12,11212,1,1,NULL),(2,1,333,3,3,1,NULL),(3,1,2,21,1,1,2),(4,1,12,11212,NULL,12,NULL),(5,1,12,11212,NULL,13,NULL),(6,1,12,11212,NULL,14,NULL),(7,1,12,11212,NULL,15,NULL),(8,1,12,11212,NULL,16,NULL),(9,1,12,11212,NULL,17,NULL),(10,1,12,11212,NULL,NULL,NULL),(11,1,12,11212,NULL,19,NULL),(12,1,12,11212,NULL,20,NULL),(13,1,12,11212,NULL,21,NULL),(14,1,12,11212,NULL,22,NULL),(15,1,12,11212,NULL,23,NULL),(16,1,12,11212,NULL,24,NULL),(17,1,12,11212,NULL,25,NULL),(18,1,12,11212,NULL,26,NULL),(19,1,12,11212,NULL,27,NULL),(20,1,12,11212,NULL,28,NULL),(21,1,12,11212,NULL,29,NULL),(22,1,12,11212,NULL,30,NULL),(23,1,12,11212,12,31,NULL),(24,1,12,11212,14,33,NULL),(25,1,12,11212,19,38,NULL),(26,1,12,11212,20,39,NULL),(27,1,12,11212,23,42,NULL),(28,1,12,11212,24,43,NULL),(29,1,12,11212,25,44,NULL),(30,1,12,11212,1,46,NULL),(31,1,12,11212,1,47,NULL),(32,1,12,11212,1,48,NULL),(33,1,12,11212,26,49,NULL),(34,1,12,11212,26,50,NULL),(35,1,12,11212,1,51,NULL),(36,1,12,11212,1,52,NULL),(37,1,12,11212,1,53,NULL),(38,1,12,11212,1,54,NULL),(39,1,12,11212,1,55,NULL),(40,1,12,11212,27,56,NULL),(41,1,12,11212,1,62,NULL),(42,1,12,11212,1,63,NULL),(43,1,12,11212,1,64,NULL),(44,1,12,11212,1,65,NULL),(45,1,12,11212,1,66,NULL),(46,1,12,11212,1,67,NULL),(47,1,12,11212,1,68,NULL),(48,1,12,11212,1,69,NULL),(49,1,12,11212,1,70,NULL),(50,1,12,11212,1,71,NULL),(51,1,12,11212,1,72,NULL),(52,1,12,11212,1,73,NULL),(53,1,12,11212,1,74,NULL),(54,1,12,11212,1,75,NULL),(55,1,12,11212,1,76,NULL),(56,1,12,11212,1,77,NULL),(57,1,12,11212,1,78,NULL),(58,1,12,11212,1,79,NULL),(59,1,12,11212,1,80,NULL),(60,1,12,11212,1,81,NULL),(61,1,12,11212,1,82,NULL),(62,1,12,11212,1,83,NULL),(63,1,12,11212,1,84,NULL),(64,1,12,11212,1,85,NULL),(65,1,12,11212,1,86,NULL),(66,1,12,11212,1,87,NULL),(67,1,12,11212,1,88,NULL),(68,1,12,11212,1,89,NULL),(69,1,12,11212,1,90,1);
/*!40000 ALTER TABLE `pages_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_p_b`
--

DROP TABLE IF EXISTS `t_p_b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_p_b` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_working` tinyint(1) NOT NULL,
  `button_id` int(11) DEFAULT NULL,
  `page_test_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `T_P_B_button_id_ea72bee1_fk_Buttons_id` (`button_id`),
  KEY `T_P_B_page_test_id_bd677bf9_fk_Pages_Tests_id` (`page_test_id`),
  CONSTRAINT `T_P_B_button_id_ea72bee1_fk_Buttons_id` FOREIGN KEY (`button_id`) REFERENCES `buttons` (`id`),
  CONSTRAINT `T_P_B_page_test_id_bd677bf9_fk_Pages_Tests_id` FOREIGN KEY (`page_test_id`) REFERENCES `pages_tests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_p_b`
--

LOCK TABLES `t_p_b` WRITE;
/*!40000 ALTER TABLE `t_p_b` DISABLE KEYS */;
INSERT INTO `t_p_b` VALUES (1,1,1,1),(2,0,2,1),(3,0,2,2),(4,0,4,1),(5,1,13,28),(6,0,14,28),(7,0,14,28),(8,1,16,29),(9,0,17,29),(10,0,17,29),(11,1,1,30),(12,0,2,30),(13,0,2,30),(14,1,1,31),(15,0,2,31),(16,0,2,31),(17,1,1,32),(18,0,2,32),(19,0,2,32),(20,1,19,33),(21,0,20,33),(22,0,20,33),(23,1,19,34),(24,0,20,34),(25,0,20,34),(26,1,1,35),(27,0,2,35),(28,0,2,35),(29,1,1,36),(30,0,2,36),(31,0,2,36),(32,1,1,37),(33,0,2,37),(34,0,2,37),(35,1,1,38),(36,0,2,38),(37,0,2,38),(38,1,1,39),(39,0,2,39),(40,0,2,39),(41,1,22,40),(42,0,23,40),(43,0,23,40),(44,1,1,41),(45,0,2,41),(46,0,2,41),(47,1,1,42),(48,1,1,43),(49,0,2,43),(50,0,2,43),(51,1,1,44),(52,0,2,44),(53,0,2,44),(54,1,1,45),(55,0,2,45),(56,0,2,45),(57,1,1,46),(58,1,2,46),(59,1,2,46),(60,1,1,47),(61,0,2,47),(62,0,2,47),(63,1,1,48),(64,0,2,48),(65,0,2,48),(66,1,1,49),(67,0,2,49),(68,0,2,49),(69,1,1,50),(70,0,2,50),(71,0,2,50),(72,1,1,51),(73,0,2,51),(74,0,2,51),(75,1,1,52),(76,0,2,52),(77,0,2,52),(78,1,1,53),(79,0,2,53),(80,0,2,53),(81,1,1,54),(82,0,2,54),(83,0,2,54),(84,1,1,55),(85,0,2,55),(86,0,2,55),(87,1,1,56),(88,0,2,56),(89,0,2,56),(90,1,1,58),(91,0,2,58),(92,0,2,58),(93,1,1,59),(94,0,2,59),(95,0,2,59),(96,1,1,60),(97,0,2,60),(98,0,2,60),(99,1,1,61),(100,0,2,61),(101,0,2,61),(102,1,1,62),(103,0,2,62),(104,0,2,62),(105,1,1,63),(106,0,2,63),(107,0,2,63),(108,1,1,64),(109,0,2,64),(110,0,2,64),(111,1,1,65),(112,0,2,65),(113,0,2,65),(114,1,1,66),(115,0,2,66),(116,0,2,66),(117,1,1,67),(118,0,2,67),(119,0,2,67),(120,1,1,68),(121,0,2,68),(122,0,2,68),(123,1,1,69),(124,0,2,69),(125,0,2,69);
/*!40000 ALTER TABLE `t_p_b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime(6) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Tests_user_id_b37cc89f_fk_Users_id` (`user_id`),
  CONSTRAINT `Tests_user_id_b37cc89f_fk_Users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (1,'2017-05-04 12:44:34.000000',1),(2,'2017-05-04 12:44:42.000000',2),(3,'2017-05-04 12:44:48.000000',1),(4,'2017-05-04 12:44:56.000000',2),(5,'2017-05-04 12:44:34.000000',1),(6,'2017-05-04 12:44:34.000000',1),(7,'2017-05-04 12:44:34.000000',1),(8,'2017-05-04 12:44:34.000000',1),(9,'2017-05-04 12:44:34.000000',1),(10,'2017-05-04 12:44:34.000000',1),(11,'2017-05-04 12:44:34.000000',1),(12,'2017-05-04 12:44:34.000000',1),(13,'2017-05-04 12:44:34.000000',1),(14,'2017-05-04 12:44:34.000000',1),(15,'2017-05-04 12:44:34.000000',1),(16,'2017-05-04 12:44:34.000000',1),(17,'2017-05-04 12:44:34.000000',1),(18,'2017-05-04 12:44:34.000000',1),(19,'2017-05-04 12:44:34.000000',1),(20,'2017-05-04 12:44:34.000000',1),(21,'2017-05-04 12:44:34.000000',1),(22,'2012-05-04 12:44:34.000000',1),(23,'2017-05-04 12:44:34.000000',1),(24,'2017-05-04 12:44:34.000000',1),(25,'2013-05-04 12:44:34.000000',1),(26,'2011-05-04 12:44:34.000000',1),(27,'2017-05-04 12:44:34.000000',1),(28,'2017-05-04 12:44:34.000000',1),(29,'2017-05-04 12:44:34.000000',1),(30,'2017-05-04 12:44:34.000000',1),(31,'2017-05-04 12:44:34.000000',1),(32,'2017-05-04 12:44:34.000000',1),(33,'2017-05-04 12:44:34.000000',1),(34,'2017-05-04 12:44:34.000000',1),(35,'2017-05-04 12:44:34.000000',1),(36,'2017-05-04 12:44:34.000000',1),(37,'2017-05-04 12:44:34.000000',1),(38,'2017-05-04 12:44:34.000000',1),(39,'2017-05-04 12:44:34.000000',1),(40,'2017-05-04 12:44:34.000000',1),(41,'2017-05-04 12:44:34.000000',1),(42,'2017-05-04 12:44:34.000000',1),(43,'2017-05-04 12:44:34.000000',1),(44,'2017-05-04 12:44:34.000000',1),(45,'2017-05-04 12:44:34.000000',1),(46,'2017-05-04 12:44:34.000000',1),(47,'2017-05-04 12:44:34.000000',1),(48,'2017-05-04 12:44:34.000000',1),(49,'2017-05-04 12:44:34.000000',1),(50,'2017-05-04 12:44:34.000000',1),(51,'2017-05-04 12:44:34.000000',1),(52,'2017-05-04 12:44:34.000000',1),(53,'2017-05-04 12:44:34.000000',1),(54,'2017-05-04 12:44:34.000000',1),(55,'2017-05-04 12:44:34.000000',1),(56,'2017-05-04 12:44:34.000000',1),(57,'2017-05-04 12:44:34.000000',1),(58,'2017-05-04 12:44:34.000000',1),(59,'2017-05-04 12:44:34.000000',1),(60,'2017-05-04 12:44:34.000000',1),(61,'2017-05-04 12:44:34.000000',1),(62,'2017-05-04 12:44:34.000000',1),(63,'2017-05-04 12:44:34.000000',1),(64,'2017-05-04 12:44:34.000000',1),(65,'2017-05-04 12:44:34.000000',1),(66,'2017-05-04 12:44:34.000000',1),(67,'2017-05-04 12:44:34.000000',1),(68,'2017-05-04 12:44:34.000000',1),(69,'2017-05-04 12:44:34.000000',1),(70,'2017-05-04 12:44:34.000000',1),(71,'2017-05-04 12:44:34.000000',1),(72,'2017-05-04 12:44:34.000000',1),(73,'2017-05-04 12:44:34.000000',1),(74,'2017-05-04 12:44:34.000000',1),(75,'2017-05-04 12:44:34.000000',1),(76,'2017-05-04 12:44:34.000000',1),(77,'2017-05-04 12:44:34.000000',1),(78,'2017-05-04 12:44:34.000000',1),(79,'2017-05-04 12:44:34.000000',1),(80,'2017-05-04 12:44:34.000000',1),(81,'2017-05-04 12:44:34.000000',1),(82,'2017-05-04 12:44:34.000000',1),(83,'2017-05-04 12:44:34.000000',1),(84,'2017-05-04 12:44:34.000000',1),(85,'2017-05-04 12:44:34.000000',1),(86,'2017-05-04 12:44:34.000000',1),(87,'2017-05-04 12:44:34.000000',1),(88,'2017-05-04 12:44:34.000000',1),(89,'2017-05-04 12:44:34.000000',1),(90,'2017-05-04 12:44:34.000000',1);
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipv4` varchar(15) COLLATE ucs2_polish_ci DEFAULT NULL,
  `transfer_speed` decimal(7,2) NOT NULL,
  `mac_address` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'12e',12.00,'edasdsad'),(2,'12ed',21.00,'dfsvf');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'http_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `lm_w_percentage` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `lm_w_percentage` ON SCHEDULE EVERY 1 DAY STARTS '2017-05-17 07:32:15' ON COMPLETION PRESERVE ENABLE DO Begin
	DECLARE finished INTEGER DEFAULT 0;
    declare total_pt integer;
	declare working integer;
    
	declare tmp decimal(5,2);
	declare ids integer;
	declare cur1 cursor for select p.id from pages p;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	
    open cur1;
	read_loop: LOOP
	fetch cur1 into ids;
	 IF finished=1 THEN
		  LEAVE read_loop;
	 END IF;
     
	select count(pt.id) into total_pt from pages_tests pt 
	join pages p on p.id=pt.page_id
    join tests t on t.id=pt.test_id
    where t.date>=(CURDATE() - INTERVAL 30 DAY) and p.id=ids;
    
	select count(pt.is_working) into working from pages_tests pt 
	join pages p on p.id=pt.page_id 
    join tests t on t.id=pt.test_id
    where (pt.is_working=1 or pt.is_working=1) and (t.date>=CURDATE() - INTERVAL 30 DAY) and p.id=ids;
    
	if total_pt>0 then
		set tmp=working/total_pt*100.0;
        update pages set last_month_working_percentage=tmp where id=ids;
	END IF;
	END LOOP;
    close cur1;
end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `lm_w_percentage_b` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `lm_w_percentage_b` ON SCHEDULE EVERY 1 DAY STARTS '2017-05-17 07:32:31' ON COMPLETION PRESERVE ENABLE DO Begin
	DECLARE finished INTEGER DEFAULT 0;
    declare total_b integer;
	declare working_b integer;
    
	declare tmp decimal(5,2);
	declare ids integer;
	declare cur1 cursor for select b.id from buttons b;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	open cur1;
	read_loop: LOOP
	fetch cur1 into ids;
	 IF finished=1 THEN
		  LEAVE read_loop;
	 END IF;
     
     
	select count(b.id) into total_b from buttons b 
    join t_p_b on t_p_b.button_id=b.id
    join pages_tests pt on pt.id=t_p_b.page_test_id
    join tests t on t.id=pt.test_id
    where t.date>=(CURDATE() - INTERVAL 30 DAY ) and b.id=ids;
    
	select count(t_p_b.is_working) into working_b from buttons b 
    join t_p_b on t_p_b.button_id=b.id
    join pages_tests pt on pt.id=t_p_b.page_test_id
    join tests t on t.id=pt.test_id
    where (t_p_b.is_working=1 or t_p_b.is_working=True) and (t.date>=CURDATE() - INTERVAL 30 DAY) and b.id=ids;
    
	if total_b>0 then
		set tmp=working_b/total_b*100.0;
        update buttons set last_month_working_percentage=tmp where id=ids;
	END IF;
	END LOOP;
    close cur1;
end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'http_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-17  7:39:44
