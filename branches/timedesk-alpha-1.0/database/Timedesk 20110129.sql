CREATE DATABASE  IF NOT EXISTS `timedesk` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `timedesk`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: timedesk
-- ------------------------------------------------------
-- Server version	5.1.52-community

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
-- Table structure for table `project_member_role`
--

DROP TABLE IF EXISTS `project_member_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_member_role` (
  `ProjectMember_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `roles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ProjectMember_id`,`roles_id`),
  KEY `FK_project_member_role_roles_id` (`roles_id`),
  CONSTRAINT `FK_project_member_role_ProjectMember_id` FOREIGN KEY (`ProjectMember_id`) REFERENCES `project_member` (`id`),
  CONSTRAINT `FK_project_member_role_roles_id` FOREIGN KEY (`roles_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member_role`
--

LOCK TABLES `project_member_role` WRITE;
/*!40000 ALTER TABLE `project_member_role` DISABLE KEYS */;
INSERT INTO `project_member_role` VALUES (16,9),(202,9),(202,12);
/*!40000 ALTER TABLE `project_member_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_role`
--

DROP TABLE IF EXISTS `employee_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_role` (
  `Employee_id` bigint(20) NOT NULL,
  `employeeRoles_id` bigint(20) NOT NULL,
  `preEmployeeRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`Employee_id`,`employeeRoles_id`,`preEmployeeRoles_id`),
  KEY `FK_employee_role_employeeRoles_id` (`employeeRoles_id`),
  KEY `FK_employee_role_preEmployeeRoles_id` (`preEmployeeRoles_id`),
  CONSTRAINT `FK_employee_role_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `FK_employee_role_employeeRoles_id` FOREIGN KEY (`employeeRoles_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FK_employee_role_preEmployeeRoles_id` FOREIGN KEY (`preEmployeeRoles_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_role`
--

LOCK TABLES `employee_role` WRITE;
/*!40000 ALTER TABLE `employee_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequence`
--

LOCK TABLES `sequence` WRITE;
/*!40000 ALTER TABLE `sequence` DISABLE KEYS */;
INSERT INTO `sequence` VALUES ('SEQ_GEN','250');
/*!40000 ALTER TABLE `sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Apache Software Foundation','APACHE',1),(203,'Red Hat','REDHAT',1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `id` bigint(20) NOT NULL,
  `site_id` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES (2,'CMB','Down Street','Colombo','Sri Lanka',1,'APACHE'),(3,'NY','High Street','New York','United States',1,'APACHE');
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `enabled` tinyint(1) DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (17,1,'admin','admin',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_role`
--

DROP TABLE IF EXISTS `security_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `security_role_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_role`
--

LOCK TABLES `security_role` WRITE;
/*!40000 ALTER TABLE `security_role` DISABLE KEYS */;
INSERT INTO `security_role` VALUES (18,'Administrator','ADMIN',1),(19,'Resource Manager','RM',1),(20,'Project Manager','PM',1);
/*!40000 ALTER TABLE `security_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `skill_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
INSERT INTO `skill` VALUES (5,'Java Web Development','JAVAWEB',1),(6,'.NET Windows Application Development','DNETWIN',1),(7,'Spring Application Server Development','SPRING',2),(8,'Spring MVC Web Development','SPRINGMVC',1);
/*!40000 ALTER TABLE `skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_phase_member`
--

DROP TABLE IF EXISTS `project_phase_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_phase_member` (
  `id` bigint(20) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `phase_member_id` varchar(255) DEFAULT NULL,
  `allocation` int(11) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `phase_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_phase_member`
--

LOCK TABLES `project_phase_member` WRITE;
/*!40000 ALTER TABLE `project_phase_member` DISABLE KEYS */;
INSERT INTO `project_phase_member` VALUES (204,'2011-01-15 00:00:00','PM-IM',80,'2011-01-22 00:00:00',1,'P1');
/*!40000 ALTER TABLE `project_phase_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_skill`
--

DROP TABLE IF EXISTS `employee_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_skill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `employee_skill_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `Employee_id` bigint(20) NOT NULL,
  `employeeSkills_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`,`Employee_id`,`employeeSkills_id`),
  KEY `FK_employee_skill_employeeSkills_id` (`employeeSkills_id`),
  KEY `FK_employee_skill_Employee_id` (`Employee_id`),
  CONSTRAINT `FK_employee_skill_employeeSkills_id` FOREIGN KEY (`employeeSkills_id`) REFERENCES `skill` (`id`),
  CONSTRAINT `FK_employee_skill_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_skill`
--

LOCK TABLES `employee_skill` WRITE;
/*!40000 ALTER TABLE `employee_skill` DISABLE KEYS */;
INSERT INTO `employee_skill` VALUES (1,NULL,NULL,NULL,102,5);
/*!40000 ALTER TABLE `employee_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_leave`
--

DROP TABLE IF EXISTS `employee_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_leave` (
  `id` bigint(20) NOT NULL,
  `from_time` datetime DEFAULT NULL,
  `to_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_leave`
--

LOCK TABLES `employee_leave` WRITE;
/*!40000 ALTER TABLE `employee_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_phase`
--

DROP TABLE IF EXISTS `project_phase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_phase` (
  `id` bigint(20) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `phase_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_phase`
--

LOCK TABLES `project_phase` WRITE;
/*!40000 ALTER TABLE `project_phase` DISABLE KEYS */;
INSERT INTO `project_phase` VALUES (201,'2011-01-08 00:00:00','Initialization','2011-01-15 00:00:00','P1',1,'Black Bird');
/*!40000 ALTER TABLE `project_phase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_feature`
--

DROP TABLE IF EXISTS `application_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_feature` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `feature_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_feature`
--

LOCK TABLES `application_feature` WRITE;
/*!40000 ALTER TABLE `application_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` bigint(20) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (15,'2010-12-18 00:00:00','Project Resource Management System','Timedesk','2011-02-21 00:00:00','TD',2,'APACHE'),(151,'2011-01-22 00:00:00','Aviation & Defense','Black Bird','2011-01-30 00:00:00','BB',5,'APACHE');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member_feedback`
--

DROP TABLE IF EXISTS `project_member_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_member_feedback` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `feedback_id` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `member_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member_feedback`
--

LOCK TABLES `project_member_feedback` WRITE;
/*!40000 ALTER TABLE `project_member_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_member_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_security_role`
--

DROP TABLE IF EXISTS `user_security_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_security_role` (
  `User_id` bigint(20) NOT NULL,
  `userRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`User_id`,`userRoles_id`),
  KEY `FK_user_security_role_userRoles_id` (`userRoles_id`),
  CONSTRAINT `FK_user_security_role_User_id` FOREIGN KEY (`User_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_security_role_userRoles_id` FOREIGN KEY (`userRoles_id`) REFERENCES `security_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_security_role`
--

LOCK TABLES `user_security_role` WRITE;
/*!40000 ALTER TABLE `user_security_role` DISABLE KEYS */;
INSERT INTO `user_security_role` VALUES (17,18);
/*!40000 ALTER TABLE `user_security_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role_type` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (9,'Software Engineer','EmployeeRole','SE',1),(10,'Quality Assurance Engineer','EmployeeRole','QAE',1),(11,'Software Architect','EmployeeRole','SA',1),(12,'Team Leader','ProjectMemberRole','TL',1),(13,'Project Manager','ProjectMemberRole','PM',1),(51,'Senior Software Engineer','EmployeeRole','SSE',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member`
--

DROP TABLE IF EXISTS `project_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_member` (
  `id` bigint(20) NOT NULL,
  `member_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_project_member_EMPLOYEE_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member`
--

LOCK TABLES `project_member` WRITE;
/*!40000 ALTER TABLE `project_member` DISABLE KEYS */;
INSERT INTO `project_member` VALUES (16,'IM',1,'TD','IM'),(202,'IM',2,'TD','IM');
/*!40000 ALTER TABLE `project_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `post_code` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `phone_mobile` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_residence` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `office_extension` varchar(255) DEFAULT NULL,
  `site_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (4,'IM','Gunaratne','12345',1,'Colombo','Sri Lanka','','First Street','imesh.gunaratne@gmail.com','','Imesh','','CMB'),(14,'CM','Disanayake','12345',1,'Colombo','Sri Lanka','','Second Street','chamil.disanayake@gmail.com','','Chamil','','CMB'),(102,'CHANNA','Seneviratne','',2,'Kandy','Sri Lanka','','New Kandy Road','channa@gmail.com','','Channa','','CMB');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_role_application_feature`
--

DROP TABLE IF EXISTS `security_role_application_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_role_application_feature` (
  `SecurityRole_id` bigint(20) NOT NULL,
  `tasks_id` bigint(20) NOT NULL,
  PRIMARY KEY (`SecurityRole_id`,`tasks_id`),
  KEY `FK_security_role_application_feature_tasks_id` (`tasks_id`),
  CONSTRAINT `FK_security_role_application_feature_tasks_id` FOREIGN KEY (`tasks_id`) REFERENCES `application_feature` (`id`),
  CONSTRAINT `security_role_application_feature_SecurityRole_id` FOREIGN KEY (`SecurityRole_id`) REFERENCES `security_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_role_application_feature`
--

LOCK TABLES `security_role_application_feature` WRITE;
/*!40000 ALTER TABLE `security_role_application_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_role_application_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_visa`
--

DROP TABLE IF EXISTS `employee_visa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_visa` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `valid_to` datetime DEFAULT NULL,
  `valid_from` datetime DEFAULT NULL,
  `visa_id` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_visa`
--

LOCK TABLES `employee_visa` WRITE;
/*!40000 ALTER TABLE `employee_visa` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_visa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-29  0:48:35
