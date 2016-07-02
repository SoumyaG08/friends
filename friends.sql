CREATE DATABASE  IF NOT EXISTS `friends_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `friends_db`;
-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: friends_db
-- ------------------------------------------------------
-- Server version	5.5.42

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
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_table1_users_idx` (`user_id`),
  KEY `fk_table1_users1_idx` (`friend_id`),
  CONSTRAINT `fk_table1_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_users1` FOREIGN KEY (`friend_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (1,3,1),(11,5,1),(12,1,3),(14,1,5),(15,1,6),(16,6,1),(17,2,1),(18,1,2),(19,2,6),(20,6,2),(21,2,7),(22,7,2),(23,8,1),(24,1,8),(25,8,5),(26,5,8),(29,8,4),(30,4,8);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pw_hash` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Soumya','Sam','soumyanatural@gmail.com','$2b$12$mQYYw22.bm.hGiX5/B539Oyyf08xiV5QGfdcouNTHZdDH37Uvht0O','2016-07-01 16:00:25','1986-07-08 00:00:00'),(2,'Praful K','Praf','prafk@yahoo.com','$2b$12$ULzeLFJrUQ/r29z4jFg0V.c7hzIhY/Xi29/Fq/3VtSWDXb5N6SgpG','2016-07-01 16:08:10','1979-04-27 00:00:00'),(3,'Jon Snow','Jon','jsnow@winterfell.com','$2b$12$/dy4orL71ms9wOFgcX1EH.z1oeIdlMx2I6xH6wNgGQALf.hwARe/m','2016-07-01 16:12:59','1990-12-25 00:00:00'),(4,'Ned Stark','Neddy','nstark@winterfell.com','$2b$12$I/AlekD8dLjyNMVcLFpGJu/nKWLcRnWljGsgSGf.DAqdUDRRwH9p6','2016-07-01 16:50:44','1970-09-12 00:00:00'),(5,'Andrew Johnson','Andy','ajohnson@gmail.com','$2b$12$18JwuYBraOTAj19V7mGL0ucS.m0uK.qHklCgPe/f.K5Vfuffv4XlC','2016-07-01 16:51:32','1987-06-15 00:00:00'),(6,'Hodor Hodor','Hodor','hodor@holdthedoor.com','$2b$12$dYpUi/PylGaHb/HXSl37nO666Rwhst90f/L3REKoWm2lRQX2ZgQFy','2016-07-01 16:52:07','1980-11-29 00:00:00'),(7,'Harry Potter','Harry','hpotter@hogwarts.edu','$2b$12$E8CsCglKoAoWcPVXOTKKu.tSwbPnknQ4uL.wEONMZKM22mInuAiRq','2016-07-01 16:54:27','1996-07-04 00:00:00'),(8,'Peter Griffin','Pete','pgriffin@fg.com','$2b$12$/DqfTWr.X8Gly.3kiJcrZOL.RX1oVdXy.VUrT73PDQgO.vTDNxey.','2016-07-01 18:38:15','1976-09-18 00:00:00');
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

-- Dump completed on 2016-07-01 18:39:45
