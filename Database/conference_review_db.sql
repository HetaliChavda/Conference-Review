-- MySQL dump 10.13  Distrib 8.0.16, for macos10.14 (x86_64)
--
-- Host: localhost    Database: conference_review
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `conference_review`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `conference_review` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `conference_review`;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email_address` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-Inactive, 1-Active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES 
(1,'Sandy','Lennon','sandy_lennon@gmail.com',1,'2020-04-08 21:28:05','2020-04-08 21:28:05',NULL),
(2,'Charlie','River','charlie_river@gmail.com',1,'2020-04-08 21:28:05','2020-04-08 21:28:05',NULL),
(3,'Dan','Brown','dan_brown@gmail.com',1,'2020-04-08 21:28:05','2020-04-08 21:28:05',NULL),
(4,'Harry','Potter','harry_potter@gmail.com',1,'2020-04-08 21:28:05','2020-04-08 21:28:05',NULL),
(5,'Chris','Gayle','chris_gayle@gmail.com',1,'2020-04-08 21:28:05','2020-04-08 21:28:05',NULL);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author_paper`
--

DROP TABLE IF EXISTS `author_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `author_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `paper_id` int(11) NOT NULL,
  `contact_author_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_AP_AUTHOR` (`author_id`),
  KEY `FK_AP_CONTACT_AUTHOR` (`contact_author_id`),
  KEY `FK_AP_PAPER` (`paper_id`),
  CONSTRAINT `FK_AP_AUTHOR` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `FK_AP_CONTACT_AUTHOR` FOREIGN KEY (`contact_author_id`) REFERENCES `author` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `FK_AP_PAPER` FOREIGN KEY (`paper_id`) REFERENCES `paper` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author_paper`
--

LOCK TABLES `author_paper` WRITE;
/*!40000 ALTER TABLE `author_paper` DISABLE KEYS */;
INSERT INTO `author_paper` VALUES 
(1,1,1,2,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL),
(2,2,1,2,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL),
(3,3,2,3,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL),
(4,4,2,3,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL),
(5,5,2,3,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL),
(6,3,3,3,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL),
(7,5,3,3,'2020-04-08 22:00:10','2020-04-08 22:00:10',NULL);
/*!40000 ALTER TABLE `author_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paper`
--

DROP TABLE IF EXISTS `paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `abstract` text COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-Inactive, 1-Active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paper`
--

LOCK TABLES `paper` WRITE;
/*!40000 ALTER TABLE `paper` DISABLE KEYS */;
INSERT INTO `paper` VALUES 
(1,'Clinical toxicology of newer recreational drugs','Novel synthetic ‘designer’ drugs with stimulant, ecstasy-like (entactogenic) and/or hallucinogenic properties have become increasingly popular among recreational drug users in recent years. The substances used change frequently in response to market trends and legislative controls and it is an important challenge for poisons centres and clinical toxicologists to remain updated on the pharmacological and toxicological effects of these emerging agents. Aims. To review the available information on newer synthetic stimulant, entactogenic and hallucinogenic drugs, provide a framework for classification of these drugs based on chemical structure and describe their pharmacology and clinical toxicology.','15563650.pdf',1,'2020-04-08 21:56:28','2020-04-08 21:56:28',NULL),
(2,'The artifical life roots of artificial intelligence','Behavior-oriented Artificial Intelligence (AI) is a scientific discipline that studies how behavior of agents emerges and becomes intelligent and adaptive. Success of the field is defined in terms of success in building physical agents that are capable of maximizing their own self-preservation in interaction with a dynamically changing environment. The paper addresses this Artificial Life route toward AI and reviews some of the results obtained so far.','199311275.pdf',1,'2020-04-08 21:56:28','2020-04-08 21:56:28',NULL),
(3,'Introduction to machine learning for brain imaging','Machine learning and pattern recognition algorithms have in the past years developed to become a working horse in brain imaging and the computational neurosciences, as they are instrumental for mining vast amounts of neural data of ever increasing measurement precision and detecting minuscule signals from an overwhelming noise floor. They provide the means to decode and characterize task relevant brain states and to distinguish them from non-informative brain signals. While undoubtedly this machinery has helped to gain novel biological insights, it also holds the danger of potential unintentional abuse. Ideally machine learning techniques should be usable for any non-expert, however, unfortunately they are typically not. Overfitting and other pitfalls may occur and lead to spurious and nonsensical interpretation. The goal of this review is therefore to provide an accessible and clear introduction to the strengths and also the inherent dangers of machine learning usage in the neurosciences.','201011004.pdf',1,'2020-04-08 21:56:28','2020-04-08 21:56:28',NULL);
/*!40000 ALTER TABLE `paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paper_reviewer`
--

DROP TABLE IF EXISTS `paper_reviewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `paper_reviewer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PR_PAPER` (`paper_id`),
  KEY `FK_PR_REVIEWER` (`reviewer_id`),
  CONSTRAINT `FK_PR_PAPER` FOREIGN KEY (`paper_id`) REFERENCES `paper` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `FK_PR_REVIEWER` FOREIGN KEY (`reviewer_id`) REFERENCES `reviewer` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paper_reviewer`
--

LOCK TABLES `paper_reviewer` WRITE;
/*!40000 ALTER TABLE `paper_reviewer` DISABLE KEYS */;
INSERT INTO `paper_reviewer` VALUES 
(1,1,1,'2020-04-08 22:02:58','2020-04-08 22:02:58',NULL),
(2,1,5,'2020-04-08 22:02:58','2020-04-08 22:02:58',NULL),
(3,2,2,'2020-04-08 22:02:58','2020-04-08 22:02:58',NULL),
(4,2,6,'2020-04-08 22:06:27','2020-04-08 22:06:27',NULL),
(5,3,2,'2020-04-08 22:07:10','2020-04-08 22:07:10',NULL),
(6,3,6,'2020-04-08 22:07:10','2020-04-08 22:07:10',NULL);
/*!40000 ALTER TABLE `paper_reviewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `recommendation` text COLLATE utf8_unicode_ci,
  `author_comments` text COLLATE utf8_unicode_ci,
  `committee_comments` text COLLATE utf8_unicode_ci,
  `technical_merit_score` tinyint(2) NOT NULL DEFAULT '0',
  `originality_score` tinyint(2) NOT NULL DEFAULT '0',
  `readability_score` tinyint(2) NOT NULL DEFAULT '0',
  `relevance_score` tinyint(2) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-Inactive, 1-Active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_R_PAPER` (`paper_id`),
  KEY `FK_R_REVIEWER` (`reviewer_id`),
  CONSTRAINT `FK_R_PAPER` FOREIGN KEY (`paper_id`) REFERENCES `paper` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `FK_R_REVIEWER` FOREIGN KEY (`reviewer_id`) REFERENCES `reviewer` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES 
(1,1,1,'NA',NULL,'Good work',8,9,8,9,1,'2020-04-08 22:24:38','2020-04-08 22:24:38',NULL),
(2,1,5,'NA',NULL,'Excellent',7,8,8,8,1,'2020-04-08 22:24:38','2020-04-08 22:24:38',NULL),
(3,2,2,'Too much descriptive',NULL,'This can be done in a better way, but overall work is good and useful',5,6,7,7,1,'2020-04-08 22:24:38','2020-04-08 22:24:38',NULL),
(4,2,6,'Scope of work should be well defined',NULL,NULL,6,6,6,6,1,'2020-04-08 22:24:38','2020-04-08 22:24:38',NULL),
(5,3,2,'NA',NULL,'Excellent',8,8,7,8,1,'2020-04-08 22:24:38','2020-04-08 22:24:38',NULL),
(6,3,6,'Future work should be addressed',NULL,'I will recommend to add future scope',7,7,7,8,1,'2020-04-08 22:24:38','2020-04-08 22:24:38',NULL);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewer`
--

