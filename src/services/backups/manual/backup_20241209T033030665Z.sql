-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: IMSDB
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditlogs`
--

DROP TABLE IF EXISTS `auditlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditlogs` (
  `audit_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `record_id` int NOT NULL,
  `change_type` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `change_details` text,
  `changed_by` int DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`),
  KEY `auditlogs_ibfk_1` (`changed_by`),
  CONSTRAINT `auditlogs_ibfk_1` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlogs`
--

LOCK TABLES `auditlogs` WRITE;
/*!40000 ALTER TABLE `auditlogs` DISABLE KEYS */;
INSERT INTO `auditlogs` VALUES (1,'Users',1,'INSERT','Added new user John Doe',2,'2024-01-01 07:00:00'),(2,'Items',1,'INSERT','Added new item Laptop',3,'2024-01-05 08:00:00'),(3,'Requests',1,'INSERT','Created new request for Laptop by user John Doe',4,'2024-01-11 06:00:00'),(4,'Transfers',1,'INSERT','Transferred Laptop from John Doe to Alice Smith',5,'2024-01-15 07:00:00'),(5,'Inventory',1,'INSERT','Added Laptop to inventory in Warehouse A',6,'2024-01-20 08:00:00'),(6,'UserItems',1,'INSERT','Assigned Laptop to user John Doe',7,'2024-01-25 09:00:00'),(7,'MaintenanceLogs',1,'INSERT','Logged routine check and software update for Laptop by IT Support',8,'2024-02-01 10:00:00'),(8,'Technicians',1,'INSERT','Added new technician for IT Support',9,'2024-02-05 11:00:00'),(9,'Roles',1,'INSERT','Added new role Admin',10,'2024-02-10 12:00:00'),(10,'Departments',1,'INSERT','Added new department Human Resources',11,'2024-02-15 13:00:00');
/*!40000 ALTER TABLE `auditlogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Human Resources'),(2,'Finance'),(3,'IT'),(4,'Sales'),(5,'Marketing');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `total_quantity_in_stock` int NOT NULL,
  `reorder_level` int NOT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,30,99),(2,2,50,119),(3,3,40,40),(4,4,100,50),(5,5,200,106),(6,6,20,125),(7,7,60,50),(8,8,70,82),(9,9,35,235),(10,10,120,212),(11,11,150,102),(12,12,200,77),(13,13,1000,56),(14,14,500,253),(15,15,300,152),(16,16,50,206),(17,17,80,86),(18,18,70,253),(19,19,400,55),(20,20,250,187),(21,21,150,51),(22,22,300,131),(23,23,200,245),(24,24,500,117),(25,25,30,57),(26,26,10,141),(27,27,25,46),(28,28,20,244),(29,29,300,136),(30,30,60,151),(31,31,40,95),(32,32,50,228),(33,33,15,135),(34,34,80,201),(35,35,100,111),(36,36,50,160),(37,37,60,210),(38,38,40,83),(39,39,300,224),(40,40,100,154),(41,41,80,71),(42,42,70,101),(43,43,25,38),(44,44,15,92),(45,45,200,89);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `category` enum('Durable','Non-durable') NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_level` int NOT NULL,
  `eligibility_tag` varchar(100) DEFAULT NULL,
  `stock_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` date DEFAULT NULL,
  `media_url` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `measurment_unit` varchar(100) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `model_number` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Laptop','High performance laptop','Durable',1200.00,30,'Tech','2024-12-07 13:15:52',NULL,'laptop.jpg',0,NULL,NULL,NULL),(2,'Desk Chair','Ergonomic desk chair','Durable',150.00,50,'Furniture','2024-12-07 13:15:52',NULL,'chair.jpg',0,NULL,NULL,NULL),(3,'Monitor','24-inch LED monitor','Durable',200.00,40,'Tech','2024-12-07 13:15:52',NULL,'monitor.jpg',0,NULL,NULL,NULL),(4,'Keyboard','Mechanical keyboard','Durable',75.00,100,'Tech','2024-12-07 13:15:52',NULL,'keyboard.jpg',0,NULL,NULL,NULL),(5,'Mouse','Wireless mouse','Durable',50.00,200,'Tech','2024-12-07 13:15:52',NULL,'mouse.jpg',0,NULL,NULL,NULL),(6,'Desk','Wooden office desk','Durable',300.00,20,'Furniture','2024-12-07 13:15:52',NULL,'desk.jpg',0,NULL,NULL,NULL),(7,'Phone','Smartphone','Durable',800.00,60,'Tech','2024-12-07 13:15:52',NULL,'phone.jpg',0,NULL,NULL,NULL),(8,'Tablet','10-inch tablet','Durable',500.00,70,'Tech','2024-12-07 13:15:52',NULL,'tablet.jpg',0,NULL,NULL,NULL),(9,'Printer','All-in-one printer','Durable',250.00,35,'Tech','2024-12-07 13:15:52',NULL,'printer.jpg',0,NULL,NULL,NULL),(10,'Webcam','HD webcam','Durable',80.00,120,'Tech','2024-12-07 13:15:52',NULL,'webcam.jpg',0,NULL,NULL,NULL),(11,'Coffee','Coffee beans','Non-durable',10.00,150,'Food','2024-12-07 13:15:52','2024-11-11','coffee.jpg',0,NULL,NULL,NULL),(12,'Tea','Green tea','Non-durable',5.00,200,'Food','2024-12-07 13:15:52','2024-12-11','tea.jpg',0,NULL,NULL,NULL),(13,'Pen','Ballpoint pen','Non-durable',1.00,1000,'Stationery','2024-12-07 13:15:52','2024-10-11','pen.jpg',0,NULL,NULL,NULL),(14,'Notebook','Spiral notebook','Non-durable',3.00,500,'Stationery','2024-12-07 13:15:52','2024-09-11','notebook.jpg',0,NULL,NULL,NULL),(15,'Paper','A4 paper ream','Non-durable',4.00,300,'Stationery','2024-12-07 13:15:52','2024-08-11','paper.jpg',0,NULL,NULL,NULL),(16,'Toner','Laser printer toner','Non-durable',60.00,50,'Tech','2024-12-07 13:15:52','2024-07-11','toner.jpg',0,NULL,NULL,NULL),(17,'Battery','AA battery pack','Non-durable',6.00,80,'Tech','2024-12-07 13:15:52','2024-06-11','battery.jpg',0,NULL,NULL,NULL),(18,'Stapler','Desk stapler','Durable',15.00,70,'Stationery','2024-12-07 13:15:52',NULL,'stapler.jpg',0,NULL,NULL,NULL),(19,'Ruler','Plastic ruler','Durable',2.00,400,'Stationery','2024-12-07 13:15:52',NULL,'ruler.jpg',0,NULL,NULL,NULL),(20,'Markers','Permanent markers','Non-durable',7.00,250,'Stationery','2024-12-07 13:15:52','2024-05-11','markers.jpg',0,NULL,NULL,NULL),(21,'Scissors','Office scissors','Durable',10.00,150,'Stationery','2024-12-07 13:15:52',NULL,'scissors.jpg',0,NULL,NULL,NULL),(22,'Glue','Glue stick','Non-durable',2.00,300,'Stationery','2024-12-07 13:15:52','2024-04-11','glue.jpg',0,NULL,NULL,NULL),(23,'Tape','Scotch tape','Non-durable',3.00,200,'Stationery','2024-12-07 13:15:52','2024-03-11','tape.jpg',0,NULL,NULL,NULL),(24,'Eraser','Rubber eraser','Durable',1.00,500,'Stationery','2024-12-07 13:15:52',NULL,'eraser.jpg',0,NULL,NULL,NULL),(25,'Whiteboard','Dry erase whiteboard','Durable',100.00,30,'Stationery','2024-12-07 13:15:52',NULL,'whiteboard.jpg',0,NULL,NULL,NULL),(26,'Projector','LCD projector','Durable',600.00,10,'Tech','2024-12-07 13:15:52',NULL,'projector.jpg',0,NULL,NULL,NULL),(27,'Router','Wi-Fi router','Durable',120.00,25,'Tech','2024-12-07 13:15:52',NULL,'router.jpg',0,NULL,NULL,NULL),(28,'Switch','Ethernet switch','Durable',200.00,20,'Tech','2024-12-07 13:15:52',NULL,'switch.jpg',0,NULL,NULL,NULL),(29,'Cable','HDMI cable','Durable',10.00,300,'Tech','2024-12-07 13:15:52',NULL,'cable.jpg',0,NULL,NULL,NULL),(30,'Charger','Laptop charger','Durable',50.00,60,'Tech','2024-12-07 13:15:52',NULL,'charger.jpg',0,NULL,NULL,NULL),(31,'Headphones','Noise-cancelling headphones','Durable',150.00,40,'Tech','2024-12-07 13:15:52',NULL,'headphones.jpg',0,NULL,NULL,NULL),(32,'Smartwatch','Fitness tracking smartwatch','Durable',200.00,50,'Tech','2024-12-07 13:15:52',NULL,'smartwatch.jpg',0,NULL,NULL,NULL),(33,'Projector Screen','120-inch projector screen','Durable',100.00,15,'Tech','2024-12-07 13:15:52',NULL,'projector_screen.jpg',0,NULL,NULL,NULL),(34,'Tablet Stand','Adjustable tablet stand','Durable',30.00,80,'Tech','2024-12-07 13:15:52',NULL,'tablet_stand.jpg',0,NULL,NULL,NULL),(35,'HDMI Adapter','HDMI to VGA adapter','Durable',20.00,100,'Tech','2024-12-07 13:15:52',NULL,'hdmi_adapter.jpg',0,NULL,NULL,NULL),(36,'Wireless Keyboard','Bluetooth wireless keyboard','Durable',70.00,50,'Tech','2024-12-07 13:15:52',NULL,'wireless_keyboard.jpg',0,NULL,NULL,NULL),(37,'Bluetooth Speaker','Portable Bluetooth speaker','Durable',90.00,60,'Tech','2024-12-07 13:15:52',NULL,'bluetooth_speaker.jpg',0,NULL,NULL,NULL),(38,'External Hard Drive','1TB external hard drive','Durable',120.00,40,'Tech','2024-12-07 13:15:52',NULL,'external_hard_drive.jpg',0,NULL,NULL,NULL),(39,'USB Flash Drive','64GB USB flash drive','Durable',20.00,300,'Tech','2024-12-07 13:15:52',NULL,'usb_flash_drive.jpg',0,NULL,NULL,NULL),(40,'Power Bank','10000mAh power bank','Durable',40.00,100,'Tech','2024-12-07 13:15:52',NULL,'power_bank.jpg',0,NULL,NULL,NULL),(41,'Wireless Charger','Qi wireless charger','Durable',30.00,80,'Tech','2024-12-07 13:15:52',NULL,'wireless_charger.jpg',0,NULL,NULL,NULL),(42,'Desk Lamp','LED desk lamp','Durable',50.00,70,'Furniture','2024-12-07 13:15:52',NULL,'desk_lamp.jpg',0,NULL,NULL,NULL),(43,'Office Chair','Executive office chair','Durable',250.00,25,'Furniture','2024-12-07 13:15:52',NULL,'office_chair.jpg',0,NULL,NULL,NULL),(44,'File Cabinet','Steel file cabinet','Durable',200.00,15,'Furniture','2024-12-07 13:15:52',NULL,'file_cabinet.jpg',0,NULL,NULL,NULL),(45,'Whiteboard Markers','Dry erase markers','Non-durable',10.00,200,'Stationery','2024-12-07 13:15:52','2024-02-11','whiteboard_markers.jpg',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_expiration_date` BEFORE INSERT ON `items` FOR EACH ROW BEGIN
    IF NEW.category = 'Durable' THEN
        SET NEW.expiration_date = NULL;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `maintenancelogs`
--

DROP TABLE IF EXISTS `maintenancelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenancelogs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `technician_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `activity` text,
  `performed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `technician_id` (`technician_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `maintenancelogs_ibfk_1` FOREIGN KEY (`technician_id`) REFERENCES `technicians` (`technician_id`) ON DELETE CASCADE,
  CONSTRAINT `maintenancelogs_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenancelogs`
--

LOCK TABLES `maintenancelogs` WRITE;
/*!40000 ALTER TABLE `maintenancelogs` DISABLE KEYS */;
INSERT INTO `maintenancelogs` VALUES (1,1,1,'Routine check and software update','2024-01-05 07:00:00'),(2,2,2,'Electrical wiring inspection','2024-02-10 08:00:00'),(3,3,3,'Lubrication and mechanical inspection','2024-03-15 09:00:00'),(4,4,4,'HVAC system cleaning and maintenance','2024-04-20 10:00:00'),(5,5,5,'Plumbing system inspection','2024-05-25 11:00:00'),(6,6,6,'Network troubleshooting','2024-06-30 12:00:00'),(7,7,7,'Software debugging and fixes','2024-07-05 13:00:00'),(8,8,8,'Database optimization','2024-08-10 14:00:00'),(9,9,9,'Security system upgrade','2024-09-15 15:00:00'),(10,10,10,'System analysis and report','2024-10-20 16:00:00'),(11,11,11,'Field inspection and repair','2024-11-25 06:00:00'),(12,12,12,'Technical support and issue resolution','2024-12-30 05:00:00'),(13,13,13,'Supervision of maintenance activities','2024-01-15 04:00:00'),(14,14,14,'Operational testing','2024-02-20 03:00:00'),(15,15,15,'Quality control assessment','2024-03-25 02:00:00'),(16,16,16,'Instrumentation calibration','2024-04-30 01:00:00'),(17,17,17,'Equipment calibration','2024-05-05 00:00:00'),(18,18,18,'Maintenance scheduling','2024-06-09 23:00:00'),(19,19,19,'Reliability assessment','2024-07-14 22:00:00'),(21,1,1,'Routine check and software update','2024-01-05 07:00:00'),(22,2,2,'Electrical wiring inspection','2024-02-10 08:00:00'),(23,3,3,'Lubrication and mechanical inspection','2024-03-15 09:00:00'),(24,4,4,'HVAC system cleaning and maintenance','2024-04-20 10:00:00'),(25,5,5,'Plumbing system inspection','2024-05-25 11:00:00'),(26,6,6,'Network troubleshooting','2024-06-30 12:00:00'),(27,7,7,'Software debugging and fixes','2024-07-05 13:00:00'),(28,8,8,'Database optimization','2024-08-10 14:00:00'),(29,9,9,'Security system upgrade','2024-09-15 15:00:00'),(30,10,10,'System analysis and report','2024-10-20 16:00:00'),(31,11,11,'Field inspection and repair','2024-11-25 06:00:00'),(32,12,12,'Technical support and issue resolution','2024-12-30 05:00:00'),(33,13,13,'Supervision of maintenance activities','2024-01-15 04:00:00'),(34,14,14,'Operational testing','2024-02-20 03:00:00'),(35,15,15,'Quality control assessment','2024-03-25 02:00:00'),(36,16,16,'Instrumentation calibration','2024-04-30 01:00:00'),(37,17,17,'Equipment calibration','2024-05-05 00:00:00'),(38,18,18,'Maintenance scheduling','2024-06-09 23:00:00'),(39,19,19,'Reliability assessment','2024-07-14 22:00:00');
/*!40000 ALTER TABLE `maintenancelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refreshtokens`
--

DROP TABLE IF EXISTS `refreshtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refreshtokens` (
  `token` varchar(255) NOT NULL,
  `userId` int NOT NULL,
  `expiresAt` datetime NOT NULL,
  PRIMARY KEY (`token`),
  KEY `userId` (`userId`),
  CONSTRAINT `refreshtokens_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refreshtokens`
--

LOCK TABLES `refreshtokens` WRITE;
/*!40000 ALTER TABLE `refreshtokens` DISABLE KEYS */;
INSERT INTO `refreshtokens` VALUES ('284dae2a-f516-4299-83cf-d7ae1bde594d',1,'2025-01-08 05:43:57'),('f09f7f20-598d-4ba7-b445-86234c01a47e',1,'2025-01-06 16:19:02');
/*!40000 ALTER TABLE `refreshtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `request_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `request_status` enum('Pending','Approved','Denied') DEFAULT 'Pending',
  `approved_by` int DEFAULT NULL,
  `approval_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `requests_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (1,'2024-01-10 21:00:00',1,1,2,'Approved',6,'2024-01-11 21:00:00'),(2,'2024-02-14 21:00:00',2,2,1,'Approved',7,'2024-02-15 21:00:00'),(3,'2024-03-19 21:00:00',3,3,3,'Pending',NULL,NULL),(4,'2024-04-24 21:00:00',4,4,4,'Denied',8,'2024-04-25 21:00:00'),(5,'2024-05-29 21:00:00',5,5,2,'Approved',9,'2024-05-30 21:00:00'),(6,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(7,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(8,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(9,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(10,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(11,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(12,'2024-07-09 21:00:00',7,7,3,'Approved',11,'2024-07-10 21:00:00'),(13,'2024-08-14 21:00:00',8,8,4,'Pending',NULL,NULL),(14,'2024-09-19 21:00:00',9,9,1,'Denied',12,'2024-09-20 21:00:00'),(15,'2024-10-24 21:00:00',10,10,2,'Approved',13,'2024-10-25 21:00:00'),(16,'2024-11-29 21:00:00',11,11,2,'Pending',NULL,NULL),(17,'2024-12-04 21:00:00',12,12,1,'Approved',14,'2024-12-05 21:00:00'),(18,'2024-01-09 21:00:00',13,13,3,'Approved',15,'2024-01-10 21:00:00'),(19,'2024-02-14 21:00:00',14,14,4,'Denied',16,'2024-02-15 21:00:00'),(20,'2024-03-19 21:00:00',15,15,2,'Approved',17,'2024-03-20 21:00:00'),(21,'2024-04-24 21:00:00',16,16,1,'Approved',18,'2024-04-25 21:00:00'),(22,'2024-05-29 21:00:00',17,17,3,'Pending',NULL,NULL),(23,'2024-06-04 21:00:00',18,18,4,'Approved',19,'2024-06-05 21:00:00'),(24,'2024-07-09 21:00:00',19,19,2,'Approved',NULL,'2024-07-10 21:00:00');
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(4,'faculity'),(2,'manager'),(5,'staff'),(6,'technician'),(3,'user');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technicians`
--

DROP TABLE IF EXISTS `technicians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technicians` (
  `technician_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`technician_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `technicians_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technicians`
--

LOCK TABLES `technicians` WRITE;
/*!40000 ALTER TABLE `technicians` DISABLE KEYS */;
INSERT INTO `technicians` VALUES (1,1,'IT Support','2024-01-01 07:00:00'),(2,2,'Electrical Maintenance','2024-01-05 08:00:00'),(3,3,'Mechanical Maintenance','2024-01-10 09:00:00'),(4,4,'HVAC Specialist','2024-01-15 10:00:00'),(5,5,'Plumbing Specialist','2024-01-20 11:00:00'),(6,6,'Network Engineer','2024-01-25 12:00:00'),(7,7,'Software Engineer','2024-02-01 13:00:00'),(8,8,'Database Administrator','2024-02-05 14:00:00'),(9,9,'Security Specialist','2024-02-10 15:00:00'),(10,10,'System Analyst','2024-02-15 16:00:00'),(11,11,'Field Technician','2024-02-20 06:00:00'),(12,12,'Technical Support','2024-02-25 05:00:00'),(13,13,'Maintenance Supervisor','2024-03-01 04:00:00'),(14,14,'Operations Technician','2024-03-05 03:00:00'),(15,15,'Quality Control Technician','2024-03-10 02:00:00'),(16,16,'Instrumentation Technician','2024-03-15 01:00:00'),(17,17,'Calibration Technician','2024-03-20 00:00:00'),(18,18,'Maintenance Planner','2024-03-24 23:00:00'),(19,19,'Reliability Engineer','2024-03-31 22:00:00'),(21,1,'IT Support','2024-01-01 07:00:00'),(22,2,'Electrical Maintenance','2024-01-05 08:00:00'),(23,3,'Mechanical Maintenance','2024-01-10 09:00:00'),(24,4,'HVAC Specialist','2024-01-15 10:00:00'),(25,5,'Plumbing Specialist','2024-01-20 11:00:00'),(26,6,'Network Engineer','2024-01-25 12:00:00'),(27,7,'Software Engineer','2024-02-01 13:00:00'),(28,8,'Database Administrator','2024-02-05 14:00:00'),(29,9,'Security Specialist','2024-02-10 15:00:00'),(30,10,'System Analyst','2024-02-15 16:00:00'),(31,11,'Field Technician','2024-02-20 06:00:00'),(32,12,'Technical Support','2024-02-25 05:00:00'),(33,13,'Maintenance Supervisor','2024-03-01 04:00:00'),(34,14,'Operations Technician','2024-03-05 03:00:00'),(35,15,'Quality Control Technician','2024-03-10 02:00:00'),(36,16,'Instrumentation Technician','2024-03-15 01:00:00'),(37,17,'Calibration Technician','2024-03-20 00:00:00'),(38,18,'Maintenance Planner','2024-03-24 23:00:00'),(39,19,'Reliability Engineer','2024-03-31 22:00:00');
/*!40000 ALTER TABLE `technicians` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfers` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `from_user_id` int DEFAULT NULL,
  `to_user_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `transfer_status` enum('Pending','Approved','Denied') DEFAULT 'Pending',
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` int DEFAULT NULL,
  `approval_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  KEY `item_id` (`item_id`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `transfers_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `transfers_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `transfers_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `transfers_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfers`
--

LOCK TABLES `transfers` WRITE;
/*!40000 ALTER TABLE `transfers` DISABLE KEYS */;
INSERT INTO `transfers` VALUES (1,1,2,1,1,'Approved','2024-01-14 21:00:00',6,'2024-01-15 21:00:00'),(2,2,3,2,1,'Approved','2024-02-19 21:00:00',7,'2024-02-20 21:00:00'),(3,3,4,3,1,'Pending','2024-03-24 21:00:00',NULL,NULL),(4,4,5,4,1,'Denied','2024-04-29 21:00:00',8,'2024-04-30 21:00:00'),(5,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(6,6,7,6,1,'Approved','2024-06-09 21:00:00',10,'2024-06-10 21:00:00'),(7,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(8,6,7,6,1,'Approved','2024-06-09 21:00:00',10,'2024-06-10 21:00:00'),(9,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(10,6,7,6,1,'Approved','2024-06-09 21:00:00',10,'2024-06-10 21:00:00'),(11,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(12,6,7,6,1,'Approved','2024-06-09 21:00:00',10,'2024-06-10 21:00:00'),(13,7,8,7,1,'Approved','2024-07-14 21:00:00',11,'2024-07-15 21:00:00'),(14,8,9,8,1,'Pending','2024-08-19 21:00:00',NULL,NULL),(15,9,10,9,1,'Denied','2024-09-24 21:00:00',12,'2024-09-25 21:00:00'),(16,10,11,10,1,'Approved','2024-10-29 21:00:00',13,'2024-10-30 21:00:00'),(17,11,12,11,1,'Pending','2024-11-03 21:00:00',NULL,NULL),(18,12,13,12,1,'Approved','2024-12-08 21:00:00',14,'2024-12-09 21:00:00'),(19,13,14,13,1,'Approved','2024-01-13 21:00:00',15,'2024-01-14 21:00:00'),(20,14,15,14,1,'Denied','2024-02-17 21:00:00',16,'2024-02-18 21:00:00'),(21,15,16,15,1,'Approved','2024-03-23 21:00:00',17,'2024-03-24 21:00:00'),(22,16,17,16,1,'Approved','2024-04-27 21:00:00',18,'2024-04-28 21:00:00'),(23,17,18,17,1,'Pending','2024-05-02 21:00:00',NULL,NULL),(24,18,19,18,1,'Approved','2024-06-06 21:00:00',19,'2024-06-07 21:00:00');
/*!40000 ALTER TABLE `transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useritems`
--

DROP TABLE IF EXISTS `useritems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useritems` (
  `user_item_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `acquired_date` date DEFAULT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`user_item_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `useritems_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `useritems_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useritems`
--

LOCK TABLES `useritems` WRITE;
/*!40000 ALTER TABLE `useritems` DISABLE KEYS */;
INSERT INTO `useritems` VALUES (1,1,1,1,'2024-01-01',12),(2,2,2,1,'2024-02-05',24),(3,3,3,1,'2024-03-10',36),(4,4,4,1,'2024-04-15',48),(5,5,5,1,'2024-05-20',60),(6,6,6,1,'2024-06-25',72),(7,7,7,1,'2024-07-30',84),(8,8,8,1,'2024-08-04',96),(9,9,9,1,'2024-09-09',108),(10,10,10,1,'2024-10-14',120),(11,11,11,1,'2024-11-19',132),(12,12,12,1,'2024-12-24',144),(13,13,13,1,'2024-01-01',156),(14,14,14,1,'2024-02-06',168),(15,15,15,1,'2024-03-11',180),(16,16,16,1,'2024-04-16',192),(17,17,17,1,'2024-05-21',204),(18,18,18,1,'2024-06-26',216),(19,19,19,1,'2024-07-31',228);
/*!40000 ALTER TABLE `useritems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userroles`
--

DROP TABLE IF EXISTS `userroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userroles` (
  `user_role_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`user_role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `userroles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `userroles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES (1,1,1),(2,2,3),(3,3,3),(4,4,4),(5,5,5),(6,6,3),(7,7,2),(8,8,3),(9,9,4),(10,10,5),(11,11,3),(12,12,2),(13,13,3),(14,14,4),(15,15,5),(16,16,3),(17,17,2),(18,18,5),(19,19,4),(21,21,1);
/*!40000 ALTER TABLE `userroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `department_id` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ash','$2a$10$9lPwEeJ6ztkuRs31TDgtb.67BYdkqvruYSKVdeC/wmuVSY/d1b1D.','jdoe@example.com','123-456-7890','profile1.jpg','2024-12-07 13:15:52','2024-12-07 13:18:50',1,0,'John','Doe'),(2,'asmith','$2a$10$u3OSXD0E0B7CYURUAEUJX.kkSPhTbK85Lxvu7R5p8mDa6KGTEszbW','asmith@example.com','234-567-8901','profile2.jpg','2024-12-07 13:15:52','2024-12-07 13:16:03',2,0,'Alice','Smith'),(3,'bjohnson','$2a$10$AdH7TdPTgdyZ9V5V2cCut.ExQGJTte5NK7Dp89pqr559BEKse8yHG','bjohnson@example.com','345-678-9012','profile3.jpg','2024-12-07 13:15:52','2024-12-07 13:16:03',3,0,'Bob','Johnson'),(4,'cwilson','$2a$10$vWq0hsBOMzmBFjpAysYbkeJO7LrvaxF2Bs.TIxKpPHWY7eMGIYZCW','cwilson@example.com','456-789-0123','profile4.jpg','2024-12-07 13:15:52','2024-12-07 13:16:03',4,0,'Carol','Wilson'),(5,'dlee','$2a$10$0wa4poRbcF7Qy1F9cDpl4u5KP0ZzX9FcpVekp7JbvrjSGWvauATE.','dlee@example.com','567-890-1234','profile5.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',5,0,'David','Lee'),(6,'emartin','$2a$10$QFiEgx7gUmntTckOXSHaWe1OvI4Zd4UEBt6RVLnhmQMbfuh/S9E26','emartin@example.com','678-901-2345','profile6.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',1,0,'Emily','Martin'),(7,'fgarcia','$2a$10$V1XQ/zVh2aAlNeu4rDdzxOQWsCWGQTtBf72ifA0ocr3opjj4arc2m','fgarcia@example.com','789-012-3456','profile7.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',2,0,'Frank','Garcia'),(8,'hthompson','$2a$10$N7i3XwYGaMAKphnu/otO2e87pcUe6OjF6QWdkljUrv/9NBWSsiDZe','hthompson@example.com','890-123-4567','profile8.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',3,0,'Helen','Thompson'),(9,'ijones','$2a$10$AGPjExKg3my8CJUp70lMcuV2xCnXNw.ANlIS4UXyXX66UHtcBZzJW','ijones@example.com','901-234-5678','profile9.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',4,0,'Ivy','Jones'),(10,'kmiller','$2a$10$Lz3emYomDuTx1Cfz8HMCXeLxUK0jW1EAUEvtpoTcEJJUz/fm5JwHu','kmiller@example.com','012-345-6789','profile10.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',5,0,'Kyle','Miller'),(11,'lgreen','$2a$10$mruH9paIxtqT68NDkUD4MePRXRonwijfDU8Xdkm/Ua7NAQOUVgpBe','lgreen@example.com','123-456-7890','profile11.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',1,0,'Liam','Green'),(12,'mbrown','$2a$10$w07Zgw8yqAl.G0qlpaHJqegPU.wUwkjlQtlxlieSSSsTEvf9tmRUC','mbrown@example.com','234-567-8901','profile12.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',2,0,'Mia','Brown'),(13,'nwilliams','$2a$10$wRxMT8f9XGcV74HyrC00VOlE7UuivdgmNPjzC6THhhpRZwG.sfCCy','nwilliams@example.com','345-678-9012','profile13.jpg','2024-12-07 13:15:52','2024-12-07 13:16:04',3,0,'Noah','Williams'),(14,'opaul','$2a$10$lYcKkIu..JK9vOmTe8Zm3.0bdVpSNKJhqAt7I4B0SOIpAGP2GzRe2','opaul@example.com','456-789-0123','profile14.jpg','2024-12-07 13:15:52','2024-12-07 13:16:05',4,0,'Olivia','Paul'),(15,'pclark','$2a$10$Xo5uTv4kftdYcDFjpWbokutSH2rPpky4FiWjRyCKQndNKkXIz.sxu','pclark@example.com','567-890-1234','profile15.jpg','2024-12-07 13:15:52','2024-12-07 13:16:05',5,0,'Paul','Clark'),(16,'qyoung','$2a$10$k/yb9XaeBd5kKPySkpwgRufG0TTkCJdzfkYNsiHWENG4DSzxTUc2O','qyoung@example.com','678-901-2345','profile16.jpg','2024-12-07 13:15:52','2024-12-07 13:16:05',1,0,'Quinn','Young'),(17,'rhill','$2a$10$e9TVJ3bjx3Ck6.25iwD6/.ZKVN/mSaXhqmjO0xKmv3TqjsyKhB24K','rhill@example.com','789-012-3456','profile17.jpg','2024-12-07 13:15:52','2024-12-07 13:16:05',2,0,'Rachel','Hill'),(18,'sstewart','$2a$10$.c/o4okWK3VLS1i96nCx4O5xoTAyRE..EaYB/jWhBds7vAZOO56re','sstewart@example.com','890-123-4567','profile18.jpg','2024-12-07 13:15:52','2024-12-07 13:16:05',3,0,'Sam','Stewart'),(19,'twhite','$2a$10$CnVfYw3xXbddcJw7E1Yly.RkxFe.bM5Fb5rEUefrsOITdvCXFKEKe','twhite@example.com','901-234-5678','profile19.jpg','2024-12-07 13:15:52','2024-12-07 13:16:05',4,0,'Tina','White'),(21,'newuser','$2a$10$5V48.impRPEN85PoWP94seB3Wm1RHLYLADhfHRYdEvRnNARJiIMbq','ashenafiyirgalem@gmail.com','0938388677','image.jpg','2024-12-07 13:18:08','2024-12-07 13:18:08',2,0,'Ashenafi','Yirgalem');
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

-- Dump completed on 2024-12-09  6:30:31
