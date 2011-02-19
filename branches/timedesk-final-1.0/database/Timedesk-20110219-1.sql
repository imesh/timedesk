CREATE DATABASE  IF NOT EXISTS `timedesk_final` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `timedesk_final`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: timedesk_final
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
-- Table structure for table `em_role`
--

DROP TABLE IF EXISTS `em_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_em_role_0` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_role`
--

LOCK TABLES `em_role` WRITE;
/*!40000 ALTER TABLE `em_role` DISABLE KEYS */;
INSERT INTO `em_role` VALUES (202,'Software Engineer','SE',1),(204,'Quality Assurance Engineer','QAE',1),(205,'Senior Quality Assurance Engineer','SQAE',1),(1152,'Senior Software Engineer','SSE',1),(5404,'Software Architect','SA',1),(5405,'Senior Software Architect','SSA',1),(5406,'Business Systems Analyst','BSA',1),(5407,'Senior Business Systems Analyst','SBSA',1);
/*!40000 ALTER TABLE `em_role` ENABLE KEYS */;
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
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_employee_leave_employee_id` (`employee_id`),
  CONSTRAINT `FK_employee_leave_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_leave`
--

LOCK TABLES `employee_leave` WRITE;
/*!40000 ALTER TABLE `employee_leave` DISABLE KEYS */;
INSERT INTO `employee_leave` VALUES (2602,'2011-02-16 00:00:00','2011-02-17 00:00:00',1,2601);
/*!40000 ALTER TABLE `employee_leave` ENABLE KEYS */;
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
INSERT INTO `sequence` VALUES ('SEQ_GEN','5450');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_company_0` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (101,'Timedesk Software Foundation','TD',1),(2001,'Apache Software Foundation','APACHE',1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_user_0` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'admin','admin',2),(2,1,'imesh','imesh',3),(3,1,'chamil','chamil',2),(4,1,'channa','channa',3),(5,1,'thilina','thilina',3),(6,1,'eranga','eranga',2),(7,1,'nilupulee','nilupulee',2),(8,1,'resourcemanager','resourcemanager',2),(9,1,'projectmanager','projectmanager',2),(2551,1,'james','james',1),(5253,1,'chris','chris',1);
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_security_role_0` (`security_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_role`
--

LOCK TABLES `security_role` WRITE;
/*!40000 ALTER TABLE `security_role` DISABLE KEYS */;
INSERT INTO `security_role` VALUES (51,'Administrator','ADMIN',1),(52,'Project Manager','PM',1),(53,'Resource Manager','RM',1),(54,'Training Manager','TM',1),(55,'Project Member','PRM',1);
/*!40000 ALTER TABLE `security_role` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_application_feature_0` (`feature_id`)
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_skill_0` (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
INSERT INTO `skill` VALUES (206,'Java Web Development','JWD',1),(207,'Spring MVC Web Development','SPRINGMVC',1),(208,'.NET Windows Application Development','DNETWIN',1),(209,'Java Enterprise Edition Development','JAVAEE',1),(210,'Software Designing','SOFTDESIGN',1);
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
  `phase_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_project_phase_member_0` (`phase_id`,`phase_member_id`),
  KEY `FK_project_phase_member_phase_id` (`phase_id`),
  KEY `FK_project_phase_member_member_id` (`member_id`),
  CONSTRAINT `FK_project_phase_member_member_id` FOREIGN KEY (`member_id`) REFERENCES `project_member` (`id`),
  CONSTRAINT `FK_project_phase_member_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `project_phase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_phase_member`
--

