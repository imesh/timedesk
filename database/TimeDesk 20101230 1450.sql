-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.21-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema timedesk
--

CREATE DATABASE IF NOT EXISTS timedesk;
USE timedesk;

--
-- Definition of table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) default NULL,
  `company_id` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`,`name`,`company_id`,`version`) VALUES 
 (1,'Apache Software Foundation','APACHE',3);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;


--
-- Definition of table `company_site`
--

DROP TABLE IF EXISTS `company_site`;
CREATE TABLE `company_site` (
  `Company_id` bigint(20) NOT NULL,
  `companySites_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`Company_id`,`companySites_id`),
  KEY `FK_COMPANY_SITE_companySites_id` (`companySites_id`),
  CONSTRAINT `FK_COMPANY_SITE_companySites_id` FOREIGN KEY (`companySites_id`) REFERENCES `site` (`id`),
  CONSTRAINT `FK_COMPANY_SITE_Company_id` FOREIGN KEY (`Company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company_site`
--

/*!40000 ALTER TABLE `company_site` DISABLE KEYS */;
INSERT INTO `company_site` (`Company_id`,`companySites_id`) VALUES 
 (1,2),
 (1,3);
/*!40000 ALTER TABLE `company_site` ENABLE KEYS */;


--
-- Definition of table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL,
  `employee_id` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `post_code` varchar(255) default NULL,
  `version` int(11) default NULL,
  `city` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `phone_mobile` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `phone_residence` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `office_extension` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id`,`employee_id`,`last_name`,`post_code`,`version`,`city`,`country`,`phone_mobile`,`email`,`address`,`phone_residence`,`first_name`,`office_extension`) VALUES 
 (4,'IMESH','Gunaratne','',1,'Colombo','','','imesh.gunaratne@gmail.com','1st Street','','Imesh',''),
 (201,'CHAMIL','Disanayake','12345',1,'Colombo','Sri Lanka','','chamil.disanayake@gmail.com','Second Street','','Chamil',''),
 (258,'THILINA','Ranaweera','12345',1,'Colombo','Sri Lanka','','thilina.ranaweera@gmail.com','','','Thilina','');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;


--
-- Definition of table `employee_employee_role`
--

DROP TABLE IF EXISTS `employee_employee_role`;
CREATE TABLE `employee_employee_role` (
  `Employee_id` bigint(20) NOT NULL,
  `employeeRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`Employee_id`,`employeeRoles_id`),
  KEY `FK_EMPLOYEE_EMPLOYEE_ROLE_employeeRoles_id` (`employeeRoles_id`),
  CONSTRAINT `FK_EMPLOYEE_EMPLOYEE_ROLE_employeeRoles_id` FOREIGN KEY (`employeeRoles_id`) REFERENCES `employee_role` (`id`),
  CONSTRAINT `FK_EMPLOYEE_EMPLOYEE_ROLE_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_employee_role`
--

/*!40000 ALTER TABLE `employee_employee_role` DISABLE KEYS */;
INSERT INTO `employee_employee_role` (`Employee_id`,`employeeRoles_id`) VALUES 
 (258,52),
 (201,53);
/*!40000 ALTER TABLE `employee_employee_role` ENABLE KEYS */;


--
-- Definition of table `employee_employee_skill`
--

DROP TABLE IF EXISTS `employee_employee_skill`;
CREATE TABLE `employee_employee_skill` (
  `Employee_id` bigint(20) NOT NULL,
  `employeeSkills_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`Employee_id`,`employeeSkills_id`),
  KEY `FK_EMPLOYEE_EMPLOYEE_SKILL_employeeSkills_id` (`employeeSkills_id`),
  CONSTRAINT `FK_EMPLOYEE_EMPLOYEE_SKILL_employeeSkills_id` FOREIGN KEY (`employeeSkills_id`) REFERENCES `employee_skill` (`id`),
  CONSTRAINT `FK_EMPLOYEE_EMPLOYEE_SKILL_Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_employee_skill`
--

/*!40000 ALTER TABLE `employee_employee_skill` DISABLE KEYS */;
INSERT INTO `employee_employee_skill` (`Employee_id`,`employeeSkills_id`) VALUES 
 (201,102),
 (258,102);
/*!40000 ALTER TABLE `employee_employee_skill` ENABLE KEYS */;


--
-- Definition of table `employee_role`
--

DROP TABLE IF EXISTS `employee_role`;
CREATE TABLE `employee_role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) default NULL,
  `employee_role_id` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_role`
--

/*!40000 ALTER TABLE `employee_role` DISABLE KEYS */;
INSERT INTO `employee_role` (`id`,`name`,`employee_role_id`,`version`) VALUES 
 (52,'Project Manager','PM',1),
 (53,'Software Engineer','SE',1),
 (54,'Quality Assurance Engineer','QA',1);
/*!40000 ALTER TABLE `employee_role` ENABLE KEYS */;


--
-- Definition of table `employee_skill`
--

DROP TABLE IF EXISTS `employee_skill`;
CREATE TABLE `employee_skill` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) default NULL,
  `employee_skill_id` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_skill`
