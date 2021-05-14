CREATE USER 'kr_covid'@'%' IDENTIFIED BY 'kr_covid';
ALTER USER 'kr_covid'@'%' IDENTIFIED WITH mysql_native_password BY 'covid123';
CREATE DATABASE  IF NOT EXISTS `sql_covid19` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
GRANT ALL ON sql_covid19.* to 'kr_covid'@'%';
USE `sql_covid19`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: sql_covid19
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `usa_counties`
--

DROP TABLE IF EXISTS `usa_counties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_counties` (
  `usa_counties_id` int NOT NULL AUTO_INCREMENT,
  `usa_counties_name` varchar(45) NOT NULL,
  `usa_counties_pop` int NOT NULL,
  `usa_counties_sq_mi` int NOT NULL,
  `usa_states_id` int NOT NULL,
  `fips` char(5) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_counties_id`),
  KEY `fk_usa_states_idx` (`usa_states_id`),
  CONSTRAINT `fk_usa_states_id` FOREIGN KEY (`usa_states_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3303 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table of counties, bouroughs, etc and their statistics';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_counties_created_at` BEFORE INSERT ON `usa_counties` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_county_adjacents`
--

DROP TABLE IF EXISTS `usa_county_adjacents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_county_adjacents` (
  `usa_county_main_id` int NOT NULL,
  `usa_county_neighbor_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_county_main_id`,`usa_county_neighbor_id`),
  KEY `fk_usa_county_adjacents_county_main_idx` (`usa_county_main_id`),
  KEY `fk_usa_county_adjacents_county_neighbor_idx` (`usa_county_neighbor_id`),
  CONSTRAINT `fk_county_adjacents_county_neighbor_id` FOREIGN KEY (`usa_county_neighbor_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usa_county_adjacents_county_main_id` FOREIGN KEY (`usa_county_main_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='table of counties and their physically adjacent counties';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_county_adjacents_created_at` BEFORE INSERT ON `usa_county_adjacents` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_county_totals`
--

DROP TABLE IF EXISTS `usa_county_totals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_county_totals` (
  `usa_county_totals_id` int NOT NULL AUTO_INCREMENT,
  `county_cases_max` int DEFAULT NULL,
  `county_cases_double_rate` int NOT NULL,
  `county_cases_7_day_avg` int NOT NULL,
  `county_deaths_max` int DEFAULT NULL,
  `county_deaths_double_rate` int NOT NULL,
  `county_deaths_7_day_avg` int NOT NULL,
  `usa_states_id` int NOT NULL,
  `usa_counties_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_county_totals_id`),
  KEY `fk_usa_county_totals_usa_states_idx` (`usa_states_id`),
  KEY `fk_usa_county_totals_usa_counties_idx` (`usa_counties_id`),
  CONSTRAINT `fk_usa_county_totals_usa_counties_id` FOREIGN KEY (`usa_counties_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usa_county_totals_usa_states_id` FOREIGN KEY (`usa_states_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3341 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table of county current totals for cases and deaths';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_county_totals_created_at` BEFORE INSERT ON `usa_county_totals` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_raw_county_daily`
--

DROP TABLE IF EXISTS `usa_raw_county_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_raw_county_daily` (
  `usa_raw_county_daily_id` int NOT NULL AUTO_INCREMENT,
  `county_daily_counts_total_on_date` int DEFAULT NULL,
  `county_daily_cases_double_rate` int NOT NULL,
  `county_daily_cases_7_day_avg` int NOT NULL,
  `county_daily_deaths_total_on_date` int DEFAULT NULL,
  `county_daily_deaths_double_rate` int NOT NULL,
  `county_daily_deaths_7_day_avg` int NOT NULL,
  `county_daily_totals_date` date DEFAULT NULL,
  `usa_states_id` int NOT NULL,
  `usa_counties_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_raw_county_daily_id`),
  KEY `fk_usa_raw_county_daily_usa_states_idx` (`usa_states_id`),
  KEY `fk_usa_raw_county_daily_usa_counties_idx` (`usa_counties_id`),
  CONSTRAINT `fk_usa_raw_county_daily_usa_counties_id` FOREIGN KEY (`usa_counties_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usa_raw_county_daily_usa_states_id` FOREIGN KEY (`usa_states_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10105190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table of county cases and deaths daily totals';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_raw_county_daily_created_at` BEFORE INSERT ON `usa_raw_county_daily` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_raw_data`
--

DROP TABLE IF EXISTS `usa_raw_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_raw_data` (
  `usa_raw_data_id` int NOT NULL AUTO_INCREMENT,
  `county_counts_total_on_date` int DEFAULT NULL,
  `county_deaths_total_on_date` int DEFAULT NULL,
  `county_totals_date` date DEFAULT NULL,
  `usa_states_id` int NOT NULL,
  `usa_counties_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_raw_data_id`),
  KEY `fk_usa_raw_data_usa_states_idx` (`usa_states_id`),
  KEY `fk_usa_raw_data_usa_counties_idx` (`usa_counties_id`),
  CONSTRAINT `fk_usa_raw_data_usa_counties_id` FOREIGN KEY (`usa_counties_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usa_raw_data_usa_states_id` FOREIGN KEY (`usa_states_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1103057 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table of daily cases and deaths running totals';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_raw_data_created_at` BEFORE INSERT ON `usa_raw_data` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_raw_state_daily`
--

DROP TABLE IF EXISTS `usa_raw_state_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_raw_state_daily` (
  `usa_raw_state_daily_id` int NOT NULL AUTO_INCREMENT,
  `state_daily_counts_total_on_date` int DEFAULT NULL,
  `state_daily_cases_double_rate` int NOT NULL,
  `state_daily_cases_7_day_avg` int NOT NULL,
  `state_daily_deaths_total_on_date` int DEFAULT NULL,
  `state_daily_deaths_double_rate` int NOT NULL,
  `state_daily_deaths_7_day_avg` int NOT NULL,
  `state_daily_totals_date` date DEFAULT NULL,
  `usa_states_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_raw_state_daily_id`),
  KEY `fk_usa_raw_state_daily_usa_states_idx` (`usa_states_id`),
  CONSTRAINT `fk_usa_raw_state_daily_usa_states_id` FOREIGN KEY (`usa_states_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table of state cases and deaths daily totals';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_raw_state_daily_created_at` BEFORE INSERT ON `usa_raw_state_daily` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_state_adjacents`
--

DROP TABLE IF EXISTS `usa_state_adjacents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_state_adjacents` (
  `usa_state_main_id` int NOT NULL,
  `usa_state_neighbor_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_state_main_id`,`usa_state_neighbor_id`),
  KEY `fk_usa_state_adjacents_state_main_idx` (`usa_state_main_id`),
  KEY `fk_usa_state_adjacents_state_neighbor_idx` (`usa_state_neighbor_id`),
  CONSTRAINT `fk_state_adjacents_state_neighbor_id` FOREIGN KEY (`usa_state_neighbor_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usa_state_adjacents_state_main_id` FOREIGN KEY (`usa_state_main_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='table of states and their physically adjacent states';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_state_adjacents_created_at` BEFORE INSERT ON `usa_state_adjacents` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_state_totals`
--

DROP TABLE IF EXISTS `usa_state_totals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_state_totals` (
  `usa_state_totals_id` int NOT NULL AUTO_INCREMENT,
  `state_cases_max` int DEFAULT NULL,
  `state_cases_double_rate` int NOT NULL,
  `state_cases_7_day_avg` int NOT NULL,
  `state_deaths_max` int DEFAULT NULL,
  `state_deaths_double_rate` int NOT NULL,
  `state_deaths_7_day_avg` int NOT NULL,
  `usa_states_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_state_totals_id`),
  KEY `fk_usa_state_totals_usa_states_idx` (`usa_states_id`),
  CONSTRAINT `fk_usa_state_totals_usa_states_id` FOREIGN KEY (`usa_states_id`) REFERENCES `usa_states` (`usa_states_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table of state current totals for cases and deaths';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_state_totals_created_at` BEFORE INSERT ON `usa_state_totals` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usa_states`
--

DROP TABLE IF EXISTS `usa_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usa_states` (
  `usa_states_id` int NOT NULL AUTO_INCREMENT,
  `usa_states_name` varchar(45) NOT NULL,
  `usa_states_short` varchar(5) NOT NULL,
  `usa_states_pop` int NOT NULL,
  `usa_states_sq_mi` int NOT NULL,
  `state_fips` char(5) NOT NULL,
  `is_a_territory` char(3) DEFAULT 'No',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usa_states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='table of states, territories, etc and their statistics';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `init_usa_states_created_at` BEFORE INSERT ON `usa_states` FOR EACH ROW set new.created_at = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'sql_covid19'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `event_name` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `event_name` ON SCHEDULE EVERY 1 DAY STARTS '2020-05-10 01:00:00' ON COMPLETION NOT PRESERVE ENABLE DO # Your awesome query

-- ============================================
-- Fixing an incorrect county to state mapping
-- --------------------------------------------
-- update usa_counties set usa_states_id = 2
-- where usa_counties_id = 2872;
-- --------------------------------------------

-- ============================================
-- Updating fips fields
-- --------------------------------------------
-- UPDATE `usa_counties` SET `fips` = '1001'  where `usa_counties_name` = 'Autauga' and `usa_states_id` = 1;
-- UPDATE `usa_states` SET `state_fips` = '1'  where `usa_states_name` = 'Alabama';
-- --------------------------------------------


-- ============================================
-- Create usa_county_adjacents table for mapping
-- all counties with their immediate physical
-- neighbors
-- --------------------------------------------
-- CREATE TABLE `usa_county_adjacents` (
--   `usa_county_main_id` int NOT NULL,
--   `usa_county_neighbor_id` int NOT NULL,
--   `created_at` TIMESTAMP DEFAULT NULL,
--   `updated_at` TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
--   KEY `fk_usa_county_adjacents_county_main_idx` (`usa_county_main_id`),
--   KEY `fk_usa_county_adjacents_county_neighbor_idx` (`usa_county_neighbor_id`),
--   CONSTRAINT `fk_usa_county_adjacents_county_main_id` FOREIGN KEY (`usa_county_main_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
--   CONSTRAINT `fk_county_adjacents_county_neighbor_id` FOREIGN KEY (`usa_county_neighbor_id`) REFERENCES `usa_counties` (`usa_counties_id`) ON DELETE RESTRICT ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='table of counties and their physically adjacent counties';
-- create trigger init_usa_county_adjacents_created_at before insert on usa_county_adjacents for each row set new.created_at = now();
-- --------------------------------------------


-- ============================================
-- Admin stuff
-- --------------------------------------------
select database() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'sql_covid19'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-08 21:14:14
