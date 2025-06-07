-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `buyer_info`
--

DROP TABLE IF EXISTS `buyer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_info` (
  `buyer_id` int NOT NULL AUTO_INCREMENT,
  `buyer_name` varchar(200) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`buyer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_info`
--

LOCK TABLES `buyer_info` WRITE;
/*!40000 ALTER TABLE `buyer_info` DISABLE KEYS */;
INSERT INTO `buyer_info` VALUES (1,'Dominique\'s Auto Repair Shop','2065 Ironbark Dr','Oxnard','Dominique Dalanni'),(5,'Tom\'s Auto Repair Shop','123 Oxnard Blvd','Oxnard','Tom Allen'),(6,'Marshall The Auto Doctor','1 Saviers Rd.','Oxnard','Marshall');
/*!40000 ALTER TABLE `buyer_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer_order_shipping`
--

DROP TABLE IF EXISTS `buyer_order_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_order_shipping` (
  `shipping_id` int NOT NULL AUTO_INCREMENT,
  `ship_to_name` varchar(200) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `tracking_number` varchar(30) DEFAULT NULL,
  `shipping_status_id` int DEFAULT NULL,
  PRIMARY KEY (`shipping_id`),
  KEY `shipping_status_id` (`shipping_status_id`),
  CONSTRAINT `buyer_order_shipping_ibfk_1` FOREIGN KEY (`shipping_status_id`) REFERENCES `shipping_status` (`shipping_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_order_shipping`
--

LOCK TABLES `buyer_order_shipping` WRITE;
/*!40000 ALTER TABLE `buyer_order_shipping` DISABLE KEYS */;
INSERT INTO `buyer_order_shipping` VALUES (19,'Dominique\'s Auto Repair Shop','2065 Ironbark Dr','Oxnard','Dominique Dalanni',NULL,1),(20,'Garrison Dalanni','3940 Via Lucero','Santa Barbara','Garrison Dalanni',NULL,1);
/*!40000 ALTER TABLE `buyer_order_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer_po`
--

DROP TABLE IF EXISTS `buyer_po`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_po` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `buyer_id` int NOT NULL,
  `payment_status` tinyint(1) DEFAULT '0',
  `order_status` tinyint(1) DEFAULT '0',
  `warranty_start_date` date DEFAULT NULL,
  `shipping_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `shipping_id` (`shipping_id`),
  CONSTRAINT `buyer_po_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `buyer_info` (`buyer_id`),
  CONSTRAINT `shipping_id` FOREIGN KEY (`shipping_id`) REFERENCES `buyer_order_shipping` (`shipping_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_po`
--

LOCK TABLES `buyer_po` WRITE;
/*!40000 ALTER TABLE `buyer_po` DISABLE KEYS */;
INSERT INTO `buyer_po` VALUES (12,1,1,0,NULL,19),(13,1,1,0,NULL,20);
/*!40000 ALTER TABLE `buyer_po` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer_po_line_items`
--

DROP TABLE IF EXISTS `buyer_po_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_po_line_items` (
  `line_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `inventory_id` int NOT NULL,
  `customer_rating` int DEFAULT NULL,
  `quantity_ordered` int NOT NULL,
  `extended_revenue_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`line_item_id`),
  KEY `order_id` (`order_id`),
  KEY `inventory_id` (`inventory_id`),
  CONSTRAINT `buyer_po_line_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_po` (`order_id`),
  CONSTRAINT `buyer_po_line_items_ibfk_2` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_po_line_items`
--

LOCK TABLES `buyer_po_line_items` WRITE;
/*!40000 ALTER TABLE `buyer_po_line_items` DISABLE KEYS */;
INSERT INTO `buyer_po_line_items` VALUES (3,12,278,NULL,3,78.00),(4,12,272,NULL,1,53.00),(5,13,278,NULL,10,260.00),(6,13,272,NULL,12,636.00),(7,13,268,NULL,1,88.00);
/*!40000 ALTER TABLE `buyer_po_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer_return`
--

DROP TABLE IF EXISTS `buyer_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_return` (
  `buyer_return_id` int NOT NULL AUTO_INCREMENT,
  `return_received` tinyint(1) NOT NULL,
  `store_credit` tinyint(1) DEFAULT '0',
  `refund_check` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`buyer_return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_return`
--

LOCK TABLES `buyer_return` WRITE;
/*!40000 ALTER TABLE `buyer_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyer_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer_return_line_items`
--

DROP TABLE IF EXISTS `buyer_return_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_return_line_items` (
  `return_line_id` int NOT NULL AUTO_INCREMENT,
  `buyer_return_id` int NOT NULL,
  `line_item_id` int NOT NULL,
  `quantity_returned` int NOT NULL,
  `damaged` tinyint(1) DEFAULT '0',
  `defective` tinyint(1) DEFAULT '0',
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`return_line_id`),
  KEY `buyer_return_id` (`buyer_return_id`),
  KEY `line_item_id` (`line_item_id`),
  CONSTRAINT `buyer_return_line_items_ibfk_1` FOREIGN KEY (`buyer_return_id`) REFERENCES `buyer_return` (`buyer_return_id`),
  CONSTRAINT `buyer_return_line_items_ibfk_2` FOREIGN KEY (`line_item_id`) REFERENCES `buyer_po_line_items` (`line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_return_line_items`
--

LOCK TABLES `buyer_return_line_items` WRITE;
/*!40000 ALTER TABLE `buyer_return_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyer_return_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `buyerreturnstoinventory`
--

DROP TABLE IF EXISTS `buyerreturnstoinventory`;
/*!50001 DROP VIEW IF EXISTS `buyerreturnstoinventory`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `buyerreturnstoinventory` AS SELECT 
 1 AS `inventory_id`,
 1 AS `part_number`,
 1 AS `part_description`,
 1 AS `vendor_name`,
 1 AS `quantity_returned`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `highestreturnqty`
--

DROP TABLE IF EXISTS `highestreturnqty`;
/*!50001 DROP VIEW IF EXISTS `highestreturnqty`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `highestreturnqty` AS SELECT 
 1 AS `inventory_id`,
 1 AS `part_number`,
 1 AS `vendor_name`,
 1 AS `inventory_with_highest_return_qty`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `vendor_id` int NOT NULL,
  `part_id` int NOT NULL,
  `unit_cost` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `revenue` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `part_id` (`part_id`),
  CONSTRAINT `part_id` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`),
  CONSTRAINT `vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vendor_info` (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,1,44.00,846,71.00),(2,1,2,59.00,519,95.00),(3,1,3,53.00,365,84.00),(4,1,4,12.00,705,19.00),(5,1,5,19.00,984,30.00),(6,1,6,17.00,545,27.00),(7,1,7,14.00,260,23.00),(8,1,8,26.00,207,42.00),(9,1,9,35.00,515,56.00),(10,1,10,55.00,157,87.00),(11,1,11,48.00,237,77.00),(12,1,12,17.00,480,28.00),(13,1,13,33.00,879,52.00),(14,1,14,11.00,993,18.00),(15,1,15,57.00,599,92.00),(16,1,16,35.00,888,56.00),(17,1,17,48.00,611,76.00),(18,1,18,54.00,872,86.00),(19,1,19,56.00,934,89.00),(20,1,20,37.00,988,59.00),(21,1,21,17.00,593,28.00),(22,2,22,59.00,313,95.00),(23,2,23,15.00,366,24.00),(24,2,24,54.00,470,87.00),(25,2,25,42.00,977,67.00),(26,2,26,38.00,375,60.00),(27,2,27,11.00,591,18.00),(28,2,28,44.00,775,70.00),(29,2,29,35.00,426,56.00),(30,2,30,33.00,699,53.00),(31,2,31,10.00,366,17.00),(32,2,32,49.00,816,78.00),(33,2,33,38.00,588,61.00),(34,2,34,39.00,883,63.00),(35,2,35,12.00,791,18.00),(36,2,36,42.00,688,67.00),(37,2,37,21.00,353,33.00),(38,2,38,58.00,712,93.00),(39,2,39,16.00,804,26.00),(40,2,40,26.00,158,42.00),(41,2,41,42.00,908,67.00),(42,2,42,25.00,546,40.00),(43,2,43,34.00,681,55.00),(44,2,44,50.00,564,81.00),(45,2,45,55.00,92,88.00),(46,2,46,44.00,6,71.00),(47,2,47,18.00,937,29.00),(48,2,48,54.00,838,87.00),(49,2,49,21.00,266,33.00),(50,2,50,32.00,764,52.00),(51,2,51,50.00,559,80.00),(52,2,52,21.00,164,33.00),(53,2,53,60.00,555,95.00),(54,3,54,18.00,763,28.00),(55,3,55,29.00,603,47.00),(56,3,56,60.00,67,96.00),(57,3,57,16.00,529,26.00),(58,3,58,31.00,236,49.00),(59,3,59,38.00,616,61.00),(60,3,60,58.00,853,93.00),(61,3,61,50.00,114,80.00),(62,3,62,26.00,97,42.00),(63,3,63,55.00,596,88.00),(64,3,64,13.00,409,20.00),(65,3,65,18.00,966,29.00),(66,3,66,53.00,393,85.00),(67,3,67,39.00,488,62.00),(68,3,68,18.00,930,29.00),(69,3,69,30.00,792,47.00),(70,3,70,21.00,304,34.00),(71,3,71,10.00,958,16.00),(72,3,72,50.00,693,80.00),(73,3,73,59.00,313,94.00),(74,3,74,44.00,34,71.00),(75,3,75,20.00,617,32.00),(76,3,76,27.00,209,43.00),(77,3,77,37.00,70,58.00),(78,3,78,57.00,560,91.00),(79,3,79,18.00,276,29.00),(80,3,80,11.00,788,17.00),(81,3,81,24.00,459,39.00),(82,3,82,28.00,270,45.00),(83,3,83,22.00,325,35.00),(84,3,84,16.00,976,25.00),(85,3,85,53.00,899,84.00),(86,3,86,42.00,395,67.00),(87,3,87,11.00,441,17.00),(88,3,88,21.00,879,33.00),(89,3,89,23.00,500,37.00),(90,3,90,39.00,807,62.00),(91,3,91,30.00,494,49.00),(92,3,92,49.00,821,78.00),(93,3,93,10.00,344,16.00),(94,3,94,59.00,873,94.00),(95,3,95,35.00,212,56.00),(96,3,96,13.00,283,21.00),(97,3,97,27.00,848,43.00),(98,3,98,27.00,821,43.00),(99,3,99,15.00,731,24.00),(100,3,100,10.00,89,16.00),(101,3,101,34.00,303,54.00),(102,3,102,58.00,525,93.00),(103,3,103,19.00,211,30.00),(104,3,104,57.00,275,91.00),(105,3,105,51.00,295,82.00),(106,3,106,15.00,667,25.00),(107,3,107,16.00,334,25.00),(108,3,108,47.00,322,75.00),(109,3,109,22.00,886,35.00),(110,3,110,19.00,956,30.00),(111,3,111,16.00,30,26.00),(112,3,112,52.00,591,83.00),(113,3,113,19.00,476,30.00),(114,3,114,49.00,665,78.00),(115,3,115,29.00,64,46.00),(116,3,116,16.00,867,25.00),(117,3,117,39.00,117,62.00),(118,3,118,58.00,607,93.00),(119,3,119,12.00,991,19.00),(120,3,120,33.00,847,53.00),(121,3,121,47.00,17,75.00),(122,3,122,18.00,562,28.00),(123,3,123,57.00,300,91.00),(124,3,124,57.00,503,91.00),(125,3,125,38.00,656,61.00),(126,3,126,56.00,394,90.00),(127,3,127,37.00,704,60.00),(128,3,128,29.00,236,46.00),(129,3,129,23.00,945,36.00),(130,3,130,45.00,821,73.00),(131,3,131,51.00,857,81.00),(132,3,132,59.00,39,94.00),(133,3,133,19.00,41,31.00),(134,3,134,54.00,271,87.00),(135,3,135,45.00,835,72.00),(136,3,136,23.00,235,36.00),(137,3,137,36.00,56,57.00),(138,3,138,36.00,436,57.00),(139,3,139,25.00,124,39.00),(140,3,140,18.00,39,29.00),(141,3,141,11.00,634,18.00),(142,3,142,15.00,766,24.00),(143,3,143,19.00,471,30.00),(144,3,144,59.00,957,94.00),(145,3,145,59.00,222,95.00),(146,3,146,40.00,540,64.00),(147,3,147,56.00,159,90.00),(148,3,148,40.00,961,65.00),(149,3,149,59.00,574,94.00),(150,3,150,33.00,617,52.00),(151,3,151,51.00,420,81.00),(152,3,152,53.00,636,84.00),(153,3,153,21.00,39,33.00),(154,3,154,27.00,412,43.00),(155,3,155,26.00,781,41.00),(156,3,156,43.00,259,69.00),(157,3,157,33.00,934,52.00),(158,3,158,51.00,195,82.00),(159,3,159,27.00,882,43.00),(160,3,160,23.00,766,37.00),(161,3,161,27.00,751,43.00),(162,3,162,30.00,945,48.00),(163,3,163,25.00,160,40.00),(164,3,164,48.00,870,77.00),(165,3,165,13.00,684,21.00),(166,3,166,11.00,922,18.00),(167,3,167,30.00,613,48.00),(168,3,168,40.00,859,64.00),(169,3,169,18.00,579,28.00),(170,3,170,32.00,660,51.00),(171,3,171,23.00,249,37.00),(172,3,172,45.00,989,72.00),(173,3,173,44.00,909,70.00),(174,3,174,46.00,985,73.00),(175,3,175,31.00,893,50.00),(176,3,176,16.00,853,26.00),(177,3,177,25.00,465,39.00),(178,3,178,43.00,996,68.00),(179,3,179,39.00,50,63.00),(180,3,180,33.00,363,53.00),(181,3,181,26.00,532,42.00),(182,3,182,36.00,950,58.00),(183,3,183,50.00,617,79.00),(184,3,184,26.00,225,42.00),(185,3,185,46.00,434,73.00),(186,3,186,50.00,363,79.00),(187,3,187,42.00,311,67.00),(188,3,188,52.00,631,83.00),(189,3,189,34.00,539,55.00),(190,3,190,13.00,715,20.00),(191,3,191,28.00,660,45.00),(192,3,192,48.00,463,77.00),(193,3,193,36.00,914,57.00),(194,3,194,20.00,304,32.00),(195,3,195,37.00,231,58.00),(196,3,196,36.00,939,57.00),(197,3,197,38.00,198,60.00),(198,3,198,37.00,631,59.00),(199,3,199,28.00,983,45.00),(200,3,200,36.00,345,57.00),(201,3,201,41.00,161,65.00),(202,3,202,13.00,328,20.00),(203,3,203,50.00,282,80.00),(204,3,204,23.00,791,36.00),(205,3,205,43.00,289,69.00),(206,3,206,32.00,720,52.00),(207,3,207,20.00,670,31.00),(208,3,208,44.00,606,70.00),(209,3,209,57.00,794,92.00),(210,3,210,57.00,10,91.00),(211,3,211,44.00,658,70.00),(212,3,212,28.00,175,45.00),(213,3,213,14.00,264,23.00),(214,3,214,16.00,937,26.00),(215,3,215,38.00,612,61.00),(216,3,216,40.00,683,65.00),(217,3,217,24.00,416,38.00),(218,3,218,23.00,57,36.00),(219,3,219,30.00,219,48.00),(220,3,220,46.00,347,73.00),(221,3,221,51.00,630,82.00),(222,3,222,32.00,553,51.00),(223,3,223,16.00,445,25.00),(224,3,224,51.00,209,82.00),(225,3,225,40.00,625,63.00),(226,3,226,21.00,682,33.00),(227,3,227,17.00,513,27.00),(228,3,228,51.00,138,82.00),(229,3,229,27.00,957,44.00),(230,3,230,53.00,191,84.00),(231,3,231,37.00,635,59.00),(232,3,232,46.00,651,74.00),(233,3,233,49.00,880,78.00),(234,3,234,31.00,951,50.00),(235,3,235,15.00,337,23.00),(236,3,236,50.00,644,81.00),(237,4,237,25.00,552,41.00),(238,4,238,38.00,107,61.00),(239,4,239,34.00,111,54.00),(240,4,240,39.00,278,62.00),(241,4,241,18.00,269,28.00),(242,4,242,22.00,443,35.00),(243,4,243,11.00,519,17.00),(244,4,244,25.00,192,41.00),(245,4,245,52.00,867,83.00),(246,4,246,35.00,558,56.00),(247,4,247,18.00,262,29.00),(248,4,248,32.00,577,50.00),(249,4,249,50.00,340,79.00),(250,4,250,34.00,765,54.00),(251,4,251,23.00,479,37.00),(252,4,252,43.00,758,68.00),(253,4,253,51.00,400,81.00),(254,4,254,28.00,906,44.00),(255,4,255,25.00,222,39.00),(256,4,256,56.00,588,89.00),(257,4,257,59.00,506,94.00),(258,4,258,15.00,768,24.00),(259,4,259,56.00,142,90.00),(260,4,260,50.00,218,81.00),(261,4,261,10.00,37,16.00),(262,4,262,10.00,620,16.00),(263,4,263,44.00,32,70.00),(264,4,264,12.00,280,19.00),(265,4,265,15.00,397,23.00),(266,4,266,60.00,480,96.00),(267,4,267,59.00,259,94.00),(268,4,268,55.00,663,88.00),(269,4,269,19.00,197,31.00),(270,4,270,53.00,220,84.00),(271,4,271,46.00,750,74.00),(272,4,272,33.00,368,53.00),(273,4,273,48.00,118,77.00),(274,4,274,56.00,243,90.00),(275,4,275,15.00,444,25.00),(276,4,276,30.00,405,48.00),(277,4,277,38.00,163,61.00),(278,4,278,16.00,567,26.00),(279,4,279,42.00,439,67.00),(280,4,280,56.00,520,89.00),(281,4,281,18.00,87,29.00),(282,4,282,26.00,528,41.00),(283,4,283,56.00,890,89.00),(284,4,284,23.00,543,37.00),(285,4,285,57.00,993,91.00),(286,4,286,10.00,845,17.00),(287,4,287,14.00,250,23.00),(288,4,288,44.00,400,71.00),(289,4,289,42.00,554,66.00),(290,4,290,35.00,356,56.00),(291,4,291,44.00,655,70.00),(292,4,292,37.00,830,59.00),(293,4,293,48.00,566,77.00),(294,4,276,22.00,349,36.00),(295,4,295,38.00,407,61.00),(296,4,296,26.00,353,42.00),(297,4,297,23.00,972,37.00),(298,4,298,31.00,481,49.00),(299,4,299,39.00,712,63.00),(300,4,300,25.00,658,40.00),(301,4,301,51.00,424,81.00),(302,4,302,39.00,731,62.00),(303,4,303,49.00,805,79.00),(304,4,304,10.00,907,17.00),(305,4,305,55.00,842,87.00),(306,4,306,13.00,919,21.00),(307,4,307,35.00,157,55.00),(308,4,308,53.00,605,84.00),(309,4,309,13.00,177,20.00),(310,4,310,60.00,852,95.00),(311,4,311,52.00,64,83.00),(312,4,312,24.00,204,38.00),(313,4,313,43.00,257,69.00),(314,4,314,18.00,75,29.00),(315,4,315,29.00,814,47.00),(316,4,316,46.00,726,74.00),(317,4,317,19.00,209,30.00),(318,4,318,58.00,712,94.00),(319,4,319,51.00,871,82.00),(320,5,320,11.00,719,17.00),(321,5,321,22.00,75,36.00),(322,5,322,45.00,311,72.00),(323,5,323,16.00,227,25.00),(324,5,324,46.00,544,73.00),(325,5,325,44.00,242,70.00),(326,5,326,56.00,861,90.00),(327,5,327,29.00,415,46.00),(328,5,328,54.00,763,87.00),(329,5,329,25.00,805,40.00),(330,5,330,33.00,80,53.00),(331,5,331,18.00,375,28.00),(332,5,332,10.00,599,16.00),(333,5,333,35.00,732,57.00),(334,5,334,38.00,468,61.00),(335,5,335,20.00,355,31.00),(336,5,336,40.00,33,63.00),(337,5,337,44.00,148,70.00),(338,5,338,46.00,824,73.00),(339,5,339,31.00,748,49.00),(340,5,340,26.00,878,41.00),(341,5,341,45.00,965,72.00),(342,5,342,13.00,842,21.00),(343,5,343,33.00,175,53.00),(344,5,344,48.00,309,77.00),(345,5,345,39.00,212,63.00),(346,5,346,38.00,155,61.00),(347,5,347,31.00,249,49.00),(348,5,348,31.00,898,50.00),(349,5,349,37.00,755,58.00),(350,5,350,58.00,187,93.00),(351,5,351,53.00,157,84.00),(352,5,352,21.00,559,34.00),(353,5,353,45.00,625,72.00),(354,5,354,43.00,59,70.00),(355,5,355,22.00,954,35.00),(356,5,356,37.00,288,59.00),(357,5,357,58.00,917,93.00),(358,5,358,37.00,179,58.00),(359,5,359,30.00,326,48.00),(360,5,360,58.00,398,93.00),(361,5,361,47.00,928,76.00),(362,5,362,29.00,84,47.00),(363,5,363,16.00,32,26.00),(364,5,364,33.00,740,52.00),(365,5,365,41.00,646,65.00),(366,5,366,45.00,239,73.00),(367,5,367,41.00,720,66.00),(368,5,368,16.00,391,26.00),(369,5,369,29.00,796,47.00),(370,5,370,35.00,536,56.00),(371,5,371,46.00,318,74.00),(372,5,372,27.00,499,43.00),(373,5,373,32.00,766,51.00),(374,5,374,59.00,977,94.00),(375,5,375,28.00,266,46.00),(376,5,376,52.00,111,83.00),(377,5,377,17.00,815,27.00),(378,5,378,14.00,416,22.00),(379,5,379,20.00,759,32.00),(380,5,380,45.00,524,73.00),(381,5,381,48.00,495,77.00),(382,5,382,57.00,523,92.00),(383,5,383,41.00,459,65.00),(384,5,384,40.00,668,64.00),(385,5,385,46.00,95,74.00),(386,5,386,18.00,533,29.00),(387,5,387,48.00,471,77.00),(388,5,388,54.00,809,87.00),(389,5,389,38.00,137,60.00),(390,5,390,16.00,985,26.00),(391,5,391,59.00,607,94.00),(392,5,392,39.00,266,62.00),(393,5,393,21.00,335,33.00),(394,5,394,29.00,174,46.00),(395,5,395,32.00,662,52.00),(396,5,396,59.00,562,95.00),(397,5,397,53.00,999,84.00),(398,5,398,39.00,211,62.00),(399,5,399,41.00,937,66.00),(400,5,400,20.00,371,31.00),(401,5,401,46.00,314,73.00),(402,5,402,33.00,892,52.00),(403,5,403,10.00,598,16.00),(404,5,404,21.00,365,33.00),(405,5,405,56.00,162,90.00),(406,5,406,15.00,391,24.00),(407,5,407,16.00,454,26.00),(408,5,408,40.00,21,64.00),(409,5,409,35.00,288,56.00),(410,5,410,32.00,551,52.00),(411,5,411,28.00,871,44.00),(412,5,412,13.00,672,21.00),(413,5,413,34.00,925,55.00),(414,5,414,27.00,861,43.00),(415,5,415,12.00,969,19.00),(416,5,416,16.00,314,25.00),(417,5,417,53.00,325,86.00),(418,5,418,23.00,869,37.00),(419,5,419,60.00,593,96.00),(420,5,420,45.00,812,72.00),(421,5,421,60.00,921,96.00),(422,5,422,56.00,116,89.00),(423,5,423,39.00,339,63.00),(424,5,424,40.00,360,64.00),(425,5,425,16.00,392,25.00),(426,5,426,28.00,541,44.00),(427,5,427,20.00,651,32.00),(428,5,428,37.00,90,59.00),(429,5,429,12.00,629,19.00),(430,5,430,28.00,816,45.00),(431,5,431,43.00,202,69.00),(432,5,432,31.00,426,50.00),(433,5,433,29.00,864,46.00),(434,5,434,14.00,763,23.00),(435,5,435,59.00,845,94.00),(436,5,436,58.00,147,92.00),(437,5,437,15.00,79,25.00),(438,5,438,44.00,411,71.00),(439,5,439,50.00,682,80.00),(440,5,440,35.00,651,56.00),(441,5,441,25.00,55,41.00),(442,5,442,11.00,192,17.00),(443,5,443,16.00,324,25.00),(444,5,444,30.00,513,48.00),(445,5,445,31.00,182,49.00),(446,5,446,42.00,734,68.00),(447,5,447,17.00,609,27.00),(448,5,448,33.00,923,53.00),(449,5,449,45.00,407,72.00),(450,5,450,59.00,474,95.00),(451,5,451,48.00,857,76.00),(452,5,452,42.00,208,67.00),(453,5,453,37.00,795,59.00),(454,5,454,14.00,46,23.00),(455,5,455,30.00,658,48.00),(456,5,456,12.00,420,19.00),(457,5,457,43.00,602,69.00),(458,5,458,57.00,802,91.00),(459,5,459,30.00,669,48.00),(460,5,460,43.00,858,69.00),(461,5,461,57.00,432,92.00),(462,5,462,12.00,409,20.00),(463,5,463,24.00,683,39.00),(464,5,464,16.00,295,26.00),(465,5,465,55.00,910,87.00),(466,5,466,45.00,172,72.00),(467,5,467,18.00,785,29.00),(468,5,468,40.00,367,64.00),(469,5,469,54.00,852,86.00),(470,5,470,30.00,679,48.00),(471,5,471,12.00,680,19.00),(472,5,472,22.00,509,36.00),(473,5,473,20.00,868,31.00),(474,5,474,24.00,194,38.00),(475,5,475,50.00,943,79.00),(476,5,476,44.00,739,71.00),(477,5,477,57.00,830,91.00),(478,5,478,19.00,347,30.00),(479,5,479,56.00,171,89.00),(480,5,480,24.00,649,38.00),(481,5,481,21.00,528,34.00),(482,5,482,25.00,658,41.00),(483,5,483,45.00,176,72.00),(484,5,484,60.00,942,96.00),(485,5,485,32.00,737,52.00),(486,5,486,57.00,738,91.00),(487,5,487,53.00,597,85.00),(488,5,488,39.00,62,63.00),(489,6,489,17.00,199,27.00),(490,6,490,48.00,297,76.00),(491,6,491,13.00,294,21.00),(492,6,492,44.00,49,70.00),(493,6,493,34.00,293,55.00),(494,6,494,50.00,179,81.00),(495,6,495,44.00,773,70.00),(496,6,496,16.00,46,25.00),(497,6,497,43.00,412,69.00),(498,6,498,59.00,479,95.00);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `inventoryreturntotals`
--

DROP TABLE IF EXISTS `inventoryreturntotals`;
/*!50001 DROP VIEW IF EXISTS `inventoryreturntotals`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `inventoryreturntotals` AS SELECT 
 1 AS `inventory_id`,
 1 AS `part_number`,
 1 AS `vendor_name`,
 1 AS `total_returned`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `part_category`
--

DROP TABLE IF EXISTS `part_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `part_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `part_category` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_category`
--

LOCK TABLES `part_category` WRITE;
/*!40000 ALTER TABLE `part_category` DISABLE KEYS */;
INSERT INTO `part_category` VALUES (1,'frame'),(2,'wheel'),(3,'glass'),(4,'door'),(5,'light'),(6,'accessory'),(7,'system'),(8,'engine'),(9,'seat');
/*!40000 ALTER TABLE `part_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts` (
  `part_id` int NOT NULL AUTO_INCREMENT,
  `part_number` int NOT NULL,
  `part_name` varchar(50) DEFAULT NULL,
  `part_description` varchar(300) DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`part_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `part_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parts`
--

LOCK TABLES `parts` WRITE;
/*!40000 ALTER TABLE `parts` DISABLE KEYS */;
INSERT INTO `parts` VALUES (1,11380316,'Quarter-panel','side panel',1),(2,11380317,'Front-wheel','front wheel for vehicle',2),(3,11380318,'Back-window','back window for vehicle',3),(4,11380319,'Trunk','trunk shell',1),(5,11380320,'Front-door','door front passenger',4),(6,11380321,'Rocker-panel','overhead panel',1),(7,11380322,'Grille','exsterior bumper',1),(8,11380323,'Windshield','front windshield',3),(9,11380324,'Front-window','front window for vehicle',3),(10,11380325,'Back-door','back door for vehicle',4),(11,11380326,'Headlight','light for vehicle',5),(12,11380327,'Back-wheel','back wheel for vehicle',2),(13,11380328,'Back-windshield','back windshield',5),(14,11380329,'Hood','exterior top of vehicle',1),(15,11380330,'Fender','rear bumper of vehicle',1),(16,11380331,'Tail-light','back light of vehicle',5),(17,11380332,'License-plate','custom license plate',6),(18,11380333,'Front-bumper','front bumper enlarged',1),(19,11380334,'Back-bumper','back bumper enlarged',1),(20,11380335,'Mirror','rear view mirror',3),(21,11380336,'Roof','interior roof of vehicle',1),(22,83362497,'Bonnet/hood','Bonnet/hood',1),(23,81335544,'Bonnet/hood latch','Bonnet/hood latch',1),(24,87024201,'Bumper','Bumper',1),(25,83749482,'Unexposed bumper','Unexposed bumper',1),(26,83935988,'Exposed bumper','Exposed bumper',1),(27,86741040,'Cowl screen','Cowl screen',7),(28,89959047,'Decklid','Decklid',8),(29,84205813,'Fascia','Fascia rear and support',7),(30,80708317,'Fender Wing','Fender wing or mudguard',1),(31,80399108,'Front clip','front clip to bumper',1),(32,87182967,'Fascia header panel','Front fascia and header panel',1),(33,80819755,'Pillar and hard trim','Pillar and hard trim',7),(34,82314700,'Quarter panel','Quarter panel',7),(35,88592616,'Radiator core clip','Radiator core support',8),(36,88826105,'Rocker panel','Rocker panel',8),(37,86756307,'Roof rack','Roof rack',6),(38,85288310,'Spoiler','Spoiler',7),(39,83366477,'Front spoiler','Front spoiler air dam',7),(40,83549855,'Rear spoiler','Rear spoiler wing',7),(41,81642102,'Rims','wheel rims',2),(42,80792528,'Hubcap','wheel hubcap',2),(43,84403411,'Tire','wheel tire',2),(44,86429122,'Trim package','Trim package',1),(45,83154793,'Trunk boot hatch','Trunk boot hatch',1),(46,84361529,'Trunk boot latch','Trunk boot latch',8),(47,83455609,'Valance','Valance',8),(48,82485140,'Welded assembly','Welded assembly',7),(49,81967403,'Outer door handle','Outer door handle',1),(50,87755931,'Inner door handle','Inner door handle',1),(51,83477521,'Door control module','Door control module',1),(52,83533788,'Door seal','Door seal',1),(53,85491052,'Door watershield','Door watershield',1),(54,61985435,'Hinge','Hinge',1),(55,67623536,'Door latch','Door latch',1),(56,66468200,'Door lock','Door lock and power door locks',1),(57,68652297,'Center-locking','Center-locking',7),(58,61137547,'Fuel tank door','Fuel tank or fuel filler door',7),(59,62450977,'Glass window','glass window replacement',3),(60,64416486,'Sunroof','replacement sun roof',3),(61,67544563,'Sunroof motor','Sunroof motor',7),(62,67448355,'Window motor','Window motor',7),(63,66209331,'Window regulator','Window regulator',7),(64,63717950,'Windshield windscreen','Windshield also called windscreen',3),(65,68809489,'Windshield washer motor','Windshield washer motor',7),(66,63993413,'Window seal','Window seal',7),(67,67055284,'Antenna assembly','Antenna assembly',7),(68,60452048,'Antenna cable','Antenna cable',7),(69,67564380,'Radio and media player','Radio and media player',6),(70,63055174,'Speaker','front speaker',6),(71,61499877,'Speaker','back speaker',6),(72,69189968,'Tuner','Tuner',6),(73,63331461,'Subwoofer','Subwoofer',6),(74,62829135,'Alternator','Alternator',8),(75,62423358,'Alternator bearing','Alternator bearing',8),(76,64596746,'Alternator bracket','Alternator bracket',8),(77,68738768,'Alternator fan','Alternator fan',8),(78,66078009,'Other alternator parts','Other alternator parts',8),(79,66452633,'Battery','Battery',7),(80,65650078,'Performance battery','Performance battery',7),(81,65150722,'Battery box','Battery box',7),(82,66867969,'Battery cable terminal','Battery cable terminal',7),(83,61325473,'Battery cable','Battery cable',7),(84,68340038,'Battery control system','Battery control system',7),(85,60255958,'Battery plate','Battery plate',7),(86,60481254,'Battery tray','Battery tray',7),(87,60051167,'Voltage regulator','Voltage regulator',7),(88,67913816,'Ammeter','Ammeter',7),(89,64429729,'Clinometer','Clinometer',7),(90,67196687,'Dynamometer','Dynamometer',7),(91,62844920,'Fuel gauge','Fuel gauge',7),(92,68623724,'Hydrometer','Hydrometer',7),(93,65616782,'Odometer milometer','Odometer also called milometer or mileometers',7),(94,63115226,'Speedometer','Speedometer',7),(95,65808555,'Tachometer','tachometer is also called rev counters',7),(96,66223906,'Temperature gauge','Temperature gauge',7),(97,65852984,'Tire pressure gauge','Tire pressure gauge',7),(98,69169875,'Vacuum gauge','Vacuum gauge',7),(99,61813696,'Voltmeter','Voltmeter',7),(100,66599634,'Water temperature meter','Water temperature meter',7),(101,66413509,'Coil wire','Coil wire',7),(102,64985542,'Distributor','Distributor',7),(103,68779331,'Electronic timing controller','Electronic timing controller',7),(104,61389736,'Ignition box','Ignition box',7),(105,68830550,'Ignition coil','Ignition coil',7),(106,69542626,'Ignition coil parts','Ignition coil parts',7),(107,60955242,'Ignition magneto','Ignition magneto',7),(108,61715210,'Spark plug','Spark plug',7),(109,68632201,'Engine bay lighting','Engine bay lighting',8),(110,65201487,'Fog light','Fog light also called foglamp',5),(111,64459981,'Halogen','Halogen',5),(112,63644916,'Standard Headlight','Headlight also called headlamp',5),(113,67074594,'Headlight motor','Headlight motor',5),(114,65494334,'Interior light and lamp','Interior light and lamp',5),(115,60404487,'License plate lamp ','License plate lamp ',5),(116,68821223,'Side lighting','Side lighting',5),(117,67048701,'Tail light','Tail light',5),(118,67215287,'Tail light cover','Tail light cover',5),(119,61151926,'Airbag sensors','Airbag sensors',7),(120,69040632,'Automatic transmission speed sensor','Automatic transmission speed sensor',7),(121,60938491,'Camshaft position sensor','Camshaft position sensor',7),(122,63611247,'Coolant temperature sensor','Coolant temperature sensor',7),(123,60847310,'Crankshaft position sensor','Crankshaft position sensor',7),(124,67611066,'Engine sensor','Engine sensor',7),(125,64893097,'Fuel level sensor','Fuel level sensor',7),(126,64067410,'Fuel Pressure sensor','Fuel Pressure sensor',7),(127,69841230,'Knock sensor','Knock sensor',7),(128,63156681,'Light sensor','Light sensor',7),(129,69332526,'Oil level sensor','Oil level sensor',7),(130,60844789,'Oil pressure sensor','Oil pressure sensor',7),(131,61912702,'Mass flow sensor','Mass flow sensor',7),(132,61621265,'Starter','Starter',7),(133,66237169,'Starter drive','Starter drive',7),(134,61281017,'Starter motor','Starter motor',7),(135,68445674,'Starter solenoid','Starter solenoid',7),(136,67884742,'Glowplug','Glowplug',7),(137,69345613,'Door switch','Door switch',7),(138,63963055,'Ignition switch','Ignition switch',7),(139,67108813,'Power window switch','Power window switch',7),(140,60580554,'Steering column switch','Steering column switch',7),(141,65891857,'Switch cover','Switch cover',7),(142,65084948,'Switch panel','Switch panel',7),(143,63387104,'Thermostat','Thermostat',7),(144,60069807,'Frame switch','Frame switch',7),(145,61252627,'Starter system function','Parts and functions of starter system',7),(146,63294784,'Air conditioning harness','Air conditioning harness',7),(147,66314648,'Engine compartment harness','Engine compartment harness',7),(148,60589814,'Interior harness','Interior harness',7),(149,61648007,'Main harness','Main harness',7),(150,65797474,'floor harness','floor harness',7),(151,60186822,'control harness','control harness',7),(152,61308244,'Air bag control module','Air bag control module',7),(153,67532627,'Alarm and siren','Alarm and siren',7),(154,65880113,'Central locking system','Central locking system',7),(155,64326734,'Chassis control computer','Chassis control computer',7),(156,65499554,'Cruise control computer','Cruise control computer',7),(157,61139338,'Door contact','Door contact',7),(158,67478717,'Engine main computer','Engine computer management system',7),(159,60980084,'ECU','Engine control unit',7),(160,63101521,'Fuse','fuse for primary cirucuitry',7),(161,62360015,'Fuse box','box enclosue for fuses',7),(162,62219276,'Ground strap','Ground strap',7),(163,64885328,'Grab Handle','Grab Handle',7),(164,69383043,'Performance chip','Performance chip',7),(165,67803869,'Performance monitor','Performance monitor',7),(166,64538687,'Relay connector','Relay connector',7),(167,61307589,'Remote lock','Remote lock',7),(168,67702753,'Shift improver','Shift improver',7),(169,69832548,'Speed controller','Speed controller',7),(170,67534482,'Speedometer calibrator','Speedometer calibrator',7),(171,64468921,'Transmission computer','Transmission computer',7),(172,67673164,'Wiring connector','Wiring connector',7),(173,69749703,'Dash Panels','Dash Panels',7),(174,60515982,'Carpet and other floor material','Carpet and other floor material',7),(175,66649997,'Center console','Center console',7),(176,64405713,'Trap','Trap for oil release',7),(177,62790160,'Arm Rest','Arm Rest',9),(178,66861153,'Bench seat','Bench seat',9),(179,68169313,'Bucket seat','Bucket seat',9),(180,69502329,'Infant restraint system','Children and baby car seat',9),(181,60008616,'Fastener','Fastener',9),(182,68824762,'Headrest','Headrest',9),(183,67741174,'Seat belt','Seat belt',9),(184,68590560,'Seat bracket','Seat bracket',9),(185,63587175,'Seat cover','Seat cover',9),(186,67550090,'Seat track','Seat track',9),(187,65589387,'Seat components','additional seat components',9),(188,62436180,'ABS','Anti-lock braking system',7),(189,64220030,'ABS steel pin','Anti-lock braking system steel pin',7),(190,69743598,'Adjusting mechanism ','adjuster star wheel',7),(191,63964046,'Anchor','Anchor',7),(192,64555852,'Bleed nipple','Bleed nipple',7),(193,63100084,'Brake backing plate','Brake backing plate',7),(194,62068880,'Brake backing pad','Brake backing pad',7),(195,67057432,'Brake cooling duct','Brake cooling duct',7),(196,63923188,'Brake disc','Brake disc',7),(197,63369660,'Brake drum','Brake drum',7),(198,67723781,'Brake line cable','Brake line cable',7),(199,65467008,'Brake pad','Brake pad',7),(200,67484907,'Brake pedal','Brake pedal',7),(201,61541423,'Brake piston','Brake piston',7),(202,65913091,'Brake pump','Brake pump',7),(203,62449090,'Brake roll','Brake roll',7),(204,60204747,'Brake rotor','Brake rotor',7),(205,66327455,'Brake servo','Brake servo',7),(206,68487055,'Brake shoe','Brake shoe',7),(207,63013182,'Brake lining','Brake lining',7),(208,67076050,'Shoe web','Shoe web',7),(209,69820443,'Brake warning light','Brake warning light',7),(210,60459363,'Calibrated friction brake','Calibrated friction brake',7),(211,61863129,'Caliper','Caliper',7),(212,67010412,'Combination valve','Combination valve',7),(213,62887477,'Dual circuit brake system','Dual circuit brake system',7),(214,69699882,'Hold-down springs','retainer springs',7),(215,67817965,'Hose','Hose',7),(216,65132240,'Brake booster hose','Brake booster hose',7),(217,63886819,'Air brake nylon hose','Air brake nylon hose',7),(218,67457937,'Brake duct hose','Brake duct hose',7),(219,69498438,'Hydraulic booster unit','Hydraulic booster unit',7),(220,65365666,'Load-sensing valve','Load-sensing valve',7),(221,63327759,'Master cylinder','Master cylinder',7),(222,61257623,'Metering valve','Metering valve',7),(223,65174503,'Other braking system parts','Other braking system parts',7),(224,61703349,'Park lever','Park brake lever/handle (hand brake)',7),(225,64110408,'Pressure differential valve','Pressure differential valve',7),(226,60034476,'Proportioning valve','Proportioning valve',7),(227,67871946,'Reservoir','Reservoir',7),(228,60007554,'Shoe return spring','Shoe return spring',7),(229,68529004,'Tyre','Tyre',7),(230,62201137,'Vacuum brake booster','Vacuum brake booster',7),(231,66812125,'Wheel cylinder','slave cylinder',7),(232,62130035,'Wheel stud','Wheel stud',7),(233,61074493,'Diesel engine','Diesel engine',8),(234,62299534,' petrol engine ','gasoline engine',8),(235,60049588,'Accessory belt','Accessory belt',8),(236,66017923,'Air duct','Air duct',8),(237,5409,'Air intake housing','Air intake housing',8),(238,5617,'Air intake manifold','Air intake manifold',8),(239,5831,'Camshaft','Camshaft',8),(240,5754,'Camshaft bearing','Camshaft bearing',8),(241,5552,'Camshaft fastener','Camshaft fastener',8),(242,5520,'Camshaft follower','Camshaft follower',8),(243,5845,'Camshaft locking plate','Camshaft locking plate',8),(244,5196,'Camshaft pushrod','Camshaft pushrod',8),(245,5169,'Camshaft spacer ring','Camshaft spacer ring',8),(246,5941,'Connecting rod','Connecting rod',8),(247,5448,'Connecting rod bearing','Connecting rod bearing',8),(248,5311,'Connecting rod bolt','Connecting rod bolt',8),(249,5077,'Connecting rod washer','Connecting rod washer',8),(250,5918,'Crank case','Crank case',8),(251,5697,'Crank pulley','Crank pulley',8),(252,5776,'Crankshaft','Crankshaft',8),(253,5260,'Crankshaft oil seal','Crankshaft oil seal',8),(254,5272,'Cylinder head','Cylinder head',8),(255,5271,'Cylinder head cover','Cylinder head cover',8),(256,5527,'Cylinder head gasket','Cylinder head gasket',8),(257,5030,'Distributor cap','Distributor cap',8),(258,5693,'Drive belt','Drive belt',8),(259,5093,'Engine block','Engine block',8),(260,5329,'Engine cradle','Engine cradle',8),(261,5048,'Engine shake damper','Engine shake damper',8),(262,5221,'Engine valve','Engine valve',8),(263,5101,'Fan belt','Fan belt',8),(264,5958,'Gudgeon pin','wrist pin',8),(265,5545,'Harmonic balancer','Harmonic balancer',7),(266,5286,'Heater','Heater',7),(267,5149,'Mounting','Mounting',8),(268,5061,'Piston','Piston',8),(269,5748,'Pins','Piston pin and crank pin',8),(270,5798,'Piston pin bush','Piston pin bush',8),(271,5560,'Piston ring and circlip','Piston ring and circlip',8),(272,5025,'Poppet valve','Poppet valve',8),(273,5180,'PCV valve','positive crankcase ventilation valve',8),(274,5236,'Pulley part','Pulley part',8),(275,5855,'Rocker arm','Rocker arm',8),(276,5965,'Rocker cover','Rocker cover',8),(277,5751,'Starter pinion','Starter pinion',8),(278,5019,'Starter ring','Starter ring',8),(279,5614,'Turbocharger','Turbocharger and supercharger',8),(280,5899,'Tappet','Tappet',8),(281,5515,'Timing tape','Timing tape',8),(282,5576,'Valve cover','Valve cover',8),(283,5807,'Valve housing','Valve housing',8),(284,5164,'Valve spring','Valve spring',8),(285,5583,'Valve stem seal','Valve stem seal',8),(286,5144,'Water pump pulley','Water pump pulley',7),(287,5449,'Air blower','Air blower',7),(288,5139,'Coolant hose','Coolant hose',7),(289,5266,'Cooling fan','Cooling fan',7),(290,5932,'Fan blade','Fan blade',7),(291,5212,'Fan clutch','Fan clutch',7),(292,5275,'Radiator','Radiator',7),(293,5772,'Radiator bolt','Radiator bolt',7),(294,5965,'Radiator shroud','Radiator fan shroud',7),(295,5060,'Radiator gasket','Radiator gasket',8),(296,5173,'Radiator pressure cap','Radiator pressure cap',8),(297,5131,'Overflow tank','Overflow tank',8),(298,5242,'Water neck','Water neck',8),(299,5777,'Water neck o-ring','Water neck o-ring',8),(300,5290,'Water pipe','Water pipe',8),(301,5308,'Water pump','Water pump',8),(302,5172,'Water pump gasket','Water pump gasket',8),(303,5224,'Water tank','Water tank',8),(304,5442,'Oil filter','Oil filter',8),(305,5757,'Oil gasket','Oil gasket',8),(306,5348,'Oil pan','Oil pan',8),(307,5729,'Oil pipe','Oil pipe',8),(308,5795,'Oil pump','Oil pump',8),(309,5620,'Oil strainer','Oil strainer',8),(310,5332,'Catalytic converter','Catalytic converter',8),(311,5325,'Exhaust clamp and bracket','Exhaust clamp and bracket',8),(312,5755,'Exhaust flange gasket','Exhaust flange gasket',8),(313,5841,'Exhaust gasket','Exhaust gasket',8),(314,5184,'Exhaust manifold','Exhaust manifold',8),(315,5837,'Exhaust manifold gasket','Exhaust manifold gasket',8),(316,5197,'Exhaust pipe','Exhaust pipe',8),(317,5952,'Heat shield','Heat shield',8),(318,5691,'Heat sleeving and tape','Heat sleeving and tape',8),(319,5802,'Resonator','Resonator',8),(320,15249,'Muffler silencer','muffler silencer',7),(321,15967,'Spacer ring','Spacer ring',7),(322,13026,'ely','ely',7),(323,14537,'Air filter','Air filter',7),(324,15336,'Carburetor','Carburetor',7),(325,13989,'Carburetor parts','Carburetor parts',7),(326,14729,'Choke cable','Choke cable',7),(327,12855,'EGR valve','EGR valve',7),(328,12120,'Fuel cap','Fuel cap',7),(329,15352,'Fuel cell','Fuel cell',7),(330,14811,'Fuel cell component','Fuel cell component',7),(331,15726,'Fuel cooler','Fuel cooler',7),(332,13191,'Fuel distributor','Fuel distributor',7),(333,15143,'Fuel filter','Fuel filter',7),(334,12844,'Fuel filter seal','Fuel filter seal',7),(335,14932,'Fuel injector','Fuel injector',7),(336,14020,'Fuel injector nozzle','Fuel injector nozzle',7),(337,14329,'Fuel pump','Fuel pump',7),(338,12480,'Fuel pump gasket','Fuel pump gasket',7),(339,14988,'Fuel pressure regulator','Fuel pressure regulator',7),(340,14042,'Fuel rail','Fuel rail',7),(341,15994,'Fuel tank','Fuel tank',7),(342,12984,'Fuel tank cover','Fuel tank cover',7),(343,15499,'Fuel water separator','Fuel water separator',7),(344,15585,'Intake manifold','Intake manifold',7),(345,12204,'Intake manifold gasket','Intake manifold gasket',7),(346,13795,'LPG system assembly','liquefied petroleum gas system assembly',7),(347,14863,'Throttle body','Throttle body',7),(348,15503,'Beam axle','Beam axle',7),(349,14594,'Control arm','Control arm',7),(350,12682,'Constant-velocity axle','Constant-velocity axle',7),(351,15635,'Constant-velocity joint','Constant-velocity joint',7),(352,15436,'Idler arm','Idler arm',7),(353,14788,'Kingpin','Kingpin',7),(354,15998,'Panhard rod','Panhard rod',7),(355,15789,'Pitman arm','Pitman arm',7),(356,15244,'Power steering assembly','Power steering assembly and components',7),(357,15807,'Rack end','Rack end',7),(358,15271,'Shock absorber','Shock absorber',7),(359,15535,'Spindle','Spindle',7),(360,14201,'Spring','Spring',7),(361,15559,'Air spring','Air spring',7),(362,12347,'Coil spring','Coil spring',7),(363,13894,'Parabolic leaf spring','Leaf and parabolic leaf spring',7),(364,15217,'Rubber spring','Rubber spring',7),(365,15186,'Spiral spring','Spiral spring',7),(366,12178,'Stabilizer bars and link','Stabilizer bars and link',7),(367,13956,'Steering arm','Steering arm',7),(368,13716,'Steering box','Steering box',7),(369,14462,'Steering column assembly','Steering column assembly',7),(370,12081,'Steering rack',' a form of steering gear see also rack and pinion and recirculating ball',7),(371,14786,'Steering shaft','Steering shaft',7),(372,14495,'Steering wheel','driving wheel',7),(373,14059,'Strut','Strut',7),(374,14170,'Stub axle','Stub axle',7),(375,12762,'Suspension link and bolt','Suspension link and bolt',7),(376,13367,'Tie bar','Tie bar',7),(377,12959,'Tie rod','Tie rod',7),(378,15894,'Tie rod end','Tie rod end',7),(379,15159,'Trailing arm','Trailing arm',7),(380,12048,'Adjustable pedal','Adjustable pedal',7),(381,12559,'Axle shaft','Axle shaft',7),(382,14607,'Bell housing','Bell housing',7),(383,13646,'Cam belt','Cam belt',7),(384,15317,'Other belts','Other belts',7),(385,15762,'Carrier assembly','Carrier assembly',7),(386,15924,'Chain wheel and sprocket','Chain wheel and sprocket',7),(387,13614,'Clutch assembly','Clutch assembly',7),(388,13389,'Clutch cable','Clutch cable',7),(389,12716,'Clutch disk','Clutch disk',7),(390,15676,'Clutch fan','Clutch fan',7),(391,15889,'Clutch fork','Clutch fork',7),(392,14079,'Clutch hose','Clutch hose',7),(393,12213,'Clutch lever','Clutch lever',7),(394,15410,'Clutch lining','Clutch lining',7),(395,13064,'Clutch pedal','Clutch pedal',7),(396,14370,'Clutch pressure plate','Clutch pressure plate',7),(397,14954,'Clutch shoe','Clutch shoe',7),(398,13185,'Clutch spring','Clutch spring',7),(399,13264,'Differential','Differential',7),(400,15128,'Differential case','Differential case',7),(401,14995,'Pinion bearing','Pinion bearing',7),(402,12551,'Differential clutch','Differential clutch',7),(403,13482,'Spider gears','Spider gears',7),(404,13736,'Differential casing','Differential casing',7),(405,12041,'Differential flange','Differential flange',7),(406,15883,'Differential gear','Differential gear',7),(407,12705,'Differential seal','Differential seal',7),(408,15681,'Flywheel','Flywheel',7),(409,12235,'Flywheel ring gear','Flywheel ring gear',7),(410,13645,'Gear','Gear',7),(411,14051,'Gear coupling','Gear coupling',7),(412,13820,'Gear pump','Gear pump',7),(413,12304,'Gear ring','Gear ring',7),(414,14717,'Gear stick','gearstick',7),(415,14217,' gear lever',' gear lever',7),(416,13055,' selection lever',' selection lever',7),(417,14446,' shift stick',' shift stick',7),(418,14014,' gear shifter',' gear shifter',7),(419,12107,'Gearbox','Gearbox',7),(420,15472,'Idler gear','Idler gear',7),(421,13261,'Knuckle','Knuckle',7),(422,12960,'Output shaft','Output shaft',7),(423,13561,'Pinion','Pinion',7),(424,13138,'Planetary gear set','Planetary gear set',7),(425,12500,'Prop shaft','drive shaft and propeller shaft',7),(426,15275,'Shift cable','Shift cable',7),(427,14902,'Shift fork','Shift fork',7),(428,13407,'Shift knob','Shift knob',7),(429,15445,'Shift lever','Shift lever',7),(430,13077,'Slave cylinder','Slave cylinder',7),(431,15100,'Speed reducer','Speed reducer',7),(432,12272,'Speedometer gear','Speedometer gear',7),(433,14165,'Steering gear','Steering gear',7),(434,14923,'Torque converter','Torque converter',7),(435,12489,'Transaxle housing','Transaxle housing',7),(436,14368,'Transfer case','Transfer case',7),(437,12996,'Transmission gear','Transmission gear',7),(438,15157,'Transmission pan','Transmission pan',7),(439,15138,'Transmission seal','Transmission seal and bonded piston',7),(440,12180,'Transmission spring','Transmission spring',7),(441,14510,'Transmission yolk','Transmission yolk',7),(442,12695,'UJ cardan joint','Universal joint cardan joint',7),(443,12260,'A/C clutch','Air conditioning clutch',7),(444,14318,'A/C compressor','Air conditioning compressor',7),(445,12560,'A/C condenser','Air conditioning condenser',7),(446,14523,'A/C hose','Air conditioning hose',7),(447,12967,'A/C kit','Air conditioning kit',7),(448,14879,'A/C relay','Air conditioning relay',7),(449,12459,'A/C valve','Air conditioning valve',7),(450,15234,'A/C expansion valve','Air conditioning expansion valve',7),(451,14300,'A/C low-pressure valve','Air conditioning low-pressure valve',7),(452,13226,'A/C schrader valve','Air conditioning schrader valve',7),(453,14620,'A/C INNER PLATE','Air conditioning INNER PLATE',7),(454,15501,'A/C COOLER','Air conditioning COOLER',7),(455,14057,'A/C Evaporator','Air conditioning Evaporator',7),(456,13766,'Ball joint','Ball joint',7),(457,12911,'Grooved ball bearing','Grooved ball bearing',7),(458,15001,'Needle bearing','Needle bearing',7),(459,12919,'Roller bearing','Roller bearing',7),(460,13583,'Sleeve bearing','Sleeve bearing',7),(461,13398,'Fuel vapour hose','Fuel vapour hose',7),(462,15060,'Reinforced hose','Reinforced hose',7),(463,15112,'Non-reinforced hose','Non-reinforced hose',7),(464,15178,'Washer hose','Washer hose',7),(465,13667,'Adhesive tape and foil','Adhesive tape and foil',7),(466,12053,'Air bag','Air bag',7),(467,15901,'Bolt cap','Bolt cap',7),(468,15835,'Bracket','Bracket',7),(469,14860,'License plate bracket','License plate bracket',7),(470,12033,'Cables','Cables',7),(471,12011,'Speedometer cable','Speedometer cable',7),(472,14962,'Cotter pin','Cotter pin',7),(473,14619,'Decal','Decal',7),(474,14934,'Dashboard','Dashboard',7),(475,15908,'Glove compartment','Glove compartment',7),(476,15698,'Drag link','Drag link',7),(477,12740,'Dynamic seal','Dynamic seal',7),(478,14703,'Gasket: Flat','Gasket: Flat',7),(479,14127,' moulded',' moulded',7),(480,15995,' profiled',' profiled',7),(481,12582,'Hood and trunk release cable','Hood and trunk release cable',7),(482,14668,'Horn and trumpet horn','Horn and trumpet horn',7),(483,15316,'Injection-molded parts','Injection-molded parts',7),(484,13332,'Instrument cluster','Instrument cluster',7),(485,12082,'Label','Label',7),(486,12710,'Mount and mounting','Mount and mounting',7),(487,14408,'Name plate','Name plate',7),(488,14977,'Nut','Nut',7),(489,64118,'Flange nut','Flange nut',7),(490,66082,'Hex nut','Hex nut',7),(491,74551,'O-ring','O-ring',7),(492,67997,'Paint','Paint',7),(493,64119,'Rivet','Rivet',7),(494,66637,'Rubber','Rubber',7),(495,74661,'Screw','Screw',7),(496,65560,'Shim','Shim',7),(497,77116,'Sun visor','Sun visor',7),(498,66306,'Washer','Washer',7);
/*!40000 ALTER TABLE `parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `pendingpayments`
--

DROP TABLE IF EXISTS `pendingpayments`;
/*!50001 DROP VIEW IF EXISTS `pendingpayments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `pendingpayments` AS SELECT 
 1 AS `buyer_id`,
 1 AS `buyer_name`,
 1 AS `order_id`,
 1 AS `total`,
 1 AS `payment_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `retreiveavailableinventory`
--

DROP TABLE IF EXISTS `retreiveavailableinventory`;
/*!50001 DROP VIEW IF EXISTS `retreiveavailableinventory`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `retreiveavailableinventory` AS SELECT 
 1 AS `inventory_id`,
 1 AS `part_number`,
 1 AS `part_name`,
 1 AS `part_description`,
 1 AS `vendor_name`,
 1 AS `revenue`,
 1 AS `quantity`,
 1 AS `part_category`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `returnbuyerinfo`
--

DROP TABLE IF EXISTS `returnbuyerinfo`;
/*!50001 DROP VIEW IF EXISTS `returnbuyerinfo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `returnbuyerinfo` AS SELECT 
 1 AS `buyer_name`,
 1 AS `buyer_return_id`,
 1 AS `order_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shipping_status`
--

DROP TABLE IF EXISTS `shipping_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_status` (
  `shipping_status_id` int NOT NULL AUTO_INCREMENT,
  `shipping_status` char(9) NOT NULL,
  PRIMARY KEY (`shipping_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_status`
--

LOCK TABLES `shipping_status` WRITE;
/*!40000 ALTER TABLE `shipping_status` DISABLE KEYS */;
INSERT INTO `shipping_status` VALUES (1,'preparing'),(2,'shipped'),(3,'delivered');
/*!40000 ALTER TABLE `shipping_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_info`
--

DROP TABLE IF EXISTS `vendor_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_info` (
  `vendor_id` int NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(200) NOT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_info`
--

LOCK TABLES `vendor_info` WRITE;
/*!40000 ALTER TABLE `vendor_info` DISABLE KEYS */;
INSERT INTO `vendor_info` VALUES (1,'Aisin Corporation','24330 Garnier St','Torrance','Joe Smith'),(2,'Akebono Brake Industry Co. Ltd.','300 Ring Rd','Elizabethtown','Bob Moore'),(3,'Brembo S.p.A.','47765 Halyard Dr','Plymouth','Kevin Sheldon'),(4,'Continental AG','1 Continental Dr','Auburn Hills','Brook Shields'),(5,'DENSO Corporation','24777 Denso Dr','Southfield','Taylor Swift'),(6,'Faurecia SE','53 State St','Boston','Justin Beiber');
/*!40000 ALTER TABLE `vendor_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_part_restock`
--

DROP TABLE IF EXISTS `vendor_part_restock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_part_restock` (
  `restock_id` int NOT NULL AUTO_INCREMENT,
  `part_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `restock_quantity` int NOT NULL,
  `purchase_status` tinyint(1) DEFAULT '0',
  `received` tinyint(1) DEFAULT '0',
  `tracking_number` int DEFAULT NULL,
  PRIMARY KEY (`restock_id`),
  KEY `part_ids` (`part_id`),
  KEY `vendor_id2` (`vendor_id`),
  CONSTRAINT `part_ids` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`),
  CONSTRAINT `vendor_id2` FOREIGN KEY (`vendor_id`) REFERENCES `vendor_info` (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_part_restock`
--

LOCK TABLES `vendor_part_restock` WRITE;
/*!40000 ALTER TABLE `vendor_part_restock` DISABLE KEYS */;
INSERT INTO `vendor_part_restock` VALUES (1,1,1,846,1,1,68356534),(2,2,1,519,1,1,97405629),(3,3,1,365,1,1,76445560),(4,4,1,705,1,1,98718993),(5,5,1,984,1,1,25995535),(6,6,1,545,1,1,50809063),(7,7,1,260,1,1,60200505),(8,8,1,207,1,1,65386560),(9,9,1,515,1,1,88672200),(10,10,1,157,1,1,30840124),(11,11,1,237,1,1,37614658),(12,12,1,480,1,1,24466055),(13,13,1,879,1,1,14752920),(14,14,1,993,1,1,67568466),(15,15,1,599,1,1,96168623),(16,16,1,888,1,1,77385614),(17,17,1,611,1,1,44266049),(18,18,1,872,1,1,85154240),(19,19,1,934,1,1,20226026),(20,20,1,988,1,1,42213706),(21,21,1,593,1,1,87029733),(22,22,2,313,1,1,77879415),(23,23,2,366,1,1,84292443),(24,24,2,470,1,1,80206817),(25,25,2,977,1,1,63966910),(26,26,2,375,1,1,35585465),(27,27,2,591,1,1,61568043),(28,28,2,775,1,1,23875506),(29,29,2,426,1,1,19825747),(30,30,2,699,1,1,35376897),(31,31,2,366,1,1,73830845),(32,32,2,816,1,1,83825048),(33,33,2,588,1,1,87103680),(34,34,2,883,1,1,33244655),(35,35,2,791,1,1,78791352),(36,36,2,688,1,1,35261310),(37,37,2,353,1,1,19930733),(38,38,2,712,1,1,21046398),(39,39,2,804,1,1,86246588),(40,40,2,158,1,1,65626360),(41,41,2,908,1,1,82152281),(42,42,2,546,1,1,94258213),(43,43,2,681,1,1,43617434),(44,44,2,564,1,1,18585616),(45,45,2,92,1,1,57328092),(46,46,2,6,1,1,82657458),(47,47,2,937,1,1,14642438),(48,48,2,838,1,1,92072464),(49,49,2,266,1,1,79358256),(50,50,2,764,1,1,96330706),(51,51,2,559,1,1,70560358),(52,52,2,164,1,1,99521377),(53,53,2,555,1,1,35797545),(54,54,3,763,1,1,33918766),(55,55,3,603,1,1,37621763),(56,56,3,67,1,1,58740518),(57,57,3,529,1,1,24201341),(58,58,3,236,1,1,83794124),(59,59,3,616,1,1,85200502),(60,60,3,853,1,1,99293869),(61,61,3,114,1,1,92562533),(62,62,3,97,1,1,47801331),(63,63,3,596,1,1,21737634),(64,64,3,409,1,1,74500096),(65,65,3,966,1,1,49158623),(66,66,3,393,1,1,24871935),(67,67,3,488,1,1,59851037),(68,68,3,930,1,1,29001168),(69,69,3,792,1,1,93104328),(70,70,3,304,1,1,41045179),(71,71,3,958,1,1,32682181),(72,72,3,693,1,1,20431579),(73,73,3,313,1,1,70266551),(74,74,3,34,1,1,50520321),(75,75,3,617,1,1,82736570),(76,76,3,209,1,1,52313269),(77,77,3,70,1,1,58354019),(78,78,3,560,1,1,25493417),(79,79,3,276,1,1,75520742),(80,80,3,788,1,1,51819257),(81,81,3,459,1,1,17761082),(82,82,3,270,1,1,79780429),(83,83,3,325,1,1,73061090),(84,84,3,976,1,1,93800007),(85,85,3,899,1,1,13957448),(86,86,3,395,1,1,60443755),(87,87,3,441,1,1,87582409),(88,88,3,879,1,1,86768084),(89,89,3,500,1,1,61325885),(90,90,3,807,1,1,47834570),(91,91,3,494,1,1,21450767),(92,92,3,821,1,1,15087836),(93,93,3,344,1,1,76201046),(94,94,3,873,1,1,55520468),(95,95,3,212,1,1,14413281),(96,96,3,283,1,1,30597242),(97,97,3,848,1,1,84988222),(98,98,3,821,1,1,57678402),(99,99,3,731,1,1,73300964),(100,100,3,89,1,1,19339750),(101,101,3,303,1,1,81948207),(102,102,3,525,1,1,78190811),(103,103,3,211,1,1,16305796),(104,104,3,275,1,1,93761803),(105,105,3,295,1,1,54797189),(106,106,3,667,1,1,40580600),(107,107,3,334,1,1,47919137),(108,108,3,322,1,1,32308522),(109,109,3,886,1,1,12043589),(110,110,3,956,1,1,79664642),(111,111,3,30,1,1,40168483),(112,112,3,591,1,1,46762373),(113,113,3,476,1,1,92435262),(114,114,3,665,1,1,76357832),(115,115,3,64,1,1,47189729),(116,116,3,867,1,1,55656788),(117,117,3,117,1,1,95939767),(118,118,3,607,1,1,84570964),(119,119,3,991,1,1,61717129),(120,120,3,847,1,1,11757868),(121,121,3,17,1,1,58381312),(122,122,3,562,1,1,58116765),(123,123,3,300,1,1,67362920),(124,124,3,503,1,1,14115104),(125,125,3,656,1,1,66688708),(126,126,3,394,1,1,36806635),(127,127,3,704,1,1,47889754),(128,128,3,236,1,1,99978221),(129,129,3,945,1,1,58992494),(130,130,3,821,1,1,22953322),(131,131,3,857,1,1,11469676),(132,132,3,39,1,1,72705432),(133,133,3,41,1,1,76500921),(134,134,3,271,1,1,60907071),(135,135,3,835,1,1,13130723),(136,136,3,235,1,1,87752988),(137,137,3,56,1,1,42249688),(138,138,3,436,1,1,32933608),(139,139,3,124,1,1,45441281),(140,140,3,39,1,1,56064367),(141,141,3,634,1,1,87197169),(142,142,3,766,1,1,91055400),(143,143,3,471,1,1,91868397),(144,144,3,957,1,1,48619638),(145,145,3,222,1,1,31676722),(146,146,3,540,1,1,17834516),(147,147,3,159,1,1,48495889),(148,148,3,961,1,1,66535368),(149,149,3,574,1,1,69393619),(150,150,3,617,1,1,17165202),(151,151,3,420,1,1,34964428),(152,152,3,636,1,1,15123068),(153,153,3,39,1,1,14434093),(154,154,3,412,1,1,64528183),(155,155,3,781,1,1,26290604),(156,156,3,259,1,1,19270861),(157,157,3,934,1,1,69043537),(158,158,3,195,1,1,28793115),(159,159,3,882,1,1,78945697),(160,160,3,766,1,1,38611157),(161,161,3,751,1,1,58650200),(162,162,3,945,1,1,84533443),(163,163,3,160,1,1,90575981),(164,164,3,870,1,1,50872419),(165,165,3,684,1,1,58156892),(166,166,3,922,1,1,53701562),(167,167,3,613,1,1,87440278),(168,168,3,859,1,1,24322865),(169,169,3,579,1,1,93408869),(170,170,3,660,1,1,51448364),(171,171,3,249,1,1,84158842),(172,172,3,989,1,1,89441322),(173,173,3,909,1,1,47353363),(174,174,3,985,1,1,24974777),(175,175,3,893,1,1,39139042),(176,176,3,853,1,1,70016496),(177,177,3,465,1,1,56236246),(178,178,3,996,1,1,94257301),(179,179,3,50,1,1,56793316),(180,180,3,363,1,1,14402577),(181,181,3,532,1,1,53143611),(182,182,3,950,1,1,54345480),(183,183,3,617,1,1,64348564),(184,184,3,225,1,1,52975382),(185,185,3,434,1,1,74449984),(186,186,3,363,1,1,87901876),(187,187,3,311,1,1,74913045),(188,188,3,631,1,1,89688423),(189,189,3,539,1,1,56252281),(190,190,3,715,1,1,41424171),(191,191,3,660,1,1,21973972),(192,192,3,463,1,1,52270920),(193,193,3,914,1,1,28797342),(194,194,3,304,1,1,81981020),(195,195,3,231,1,1,43328044),(196,196,3,939,1,1,22159362),(197,197,3,198,1,1,20380184),(198,198,3,631,1,1,13673021),(199,199,3,983,1,1,72168692),(200,200,3,345,1,1,82962053),(201,201,3,161,1,1,25361413),(202,202,3,328,1,1,63869848),(203,203,3,282,1,1,76013294),(204,204,3,791,1,1,16931298),(205,205,3,289,1,1,84412147),(206,206,3,720,1,1,33748502),(207,207,3,670,1,1,39309108),(208,208,3,606,1,1,58090639),(209,209,3,794,1,1,72772513),(210,210,3,10,1,1,82022674),(211,211,3,658,1,1,91981031),(212,212,3,175,1,1,92261650),(213,213,3,264,1,1,56737707),(214,214,3,937,1,1,80978341),(215,215,3,612,1,1,26827935),(216,216,3,683,1,1,32034674),(217,217,3,416,1,1,26744061),(218,218,3,57,1,1,78260462),(219,219,3,219,1,1,25717167),(220,220,3,347,1,1,66620769),(221,221,3,630,1,1,32719090),(222,222,3,553,1,1,52495795),(223,223,3,445,1,1,86778816),(224,224,3,209,1,1,99876256),(225,225,3,625,1,1,14539340),(226,226,3,682,1,1,64864621),(227,227,3,513,1,1,94066475),(228,228,3,138,1,1,88605100),(229,229,3,957,1,1,54051278),(230,230,3,191,1,1,65948151),(231,231,3,635,1,1,53978155),(232,232,3,651,1,1,89852352),(233,233,3,880,1,1,69733482),(234,234,3,951,1,1,71630588),(235,235,3,337,1,1,22436924),(236,236,3,644,1,1,41550366),(237,237,4,552,1,1,12109070),(238,238,4,107,1,1,97308122),(239,239,4,111,1,1,31413473),(240,240,4,278,1,1,76275723),(241,241,4,269,1,1,35353326),(242,242,4,443,1,1,33033336),(243,243,4,519,1,1,18496823),(244,244,4,192,1,1,98562457),(245,245,4,867,1,1,99541065),(246,246,4,558,1,1,56844221),(247,247,4,262,1,1,71858246),(248,248,4,577,1,1,45420373),(249,249,4,340,1,1,47420555),(250,250,4,765,1,1,67056994),(251,251,4,479,1,1,18911109),(252,252,4,758,1,1,69593711),(253,253,4,400,1,1,40737924),(254,254,4,906,1,1,44141226),(255,255,4,222,1,1,37474787),(256,256,4,588,1,1,61492877),(257,257,4,506,1,1,99263455),(258,258,4,768,1,1,76281975),(259,259,4,142,1,1,90594792),(260,260,4,218,1,1,69039808),(261,261,4,37,1,1,37352360),(262,262,4,620,1,1,39766674),(263,263,4,32,1,1,73542783),(264,264,4,280,1,1,79394643),(265,265,4,397,1,1,74171634),(266,266,4,480,1,1,74631792),(267,267,4,259,1,1,88107283),(268,268,4,663,1,1,22475267),(269,269,4,197,1,1,51057572),(270,270,4,220,1,1,31604167),(271,271,4,750,1,1,40420159),(272,272,4,369,1,1,44212467),(273,273,4,118,1,1,99940539),(274,274,4,243,1,1,32328252),(275,275,4,444,1,1,75798711),(276,276,4,405,1,1,83212894),(277,277,4,163,1,1,65010349),(278,278,4,570,1,1,58675232),(279,279,4,439,1,1,93173093),(280,280,4,520,1,1,67123946),(281,281,4,87,1,1,49232212),(282,282,4,528,1,1,85207295),(283,283,4,890,1,1,61787334),(284,284,4,543,1,1,57495829),(285,285,4,993,1,1,52674781),(286,286,4,845,1,1,15813602),(287,287,4,250,1,1,27691730),(288,288,4,400,1,1,57156295),(289,289,4,554,1,1,78311471),(290,290,4,356,1,1,77611714),(291,291,4,655,1,1,71805869),(292,292,4,830,1,1,73690260),(293,293,4,566,1,1,70536850),(294,276,4,349,1,1,86489481),(295,295,4,407,1,1,69418520),(296,296,4,353,1,1,75596699),(297,297,4,972,1,1,35309519),(298,298,4,481,1,1,76996224),(299,299,4,712,1,1,37971398),(300,300,4,658,1,1,67437233),(301,301,4,424,1,1,41030879),(302,302,4,731,1,1,33403978),(303,303,4,805,1,1,11738462),(304,304,4,907,1,1,56673792),(305,305,4,842,1,1,76523034),(306,306,4,919,1,1,35180435),(307,307,4,157,1,1,11402653),(308,308,4,605,1,1,80554322),(309,309,4,177,1,1,91418815),(310,310,4,852,1,1,90805163),(311,311,4,64,1,1,27450052),(312,312,4,204,1,1,72401804),(313,313,4,257,1,1,59963254),(314,314,4,75,1,1,41649693),(315,315,4,814,1,1,31078320),(316,316,4,726,1,1,60883797),(317,317,4,209,1,1,96681695),(318,318,4,712,1,1,87859767),(319,319,4,871,1,1,36374401),(320,320,5,719,1,1,81779681),(321,321,5,75,1,1,70640903),(322,322,5,311,1,1,69041149),(323,323,5,227,1,1,83787385),(324,324,5,544,1,1,57706622),(325,325,5,242,1,1,78326307),(326,326,5,861,1,1,42861264),(327,327,5,415,1,1,57541675),(328,328,5,763,1,1,32149596),(329,329,5,805,1,1,65304434),(330,330,5,80,1,1,34934121),(331,331,5,375,1,1,15189095),(332,332,5,599,1,1,34566355),(333,333,5,732,1,1,26846048),(334,334,5,468,1,1,41308844),(335,335,5,355,1,1,50518975),(336,336,5,33,1,1,26840022),(337,337,5,148,1,1,95571697),(338,338,5,824,1,1,82119891),(339,339,5,748,1,1,18028309),(340,340,5,878,1,1,37214622),(341,341,5,965,1,1,96871983),(342,342,5,842,1,1,32479107),(343,343,5,175,1,1,31723156),(344,344,5,309,1,1,89406093),(345,345,5,212,1,1,36573021),(346,346,5,155,1,1,34670885),(347,347,5,249,1,1,42603026),(348,348,5,898,1,1,26308174),(349,349,5,755,1,1,57180859),(350,350,5,187,1,1,50312417),(351,351,5,157,1,1,30104317),(352,352,5,559,1,1,79885870),(353,353,5,625,1,1,89080709),(354,354,5,59,1,1,26836574),(355,355,5,954,1,1,50745848),(356,356,5,288,1,1,66380346),(357,357,5,917,1,1,58458422),(358,358,5,179,1,1,44576757),(359,359,5,326,1,1,50061572),(360,360,5,398,1,1,16928072),(361,361,5,928,1,1,96370155),(362,362,5,84,1,1,41841107),(363,363,5,32,1,1,80382544),(364,364,5,740,1,1,30389155),(365,365,5,646,1,1,35529160),(366,366,5,239,1,1,34066070),(367,367,5,720,1,1,20339061),(368,368,5,391,1,1,72192572),(369,369,5,796,1,1,36361725),(370,370,5,536,1,1,80490172),(371,371,5,318,1,1,67332458),(372,372,5,499,1,1,51638554),(373,373,5,766,1,1,65529784),(374,374,5,977,1,1,47974230),(375,375,5,266,1,1,91997410),(376,376,5,111,1,1,69308599),(377,377,5,815,1,1,20341177),(378,378,5,416,1,1,69447134),(379,379,5,759,1,1,54005710),(380,380,5,524,1,1,87162556),(381,381,5,495,1,1,16326337),(382,382,5,523,1,1,67575965),(383,383,5,459,1,1,46004914),(384,384,5,668,1,1,93493540),(385,385,5,95,1,1,87027730),(386,386,5,533,1,1,88481481),(387,387,5,471,1,1,50456492),(388,388,5,809,1,1,85668692),(389,389,5,137,1,1,82872642),(390,390,5,985,1,1,22963162),(391,391,5,607,1,1,69013118),(392,392,5,266,1,1,62092398),(393,393,5,335,1,1,54830859),(394,394,5,174,1,1,17283142),(395,395,5,662,1,1,56877217),(396,396,5,562,1,1,54439950),(397,397,5,999,1,1,98590521),(398,398,5,211,1,1,91650908),(399,399,5,937,1,1,54606023),(400,400,5,371,1,1,44888035),(401,401,5,314,1,1,54953754),(402,402,5,892,1,1,71220885),(403,403,5,598,1,1,40263716),(404,404,5,365,1,1,14944568),(405,405,5,162,1,1,20657655),(406,406,5,391,1,1,50027628),(407,407,5,454,1,1,81252092),(408,408,5,21,1,1,84542756),(409,409,5,288,1,1,97937388),(410,410,5,551,1,1,88501605),(411,411,5,871,1,1,64165523),(412,412,5,672,1,1,92000388),(413,413,5,925,1,1,64008548),(414,414,5,861,1,1,19046194),(415,415,5,969,1,1,70827491),(416,416,5,314,1,1,98734346),(417,417,5,325,1,1,80427620),(418,418,5,869,1,1,89170559),(419,419,5,593,1,1,35306956),(420,420,5,812,1,1,32058168),(421,421,5,921,1,1,34961588),(422,422,5,116,1,1,23363612),(423,423,5,339,1,1,67153441),(424,424,5,360,1,1,41087361),(425,425,5,392,1,1,96870311),(426,426,5,541,1,1,46643431),(427,427,5,651,1,1,47782256),(428,428,5,90,1,1,53434650),(429,429,5,629,1,1,67815915),(430,430,5,816,1,1,24937492),(431,431,5,202,1,1,33391908),(432,432,5,426,1,1,40168266),(433,433,5,864,1,1,72793151),(434,434,5,763,1,1,64879312),(435,435,5,845,1,1,68489364),(436,436,5,147,1,1,59766832),(437,437,5,79,1,1,59035553),(438,438,5,411,1,1,72255277),(439,439,5,682,1,1,16077957),(440,440,5,651,1,1,96147270),(441,441,5,55,1,1,26980320),(442,442,5,192,1,1,12603542),(443,443,5,324,1,1,30584354),(444,444,5,513,1,1,26510273),(445,445,5,182,1,1,39189835),(446,446,5,734,1,1,12396934),(447,447,5,609,1,1,85929978),(448,448,5,923,1,1,45630760),(449,449,5,407,1,1,31956266),(450,450,5,474,1,1,83164556),(451,451,5,857,1,1,96849562),(452,452,5,208,1,1,51876708),(453,453,5,795,1,1,91495870),(454,454,5,46,1,1,89030697),(455,455,5,658,1,1,16607336),(456,456,5,420,1,1,18655984),(457,457,5,602,1,1,21717458),(458,458,5,802,1,1,51404888),(459,459,5,669,1,1,24752476),(460,460,5,858,1,1,70700267),(461,461,5,432,1,1,74553495),(462,462,5,409,1,1,55868564),(463,463,5,683,1,1,78914788),(464,464,5,295,1,1,27956863),(465,465,5,910,1,1,70486300),(466,466,5,172,1,1,84324855),(467,467,5,785,1,1,94924563),(468,468,5,367,1,1,74851638),(469,469,5,852,1,1,69948287),(470,470,5,679,1,1,47121424),(471,471,5,680,1,1,16351957),(472,472,5,509,1,1,17117825),(473,473,5,868,1,1,37989545),(474,474,5,194,1,1,19993121),(475,475,5,943,1,1,88856873),(476,476,5,739,1,1,28589414),(477,477,5,830,1,1,71742434),(478,478,5,347,1,1,12196272),(479,479,5,171,1,1,28670862),(480,480,5,649,1,1,79001837),(481,481,5,528,1,1,66438116),(482,482,5,658,1,1,84860439),(483,483,5,176,1,1,75865076),(484,484,5,942,1,1,57638079),(485,485,5,737,1,1,58903495),(486,486,5,738,1,1,32664942),(487,487,5,597,1,1,45277992),(488,488,5,62,1,1,84443341),(489,489,6,199,1,1,50879344),(490,490,6,297,1,1,16546182),(491,491,6,294,1,1,52954897),(492,492,6,49,1,1,91237416),(493,493,6,293,1,1,83463752),(494,494,6,179,1,1,30967525),(495,495,6,773,1,1,28541316),(496,496,6,46,1,1,16554081),(497,497,6,412,1,1,98965186),(498,498,6,479,1,1,26509191);
/*!40000 ALTER TABLE `vendor_part_restock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_return`
--

DROP TABLE IF EXISTS `vendor_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_return` (
  `return_id` int NOT NULL AUTO_INCREMENT,
  `return_received` tinyint(1) NOT NULL,
  `store_credit` tinyint(1) DEFAULT '0',
  `refund_check` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_return`
--

LOCK TABLES `vendor_return` WRITE;
/*!40000 ALTER TABLE `vendor_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_return_line_items`
--

DROP TABLE IF EXISTS `vendor_return_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_return_line_items` (
  `return_line_id` int NOT NULL AUTO_INCREMENT,
  `vendor_return_id` int NOT NULL,
  `restock_id` int NOT NULL,
  `quantity_returned` int NOT NULL,
  `damaged` tinyint(1) DEFAULT '0',
  `defective` tinyint(1) DEFAULT '0',
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`return_line_id`),
  KEY `vendor_return_id` (`vendor_return_id`),
  KEY `restock_id` (`restock_id`),
  CONSTRAINT `vendor_return_line_items_ibfk_1` FOREIGN KEY (`vendor_return_id`) REFERENCES `vendor_return` (`return_id`),
  CONSTRAINT `vendor_return_line_items_ibfk_2` FOREIGN KEY (`restock_id`) REFERENCES `vendor_part_restock` (`restock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_return_line_items`
--

LOCK TABLES `vendor_return_line_items` WRITE;
/*!40000 ALTER TABLE `vendor_return_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_return_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'project'
--

--
-- Dumping routines for database 'project'
--
/*!50003 DROP FUNCTION IF EXISTS `extRev` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ddalanni`@`%` FUNCTION `extRev`(inventoryID INT, quantity INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    DECLARE extended_rev DECIMAL(10, 2);

    SELECT inventory.revenue * quantity INTO extended_rev
    FROM inventory
    WHERE inventory_id = inventoryID;

    RETURN extended_rev;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `orderTotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ddalanni`@`%` FUNCTION `orderTotal`(buyer_order_id INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT sum(extended_revenue_price) INTO total
    FROM buyer_po_line_items
    WHERE order_id = buyer_order_id;

    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `returnRate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ddalanni`@`%` FUNCTION `returnRate`(inventoryID INT) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE rate INT;
    SELECT sum(quantity_returned) into rate
    from buyerreturnstoinventory
    where inventory_id = inventoryID;
    
    RETURN rate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `changeShippingStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ddalanni`@`%` PROCEDURE `changeShippingStatus`(IN desired_shipping_status INT, IN buyer_order_id INT)
BEGIN
    UPDATE buyer_order_shipping 
    SET shipping_status_id = desired_shipping_status
    WHERE shipping_id = (select shipping_id from buyer_po where order_id = buyer_order_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createBuyer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ddalanni`@`%` PROCEDURE `createBuyer`(
	IN  input_buyer_name VARCHAR(200), 
	IN input_street VARCHAR(100), 
	IN input_city VARCHAR(50),
    IN input_contact VARCHAR(50)
)
BEGIN
    INSERT INTO Buyer_Info (buyer_name, street, city, contact) 
	VALUES (input_buyer_name, input_street, input_city, input_contact);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateInventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ddalanni`@`%` PROCEDURE `updateInventory`(IN inventoryID INT, IN quantity_sold INT)
BEGIN
    UPDATE inventory 
    SET quantity = quantity - quantity_sold 
    WHERE inventory_id = inventoryID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `buyerreturnstoinventory`
--

/*!50001 DROP VIEW IF EXISTS `buyerreturnstoinventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ddalanni`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `buyerreturnstoinventory` AS select `i`.`inventory_id` AS `inventory_id`,`p`.`part_number` AS `part_number`,`p`.`part_description` AS `part_description`,`v`.`vendor_name` AS `vendor_name`,`r`.`quantity_returned` AS `quantity_returned` from ((((`buyer_return_line_items` `r` join `buyer_po_line_items` `b` on((`r`.`line_item_id` = `b`.`line_item_id`))) join `inventory` `i` on((`b`.`inventory_id` = `i`.`inventory_id`))) join `parts` `p` on((`i`.`part_id` = `p`.`part_id`))) join `vendor_info` `v` on((`i`.`vendor_id` = `v`.`vendor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `highestreturnqty`
--

/*!50001 DROP VIEW IF EXISTS `highestreturnqty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ddalanni`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `highestreturnqty` AS select `inventoryreturntotals`.`inventory_id` AS `inventory_id`,`inventoryreturntotals`.`part_number` AS `part_number`,`inventoryreturntotals`.`vendor_name` AS `vendor_name`,`inventoryreturntotals`.`total_returned` AS `inventory_with_highest_return_qty` from `inventoryreturntotals` where (`inventoryreturntotals`.`total_returned` = (select max(`inventoryreturntotals`.`total_returned`) from `inventoryreturntotals`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `inventoryreturntotals`
--

/*!50001 DROP VIEW IF EXISTS `inventoryreturntotals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ddalanni`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `inventoryreturntotals` AS select `r`.`inventory_id` AS `inventory_id`,`r`.`part_number` AS `part_number`,`r`.`vendor_name` AS `vendor_name`,`returnRate`(`r`.`inventory_id`) AS `total_returned` from `buyerreturnstoinventory` `r` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pendingpayments`
--

/*!50001 DROP VIEW IF EXISTS `pendingpayments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ddalanni`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `pendingpayments` AS select `p`.`buyer_id` AS `buyer_id`,`b`.`buyer_name` AS `buyer_name`,`p`.`order_id` AS `order_id`,(select `orderTotal`(`p`.`order_id`)) AS `total`,`p`.`payment_status` AS `payment_status` from (`buyer_info` `b` join `buyer_po` `p` on((`b`.`buyer_id` = `p`.`buyer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `retreiveavailableinventory`
--

/*!50001 DROP VIEW IF EXISTS `retreiveavailableinventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ddalanni`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `retreiveavailableinventory` AS select `i`.`inventory_id` AS `inventory_id`,`p`.`part_number` AS `part_number`,`p`.`part_name` AS `part_name`,`p`.`part_description` AS `part_description`,`v`.`vendor_name` AS `vendor_name`,`i`.`revenue` AS `revenue`,`i`.`quantity` AS `quantity`,`c`.`part_category` AS `part_category` from (((`parts` `p` join `inventory` `i` on((`p`.`part_id` = `i`.`part_id`))) join `vendor_info` `v` on((`i`.`vendor_id` = `v`.`vendor_id`))) join `part_category` `c` on((`p`.`category_id` = `c`.`category_id`))) order by `p`.`part_number` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `returnbuyerinfo`
--

/*!50001 DROP VIEW IF EXISTS `returnbuyerinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ddalanni`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `returnbuyerinfo` AS select `b`.`buyer_name` AS `buyer_name`,`r`.`buyer_return_id` AS `buyer_return_id`,`p`.`order_id` AS `order_id` from ((((`buyer_return` `r` join `buyer_return_line_items` `e` on((`r`.`buyer_return_id` = `e`.`buyer_return_id`))) join `buyer_po_line_items` `l` on((`e`.`line_item_id` = `l`.`line_item_id`))) join `buyer_po` `p` on((`l`.`order_id` = `p`.`order_id`))) join `buyer_info` `b` on((`p`.`buyer_id` = `b`.`buyer_id`))) group by `b`.`buyer_name`,`r`.`buyer_return_id`,`p`.`order_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-03 11:06:29