LOCK TABLES `project_phase_member` WRITE;
/*!40000 ALTER TABLE `project_phase_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_phase_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pm_role`
--

DROP TABLE IF EXISTS `pm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pm_role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_pm_role_0` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pm_role`
--

LOCK TABLES `pm_role` WRITE;
/*!40000 ALTER TABLE `pm_role` DISABLE KEYS */;
INSERT INTO `pm_role` VALUES (1752,'Project Manager','PM',1),(1753,'Team Leader','TL',1),(1754,'Package Manager','PKGM',1),(1903,'Project Member','PMEM',1),(1904,'Tech Lead','TCL',1),(1905,'Project Technician','PT',1);
/*!40000 ALTER TABLE `pm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_em_role`
--

DROP TABLE IF EXISTS `employee_em_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_em_role` (
  `Employee_id` bigint(20) NOT NULL,
  `employeeRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`Employee_id`,`employeeRoles_id`),
  KEY `FK_employee_em_role_employeeRoles_id` (`employeeRoles_id`),
  CONSTRAINT `FK_employee_em_role_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `FK_employee_em_role_employeeRoles_id` FOREIGN KEY (`employeeRoles_id`) REFERENCES `em_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_em_role`
--

LOCK TABLES `employee_em_role` WRITE;
/*!40000 ALTER TABLE `employee_em_role` DISABLE KEYS */;
INSERT INTO `employee_em_role` VALUES (5401,204),(103,1152),(5351,1152),(5403,1152);
/*!40000 ALTER TABLE `employee_em_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member_pm_role`
--

DROP TABLE IF EXISTS `project_member_pm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_member_pm_role` (
  `ProjectMember_id` bigint(20) NOT NULL,
  `roles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ProjectMember_id`,`roles_id`),
  KEY `FK_project_member_pm_role_roles_id` (`roles_id`),
  CONSTRAINT `FK_project_member_pm_role_ProjectMember_id` FOREIGN KEY (`ProjectMember_id`) REFERENCES `project_member` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_project_member_pm_role_roles_id` FOREIGN KEY (`roles_id`) REFERENCES `pm_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member_pm_role`
--

LOCK TABLES `project_member_pm_role` WRITE;
/*!40000 ALTER TABLE `project_member_pm_role` DISABLE KEYS */;
INSERT INTO `project_member_pm_role` VALUES (1801,1753),(5301,1753),(5302,1903),(2301,1904);
/*!40000 ALTER TABLE `project_member_pm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_skill`
--

DROP TABLE IF EXISTS `employee_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_skill` (
  `Employee_id` bigint(20) NOT NULL,
  `employeeSkills_id` bigint(20) NOT NULL,
  PRIMARY KEY (`Employee_id`,`employeeSkills_id`),
  KEY `FK_employee_skill_employeeSkills_id` (`employeeSkills_id`),
  CONSTRAINT `FK_employee_skill_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `FK_employee_skill_employeeSkills_id` FOREIGN KEY (`employeeSkills_id`) REFERENCES `skill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_skill`
--

LOCK TABLES `employee_skill` WRITE;
/*!40000 ALTER TABLE `employee_skill` DISABLE KEYS */;
INSERT INTO `employee_skill` VALUES (5402,206),(5403,206),(5402,207),(103,209),(103,210);
/*!40000 ALTER TABLE `employee_skill` ENABLE KEYS */;
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
  `project_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_project_phase_0` (`project_id`,`phase_id`),
  KEY `FK_project_phase_project_id` (`project_id`),
  CONSTRAINT `FK_project_phase_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_phase`
--

