-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: http_testing
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
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `id_options` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`id_options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `p_t_options`
--

DROP TABLE IF EXISTS `p_t_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `p_t_options` (
  `id_pages_tests` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_options` int(10) unsigned NOT NULL,
  `value` varchar(45) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`id_pages_tests`,`id_options`),
  UNIQUE KEY `id_options_UNIQUE` (`id_options`),
  UNIQUE KEY `id_p_t_options_UNIQUE` (`id_pages_tests`),
  CONSTRAINT `id_options` FOREIGN KEY (`id_options`) REFERENCES `options` (`id_options`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_pages_tests` FOREIGN KEY (`id_pages_tests`) REFERENCES `pages_tests` (`id_pages_tests`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `p_t_options`
--

LOCK TABLES `p_t_options` WRITE;
/*!40000 ALTER TABLE `p_t_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `p_t_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id_pages` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(2048) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id_pages`),
  UNIQUE KEY `id_pages_UNIQUE` (`id_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages_tests`
--

DROP TABLE IF EXISTS `pages_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages_tests` (
  `id_pages_tests` int(10) unsigned NOT NULL,
  `id_tests` int(10) unsigned NOT NULL,
  `id_pages` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pages_tests`),
  UNIQUE KEY `pages_tests_UNIQUE` (`id_pages_tests`),
  UNIQUE KEY `id_pages_UNIQUE` (`id_pages`),
  UNIQUE KEY `id_tests_UNIQUE` (`id_tests`),
  CONSTRAINT `id_pages` FOREIGN KEY (`id_pages`) REFERENCES `pages` (`id_pages`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_tests` FOREIGN KEY (`id_tests`) REFERENCES `tests` (`id_tests`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages_tests`
--

LOCK TABLES `pages_tests` WRITE;
/*!40000 ALTER TABLE `pages_tests` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `id_servers` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IPv4` varchar(15) COLLATE utf8_polish_ci DEFAULT NULL,
  `id_pages` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_servers`),
  UNIQUE KEY `id_servers_UNIQUE` (`id_servers`),
  UNIQUE KEY `id_pages_UNIQUE` (`id_pages`),
  KEY `id_pages_idx` (`id_pages`),
  CONSTRAINT `id_pages_` FOREIGN KEY (`id_pages`) REFERENCES `pages` (`id_pages`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id_tests` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_users` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `leves` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_tests`),
  UNIQUE KEY `id_user_UNIQUE` (`id_users`),
  UNIQUE KEY `id_tests_UNIQUE` (`id_tests`),
  CONSTRAINT `id_user` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_users` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IPv4` varchar(15) CHARACTER SET utf8 NOT NULL,
  `transfer_speed` decimal(5,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_users`),
  UNIQUE KEY `id_users_UNIQUE` (`id_users`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2017-03-29 18:04:46