--

/*!40000 ALTER TABLE `employee_skill` DISABLE KEYS */;
INSERT INTO `employee_skill` (`id`,`description`,`employee_skill_id`,`version`) VALUES 
 (55,'User Interface Designing','UID',2),
 (102,'Spring MVC','SPRMVC',1);
/*!40000 ALTER TABLE `employee_skill` ENABLE KEYS */;


--
-- Definition of table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) default NULL,
  `feedback_id` int(11) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;


--
-- Definition of table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` bigint(20) NOT NULL,
  `start_date` datetime default NULL,
  `description` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `end_date` datetime default NULL,
  `project_id` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`id`,`start_date`,`description`,`name`,`end_date`,`project_id`,`version`) VALUES 
 (51,'2010-12-18 00:00:00','A Project Resource Management System','Time Desk','2011-02-21 00:00:00','TIMEDESK',1);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


--
-- Definition of table `project_component`
--

DROP TABLE IF EXISTS `project_component`;
CREATE TABLE `project_component` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `component_id` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_component`
--

/*!40000 ALTER TABLE `project_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_component` ENABLE KEYS */;


--
-- Definition of table `project_component_task`
--

DROP TABLE IF EXISTS `project_component_task`;
CREATE TABLE `project_component_task` (
  `ProjectComponent_id` bigint(20) NOT NULL,
  `tasks_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`ProjectComponent_id`,`tasks_id`),
  KEY `FK_PROJECT_COMPONENT_TASK_tasks_id` (`tasks_id`),
  CONSTRAINT `FK_PROJECT_COMPONENT_TASK_ProjectComponent_id` FOREIGN KEY (`ProjectComponent_id`) REFERENCES `project_component` (`id`),
  CONSTRAINT `FK_PROJECT_COMPONENT_TASK_tasks_id` FOREIGN KEY (`tasks_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_component_task`
--

/*!40000 ALTER TABLE `project_component_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_component_task` ENABLE KEYS */;


--
-- Definition of table `project_member`
--

DROP TABLE IF EXISTS `project_member`;
CREATE TABLE `project_member` (
  `id` bigint(20) NOT NULL,
  `start_date` datetime default NULL,
  `allocation` int(11) default NULL,
  `member_id` varchar(255) default NULL,
  `end_date` datetime default NULL,
  `version` int(11) default NULL,
  `EMPLOYEE_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_PROJECT_MEMBER_EMPLOYEE_id` (`EMPLOYEE_id`),
  CONSTRAINT `FK_PROJECT_MEMBER_EMPLOYEE_id` FOREIGN KEY (`EMPLOYEE_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_member`
--

/*!40000 ALTER TABLE `project_member` DISABLE KEYS */;
INSERT INTO `project_member` (`id`,`start_date`,`allocation`,`member_id`,`end_date`,`version`,`EMPLOYEE_id`) VALUES 
 (151,'2010-12-18 00:00:00',80,'IMESH','2011-02-21 00:00:00',2,4),
 (251,'2010-12-18 00:00:00',60,'CHAMIL','2011-01-10 00:00:00',2,201),
 (259,'2010-12-18 00:00:00',80,'THILINA','2011-02-21 00:00:00',1,258);
/*!40000 ALTER TABLE `project_member` ENABLE KEYS */;


--
-- Definition of table `project_member_feedback`
--

DROP TABLE IF EXISTS `project_member_feedback`;
CREATE TABLE `project_member_feedback` (
  `ProjectMember_id` bigint(20) NOT NULL,
  `feedbacks_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`ProjectMember_id`,`feedbacks_id`),
  KEY `FK_PROJECT_MEMBER_FEEDBACK_feedbacks_id` (`feedbacks_id`),
  CONSTRAINT `FK_PROJECT_MEMBER_FEEDBACK_feedbacks_id` FOREIGN KEY (`feedbacks_id`) REFERENCES `feedback` (`id`),
  CONSTRAINT `FK_PROJECT_MEMBER_FEEDBACK_ProjectMember_id` FOREIGN KEY (`ProjectMember_id`) REFERENCES `project_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_member_feedback`