LOCK TABLES `project_phase` WRITE;
/*!40000 ALTER TABLE `project_phase` DISABLE KEYS */;
INSERT INTO `project_phase` VALUES (902,'2011-01-01 00:00:00','Prototype Development','2011-01-15 00:00:00','OCEAN_PH2',1,201),(1301,'2011-02-15 00:00:00','Second Stage','2011-02-19 00:00:00','OCEANPH1',1,201),(1651,'2011-02-20 00:00:00','Evaluation Stage','2011-02-24 00:00:00','SKYPH1',1,351),(1702,'2011-02-14 00:00:00','Beta Testing','2011-02-18 00:00:00','SKYPH2',1,351),(1851,'2011-03-01 00:00:00','SOA Designing Phase','2011-03-30 00:00:00','IMAGINEPH1',1,1751),(1902,'2011-03-01 00:00:00','Fourth Stage','2011-02-21 00:00:00','OCEANPH2',1,201),(2252,'2011-02-15 00:00:00','Third Stage','2011-02-20 00:00:00','OCEANPH3',1,201);
/*!40000 ALTER TABLE `project_phase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_pre_em_role`
--

DROP TABLE IF EXISTS `employee_pre_em_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_pre_em_role` (
  `Employee_id` bigint(20) NOT NULL,
  `preEmployeeRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`Employee_id`,`preEmployeeRoles_id`),
  KEY `FK_employee_pre_em_role_preEmployeeRoles_id` (`preEmployeeRoles_id`),
  CONSTRAINT `FK_employee_pre_em_role_preEmployeeRoles_id` FOREIGN KEY (`preEmployeeRoles_id`) REFERENCES `em_role` (`id`),
  CONSTRAINT `FK_employee_pre_em_role_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_pre_em_role`
--

LOCK TABLES `employee_pre_em_role` WRITE;
/*!40000 ALTER TABLE `employee_pre_em_role` DISABLE KEYS */;
INSERT INTO `employee_pre_em_role` VALUES (5403,204),(5401,1152),(5402,1152);
/*!40000 ALTER TABLE `employee_pre_em_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_site`
--

DROP TABLE IF EXISTS `company_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_site` (
  `id` bigint(20) NOT NULL,
  `site_id` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_company_site_0` (`company_id`,`site_id`),
  CONSTRAINT `FK_company_site_company_id` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_site`
--

LOCK TABLES `company_site` WRITE;
/*!40000 ALTER TABLE `company_site` DISABLE KEYS */;
INSERT INTO `company_site` VALUES (102,'CMB','World Trade Center','Colombo','Sri_Lanka',1,101),(107,'KND','Kandy Road','Kandy','Sri_Lanka',1,101),(2002,'NY','New York','New York','United_States',1,2001),(2302,'MELBN','Town Hall','Melbourne','Australia',1,2001);
/*!40000 ALTER TABLE `company_site` ENABLE KEYS */;
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
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_project_0` (`company_id`,`project_id`),
  KEY `FK_project_company_id` (`company_id`),
  CONSTRAINT `FK_project_company_id` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (201,'2010-12-18 00:00:00','Timedesk Version 1.0','Project Ocean','2011-01-18 00:00:00','OCEAN',2,101),(351,'2010-12-20 00:00:00','Timedesk Reporting','Project Sky','2011-01-01 00:00:00','SKY',1,101),(1751,'2011-02-01 00:00:00','Timedesk Web Services Implementation','Project Imagine','2011-02-28 00:00:00','IMAGINE',1,101);
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
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_project_member_feedback_0` (`member_id`,`feedback_id`),
  KEY `FK_project_member_feedback_member_id` (`member_id`),
  CONSTRAINT `FK_project_member_feedback_member_id` FOREIGN KEY (`member_id`) REFERENCES `project_member` (`id`)
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
  `securityRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY (`User_id`,`securityRoles_id`),
  KEY `FK_user_security_role_securityRoles_id` (`securityRoles_id`),
  CONSTRAINT `FK_user_security_role_User_id` FOREIGN KEY (`User_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_security_role_securityRoles_id` FOREIGN KEY (`securityRoles_id`) REFERENCES `security_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_security_role`
--

LOCK TABLES `user_security_role` WRITE;
/*!40000 ALTER TABLE `user_security_role` DISABLE KEYS */;
INSERT INTO `user_security_role` VALUES (1,51),(2,51),(9,52),(8,53),(5253,53),(2551,54),(3,55),(4,55),(5,55),(6,55),(7,55);
/*!40000 ALTER TABLE `user_security_role` ENABLE KEYS */;
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
  `employee_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_project_member_0` (`project_id`,`member_id`),
  KEY `FK_project_member_employee_id` (`employee_id`),
  KEY `FK_project_member_project_id` (`project_id`),
  CONSTRAINT `FK_project_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_project_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member`
--

LOCK TABLES `project_member` WRITE;
/*!40000 ALTER TABLE `project_member` DISABLE KEYS */;
INSERT INTO `project_member` VALUES (214,'OCEANIM',3,103,201),(251,'OCEANCH',3,104,201),(1801,'IMAGINEIMGUCMB',1,103,1751),(2301,'OCEANCHN',1,NULL,201),(5301,'SKYIMGUCMB1',1,103,351),(5302,'SKYCHDICMB',1,104,351);
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
  `current_allocation` int(11) DEFAULT NULL,
  `post_code` varchar(255) DEFAULT NULL,
  `max_allocation` int(11) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `phone_mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_residence` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `office_extension` varchar(255) DEFAULT NULL,
  `site_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_employee_0` (`employee_id`),
  KEY `FK_employee_site_id` (`site_id`),
  KEY `FK_employee_username` (`user_id`),
  CONSTRAINT `FK_employee_site_id` FOREIGN KEY (`site_id`) REFERENCES `company_site` (`id`),
  CONSTRAINT `FK_employee_username` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (103,'IMGUCMB','Gunaratne',NULL,'12345',100,'Sri_Lanka','',6,'','imesh@timedeskonline.com','','','Imesh','',102,2),(104,'CHDICMB','Disanayake',NULL,'45678',100,'Sri_Lanka','Colombo',2,'','chamil@timedeskonline.com','','','Chamil','',102,3),(2601,'JAASMEL','Ashmore',NULL,'',100,'Australia','Melbourne',2,'','james@apache.org','','','James','',2302,2551),(5351,'THRACMB','Ranaweera',NULL,'',100,'Sri_Lanka','Piliyandala',2,'','thilina@timedeskonline.com','','','Thilina','',102,5),(5401,'NINACMB','Nathawitharana',NULL,'',100,'Sri_Lanka','Colombo',1,'','nilupulee@timedeskonline.com','','','Nilupulee','',102,7),(5402,'CHSECMB','Senavirathna',NULL,'',100,'Sri_Lanka','Kandy',1,'','channa@timedeskonline.com','','','Channa','',102,4),(5403,'ERSACMB','Samararathna',NULL,'',100,'Sri_Lanka','Colombo',1,'','eranga@timedeskonline.com','','','Eranga','',102,6);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holiday`