DROP TABLE IF EXISTS `reviewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reviewer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email_address` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `affiliation` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-Inactive, 1-Active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewer`
--

LOCK TABLES `reviewer` WRITE;
/*!40000 ALTER TABLE `reviewer` DISABLE KEYS */;
INSERT INTO `reviewer` VALUES 
(1,'Johnson','Mathew','johnson_mathew@gmail.com','+1-848-221-2331','Laboratory of Forensic Science, Western University, NY, 10305, USA',1,'2020-04-08 21:35:45','2020-04-08 21:35:45',NULL),
(2,'Damian','Sendler','damian_sendler@gmail.com','+1-515-231-2442','Department of Computer Science, NYIT, NY, 1033, USA',1,'2020-04-08 21:39:08','2020-04-08 21:39:08',NULL),
(3,'Donna','Biagioli','donna_biagioli@gmail.com','+1-219-232-4451','Department of Network Security, NYIT, NY, 1033, USA',1,'2020-04-08 21:39:08','2020-04-08 21:39:08',NULL),
(4,'Nicholas','rivera','nicholas_rivera@gmail.com','+1-882-233-9843','Department of Electrical Engineering, Western University, NY, 10305, USA',1,'2020-04-08 21:42:37','2020-04-08 21:42:37',NULL),
(5,'Nick','Jonas','nick_jonas@gmail.com','+1-321-423-2312','Laboratory of Forensic Science, Western University, NY, 10305, USA',1,'2020-04-08 21:42:37','2020-04-08 21:42:37',NULL),
(6,'Steven','Lemn','steven_lemn@gmail.com','+1-823-232-7832','Depaertment of Computer Science, Stanford University, CA, 94305, USA',1,'2020-04-08 22:06:04','2020-04-08 22:06:04',NULL);
/*!40000 ALTER TABLE `reviewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_of_interest`
--

DROP TABLE IF EXISTS `topic_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `topic_of_interest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reviewer_id` int(11) NOT NULL,
  `topic_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-Inactive, 1-Active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_TOI_Reviewer` (`reviewer_id`),
  CONSTRAINT `FK_TOI_Reviewer` FOREIGN KEY (`reviewer_id`) REFERENCES `reviewer` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_of_interest`
--

LOCK TABLES `topic_of_interest` WRITE;
/*!40000 ALTER TABLE `topic_of_interest` DISABLE KEYS */;
INSERT INTO `topic_of_interest` VALUES 
(1,1,'Drugs and Toxicology',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(2,1,'DNA and Biological Evidence',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(3,2,'Machine Learning',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(4,2,'Artificial Intelligence',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(5,2,'Deep Learning',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(6,3,'Crptography',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(7,3,'End point security',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(8,3,'Content Security',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(9,3,'Web Security',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL),
(10,5,'Digital and Multimedia Evidence',1,'2020-04-08 21:48:46','2020-04-08 21:48:46',NULL);
/*!40000 ALTER TABLE `topic_of_interest` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-08 22:38:44