--

/*!40000 ALTER TABLE `project_member_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_member_feedback` ENABLE KEYS */;


--
-- Definition of table `project_member_project_member_role`
--

DROP TABLE IF EXISTS `project_member_project_member_role`;
CREATE TABLE `project_member_project_member_role` (
  `ProjectMember_id` bigint(20) NOT NULL,
  `memberRoles_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`ProjectMember_id`,`memberRoles_id`),
  KEY `PROJECT_MEMBER_PROJECT_MEMBER_ROLE_memberRoles_id` (`memberRoles_id`),
  CONSTRAINT `PROJECT_MEMBER_PROJECT_MEMBER_ROLE_memberRoles_id` FOREIGN KEY (`memberRoles_id`) REFERENCES `project_member_role` (`id`),
  CONSTRAINT `PROJECT_MEMBER_PROJECT_MEMBER_ROLEProjectMember_id` FOREIGN KEY (`ProjectMember_id`) REFERENCES `project_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_member_project_member_role`
--

/*!40000 ALTER TABLE `project_member_project_member_role` DISABLE KEYS */;
INSERT INTO `project_member_project_member_role` (`ProjectMember_id`,`memberRoles_id`) VALUES 
 (259,252),
 (251,254),
 (251,257);
/*!40000 ALTER TABLE `project_member_project_member_role` ENABLE KEYS */;


--
-- Definition of table `project_member_role`
--

DROP TABLE IF EXISTS `project_member_role`;
CREATE TABLE `project_member_role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) default NULL,
  `role_id` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_member_role`
--

/*!40000 ALTER TABLE `project_member_role` DISABLE KEYS */;
INSERT INTO `project_member_role` (`id`,`name`,`role_id`,`version`) VALUES 
 (252,'Project Manager','PM',1),
 (253,'Team Leader','TL',1),
 (254,'Software Engineer','SE',1),
 (255,'Software Architect','SA',1),
 (256,'Quality Assurance Engineer','QA',1),
 (257,'Business Analyst','BA',1);
/*!40000 ALTER TABLE `project_member_role` ENABLE KEYS */;


--
-- Definition of table `project_project_member`
--

DROP TABLE IF EXISTS `project_project_member`;
CREATE TABLE `project_project_member` (
  `Project_id` bigint(20) NOT NULL,
  `members_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`Project_id`,`members_id`),
  KEY `FK_PROJECT_PROJECT_MEMBER_members_id` (`members_id`),
  CONSTRAINT `FK_PROJECT_PROJECT_MEMBER_members_id` FOREIGN KEY (`members_id`) REFERENCES `project_member` (`id`),
  CONSTRAINT `FK_PROJECT_PROJECT_MEMBER_Project_id` FOREIGN KEY (`Project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_project_member`
--

/*!40000 ALTER TABLE `project_project_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_project_member` ENABLE KEYS */;


--
-- Definition of table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
CREATE TABLE `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) default NULL,
  PRIMARY KEY  (`SEQ_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sequence`
--

/*!40000 ALTER TABLE `sequence` DISABLE KEYS */;
INSERT INTO `sequence` (`SEQ_NAME`,`SEQ_COUNT`) VALUES 
 ('SEQ_GEN','300');
/*!40000 ALTER TABLE `sequence` ENABLE KEYS */;


--
-- Definition of table `site`
--

DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
  `id` bigint(20) NOT NULL,
  `site_id` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `site`
--

/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` (`id`,`site_id`,`location`,`city`,`country`,`version`) VALUES 
 (2,'NY','Down Street','New York','United States',1),
 (3,'CMB','Havelock Road','Colombo','Sri Lanka',1);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;


--
-- Definition of table `site_employee`
--

DROP TABLE IF EXISTS `site_employee`;
CREATE TABLE `site_employee` (
  `Site_id` bigint(20) NOT NULL,
  `employees_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`Site_id`,`employees_id`),
  KEY `FK_SITE_EMPLOYEE_employees_id` (`employees_id`),
  CONSTRAINT `FK_SITE_EMPLOYEE_employees_id` FOREIGN KEY (`employees_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `FK_SITE_EMPLOYEE_Site_id` FOREIGN KEY (`Site_id`) REFERENCES `site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `site_employee`
--

/*!40000 ALTER TABLE `site_employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_employee` ENABLE KEYS */;


--
-- Definition of table `task`
--

DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` bigint(20) NOT NULL,
  `task_id` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `version` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task`
--

/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
