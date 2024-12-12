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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Durable Chair','A sturdy chair made of wood','Durable',49.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/chair.jpg',0,'pieces','ABC Furniture Co.','1234XYZ'),(2,'Milk Carton','A 1-liter carton of milk','Non-durable',2.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/milk.jpg',0,'liters','Dairy Co.','5678ABC'),(3,'Meat Minicar','A compact vehicle designed for transporting meat','Durable',4999.99,10,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/meat_minicar.jpg',0,'units','Meat Transport Co.','MM-2023'),(4,'Pasta Scissor','Specialized scissors for cutting pasta dough','Durable',15.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/pasta_scissor.jpg',0,'pieces','Culinary Utensils Co.','PSC-2023'),(5,'Table Spoon','A stainless steel table spoon for dining','Durable',2.49,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/table_spoon.jpg',0,'pieces','Kitchenware Inc.','TS-2023'),(6,'Fork','A stainless steel fork for dining','Durable',1.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/fork.jpg',0,'pieces','Kitchenware Inc.','F-2023'),(7,'Stock Pot','A large 30-liter stock pot for cooking soups and stews','Durable',89.99,20,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/stock_pot.jpg',0,'pieces','Culinary Essentials','SP-30L-2023'),(8,'Knife','A high-quality stainless steel kitchen knife','Durable',25.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/knife.jpg',0,'pieces','Culinary Tools Co.','K-2023'),(9,'Roasting Fork','A long fork for roasting meat over an open fire','Durable',19.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/roasting_fork.jpg',0,'pieces','Outdoor Gear Co.','RF-2023'),(10,'Sharpener Knife','A knife designed specifically for sharpening other knives','Durable',15.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/sharpener_knife.jpg',0,'pieces','Knife Care Co.','SK-2023'),(11,'Coffee Cup','A ceramic cup for enjoying coffee','Durable',9.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/coffee_cup.jpg',0,'pieces','Brewware Inc.','CC-2023'),(12,'Tea Cup','A fine china cup for serving tea','Durable',12.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tea_cup.jpg',0,'pieces','Brewware Inc.','TC-2023'),(13,'Coffee Pot One Liter','A 1-liter coffee pot for brewing coffee','Durable',29.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/coffee_pot.jpg',0,'pieces','Brewware Inc.','CP-1L-2023'),(14,'Tea Pot One Liter','A 1-liter tea pot for brewing tea','Durable',24.99,70,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tea_pot.jpg',0,'pieces','Brewware Inc.','TP-1L-2023'),(15,'Cutlery Trolley','A trolley for organizing and storing cutlery','Durable',149.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/cutlery_trolley.jpg',0,'pieces','Kitchenware Co.','CT-2023'),(16,'Side Plate 320 mm','A 320 mm side plate for serving dishes','Durable',5.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/side_plate.jpg',0,'pieces','Tableware Inc.','SP-320-2023'),(17,'Condiment Set','A set of containers for various condiments','Durable',19.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/condiment_set.jpg',0,'sets','Kitchen Essentials','CS-2023'),(18,'Bottle Opener Windo','A handy bottle opener for easy access','Durable',9.99,120,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/bottle_opener_windo.jpg',0,'pieces','Barware Co.','BOW-2023'),(19,'Bottle Opener Waiyer','A stylish bottle opener for wine bottles','Durable',12.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/bottle_opener_waiyer.jpg',0,'pieces','Barware Co.','BOWW-2023'),(20,'Can Opener','A durable can opener for kitchen use','Durable',15.99,90,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/can_opener.jpg',0,'pieces','Kitchenware Inc.','CO-2023'),(21,'Milk Cup','A cup designed for serving milk','Durable',3.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/milk_cup.jpg',0,'pieces','Drinkware Inc.','MC-2023'),(22,'Knife Sharpener','A tool for sharpening kitchen knives','Durable',19.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/knife_sharpener.jpg',0,'pieces','Knife Care Co.','KS-2023'),(23,'Serving Ladle','A large ladle for serving soups and stews','Durable',12.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/serving_ladle.jpg',0,'pieces','Culinary Essentials','SL-2023'),(24,'Serving Fork','A fork designed for serving food','Durable',10.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/serving_fork.jpg',0,'pieces','Culinary Essentials','SF-2023'),(25,'Serving Fork','A fork designed for serving food','Durable',10.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/serving_fork.jpg',0,'pieces','Culinary Essentials','SF-2023'),(26,'Serving Spoon','A spoon for serving dishes','Durable',11.99,90,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/serving_spoon.jpg',0,'pieces','Culinary Essentials','SS-2023'),(27,'Milk Pot','A pot for heating and serving milk','Durable',24.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/milk_pot.jpg',0,'pieces','Kitchenware Inc.','MP-2023'),(28,'Tea Cup 215ml','A 215ml cup for serving tea','Durable',7.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tea_cup.jpg',0,'pieces','Drinkware Inc.','TC-215-2023'),(29,'Water Glass','A durable glass for serving water','Durable',3.49,300,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/water_glass.jpg',0,'pieces','Glassware Co.','WG-2023'),(30,'Can Opener','A durable can opener for kitchen use','Durable',15.99,90,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/can_opener.jpg',0,'pieces','Kitchenware Inc.','CO-2023'),(31,'Dining Plate','A plate for serving main courses','Durable',8.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/dining_plate.jpg',0,'pieces','Tableware Inc.','DP-2023'),(32,'Stock Pot','A large pot for making stocks and soups','Durable',59.99,40,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/stock_pot.jpg',0,'pieces','Kitchenware Inc.','SP-2023'),(33,'Side Plate','A plate for serving side dishes','Durable',6.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/side_plate.jpg',0,'pieces','Tableware Inc.','SP-2023'),(34,'Floor Mat Roll','A durable roll of floor matting for various uses','Durable',129.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/floor_mat_roll.jpg',0,'meters','Flooring Solutions Co.','FMR-2023'),(35,'Project Pointer','A laser pointer for presentations and projectors','Durable',15.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/project_pointer.jpg',0,'pieces','Tech Tools Inc.','PP-2023'),(36,'Volting Table','A sturdy table for voltage testing','Durable',199.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/volting_table.jpg',0,'pieces','Electrical Solutions Co.','VT-2023'),(37,'Bottle Opener','A durable bottle opener for easy access','Durable',9.99,120,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/bottle_opener.jpg',0,'pieces','Barware Co.','BO-2023'),(38,'Cover Knife','A versatile knife for various cutting tasks','Durable',12.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/cover_knife.jpg',0,'pieces','Cutlery Co.','CK-2023'),(39,'Spatula Thing','A versatile spatula for cooking and serving','Durable',8.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/spatula_thing.jpg',0,'pieces','Kitchen Essentials','ST-2023'),(40,'Milk Pot','A pot for heating and serving milk','Durable',24.99,60,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/milk_pot.jpg',0,'pieces','Kitchenware Inc.','MP-2023'),(41,'Coffee Pot Little','A small coffee pot for brewing coffee','Durable',19.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/coffee_pot_little.jpg',0,'pieces','Brewware Inc.','CPL-2023'),(42,'Tea Pot','A pot for brewing and serving tea','Durable',22.99,70,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tea_pot.jpg',0,'pieces','Brewware Inc.','TP-2023'),(43,'Meat Cleaner','A tool for cleaning and preparing meat','Durable',15.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/meat_cleaner.jpg',0,'pieces','Kitchen Gear Co.','MC-2023'),(44,'Water Glass','A durable glass for serving water','Durable',3.49,300,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/water_glass.jpg',0,'pieces','Glassware Co.','WG-2023'),(45,'Gun Opener Mixing','A multifunctional opener for various uses','Durable',12.99,90,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/gun_opener_mixing.jpg',0,'pieces','Kitchen Solutions Co.','GOM-2023'),(46,'Fork','A stainless steel fork for dining','Durable',1.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/fork.jpg',0,'pieces','Kitchenware Inc.','F-2023'),(47,'Spoon','A stainless steel spoon for dining','Durable',1.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/spoon.jpg',0,'pieces','Kitchenware Inc.','S-2023'),(48,'Plate','A ceramic plate for serving meals','Durable',6.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/plate.jpg',0,'pieces','Tableware Inc.','PL-2023'),(49,'Tea Cup','A cup designed for serving tea','Durable',7.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tea_cup.jpg',0,'pieces','Drinkware Inc.','TC-2023'),(50,'All Purpose Bowser','A versatile bowl for mixing and serving','Durable',14.99,80,'Kitchen Tools','2024-12-12 08:27:30',NULL,'http://example.com/all_purpose_bowser.jpg',0,'pieces','Kitchen Essentials','APB-2023'),(51,'Pasta Scissor Large','Large scissors for cutting pasta dough','Durable',15.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/pasta_scissor_large.jpg',0,'pieces','Culinary Tools Co.','PSL-2023'),(52,'Pasta Scissor 320','320 mm scissors for cutting pasta','Durable',15.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/pasta_scissor_320.jpg',0,'pieces','Culinary Tools Co.','PSS-320-2023'),(53,'Roasting Fork','A long fork for roasting meat over an open fire','Durable',19.99,40,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/roasting_fork.jpg',0,'pieces','Outdoor Gear Co.','RF-2023'),(54,'Bread Basket','A basket for serving bread','Durable',12.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/bread_basket.jpg',0,'pieces','Kitchen Essentials','BB-2023'),(55,'Mixing Bowl Little','A small bowl for mixing ingredients','Durable',9.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/mixing_bowl_little.jpg',0,'pieces','Kitchenware Inc.','MBL-2023'),(56,'Digital Camera Bag','A padded bag for carrying digital cameras','Durable',49.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/digital_camera_bag.jpg',0,'pieces','Camera Gear Co.','DCB-2023'),(57,'Sherator Chair Carve','A carved wooden chair for dining','Durable',199.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/sherator_chair_carve.jpg',0,'pieces','Furniture Makers Inc.','SCC-2023'),(58,'Political Book Hidase','A book discussing political theories and practices','Non-durable',29.99,150,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/political_book_hidase.jpg',0,'pieces','Publishing House','PBH-2023'),(59,'Generate Store Shelf','Adjustable shelving for retail displays','Durable',89.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/store_shelf.jpg',0,'pieces','Retail Solutions Co.','GSS-2023'),(60,'Laser Bag','A bag designed for carrying laser equipment','Durable',39.99,60,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/laser_bag.jpg',0,'pieces','Laser Tech Inc.','LB-2023'),(61,'GPS','A portable GPS device for navigation','Durable',119.99,70,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/gps.jpg',0,'pieces','Navigation Systems Inc.','GPS-2023'),(62,'Steel Pot','A durable pot for cooking and boiling','Durable',34.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/steel_pot.jpg',0,'pieces','Kitchenware Inc.','SP-2023'),(63,'Restaurant Table','A sturdy table for restaurant dining','Durable',199.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/restaurant_table.jpg',0,'pieces','Furniture Makers Inc.','RT-2023'),(64,'Pasta Dip','A flavorful dip for pasta dishes','Non-durable',5.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/pasta_dip.jpg',0,'pieces','Gourmet Foods Co.','PD-2023'),(65,'Kitchen Reducer Plate','A plate designed for reducing food waste','Durable',12.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/kitchen_reducer_plate.jpg',0,'pieces','Eco Kitchen Co.','KRP-2023'),(66,'Onion Chop','A tool for chopping onions easily','Durable',9.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/onion_chop.jpg',0,'pieces','Culinary Tools Co.','OC-2023'),(67,'English Book','A comprehensive guide to English literature','Non-durable',24.99,120,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/english_book.jpg',0,'pieces','Publishing House','EB-2023'),(68,'Physics Book 7-8 Grade','A physics textbook for 7th and 8th graders','Non-durable',29.99,100,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/physics_book_7_8.jpg',0,'pieces','Education Publishing','PB78-2023'),(69,'Medium L-Shape Table','A medium-sized L-shaped table for offices','Durable',249.99,40,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/medium_l_shape_table.jpg',0,'pieces','Office Furniture Co.','MLT-2023'),(70,'Tennis Board','A board for keeping score in tennis','Durable',29.99,60,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tennis_board.jpg',0,'pieces','Sports Gear Co.','TB-2023'),(71,'Aluminum','High-quality aluminum sheets','Durable',1.99,1000,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/aluminum.jpg',0,'kilograms','Metalworks Inc.','AL-2023'),(72,'Water Filter','A filter for purifying drinking water','Durable',39.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/water_filter.jpg',0,'pieces','Purity Solutions','WF-2023'),(73,'Chalk Board','A board for writing with chalk','Durable',49.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/chalk_board.jpg',0,'pieces','Office Essentials','CB-2023'),(74,'Corn Threshing Machine','A machine for threshing corn','Durable',599.99,10,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/corn_threshing_machine.jpg',0,'pieces','AgriTech Co.','CTM-2023'),(75,'Aluminum In Meter','Aluminum rods measured in meters','Durable',5.99,500,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/aluminum_meter.jpg',0,'meters','Metalworks Inc.','AIM-2023'),(76,'Laptop Computer i7','A high-performance laptop with Intel i7 processor','Durable',999.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/laptop_i7.jpg',0,'pieces','Tech Solutions Inc.','LAP-I7-2023'),(77,'Laptop Computer i5','A reliable laptop with Intel i5 processor','Durable',749.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/laptop_i5.jpg',0,'pieces','Tech Solutions Inc.','LAP-I5-2023'),(78,'Desktop Computer HP 7','A powerful desktop computer by HP','Durable',599.99,20,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/desktop_hp7.jpg',0,'pieces','HP Inc.','DHP-7-2023'),(79,'Adjustable Basketball','An adjustable basketball hoop for outdoor use','Durable',199.99,15,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/adjustable_basketball.jpg',0,'pieces','Sports Gear Co.','AB-2023'),(80,'Butcher Extractor','A machine for extracting meat from bones','Durable',299.99,20,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/butcher_extractor.jpg',0,'pieces','Food Machinery Co.','BE-2023'),(81,'Plastic Mat','A lightweight mat for various uses','Durable',19.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/plastic_mat.jpg',0,'pieces','Home Essentials','PM-2023'),(82,'HP Charger','A charger for HP laptops','Durable',39.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/hp_charger.jpg',0,'pieces','HP Inc.','HC-2023'),(83,'Wall Paint: 118','High-quality wall paint in color 118','Durable',24.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/wall_paint_118.jpg',0,'liters','Paints Co.','WP-118-2023'),(84,'Color Painting Brush','A brush for painting with various colors','Durable',3.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/color_painting_brush.jpg',0,'pieces','Art Supplies Co.','CPB-2023'),(85,'Metallic Paint','Shiny paint for decorative purposes','Durable',29.99,60,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/metallic_paint.jpg',0,'liters','Paints Co.','MP-2023'),(86,'Nails in Different Numbers','A collection of nails in various sizes','Durable',9.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/nails_different_numbers.jpg',0,'pieces','Hardware Supplies Inc.','NDN-2023'),(87,'Shovel','A durable shovel for digging','Durable',24.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/shovel.jpg',0,'pieces','Garden Gear Co.','SH-2023'),(88,'Shorts','Comfortable shorts for casual wear','Non-durable',19.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/shorts.jpg',0,'pieces','Fashion Co.','SH-2023'),(89,'Allo','A versatile multi-use tool','Durable',15.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/allo.jpg',0,'pieces','Tool Co.','AL-2023'),(90,'Coach Watch','A stylish watch by Coach','Durable',199.99,40,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/coach_watch.jpg',0,'pieces','Coach','CW-2023'),(91,'Stop Watch','A reliable stop watch for timing','Durable',14.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/stop_watch.jpg',0,'pieces','Sports Gear Co.','SW-2023'),(92,'Tennis Ball','A high-quality tennis ball for matches','Durable',2.99,300,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tennis_ball.jpg',0,'pieces','Sports Gear Co.','TB-2023'),(93,'Notebook','A spiral-bound notebook for writing notes','Non-durable',3.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/notebook.jpg',0,'pieces','Stationery Co.','NB-2023'),(94,'Chart','A large chart for educational purposes','Non-durable',14.99,100,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/chart.jpg',0,'pieces','Educational Supplies Co.','CH-2023'),(95,'Adapter','A universal adapter for electronic devices','Durable',19.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/adapter.jpg',0,'pieces','Tech Gear Inc.','AD-2023'),(96,'Guard Cabort','Protective gear for work environments','Durable',89.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/guard_cabort.jpg',0,'pieces','Safety Gear Co.','GC-2023'),(97,'Safety Shoes','Durable shoes designed for protection at work','Durable',59.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/safety_shoes.jpg',0,'pairs','Footwear Co.','SS-2023'),(98,'Pipe Range','A set of pipes for various uses','Durable',49.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/pipe_range.jpg',0,'pieces','Construction Supplies Inc.','PR-2023'),(99,'Hurdle','A portable hurdle for training and competitions','Durable',39.99,40,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/hurdle.jpg',0,'pieces','Sports Gear Co.','HR-2023'),(100,'Roll Mat','A versatile mat for workouts and activities','Durable',29.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/roll_mat.jpg',0,'pieces','Fitness Gear Inc.','RM-2023'),(101,'Table Tennis Ball','High-quality ball for table tennis games','Non-durable',2.49,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/table_tennis_ball.jpg',0,'pieces','Sports Gear Co.','TTB-2023'),(102,'Carbon','Carbon materials for various applications','Durable',19.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/carbon.jpg',0,'kilograms','Materials Co.','C-2023'),(103,'Calculator','A scientific calculator for educational use','Non-durable',24.99,120,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/calculator.jpg',0,'pieces','Tech Gear Inc.','CAL-2023'),(104,'Paper A-3','A3 size paper for printing and drawing','Non-durable',9.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/paper_a3.jpg',0,'reams','Paper Co.','PA3-2023'),(105,'Pen','A ballpoint pen for writing','Non-durable',1.49,500,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/pen.jpg',0,'pieces','Stationery Co.','PEN-2023'),(106,'Chalk','White chalk for writing on blackboards','Non-durable',2.99,300,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/chalk.jpg',0,'boxes','School Supplies Co.','CH-2023'),(107,'Obstacle','Training obstacle for sports and fitness','Durable',49.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/obstacle.jpg',0,'pieces','Sports Gear Co.','OB-2023'),(108,'Wire Coil','High-quality wire coil for various uses','Durable',19.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/wire_coil.jpg',0,'meters','Hardware Supplies Inc.','WC-2023'),(109,'Stock Card','A card for tracking stock levels','Non-durable',4.99,150,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/stock_card.jpg',0,'pieces','Stationery Co.','SC-2023'),(110,'Stapler Hit','A heavy-duty stapler for binding papers','Non-durable',12.99,80,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/stapler_hit.jpg',0,'pieces','Office Supplies Co.','SH-2023'),(111,'Vin Card','A card for tracking wine inventory','Non-durable',6.99,100,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/vin_card.jpg',0,'pieces','Stationery Co.','VC-2023'),(112,'Medium Notebook','A medium-sized notebook for notes','Non-durable',5.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/medium_notebook.jpg',0,'pieces','Stationery Co.','MN-2023'),(113,'Coffee Cup','A ceramic cup for serving coffee','Durable',7.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/coffee_cup.jpg',0,'pieces','Kitchenware Inc.','CC-2023'),(114,'Thermometer','A digital thermometer for measuring temperature','Durable',19.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/thermometer.jpg',0,'pieces','Medical Gear Co.','TH-2023'),(115,'Round Stamp','A round stamp for marking documents','Non-durable',15.99,100,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/round_stamp.jpg',0,'pieces','Office Supplies Co.','RS-2023'),(116,'Titer','A device for measuring liquid volumes','Durable',39.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/titer.jpg',0,'pieces','Lab Equipment Co.','T-2023'),(117,'Phase Bar','A tool for electrical phase management','Durable',29.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/phase_bar.jpg',0,'pieces','Electrical Supplies Co.','PB-2023'),(118,'Photo Camera Memory','Memory card for digital cameras','Durable',19.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/photo_camera_memory.jpg',0,'pieces','Camera Gear Inc.','PCM-2023'),(119,'Mill Rucker','A tool for milling and cutting','Durable',199.99,20,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/mill_rucker.jpg',0,'pieces','Machinery Co.','MR-2023'),(120,'Wood Saw','A hand saw for cutting wood','Durable',14.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/wood_saw.jpg',0,'pieces','Tool Co.','WS-2023'),(121,'Graphic Plastic','Plastic sheets for graphic design','Durable',9.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/graphic_plastic.jpg',0,'sheets','Art Supplies Co.','GP-2023'),(122,'Video Camera Disk','Disk for storing video footage','Durable',29.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/video_camera_disk.jpg',0,'pieces','Camera Gear Inc.','VCD-2023'),(123,'Cable Converter','Adapter for converting cable types','Durable',15.99,75,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/cable_converter.jpg',0,'pieces','Tech Gear Inc.','CC-2023'),(124,'Tricking Fur','Artificial fur for costumes and crafts','Durable',24.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/tricking_fur.jpg',0,'meters','Craft Materials Co.','TF-2023'),(125,'Certificate Paper','Special paper for printing certificates','Non-durable',12.99,100,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/certificate_paper.jpg',0,'reams','Paper Co.','CP-2023'),(126,'Battery Stone','Portable battery charger','Durable',39.99,60,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/battery_stone.jpg',0,'pieces','Power Solutions Inc.','BS-2023'),(127,'Silver Strap','Stylish strap for watches and accessories','Durable',19.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/silver_strap.jpg',0,'pieces','Fashion Co.','SS-2023'),(128,'Electric Wire','High-quality wire for electrical work','Durable',0.99,1000,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/electric_wire.jpg',0,'meters','Electrical Supplies Co.','EW-2023'),(129,'Lenebo Charger','Charger for Lenebo devices','Durable',29.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/lenebo_charger.jpg',0,'pieces','Tech Gear Inc.','LC-2023'),(130,'Silver','High-quality silver for crafting','Durable',24.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/silver.jpg',0,'grams','Metals Inc.','SIL-2023'),(131,'Computer Paper A-4','A4 size paper for printers','Non-durable',8.99,200,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/computer_paper_a4.jpg',0,'reams','Paper Co.','CPA4-2023'),(132,'Blanket','A warm blanket for comfort','Durable',39.99,80,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/blanket.jpg',0,'pieces','Home Essentials','BL-2023'),(133,'Linen','High-quality linen fabric for clothing','Durable',19.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/linen.jpg',0,'meters','Textiles Co.','LIN-2023'),(134,'Bijama','Comfortable pajamas for sleep','Non-durable',24.99,150,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/bijama.jpg',0,'pieces','Fashion Co.','BJ-2023'),(135,'Rainwear','Waterproof clothing for rainy weather','Non-durable',39.99,60,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/rainwear.jpg',0,'pieces','Fashion Co.','RW-2023'),(136,'Stapler','A tool for stapling papers together','Non-durable',12.99,100,'Non-durable','2024-12-12 08:27:30','2028-11-11','http://example.com/stapler.jpg',0,'pieces','Office Supplies Co.','ST-2023'),(137,'Board Betel 3mm','3mm thick betel board for various applications','Durable',19.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/board_betel_3mm.jpg',0,'sheets','Board Manufacturing Co.','BB-3MM-2023'),(138,'Paint Brush','A brush for applying paint on surfaces','Durable',5.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/paint_brush.jpg',0,'pieces','Art Supplies Co.','PB-2023'),(139,'Door Handle','Durable handle for doors','Durable',14.99,150,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/door_handle.jpg',0,'pieces','Hardware Co.','DH-2023'),(140,'Soundproofing','Material for soundproofing walls','Durable',49.99,50,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/soundproofing.jpg',0,'sheets','Acoustic Solutions Inc.','SP-2023'),(141,'Google Glass','Smart glasses with augmented reality features','Durable',1499.99,30,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/google_glass.jpg',0,'pieces','Google','GG-2023'),(142,'Welding Glass','Protective glass for welding applications','Durable',39.99,40,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/welding_glass.jpg',0,'pieces','Welding Supplies Co.','WG-2023'),(143,'Switch Tawny','Electrical switch for controlling power','Durable',9.99,100,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/switch_tawny.jpg',0,'pieces','Electrical Co.','ST-2023'),(144,'Electrode 2.5','2.5mm electrode for welding','Durable',1.99,200,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/electrode_2_5.jpg',0,'pieces','Welding Gear Co.','E-2.5-2023'),(145,'Squadron','A model kit for building aircraft squadrons','Durable',29.99,60,'Durable','2024-12-12 08:27:30',NULL,'http://example.com/squadron.jpg',0,'kits','Hobby Co.','SQ-2023'),(146,'Textbook: Advanced Calculus','A comprehensive guide to advanced calculus','Non-durable',49.99,150,'Education','2024-12-12 08:27:30','2028-11-11','http://example.com/textbook_advanced_calculus.jpg',0,'pieces','Education Publishing','TAC-2023'),(147,'Study Guide: Literature Analysis','A guide to analyzing literature','Non-durable',24.99,100,'Education','2024-12-12 08:27:30','2028-11-11','http://example.com/study_guide_literature.jpg',0,'pieces','Education Publishing','SGL-2023'),(148,'Spiral Notebook','A notebook for note-taking','Non-durable',3.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/spiral_notebook.jpg',0,'pieces','Stationery Co.','SN-2023'),(149,'Legal Pad','A pad for writing notes','Non-durable',2.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/legal_pad.jpg',0,'pieces','Stationery Co.','LP-2023'),(150,'Ballpoint Pens','Pack of 10 blue ballpoint pens','Non-durable',1.99,500,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/ballpoint_pens.jpg',0,'packs','Stationery Co.','BP-2023'),(151,'Highlighters','Pack of 6 assorted highlighters','Non-durable',4.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/highlighters.jpg',0,'packs','Stationery Co.','HL-2023'),(152,'Sticky Notes','Pack of sticky notes for reminders','Non-durable',2.49,400,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/sticky_notes.jpg',0,'packs','Stationery Co.','SN-2023'),(153,'Printer Paper','500 sheets of A4 printer paper','Non-durable',9.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/printer_paper.jpg',0,'reams','Paper Co.','PP-2023'),(154,'Photocopy Paper','1000 sheets of A3 photocopy paper','Non-durable',18.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/photocopy_paper.jpg',0,'reams','Paper Co.','PCP-2023'),(155,'Staplers','Standard stapler for office use','Non-durable',12.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/stapler.jpg',0,'pieces','Office Supplies Co.','ST-2023'),(156,'Binder Clips','Pack of 24 binder clips','Non-durable',3.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/binder_clips.jpg',0,'packs','Office Supplies Co.','BC-2023'),(157,'Push Pins','Pack of 100 push pins','Non-durable',1.49,400,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/push_pins.jpg',0,'packs','Office Supplies Co.','PP-2023'),(158,'Whiteboard Markers','Set of 4 whiteboard markers','Non-durable',6.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/whiteboard_markers.jpg',0,'sets','Educational Supplies Co.','WM-2023'),(159,'Chalk','Pack of 10 white chalk sticks','Non-durable',1.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/chalk.jpg',0,'packs','School Supplies Co.','CH-2023'),(160,'Lanyards','Pack of 50 lanyards for ID cards','Non-durable',19.99,100,'Office Supplies','2024-12-12 08:27:30','2028-11-11','http://example.com/lanyards.jpg',0,'packs','Office Supplies Co.','LN-2023'),(161,'ID Card Holders','Pack of 50 ID card holders','Non-durable',14.99,100,'Office Supplies','2024-12-12 08:27:30','2028-11-11','http://example.com/id_card_holders.jpg',0,'packs','Office Supplies Co.','IDH-2023'),(162,'USB Flash Drives','16GB USB flash drives','Non-durable',9.99,50,'Electronics','2024-12-12 08:27:30','2028-11-11','http://example.com/usb_flash_drives.jpg',0,'pieces','Tech Supplies Co.','USB-2023'),(163,'Desk Calendars','2024 desk calendars','Non-durable',7.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/desk_calendars.jpg',0,'pieces','Stationery Co.','DC-2023'),(164,'Markers','Pack of 12 assorted markers','Non-durable',5.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/markers.jpg',0,'packs','Stationery Co.','MK-2023'),(165,'Paper Clips','Pack of 100 paper clips','Non-durable',1.99,500,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/paper_clips.jpg',0,'packs','Stationery Co.','PC-2023'),(166,'Scissors','Standard office scissors','Non-durable',3.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/scissors.jpg',0,'pieces','Office Supplies Co.','SC-2023'),(167,'Folders','Pack of 10 file folders','Non-durable',4.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/file_folders.jpg',0,'packs','Office Supplies Co.','FF-2023'),(168,'Rulers','Standard 12-inch rulers','Non-durable',1.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/rulers.jpg',0,'pieces','Stationery Co.','RUL-2023'),(169,'Binders','3-ring binders for documents','Non-durable',6.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/binders.jpg',0,'pieces','Office Supplies Co.','BD-2023'),(170,'Drawing Paper','A3 size drawing paper for art classes','Non-durable',9.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/drawing_paper.jpg',0,'reams','Art Supplies Co.','DP-2023'),(171,'Poster Board','Pack of 10 poster boards for presentations','Non-durable',12.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/poster_board.jpg',0,'packs','Educational Supplies Co.','PB-2023'),(172,'Index Cards','Pack of 100 index cards for notes','Non-durable',2.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/index_cards.jpg',0,'packs','Stationery Co.','IC-2023'),(173,'File Folders','Pack of 12 file folders for organization','Non-durable',6.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/file_folders.jpg',0,'packs','Office Supplies Co.','FF-2023'),(174,'Bulletin Board Pins','Pack of 50 pins for bulletin boards','Non-durable',1.99,500,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/bulletin_board_pins.jpg',0,'packs','Office Supplies Co.','BBP-2023'),(175,'Note Cards','Pack of 50 note cards for reminders','Non-durable',3.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/note_cards.jpg',0,'packs','Stationery Co.','NC-2023'),(176,'Manila Folders','Pack of 20 manila folders for documents','Non-durable',5.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/manila_folders.jpg',0,'packs','Office Supplies Co.','MF-2023'),(177,'Name Badges','Pack of 100 name badges for events','Non-durable',9.99,100,'Office Supplies','2024-12-12 08:27:30','2028-11-11','http://example.com/name_badges.jpg',0,'packs','Office Supplies Co.','NB-2023'),(178,'Memo Pads','Pack of 5 memo pads for notes','Non-durable',4.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/memo_pads.jpg',0,'packs','Stationery Co.','MP-2023'),(179,'Clipboard','Standard clipboard for holding documents','Non-durable',2.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/clipboard.jpg',0,'pieces','Office Supplies Co.','CB-2023'),(180,'Whiteboard Eraser','Eraser for cleaning whiteboards','Non-durable',3.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/whiteboard_eraser.jpg',0,'pieces','Educational Supplies Co.','WE-2023'),(181,'Crayons','Box of 24 crayons for coloring','Non-durable',2.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/crayons.jpg',0,'boxes','Art Supplies Co.','CR-2023'),(182,'Glue Sticks','Pack of 10 glue sticks for projects','Non-durable',4.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/glue_sticks.jpg',0,'packs','Art Supplies Co.','GS-2023'),(183,'Rubber Bands','Pack of 100 rubber bands for office use','Non-durable',1.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/rubber_bands.jpg',0,'packs','Office Supplies Co.','RB-2023'),(184,'Sharpie Markers','Pack of 8 permanent markers','Non-durable',5.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/sharpie_markers.jpg',0,'packs','Stationery Co.','SM-2023'),(185,'Colored Pencils','Box of 12 colored pencils for art','Non-durable',4.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/colored_pencils.jpg',0,'boxes','Art Supplies Co.','CP-2023'),(186,'Erasers','Pack of 10 erasers for pencils','Non-durable',2.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/erasers.jpg',0,'packs','Stationery Co.','ER-2023'),(187,'Correction Tape','Pack of 5 correction tapes for errors','Non-durable',5.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/correction_tape.jpg',0,'packs','Office Supplies Co.','CT-2023'),(188,'Sticky Flags','Pack of sticky flags for marking pages','Non-durable',3.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/sticky_flags.jpg',0,'packs','Stationery Co.','SF-2023'),(189,'Report Covers','Pack of 10 report covers for documents','Non-durable',6.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/report_covers.jpg',0,'packs','Office Supplies Co.','RC-2023'),(190,'Composition Books','Composition books for writing','Non-durable',3.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/composition_books.jpg',0,'pieces','Stationery Co.','CB-2023'),(191,'Graph Paper','Pack of graph paper for math classes','Non-durable',4.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/graph_paper.jpg',0,'packs','Educational Supplies Co.','GP-2023'),(192,'Sticky Tabs','Pack of 12 sticky tabs for notes','Non-durable',3.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/sticky_tabs.jpg',0,'packs','Stationery Co.','ST-2023'),(193,'Presentation Folders','Pack of 6 folders for presentations','Non-durable',4.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/presentation_folders.jpg',0,'packs','Office Supplies Co.','PF-2023'),(194,'Pen Refills','Pack of pen refills for ballpoint pens','Non-durable',2.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/pen_refills.jpg',0,'packs','Stationery Co.','PR-2023'),(195,'Index Tabs','Pack of 5 sets of index tabs for organizing files','Non-durable',3.49,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/index_tabs.jpg',0,'packs','Stationery Co.','IT-2023'),(196,'Correction Fluid','Bottle of correction fluid for errors','Non-durable',1.99,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/correction_fluid.jpg',0,'bottles','Office Supplies Co.','CF-2023'),(197,'Duct Tape','Roll of duct tape for various uses','Non-durable',4.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/duct_tape.jpg',0,'rolls','Office Supplies Co.','DT-2023'),(198,'Mouse Pads','Standard mouse pads for computers','Non-durable',5.99,100,'Office Supplies','2024-12-12 08:27:30','2028-11-11','http://example.com/mouse_pads.jpg',0,'pieces','Tech Supplies Co.','MP-2023'),(199,'Notebook Labels','Pack of labels for notebooks and folders','Non-durable',2.49,300,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/notebook_labels.jpg',0,'packs','Stationery Co.','NL-2023'),(200,'Tape Dispensers','Standard tape dispensers for office use','Non-durable',7.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/tape_dispensers.jpg',0,'pieces','Office Supplies Co.','TD-2023'),(201,'Whiteboard Cleaner','Spray for cleaning whiteboards','Non-durable',3.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/whiteboard_cleaner.jpg',0,'bottles','Educational Supplies Co.','WC-2023'),(202,'Graphing Calculators','Advanced graphing calculators for math classes','Non-durable',79.99,50,'Electronics','2024-12-12 08:27:30','2028-11-11','http://example.com/graphing_calculators.jpg',0,'pieces','Tech Supplies Co.','GC-2023'),(203,'Sticky Notes Holder','Holder for organizing sticky notes','Non-durable',4.99,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/sticky_notes_holder.jpg',0,'pieces','Office Supplies Co.','SNH-2023'),(204,'Printer Ink','Cartridges of printer ink for office printers','Non-durable',29.99,80,'Office Supplies','2024-12-12 08:27:30','2028-11-11','http://example.com/printer_ink.jpg',0,'cartridges','Tech Supplies Co.','PI-2023'),(205,'Report Binders','Binders for holding multiple reports','Non-durable',8.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/report_binders.jpg',0,'pieces','Office Supplies Co.','RB-2023'),(206,'Presentation Pointers','Laser pointers for presentations','Non-durable',19.99,50,'Electronics','2024-12-12 08:27:30','2028-11-11','http://example.com/presentation_pointers.jpg',0,'pieces','Tech Supplies Co.','PP-2023'),(207,'Thumb Drives','32GB thumb drives for data storage','Non-durable',14.99,50,'Electronics','2024-12-12 08:27:30','2028-11-11','http://example.com/thumb_drives.jpg',0,'pieces','Tech Supplies Co.','TD-2023'),(208,'Paper Shredders','Office paper shredders for secure document disposal','Non-durable',49.99,30,'Office Supplies','2024-12-12 08:27:30','2028-11-11','http://example.com/paper_shredders.jpg',0,'pieces','Office Supplies Co.','PS-2023'),(209,'Laminating Sheets','Pack of 100 laminating sheets for documents','Non-durable',19.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/laminating_sheets.jpg',0,'packs','Office Supplies Co.','LS-2023'),(210,'Dry Erase Boards','Small dry erase boards for personal use','Non-durable',9.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/dry_erase_boards.jpg',0,'pieces','Educational Supplies Co.','DEB-2023'),(211,'Binder Dividers','Pack of 8 binder dividers for organizing','Non-durable',3.49,150,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/binder_dividers.jpg',0,'packs','Office Supplies Co.','BD-2023'),(212,'Easel Pads','Large pads for easel presentations','Non-durable',24.99,50,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/easel_pads.jpg',0,'pieces','Educational Supplies Co.','EP-2023'),(213,'High-Capacity Staplers','Heavy-duty staplers for thick documents','Non-durable',19.99,50,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/high_capacity_staplers.jpg',0,'pieces','Office Supplies Co.','HCS-2023'),(214,'Presentation Boards','Tri-fold presentation boards','Non-durable',7.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/presentation_boards.jpg',0,'pieces','Educational Supplies Co.','PB-2023'),(215,'Lecture Pads','Notepads for lectures and meetings','Non-durable',4.99,200,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/lecture_pads.jpg',0,'pieces','Stationery Co.','LP-2023'),(216,'Expanding Files','Files that expand to hold many documents','Non-durable',6.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/expanding_files.jpg',0,'pieces','Office Supplies Co.','EF-2023'),(217,'Presentation Kits','Complete kits for presentations','Non-durable',29.99,50,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/presentation_kits.jpg',0,'sets','Educational Supplies Co.','PK-2023'),(218,'Label Makers','Devices for printing labels','Non-durable',34.99,30,'Electronics','2024-12-12 08:27:30','2028-11-11','http://example.com/label_makers.jpg',0,'pieces','Tech Supplies Co.','LM-2023'),(219,'Magazine Holders','Holders for organizing magazines','Non-durable',9.99,100,'Stationery','2024-12-12 08:27:30','2028-11-11','http://example.com/magazine_holders.jpg',0,'pieces','Office Supplies Co.','MH-2023'),(220,'File Cabinet','Steel file cabinet','Non-durable',200.00,15,NULL,'2024-12-12 08:38:03',NULL,NULL,0,NULL,NULL,NULL);
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
    IF NEW.category = 'Non-durable' AND NEW.expiration_date <= CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot store expired non-durable items.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prevent_update_expiration_date` BEFORE UPDATE ON `items` FOR EACH ROW BEGIN
    IF OLD.category = 'Non-durable' AND NEW.expiration_date <> OLD.expiration_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expiration date cannot be updated for non-durable items.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `message` text NOT NULL,
  `notification_type` enum('Info','Warning','Critical') DEFAULT 'Info',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
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
INSERT INTO `refreshtokens` VALUES ('4b6d384e-0935-4689-909f-b52bcde7be13',2,'2025-01-11 11:28:05'),('50a9d1b7-e22d-426c-a5d6-9b714054132d',2,'2025-01-11 11:55:03'),('6b2e52a6-997d-4757-8472-0bb7224ea5aa',2,'2025-01-11 11:48:19'),('72c66a3f-9ec5-4dfe-82ec-835d7c16d4a4',4,'2025-01-11 11:37:30'),('73875430-d2b5-46d0-9b86-6f99503f7d34',2,'2025-01-11 12:09:51'),('7cbbff21-c128-429a-bf4f-1c567b83a67b',1,'2025-01-11 12:11:43'),('9d2f4f91-d960-4290-b99f-06b395d017ec',3,'2025-01-11 11:50:29'),('a4d89134-c6b1-4e27-99a3-ef48166e7452',2,'2025-01-11 11:29:57'),('b1721a64-006f-453f-9a63-263ea35806c9',1,'2025-01-11 11:28:40'),('b5be5e60-1308-4411-96ab-bd719866fd50',4,'2025-01-11 11:58:53'),('b765f7b0-9659-4c06-b943-27e0de3283b2',4,'2025-01-11 11:51:20'),('c2151716-fdde-4240-ac1b-fa72699a068f',5,'2025-01-11 12:01:19'),('fc3091ee-cb51-4951-9115-94d2393b4646',2,'2025-01-11 12:00:35');
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
  `request_status` enum('Pending','Approved','Denied','Recieved') DEFAULT 'Pending',
  `approved_by` int DEFAULT NULL,
  `approval_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `requests_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfers`
--

LOCK TABLES `transfers` WRITE;
/*!40000 ALTER TABLE `transfers` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useritems`
--

LOCK TABLES `useritems` WRITE;
/*!40000 ALTER TABLE `useritems` DISABLE KEYS */;
INSERT INTO `useritems` VALUES (1,2,95,1,'2024-12-12',NULL),(2,2,21,1,'2024-12-12',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES (1,1,1),(2,2,3),(3,3,2),(4,4,5),(5,5,4),(6,6,3),(7,7,2),(8,8,3),(9,9,4),(10,10,5),(11,11,3),(12,12,2),(13,13,3),(14,14,4),(15,15,5),(16,16,3),(17,17,2),(18,18,3),(19,19,4),(20,20,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$10$ih8dq8aVWmc4rN8uIPUf6.OPWr7uqDachZPF4ji2aGOHDgHafyT0K','admin@example.com','123-456-7890','profile1.jpg','2024-12-12 08:27:25','2024-12-12 08:27:42',1,0,'John','Doe'),(2,'user','$2a$10$wHvKJ.6r8C2u6t6jnO4/6OqWsA0mXekbP.lAk58KFWzloVv.eWh0O','user@example.com','234-567-8901','profile2.jpg','2024-12-12 08:27:25','2024-12-12 08:27:42',2,0,'Alice','Smith'),(3,'manager','$2a$10$kzE4WxXYG33SySITJh6oaONi4Q464iGxeXoJ2LE36OENj9M6Y30zq','manager@example.com','345-678-9012','profile3.jpg','2024-12-12 08:27:25','2024-12-12 08:27:42',3,0,'Bob','Johnson'),(4,'staff','$2a$10$JuXlnrD6DsDWnA2KITZOaea/jwLhpwEqFwN9KDDhHEwBNfASCgG7y','staff@example.com','456-789-0123','profile4.jpg','2024-12-12 08:27:25','2024-12-12 08:27:42',4,0,'Carol','Wilson'),(5,'faculty','$2a$10$oR/WQdy6LeTDsP82FojB1.1.7qMGabbxari.7gUwrV52z8mUNo9BW','faculty@example.com','567-890-1234','profile5.jpg','2024-12-12 08:27:25','2024-12-12 08:27:42',5,0,'David','Lee'),(6,'jdoe','$2a$10$dMCyOvpn06ezwiYEW4VHTejzMNCZeSLQCgIYtlG2/YpFUPGzJIPqG','jdoe@example.com','123-456-7890','profile1.jpg','2024-12-12 08:27:25','2024-12-12 08:27:42',1,0,'John','Doe'),(7,'asmith','$2a$10$3S4Mwt1BpSCNbxFSIZJ2SexThWORGfELOKSYIMgmDQWzanuNVRLDy','asmith@example.com','234-567-8901','profile2.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',2,0,'Alice','Smith'),(8,'bjohnson','$2a$10$DKPVYtDOH5WLmdZyQR3LHeMxNodIwnUw2KPqxvyaw8MEWno03J88W','bjohnson@example.com','345-678-9012','profile3.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',3,0,'Bob','Johnson'),(9,'cwilson','$2a$10$QQdgRtkoJobELfIiHIRgLu0ertVrUlOm2f8ozGEHXAPAlMh7sgdTC','cwilson@example.com','456-789-0123','profile4.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',4,0,'Carol','Wilson'),(10,'dlee','$2a$10$4gYCJpEZW8nayVzdFhRVRuyiY6IIf6T0XxQeYqhToemyuCcsMnp1O','dlee@example.com','567-890-1234','profile5.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',5,0,'David','Lee'),(11,'emartin','$2a$10$/BDc8nLaYKYKJkege7Xzge1GfRcS4hywDdGxFedk1LIzRWVBaeDdC','emartin@example.com','678-901-2345','profile6.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',1,0,'Emily','Martin'),(12,'fgarcia','$2a$10$A6.It2EPXDKkrz336qeWPOXNcUtVGDLtSWGLuThm9WF5jrNbomNB6','fgarcia@example.com','789-012-3456','profile7.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',2,0,'Frank','Garcia'),(13,'hthompson','$2a$10$mOJPfVvPwZHsemE1c3.Op.wDH.VDiHeqLnAHBtjn/IsKSiPvDjd3C','hthompson@example.com','890-123-4567','profile8.jpg','2024-12-12 08:27:25','2024-12-12 08:27:43',3,0,'Helen','Thompson'),(14,'ijones','$2a$10$UbubB9icrj3SX/qtzJ2nu.aHH42hnt5MVUWcmpN8JmGmi5U55YiiO','ijones@example.com','901-234-5678','profile9.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',4,0,'Ivy','Jones'),(15,'kmiller','$2a$10$a3ucsqNkTRo7G1AycakoH.HAa8DEOizJqyyOw3V6KGDeXVoVuh0/y','kmiller@example.com','012-345-6789','profile10.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',5,0,'Kyle','Miller'),(16,'lgreen','$2a$10$2941dLS8HcJlf/SqKGMtVeA67aVTV04DxY8erjgznQvygPf2fsrZS','lgreen@example.com','123-456-7890','profile11.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',1,0,'Liam','Green'),(17,'mbrown','$2a$10$IMIKc3w3to3vuKUwFgx2zeeVh28QVGE2OI7Mag5lfze4izkaHeTc2','mbrown@example.com','234-567-8901','profile12.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',2,0,'Mia','Brown'),(18,'nwilliams','$2a$10$3StQ5OHZLP/5OlMSYT3/DeuCAvZxcltTKxgxCcomZpLzjZlT9KZn6','nwilliams@example.com','345-678-9012','profile13.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',3,0,'Noah','Williams'),(19,'opaul','$2a$10$0tWyjcJwco/Sr5imx/JsC.5Gc5hy3kAeBbAVEWkEdNpdQqo/wzG6.','opaul@example.com','456-789-0123','profile14.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',4,0,'Olivia','Paul'),(20,'pclark','$2a$10$7iT2xAfv7cHfpdp1gL2U9uimc70mEaz7uTus/QWVo2EW/fZ9FxAYu','pclark@example.com','567-890-1234','profile15.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',5,0,'Paul','Clark'),(21,'qyoung','$2a$10$844m/UPVNjTM6rlj384nxeLWL2dELKegcUSeFqXtDOqCZxSqXa7wu','qyoung@example.com','678-901-2345','profile16.jpg','2024-12-12 08:27:25','2024-12-12 08:27:44',1,0,'Quinn','Young'),(22,'rhill','$2a$10$a8yWs1Z59gOJ64BBTyyJruHrL5rtqgtAO1BS4ahVIkIY896ZOok7C','rhill@example.com','789-012-3456','profile17.jpg','2024-12-12 08:27:25','2024-12-12 08:27:45',2,0,'Rachel','Hill'),(23,'sstewart','$2a$10$Fs1MTgj7Zhq9iRntZ1Qzv.7fUcPHWBN3tL2nxlfwQrEVMUQfWwqmy','sstewart@example.com','890-123-4567','profile18.jpg','2024-12-12 08:27:25','2024-12-12 08:27:45',3,0,'Sam','Stewart'),(24,'twhite','$2a$10$UMeQwaHHXADPVWYNkCg9k.M7I3el9halvPPXxcT0w0OvIGzMxknIW','twhite@example.com','901-234-5678','profile19.jpg','2024-12-12 08:27:25','2024-12-12 08:27:45',4,0,'Tina','White'),(25,'uharris','$2a$10$qw1sX9sW2NTqHgISPPncLegqbhLMRztrgGlCMTUvmepkguddbrCBq','uharris@example.com','012-345-6789','profile20.jpg','2024-12-12 08:27:25','2024-12-12 08:27:45',5,0,'Ursula','Harris');
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

-- Dump completed on 2024-12-12 12:11:54