--

DROP TABLE IF EXISTS `holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holiday` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `site_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_HOLIDAY_site_id` (`site_id`),
  CONSTRAINT `FK_HOLIDAY_site_id` FOREIGN KEY (`site_id`) REFERENCES `company_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holiday`
--

LOCK TABLES `holiday` WRITE;
/*!40000 ALTER TABLE `holiday` DISABLE KEYS */;
INSERT INTO `holiday` VALUES (2202,'2011-02-16 00:00:00',1,102),(2501,'2011-02-15 00:00:00',1,2302),(5408,'2011-02-17 00:00:00',1,102);
/*!40000 ALTER TABLE `holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_role_application_feature`
--

DROP TABLE IF EXISTS `security_role_application_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_role_application_feature` (
  `SecurityRole_id` bigint(20) NOT NULL,
  `applicationFeatures_id` bigint(20) NOT NULL,
  PRIMARY KEY (`SecurityRole_id`,`applicationFeatures_id`),
  KEY `securityroleapplicationfeaturepplicationFeaturesid` (`applicationFeatures_id`),
  CONSTRAINT `securityroleapplicationfeaturepplicationFeaturesid` FOREIGN KEY (`applicationFeatures_id`) REFERENCES `application_feature` (`id`),
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
  `id` bigint(20) NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `valid_from` datetime DEFAULT NULL,
  `visa_id` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_employee_visa_0` (`employee_id`,`visa_id`),
  KEY `FK_employee_visa_employee_id` (`employee_id`),
  CONSTRAINT `FK_employee_visa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_visa`
--

LOCK TABLES `employee_visa` WRITE;
/*!40000 ALTER TABLE `employee_visa` DISABLE KEYS */;
INSERT INTO `employee_visa` VALUES (2051,'2011-08-01 00:00:00','2011-02-01 00:00:00','UK','United_Kingdom',1,103);
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

-- Dump completed on 2011-02-19  9:21:32

--
-- Create Employee Allocation View
--

CREATE OR REPLACE VIEW employee_allocation AS
SELECT (CAST(CONCAT(e.id, p.id, phm.id) AS CHAR)) as 'id', e.version, e.id as 'emp_id', e.employee_id, p.id as 'p_id', p.name, phm.id as 'phm_id', phm.phase_member_id, phm.start_date, phm.end_date, phm.allocation 
FROM employee e, project_member m, project_phase_member phm, project p
WHERE e.id = m.employee_id AND m.id = phm.member_id AND m.project_id = p.id;
