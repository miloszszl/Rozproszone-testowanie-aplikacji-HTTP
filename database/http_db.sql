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
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$2S31CQuHlsH0$8etrJdQ0UGHJcwhDyTgys2yKLamgpehBZl9HXDYmLz0=','2017-05-07 17:29:04.992399',1,'milosz','','','miloszszl@interia.pl',1,1,'2017-05-03 16:28:02.980759');
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
  `page_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Batch_test_id_6f58cb58_fk_Tests_id` (`test_id`),
  KEY `Batch_page_id_f61792ce_fk_Pages_id` (`page_id`),
  CONSTRAINT `Batch_page_id_f61792ce_fk_Pages_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Batch_test_id_6f58cb58_fk_Tests_id` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES (1,3,1,1),(2,2,3,2),(3,3,1,1),(4,5,3,4);
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
  `page_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Buttons_page_id_d863ccc4_fk_Pages_id` (`page_id`),
  CONSTRAINT `Buttons_page_id_d863ccc4_fk_Pages_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buttons`
--

LOCK TABLES `buttons` WRITE;
/*!40000 ALTER TABLE `buttons` DISABLE KEYS */;
INSERT INTO `buttons` VALUES (1,'6456y5fgsh sgfh gfh fgsh fsgh shg',1),(2,'hsfghfgs b 54 yhfg hf hsf hsfvs v',1),(3,'gf 54w gehbh avfew ttdhagrzz',1),(4,'sdf sdf3 sr fd fdd',2),(5,'sf dSF 3QFQCF',2),(6,'SDF  4QX3 QA',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-05-03 16:30:39.721377','1','a',1,'[{\"added\": {}}]',11,1),(2,'2017-05-03 16:30:46.918109','2','a',1,'[{\"added\": {}}]',11,1),(3,'2017-05-03 16:31:05.141415','1','Page object',1,'[{\"added\": {}}]',9,1),(4,'2017-05-04 12:44:23.563437','1','edasdsad : 12e',1,'[{\"added\": {}}]',15,1),(5,'2017-05-04 12:44:29.094907','2','dfsvf : 12ed',1,'[{\"added\": {}}]',15,1),(6,'2017-05-04 12:44:39.325409','1','2017-05-04 14:44:34+02:00',1,'[{\"added\": {}}]',14,1),(7,'2017-05-04 12:44:46.282738','2','2017-05-04 14:44:42+02:00',1,'[{\"added\": {}}]',14,1),(8,'2017-05-04 12:44:51.430889','3','2017-05-04 14:44:48+02:00',1,'[{\"added\": {}}]',14,1),(9,'2017-05-04 12:44:58.665882','4','2017-05-04 14:44:56+02:00',1,'[{\"added\": {}}]',14,1),(10,'2017-05-04 13:07:20.640844','2','Page object',1,'[{\"added\": {}}]',9,1),(11,'2017-05-04 13:07:30.606606','3','Page object',1,'[{\"added\": {}}]',9,1),(12,'2017-05-04 13:08:18.543743','1','Batch object',1,'[{\"added\": {}}]',7,1),(13,'2017-05-04 13:08:28.934979','2','Batch object',1,'[{\"added\": {}}]',7,1),(14,'2017-05-04 13:08:35.564085','3','Batch object',1,'[{\"added\": {}}]',7,1),(15,'2017-05-04 13:08:44.093903','4','Batch object',1,'[{\"added\": {}}]',7,1),(16,'2017-05-04 14:45:51.942417','1','Page_Test object',1,'[{\"added\": {}}]',12,1),(17,'2017-05-04 14:46:02.634443','2','Page_Test object',1,'[{\"added\": {}}]',12,1),(18,'2017-05-04 15:25:08.270087','1','6456y5fgsh sgfh gfh fgsh fsgh shg',1,'[{\"added\": {}}]',8,1),(19,'2017-05-04 15:25:17.128206','2','hsfghfgs b 54 yhfg hf hsf hsfvs v',1,'[{\"added\": {}}]',8,1),(20,'2017-05-04 15:25:23.689012','3','gf 54w gehbh avfew ttdhagrzz',1,'[{\"added\": {}}]',8,1),(21,'2017-05-04 15:25:30.276760','4','sdf sdf3 sr fd fdd',1,'[{\"added\": {}}]',8,1),(22,'2017-05-04 15:25:35.206403','5','sf dSF 3QFQCF',1,'[{\"added\": {}}]',8,1),(23,'2017-05-04 15:25:41.253353','6','SDF  4QX3 QA',1,'[{\"added\": {}}]',8,1),(24,'2017-05-04 16:15:40.643944','1','T_P_B object',1,'[{\"added\": {}}]',13,1),(25,'2017-05-04 16:15:46.471697','2','T_P_B object',1,'[{\"added\": {}}]',13,1),(26,'2017-05-04 16:15:52.062238','3','T_P_B object',1,'[{\"added\": {}}]',13,1),(27,'2017-05-04 16:16:01.564866','4','T_P_B object',1,'[{\"added\": {}}]',13,1),(28,'2017-05-07 17:16:10.943425','3','Page_Test object',1,'[{\"added\": {}}]',12,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-05-03 16:25:18.926692'),(2,'auth','0001_initial','2017-05-03 16:25:29.539106'),(3,'admin','0001_initial','2017-05-03 16:25:31.645744'),(4,'admin','0002_logentry_remove_auto_add','2017-05-03 16:25:31.728780'),(5,'contenttypes','0002_remove_content_type_name','2017-05-03 16:25:33.173454'),(6,'auth','0002_alter_permission_name_max_length','2017-05-03 16:25:34.013782'),(7,'auth','0003_alter_user_email_max_length','2017-05-03 16:25:34.784516'),(8,'auth','0004_alter_user_username_opts','2017-05-03 16:25:34.833759'),(9,'auth','0005_alter_user_last_login_null','2017-05-03 16:25:35.721481'),(10,'auth','0006_require_contenttypes_0002','2017-05-03 16:25:35.765477'),(11,'auth','0007_alter_validators_add_error_messages','2017-05-03 16:25:35.826885'),(12,'auth','0008_alter_user_username_max_length','2017-05-03 16:25:36.799751'),(13,'my_app','0001_initial','2017-05-03 16:25:53.990064'),(14,'sessions','0001_initial','2017-05-03 16:25:54.685301'),(15,'my_app','0002_auto_20170504_1521','2017-05-04 13:21:40.589147'),(16,'my_app','0003_auto_20170504_1843','2017-05-04 16:43:19.266888'),(17,'my_app','0004_remove_page_test_with_pictures','2017-05-04 17:37:05.996936'),(18,'my_app','0005_page_weight_w_pictures','2017-05-05 10:37:06.042878'),(19,'my_app','0002_auto_20170507_1858','2017-05-07 16:58:14.771891'),(20,'my_app','0002_page_test_redirection','2017-05-07 17:02:37.937154');
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
INSERT INTO `django_session` VALUES ('7t42n3re0axrs7sqbnootl7b3yz67cro','NGVmMTljZjhlZDFkM2I2YTk5OWNmODg1MzIzMjEwY2Q1Yjc4MjMzZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYWY2M2Q0ZTVkODdlZmI3ZWJiZmU4NTBiN2UyMjU0MWY3ZjUyODliIn0=','2017-05-21 17:29:05.104692');
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
  `avg_download_time` int(11) NOT NULL,
  `force_test` tinyint(1) NOT NULL,
  `host_id` int(11) DEFAULT NULL,
  `weight_w_pictures` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Pages_host_id_699a9d8b_fk_Page_hosts_id` (`host_id`),
  CONSTRAINT `Pages_host_id_699a9d8b_fk_Page_hosts_id` FOREIGN KEY (`host_id`) REFERENCES `page_hosts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'rgdf',32,'23',1,32,0,1,NULL),(2,'rgdf',324,'2fds',1,32,1,1,NULL),(3,'fbcvb',32,'23',1,3,1,NULL,NULL),(4,'kllklll',NULL,'',0,0,1,NULL,NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_connections`
--

LOCK TABLES `pages_connections` WRITE;
/*!40000 ALTER TABLE `pages_connections` DISABLE KEYS */;
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
  `page_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `redirection_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Pages_Tests_page_id_4c99f000_fk_Pages_id` (`page_id`),
  KEY `Pages_Tests_test_id_b069bc9c_fk_Tests_id` (`test_id`),
  KEY `Pages_Tests_redirection_id_7154725c_fk_Pages_id` (`redirection_id`),
  CONSTRAINT `Pages_Tests_page_id_4c99f000_fk_Pages_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Pages_Tests_redirection_id_7154725c_fk_Pages_id` FOREIGN KEY (`redirection_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `Pages_Tests_test_id_b069bc9c_fk_Tests_id` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_tests`
--

LOCK TABLES `pages_tests` WRITE;
/*!40000 ALTER TABLE `pages_tests` DISABLE KEYS */;
INSERT INTO `pages_tests` VALUES (1,1,12,11212,1,1,NULL),(2,1,333,3,3,1,NULL),(3,1,2,21,1,1,2);
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
  `button_id` int(11) NOT NULL,
  `page_test_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `T_P_B_button_id_ea72bee1_fk_Buttons_id` (`button_id`),
  KEY `T_P_B_page_test_id_bd677bf9_fk_Pages_Tests_id` (`page_test_id`),
  CONSTRAINT `T_P_B_button_id_ea72bee1_fk_Buttons_id` FOREIGN KEY (`button_id`) REFERENCES `buttons` (`id`),
  CONSTRAINT `T_P_B_page_test_id_bd677bf9_fk_Pages_Tests_id` FOREIGN KEY (`page_test_id`) REFERENCES `pages_tests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_p_b`
--

LOCK TABLES `t_p_b` WRITE;
/*!40000 ALTER TABLE `t_p_b` DISABLE KEYS */;
INSERT INTO `t_p_b` VALUES (1,1,1,1),(2,0,2,1),(3,0,2,2),(4,0,4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (1,'2017-05-04 12:44:34.000000',1),(2,'2017-05-04 12:44:42.000000',2),(3,'2017-05-04 12:44:48.000000',1),(4,'2017-05-04 12:44:56.000000',2);
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
  `ipv4` varchar(15) COLLATE ucs2_polish_ci NOT NULL,
  `transfer_speed` decimal(7,2) NOT NULL,
  `mac_address` varchar(16) COLLATE ucs2_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=ucs2 COLLATE=ucs2_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'12e',12.00,'edasdsad'),(2,'12ed',21.00,'dfsvf');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-09 18:28:57
