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
INSERT INTO `auditlogs` VALUES (2,'Items',1,'INSERT','Added new item Laptop',3,'2024-01-05 08:00:00'),(3,'Requests',1,'INSERT','Created new request for Laptop by user John Doe',4,'2024-01-11 06:00:00'),(4,'Transfers',1,'INSERT','Transferred Laptop from John Doe to Alice Smith',5,'2024-01-15 07:00:00'),(5,'Inventory',1,'INSERT','Added Laptop to inventory in Warehouse A',6,'2024-01-20 08:00:00'),(8,'Technicians',1,'INSERT','Added new technician for IT Support',9,'2024-02-05 11:00:00'),(9,'Roles',1,'INSERT','Added new role Admin',10,'2024-02-10 12:00:00'),(10,'Departments',1,'INSERT','Added new department Human Resources',11,'2024-02-15 13:00:00');
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
INSERT INTO `inventory` VALUES (1,1,30,81),(2,2,50,60),(3,3,40,33),(4,4,100,192),(5,5,200,142),(6,6,20,111),(7,7,60,105),(8,8,70,165),(9,9,35,27),(10,10,120,74),(11,11,150,35),(12,12,200,158),(13,13,1000,200),(14,14,500,37),(15,15,300,255),(16,16,50,216),(17,17,80,57),(18,18,70,77),(19,19,400,188),(20,20,250,225),(21,21,150,73),(22,22,300,127),(23,23,200,160),(24,24,500,163),(25,25,30,81),(26,26,10,121),(27,27,25,106),(28,28,20,143),(29,29,300,142),(30,30,60,26),(31,31,40,141),(32,32,50,139),(33,33,15,250),(34,34,80,113),(35,35,100,253),(36,36,50,210),(37,37,60,34),(38,38,40,210),(39,39,300,228),(40,40,100,26),(41,41,80,112),(42,42,70,226),(43,43,25,78),(44,44,15,148),(45,45,200,250);
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Laptop','High performance laptop','Durable',1200.00,30,'Tech','2024-12-09 04:48:35',NULL,'laptop.jpg',0,NULL,NULL,NULL),(2,'Desk Chair','Ergonomic desk chair','Durable',150.00,50,'Furniture','2024-12-09 04:48:35',NULL,'chair.jpg',0,NULL,NULL,NULL),(3,'Monitor','24-inch LED monitor','Durable',200.00,40,'Tech','2024-12-09 04:48:35',NULL,'monitor.jpg',0,NULL,NULL,NULL),(4,'Keyboard','Mechanical keyboard','Durable',75.00,100,'Tech','2024-12-09 04:48:35',NULL,'keyboard.jpg',0,NULL,NULL,NULL),(5,'Mouse','Wireless mouse','Durable',50.00,200,'Tech','2024-12-09 04:48:35',NULL,'mouse.jpg',0,NULL,NULL,NULL),(6,'Desk','Wooden office desk','Durable',300.00,20,'Furniture','2024-12-09 04:48:35',NULL,'desk.jpg',0,NULL,NULL,NULL),(7,'Phonefds','Smartphone','Durable',800.00,60,'Tech','2024-12-09 04:48:35',NULL,'phone.jpg',0,NULL,NULL,NULL),(8,'Tablet','10-inch tablet','Durable',500.00,70,'Tech','2024-12-09 04:48:35',NULL,'tablet.jpg',0,NULL,NULL,NULL),(9,'Printer','All-in-one printer','Durable',250.00,35,'Tech','2024-12-09 04:48:35',NULL,'printer.jpg',0,NULL,NULL,NULL),(10,'Webcam','HD webcam','Durable',80.00,120,'Tech','2024-12-09 04:48:35',NULL,'webcam.jpg',0,NULL,NULL,NULL),(11,'Coffee','Coffee beans','Non-durable',10.00,150,'Food','2024-12-09 04:48:35','2024-11-11','coffee.jpg',0,NULL,NULL,NULL),(12,'Tea','Green tea','Non-durable',5.00,2041,'Food','2024-12-09 04:48:35','2030-12-05','tea.jpg',0,NULL,NULL,NULL),(13,'Pen','Ballpoint pen','Non-durable',1.00,1000,'Stationery','2024-12-09 04:48:35','2024-10-11','pen.jpg',0,NULL,NULL,NULL),(14,'Notebook','Spiral notebook','Non-durable',3.00,500,'Stationery','2024-12-09 04:48:35','2024-09-11','notebook.jpg',0,NULL,NULL,NULL),(15,'Paper','A4 paper ream','Non-durable',4.00,300,'Stationery','2024-12-09 04:48:35','2024-08-11','paper.jpg',0,NULL,NULL,NULL),(16,'Toner','Laser printer toner','Non-durable',60.00,50,'Tech','2024-12-09 04:48:35','2024-07-11','toner.jpg',0,NULL,NULL,NULL),(17,'Battery','AA battery pack','Non-durable',6.00,80,'Tech','2024-12-09 04:48:35','2024-06-11','battery.jpg',0,NULL,NULL,NULL),(18,'Stapler','Desk stapler','Durable',15.00,70,'Stationery','2024-12-09 04:48:35',NULL,'stapler.jpg',0,NULL,NULL,NULL),(19,'Ruler','Plastic ruler','Durable',2.00,400,'Stationery','2024-12-09 04:48:35',NULL,'ruler.jpg',0,NULL,NULL,NULL),(20,'Markers','Permanent markers','Non-durable',7.00,250,'Stationery','2024-12-09 04:48:35','2024-05-11','markers.jpg',0,NULL,NULL,NULL),(21,'Scissors','Office scissors','Durable',10.00,150,'Stationery','2024-12-09 04:48:35',NULL,'scissors.jpg',0,NULL,NULL,NULL),(22,'Glue','Glue stick','Non-durable',2.00,300,'Stationery','2024-12-09 04:48:35','2024-04-11','glue.jpg',0,NULL,NULL,NULL),(23,'Tape','Scotch tape','Non-durable',3.00,200,'Stationery','2024-12-09 04:48:35','2024-03-11','tape.jpg',0,NULL,NULL,NULL),(24,'Eraser','Rubber eraser','Durable',1.00,500,'Stationery','2024-12-09 04:48:35',NULL,'eraser.jpg',0,NULL,NULL,NULL),(25,'Whiteboard','Dry erase whiteboard','Durable',100.00,30,'Stationery','2024-12-09 04:48:35',NULL,'whiteboard.jpg',0,NULL,NULL,NULL),(26,'Projector','LCD projector','Durable',600.00,10,'Tech','2024-12-09 04:48:35',NULL,'projector.jpg',0,NULL,NULL,NULL),(27,'Router','Wi-Fi router','Durable',120.00,25,'Tech','2024-12-09 04:48:35',NULL,'router.jpg',0,NULL,NULL,NULL),(28,'Switch','Ethernet switch','Durable',200.00,20,'Tech','2024-12-09 04:48:35',NULL,'switch.jpg',0,NULL,NULL,NULL),(29,'Cable','HDMI cable','Durable',10.00,300,'Tech','2024-12-09 04:48:35',NULL,'cable.jpg',0,NULL,NULL,NULL),(30,'Charger','Laptop charger','Durable',50.00,60,'Tech','2024-12-09 04:48:35',NULL,'charger.jpg',0,NULL,NULL,NULL),(31,'Headphones','Noise-cancelling headphones','Durable',150.00,40,'Tech','2024-12-09 04:48:35',NULL,'headphones.jpg',0,NULL,NULL,NULL),(32,'Smartwatch','Fitness tracking smartwatch','Durable',200.00,50,'Tech','2024-12-09 04:48:35',NULL,'smartwatch.jpg',0,NULL,NULL,NULL),(33,'Projector Screen','120-inch projector screen','Durable',100.00,15,'Tech','2024-12-09 04:48:35',NULL,'projector_screen.jpg',0,NULL,NULL,NULL),(34,'Tablet Stand','Adjustable tablet stand','Durable',30.00,80,'Tech','2024-12-09 04:48:35',NULL,'tablet_stand.jpg',0,NULL,NULL,NULL),(35,'HDMI Adapter','HDMI to VGA adapter','Durable',20.00,100,'Tech','2024-12-09 04:48:35',NULL,'hdmi_adapter.jpg',0,NULL,NULL,NULL),(36,'Wireless Keyboard','Bluetooth wireless keyboard','Durable',70.00,50,'Tech','2024-12-09 04:48:35',NULL,'wireless_keyboard.jpg',0,NULL,NULL,NULL),(37,'Bluetooth Speaker','Portable Bluetooth speaker','Durable',90.00,60,'Tech','2024-12-09 04:48:35',NULL,'bluetooth_speaker.jpg',0,NULL,NULL,NULL),(38,'External Hard Drive','1TB external hard drive','Durable',120.00,40,'Tech','2024-12-09 04:48:35',NULL,'external_hard_drive.jpg',0,NULL,NULL,NULL),(39,'USB Flash Drive','64GB USB flash drive','Durable',20.00,300,'Tech','2024-12-09 04:48:35',NULL,'usb_flash_drive.jpg',0,NULL,NULL,NULL),(40,'Power Bank','10000mAh power bank','Durable',40.00,100,'Tech','2024-12-09 04:48:35',NULL,'power_bank.jpg',0,NULL,NULL,NULL),(41,'Wireless Charger','Qi wireless charger','Durable',30.00,80,'Tech','2024-12-09 04:48:35',NULL,'wireless_charger.jpg',0,NULL,NULL,NULL),(42,'Desk Lamp','LED desk lamp','Durable',50.00,70,'Furniture','2024-12-09 04:48:35',NULL,'desk_lamp.jpg',0,NULL,NULL,NULL),(43,'Office Chair','Executive office chair','Durable',250.00,25,'Furniture','2024-12-09 04:48:35',NULL,'office_chair.jpg',0,NULL,NULL,NULL),(44,'File Cabinet','Steel file cabinet','Durable',200.00,15,'Furniture','2024-12-09 04:48:35',NULL,'file_cabinet.jpg',0,NULL,NULL,NULL),(45,'Whiteboard Markers','Dry erase markers','Non-durable',10.00,20055,'Stationery','2024-12-09 04:48:35','5454-04-05','whiteboard_markers.jpg',0,NULL,NULL,NULL);
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
INSERT INTO `refreshtokens` VALUES ('0e58c398-df28-4cca-8869-096ace5c822b',1,'2025-01-09 15:45:51'),('1521eca2-b30a-4f1a-92ab-50299a4c930a',21,'2025-01-10 00:13:00'),('20f640e5-241f-4677-a0ec-c9d0224653b1',3,'2025-01-10 02:59:20'),('2d60c956-95bb-4519-8b48-e5f1055ee6de',21,'2025-01-09 14:09:31'),('31a21bbc-61f1-4725-b609-33cac09989af',1,'2025-01-10 00:40:48'),('46e82043-e2de-46ec-a7ab-08c5dc33aa45',21,'2025-01-09 11:41:56'),('49389540-8095-4de7-b89f-e8eb82093997',1,'2025-01-10 02:58:49'),('4a945df9-5b5c-4d53-b710-80524cd2d1b5',14,'2025-01-10 03:08:53'),('4ae69bc3-0b74-474a-a756-070c9cdd8f50',21,'2025-01-09 15:29:54'),('4e5bcaa9-ea6a-489c-84f7-3c2ce58e663b',21,'2025-01-09 19:49:05'),('60fbccdd-5089-4e90-9a78-fe356119a2fa',3,'2025-01-10 03:53:47'),('6683a323-d9a3-43c7-8d9f-c9608901eab2',4,'2025-01-10 02:15:08'),('6caac013-9822-427a-ba76-9759c55e43a3',1,'2025-01-10 03:52:29'),('6ee13354-0fb7-4871-9a17-d98e97d6a785',14,'2025-01-10 00:13:53'),('867d1334-f9aa-45f2-bc28-05cc5a50cc19',21,'2025-01-09 09:36:19'),('868f7f22-62a4-4caf-abd8-ad126222902e',3,'2025-01-10 00:49:49'),('8800ea14-5b43-4de3-b2b6-34e0990ee809',1,'2025-01-08 07:49:40'),('8e264d1d-668b-48f1-8963-bea90839bd40',1,'2025-01-10 02:27:58'),('8ef5b185-5949-4fc8-ba6a-4cc73673ae6e',14,'2025-01-09 11:44:33'),('9502a35b-5d99-4efb-bc58-310934f4a396',1,'2025-01-10 03:03:14'),('a0b8b2c1-390e-4a40-aaea-10140935cdab',3,'2025-01-10 02:57:50'),('b779bc4c-002f-4b66-bfa3-898579c832d5',4,'2025-01-10 03:57:51'),('c244a712-9161-4c0b-a340-5a122d63452f',21,'2025-01-09 13:09:07'),('d780e5f6-1b18-435a-98f5-60e8357d1c1f',1,'2025-01-09 15:33:41'),('f0a8b765-e340-43d0-b4e1-3d6ae6da8107',1,'2025-01-10 00:03:00'),('faecc1ea-d3de-43b0-b496-bbc859d57ae6',21,'2025-01-09 18:12:03'),('fdc85c73-0523-4ac1-8b53-d32829c44f71',21,'2025-01-09 11:56:46'),('ff5a073e-5dae-4b9d-9fe1-916c8f638e18',21,'2025-01-10 09:00:56');
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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (4,'2024-04-24 21:00:00',4,4,4,'Denied',NULL,'2024-04-25 21:00:00'),(6,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(7,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(8,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(9,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(10,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(11,'2024-06-04 21:00:00',6,6,1,'Approved',10,'2024-06-05 21:00:00'),(14,'2024-09-19 21:00:00',9,9,1,'Denied',12,'2024-09-20 21:00:00'),(15,'2024-10-24 21:00:00',10,10,2,'Approved',13,'2024-10-25 21:00:00'),(16,'2024-11-29 21:00:00',11,11,2,'Denied',NULL,NULL),(17,'2024-12-04 21:00:00',12,12,1,'Approved',14,'2024-12-05 21:00:00'),(22,'2024-05-29 21:00:00',17,17,3,'Denied',NULL,NULL),(25,'2024-08-14 21:00:00',20,20,1,'Denied',NULL,NULL),(30,'2024-12-10 08:19:08',1,5,1,'Denied',NULL,NULL),(32,'2024-12-10 08:27:29',NULL,1,1,'Denied',NULL,NULL),(81,'2024-12-11 00:09:02',14,12,1,'Pending',NULL,NULL),(82,'2024-12-11 00:09:05',14,14,1,'Pending',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(4,'faculity'),(2,'manager'),(5,'staff'),(3,'user');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
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
INSERT INTO `transfers` VALUES (3,3,4,3,1,'Pending','2024-03-24 21:00:00',NULL,NULL),(4,4,5,4,1,'Denied','2024-04-29 21:00:00',NULL,'2024-04-30 21:00:00'),(5,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(7,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(9,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(11,5,6,5,1,'Approved','2024-05-04 21:00:00',9,'2024-05-05 21:00:00'),(15,9,10,9,1,'Denied','2024-09-24 21:00:00',12,'2024-09-25 21:00:00'),(16,10,11,10,1,'Approved','2024-10-29 21:00:00',13,'2024-10-30 21:00:00'),(17,11,12,11,1,'Pending','2024-11-03 21:00:00',NULL,NULL),(18,12,13,12,1,'Approved','2024-12-08 21:00:00',14,'2024-12-09 21:00:00'),(19,13,14,13,1,'Approved','2024-01-13 21:00:00',15,'2024-01-14 21:00:00'),(20,14,15,14,1,'Denied','2024-02-17 21:00:00',16,'2024-02-18 21:00:00'),(21,15,16,15,1,'Approved','2024-03-23 21:00:00',17,'2024-03-24 21:00:00'),(22,16,17,16,1,'Approved','2024-04-27 21:00:00',18,'2024-04-28 21:00:00'),(23,17,18,17,1,'Pending','2024-05-02 21:00:00',NULL,NULL),(24,18,19,18,1,'Approved','2024-06-06 21:00:00',19,'2024-06-07 21:00:00'),(25,19,20,19,1,'Approved','2024-07-11 21:00:00',20,'2024-07-12 21:00:00'),(26,20,1,20,1,'Pending','2024-08-16 21:00:00',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useritems`
--

LOCK TABLES `useritems` WRITE;
/*!40000 ALTER TABLE `useritems` DISABLE KEYS */;
INSERT INTO `useritems` VALUES (1,1,1,1,'2024-01-01',12),(3,3,3,1,'2024-03-10',36),(4,4,4,1,'2024-04-15',48),(5,5,5,1,'2024-05-20',60),(6,6,6,1,'2024-06-25',72),(9,9,9,1,'2024-09-09',108),(10,10,10,1,'2024-10-14',120),(11,11,11,1,'2024-11-19',132),(12,12,12,1,'2024-12-24',144),(13,13,13,1,'2024-01-01',156),(14,14,14,1,'2024-02-06',168),(15,15,15,1,'2024-03-11',180),(16,16,16,1,'2024-04-16',192),(17,17,17,1,'2024-05-21',204),(18,18,18,1,'2024-06-26',216),(19,19,19,1,'2024-07-31',228),(20,20,20,1,'2024-08-05',240),(21,3,3,3,'2024-12-11',NULL),(22,5,5,2,'2024-12-11',NULL),(23,1,1,1,'2024-12-11',NULL),(24,1,1,1,'2024-12-11',NULL),(25,1,3,1,'2024-12-11',NULL),(26,1,1,1,'2024-12-11',NULL),(27,14,20,1,'2024-12-11',NULL),(28,14,23,1,'2024-12-11',NULL),(29,14,13,1,'2024-12-11',NULL),(30,1,3,1,'2024-12-11',NULL),(31,1,14,1,'2024-12-11',NULL),(32,1,1,1,'2024-12-11',NULL),(33,NULL,4,1,'2024-12-11',NULL),(34,NULL,2,1,'2024-12-11',NULL),(35,NULL,2,1,'2024-12-11',NULL),(36,NULL,1,1,'2024-12-11',NULL),(37,NULL,3,1,'2024-12-11',NULL),(38,NULL,2,1,'2024-12-11',NULL),(39,19,19,2,'2024-12-11',NULL),(40,18,18,4,'2024-12-11',NULL),(41,16,16,1,'2024-12-11',NULL),(42,15,15,2,'2024-12-11',NULL),(43,13,13,3,'2024-12-11',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES (1,1,3),(3,3,2),(4,4,5),(5,5,5),(6,6,3),(9,9,4),(10,10,5),(11,11,3),(12,12,2),(13,13,3),(14,14,4),(15,15,5),(16,16,3),(17,17,2),(18,18,3),(19,19,4),(20,20,5),(21,21,1),(23,24,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'us','$2a$10$sf5JQGOjsbPXD1LrEyHEZu0x8DgOabSj1yfxLpaporfAQ67YmJEOO','jdoe@example.com','123-456-7890','profile1.jpg','2024-12-09 04:48:35','2024-12-10 12:30:25',1,0,'John','Doe'),(3,'manager','$2a$10$LWZGwf9WHBLefxoL48zPPO0jq8faSJTrCdKtpkJEqYID5Z2/qfv3S','bjohnson@example.com','345-678-9012','profile3.jpg','2024-12-09 04:48:35','2024-12-10 10:14:40',3,0,'Bob','Johnson'),(4,'staff','$2a$10$g4ExH.ZbM1AEZFhZt03o6O.9vPoxYrAYke/cwLqSFuoT9IIUxuVMG','cwilson@example.com','456-789-0123','profile4.jpg','2024-12-09 04:48:35','2024-12-10 10:15:00',4,0,'Carol','Wilson'),(5,'dlee','$2a$10$.jsl.ggE5ogYdrFGUoo1Tu0E5KH4AaFlhLf.x1X24fC2L2nfM/v1u','dlee@example.com','567-890-1234','profile5.jpg','2024-12-09 04:48:35','2024-12-09 04:49:12',5,0,'David','Lee'),(6,'emartin','$2a$10$y1H8DN/3/JjBLQsK2lTHF.ScwihTuS6FOV9O620M4aaC6eQ5qLIzO','emartin@example.com','678-901-2345','profile6.jpg','2024-12-09 04:48:35','2024-12-09 04:49:12',1,0,'Emily','Martin'),(9,'ijones','$2a$10$xlRP68pK028opUGUInhzLOAodNbO5mm75L8uG2SE6l/KNwxHM.ybe','ijones@example.com','901-234-5678','profile9.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',4,0,'Ivy','Jones'),(10,'kmiller','$2a$10$5G5/5NafaWAJYSSiE6qLKeaYqmFVRAMQBa2i8SE84sNICyC7jua6u','kmiller@example.com','012-345-6789','profile10.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',5,0,'Kyle','Miller'),(11,'lgreen','$2a$10$.oYFMQC8JJFKhr.naNiZiu1wtyyvjKhDUeFSrmIO6mSLNtRHmUSq2','lgreen@example.com','123-456-7890','profile11.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',1,0,'Liam','Green'),(12,'mbrown','$2a$10$Lph2Llo5nBNNca.TY/R7Rea9W.4KuO9FC1IKA.SgoxsEJLnTnTgOy','mbrown@example.com','234-567-8901','profile12.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',2,0,'Mia','Brown'),(13,'nwilliams','$2a$10$dpCrbPngPe0BDczYxFZJc.UWaOmwbHu4t7Ij/bwD2oV5Y81MatjUG','nwilliams@example.com','345-678-9012','profile13.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',3,0,'Noah','Williams'),(14,'fc','$2a$10$gsfi9IVx98Ga.NweNTigQOYpjWrq/EMwgqAtbQYHaGO2Muk2L/1hu','opaul@example.com','456-789-0123','profile14.jpg','2024-12-09 04:48:35','2024-12-10 08:44:10',4,0,'Olivia','Paul'),(15,'pclark','$2a$10$HMsAUUhn38s5C0Mf3fmIV.P2WjIOeyDsxAPccmqv8lYirz0bI2FcW','pclark@example.com','567-890-1234','profile15.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',5,0,'Paul','Clark'),(16,'qyoung','$2a$10$ddiOLnxZC/drqkLKapaey.59nLHPlZGihDMMHjOpJQB50oSomFKLC','qyoung@example.com','678-901-2345','profile16.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',1,0,'Quinn','Young'),(17,'rhill','$2a$10$UTjTMdU3m3aoKDuF/xa2zetHOJ7EF3/T9UOf6qr7W1IRvWROOoBjW','rhill@example.com','789-012-3456','profile17.jpg','2024-12-09 04:48:35','2024-12-09 04:49:13',2,0,'Rachel','Hill'),(18,'sstewart','$2a$10$H/2EoXNdEQpf/hiOohTdcel6Y4MfKMniY2CYjlOpq59aM585e00mO','sstewart@example.com','890-123-4567','profile18.jpg','2024-12-09 04:48:35','2024-12-09 04:49:14',3,0,'Sam','Stewart'),(19,'twhite','$2a$10$uPDi62jaZYsWBD2ukOB7TOACorvP65k4WYQVjkhsgvQngYJ3bItuC','twhite@example.com','901-234-5678','profile19.jpg','2024-12-09 04:48:35','2024-12-10 16:15:12',4,0,'Tina','White'),(20,'uharris','$2a$10$aL1Aeh9rPxlb3RbmbNn9Zen1WzL6OHMOFONMIbR5LPNTOxU6R0xY2','uharris@example.com','012-345-6789','profile20.jpg','2024-12-09 04:48:35','2024-12-09 04:49:14',5,0,'Ursula','Harris'),(21,'ash','$2a$10$jkV445OTLp8XYW5sxeq5COf8kIFqz3sId1FU3HleXckOwZqe3NiBe','ashenafiyirgalem@gmail.com','0938388677','image.jpg','2024-12-09 04:50:16','2024-12-09 04:50:16',2,0,'Ashenafi','Yirgalem'),(24,'user','$2a$10$voZ59KZzOAZpK/CbKBiG0OQng1s7FhS/QnCJV7iFvrQinV2yPG1Ya','ashenafiyirgaool4564em@gmail.com','0938388677','image.jpg','2024-12-10 11:10:06','2024-12-11 06:01:14',2,0,'Ashenafi','Yirgalem');
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

-- Dump completed on 2024-12-11  9:19:45
