-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: travel_reservation
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS activity;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE activity (
  activity_id int NOT NULL AUTO_INCREMENT,
  activity_name varchar(255) NOT NULL,
  activity_description text NOT NULL,
  PRIMARY KEY (activity_id),
  UNIQUE KEY activity_name (activity_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES activity WRITE;
/*!40000 ALTER TABLE activity DISABLE KEYS */;
/*!40000 ALTER TABLE activity ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS airport;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE airport (
  airport_id int NOT NULL AUTO_INCREMENT,
  airport_name varchar(255) NOT NULL,
  city varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL,
  PRIMARY KEY (airport_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES airport WRITE;
/*!40000 ALTER TABLE airport DISABLE KEYS */;
/*!40000 ALTER TABLE airport ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amenity`
--

DROP TABLE IF EXISTS amenity;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE amenity (
  amenity_id int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (amenity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenity`
--

LOCK TABLES amenity WRITE;
/*!40000 ALTER TABLE amenity DISABLE KEYS */;
/*!40000 ALTER TABLE amenity ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS audit_log;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE audit_log (
  log_id int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) NOT NULL,
  `action` enum('INSERT','UPDATE','DELETE') NOT NULL,
  changed_data text NOT NULL,
  changed_by int NOT NULL,
  changed_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (log_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES audit_log WRITE;
/*!40000 ALTER TABLE audit_log DISABLE KEYS */;
/*!40000 ALTER TABLE audit_log ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS flight;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE flight (
  flight_id int NOT NULL AUTO_INCREMENT,
  airline_name varchar(100) NOT NULL,
  flight_number varchar(50) NOT NULL,
  departure_airport varchar(100) NOT NULL,
  arrival_airport varchar(100) NOT NULL,
  departure_date datetime NOT NULL,
  arrival_date datetime NOT NULL,
  departure_airport_id int NOT NULL,
  arrival_airport_id int NOT NULL,
  PRIMARY KEY (flight_id),
  UNIQUE KEY flight_number (flight_number),
  KEY fk_departure_airport (departure_airport_id),
  KEY fk_arrival_airport (arrival_airport_id),
  CONSTRAINT fk_arrival_airport FOREIGN KEY (arrival_airport_id) REFERENCES airport (airport_id),
  CONSTRAINT fk_departure_airport FOREIGN KEY (departure_airport_id) REFERENCES airport (airport_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES flight WRITE;
/*!40000 ALTER TABLE flight DISABLE KEYS */;
/*!40000 ALTER TABLE flight ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_booking`
--

DROP TABLE IF EXISTS flight_booking;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE flight_booking (
  flight_booking_id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  flight_id int NOT NULL,
  flight_class_id int NOT NULL,
  total_amount decimal(10,2) NOT NULL,
  `status` enum('Pending','Confirmed','Cancelled','Completed') NOT NULL DEFAULT 'Pending',
  booking_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (flight_booking_id),
  KEY user_id (user_id),
  KEY flight_id (flight_id),
  KEY flight_class_id (flight_class_id),
  CONSTRAINT flight_booking_ibfk_1 FOREIGN KEY (user_id) REFERENCES `user` (user_id),
  CONSTRAINT flight_booking_ibfk_2 FOREIGN KEY (flight_id) REFERENCES flight (flight_id),
  CONSTRAINT flight_booking_ibfk_3 FOREIGN KEY (flight_class_id) REFERENCES flight_class (flight_class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_booking`
--

LOCK TABLES flight_booking WRITE;
/*!40000 ALTER TABLE flight_booking DISABLE KEYS */;
/*!40000 ALTER TABLE flight_booking ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_class`
--

DROP TABLE IF EXISTS flight_class;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE flight_class (
  flight_class_id int NOT NULL AUTO_INCREMENT,
  flight_id int DEFAULT NULL,
  class_name varchar(50) NOT NULL,
  price decimal(10,2) NOT NULL,
  seats_available int NOT NULL,
  class_type_id int NOT NULL,
  PRIMARY KEY (flight_class_id),
  KEY flight_id (flight_id),
  KEY fk_class_type (class_type_id),
  CONSTRAINT fk_class_type FOREIGN KEY (class_type_id) REFERENCES flight_class_type (class_type_id),
  CONSTRAINT flight_class_ibfk_1 FOREIGN KEY (flight_id) REFERENCES flight (flight_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_class`
--

LOCK TABLES flight_class WRITE;
/*!40000 ALTER TABLE flight_class DISABLE KEYS */;
/*!40000 ALTER TABLE flight_class ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_class_type`
--

DROP TABLE IF EXISTS flight_class_type;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE flight_class_type (
  class_type_id int NOT NULL AUTO_INCREMENT,
  class_name varchar(50) NOT NULL,
  PRIMARY KEY (class_type_id),
  UNIQUE KEY class_name (class_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_class_type`
--

LOCK TABLES flight_class_type WRITE;
/*!40000 ALTER TABLE flight_class_type DISABLE KEYS */;
/*!40000 ALTER TABLE flight_class_type ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS hotel;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE hotel (
  hotel_id int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  city varchar(255) DEFAULT NULL,
  state varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL,
  zip_code varchar(10) DEFAULT NULL,
  rating decimal(3,2) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (hotel_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES hotel WRITE;
/*!40000 ALTER TABLE hotel DISABLE KEYS */;
/*!40000 ALTER TABLE hotel ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_amenity`
--

DROP TABLE IF EXISTS hotel_amenity;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE hotel_amenity (
  hotel_id int NOT NULL,
  amenity_id int NOT NULL,
  PRIMARY KEY (hotel_id,amenity_id),
  KEY amenity_id (amenity_id),
  CONSTRAINT hotel_amenity_ibfk_1 FOREIGN KEY (hotel_id) REFERENCES hotel (hotel_id),
  CONSTRAINT hotel_amenity_ibfk_2 FOREIGN KEY (amenity_id) REFERENCES amenity (amenity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_amenity`
--

LOCK TABLES hotel_amenity WRITE;
/*!40000 ALTER TABLE hotel_amenity DISABLE KEYS */;
/*!40000 ALTER TABLE hotel_amenity ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_booking`
--

DROP TABLE IF EXISTS hotel_booking;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE hotel_booking (
  booking_id int NOT NULL AUTO_INCREMENT,
  user_id int DEFAULT NULL,
  hotel_id int DEFAULT NULL,
  room_id int DEFAULT NULL,
  check_in_date date DEFAULT NULL,
  check_out_date date DEFAULT NULL,
  total_price decimal(10,2) DEFAULT NULL,
  booking_status enum('Pending','Confirmed','Cancelled') DEFAULT NULL,
  created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id),
  KEY user_id (user_id),
  KEY hotel_id (hotel_id),
  KEY room_id (room_id),
  CONSTRAINT hotel_booking_ibfk_1 FOREIGN KEY (user_id) REFERENCES `user` (user_id),
  CONSTRAINT hotel_booking_ibfk_2 FOREIGN KEY (hotel_id) REFERENCES hotel (hotel_id),
  CONSTRAINT hotel_booking_ibfk_3 FOREIGN KEY (room_id) REFERENCES room (room_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_booking`
--

LOCK TABLES hotel_booking WRITE;
/*!40000 ALTER TABLE hotel_booking DISABLE KEYS */;
/*!40000 ALTER TABLE hotel_booking ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itinerary`
--

DROP TABLE IF EXISTS itinerary;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE itinerary (
  itinerary_id int NOT NULL AUTO_INCREMENT,
  package_id int NOT NULL,
  destination varchar(255) NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  activity_description text NOT NULL,
  PRIMARY KEY (itinerary_id),
  KEY package_id (package_id),
  CONSTRAINT itinerary_ibfk_1 FOREIGN KEY (package_id) REFERENCES package (package_id) ON DELETE CASCADE,
  CONSTRAINT chk_start_before_end CHECK ((`start_date` < `end_date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerary`
--

LOCK TABLES itinerary WRITE;
/*!40000 ALTER TABLE itinerary DISABLE KEYS */;
/*!40000 ALTER TABLE itinerary ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itinerary_activity`
--

DROP TABLE IF EXISTS itinerary_activity;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE itinerary_activity (
  activity_id int NOT NULL AUTO_INCREMENT,
  itinerary_id int NOT NULL,
  activity_time datetime NOT NULL,
  activity_ref_id int NOT NULL,
  PRIMARY KEY (activity_id),
  KEY itinerary_id (itinerary_id),
  KEY fk_activity_ref_id (activity_ref_id),
  CONSTRAINT fk_activity_ref_id FOREIGN KEY (activity_ref_id) REFERENCES activity (activity_id) ON DELETE CASCADE,
  CONSTRAINT itinerary_activity_ibfk_1 FOREIGN KEY (itinerary_id) REFERENCES itinerary (itinerary_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerary_activity`
--

LOCK TABLES itinerary_activity WRITE;
/*!40000 ALTER TABLE itinerary_activity DISABLE KEYS */;
/*!40000 ALTER TABLE itinerary_activity ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS package;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE package (
  package_id int NOT NULL AUTO_INCREMENT,
  package_name varchar(255) NOT NULL,
  `description` text,
  total_price decimal(10,2) NOT NULL,
  `status` enum('Available','Inactive','Sold Out') NOT NULL DEFAULT 'Available',
  PRIMARY KEY (package_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES package WRITE;
/*!40000 ALTER TABLE package DISABLE KEYS */;
/*!40000 ALTER TABLE package ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_booking`
--

DROP TABLE IF EXISTS package_booking;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE package_booking (
  package_booking_id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  package_id int NOT NULL,
  num_adults int NOT NULL,
  num_children int NOT NULL,
  total_amount decimal(10,2) NOT NULL,
  `status` enum('Pending','Confirmed','Cancelled','Completed') NOT NULL DEFAULT 'Pending',
  booking_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (package_booking_id),
  KEY user_id (user_id),
  KEY package_id (package_id),
  CONSTRAINT package_booking_ibfk_1 FOREIGN KEY (user_id) REFERENCES `user` (user_id),
  CONSTRAINT package_booking_ibfk_2 FOREIGN KEY (package_id) REFERENCES package (package_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_booking`
--

LOCK TABLES package_booking WRITE;
/*!40000 ALTER TABLE package_booking DISABLE KEYS */;
/*!40000 ALTER TABLE package_booking ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_pricing`
--

DROP TABLE IF EXISTS package_pricing;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE package_pricing (
  pricing_id int NOT NULL AUTO_INCREMENT,
  package_id int NOT NULL,
  season varchar(50) DEFAULT NULL,
  price decimal(10,2) NOT NULL,
  PRIMARY KEY (pricing_id),
  KEY package_id (package_id),
  CONSTRAINT package_pricing_ibfk_1 FOREIGN KEY (package_id) REFERENCES package (package_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_pricing`
--

LOCK TABLES package_pricing WRITE;
/*!40000 ALTER TABLE package_pricing DISABLE KEYS */;
/*!40000 ALTER TABLE package_pricing ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS payment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE payment (
  payment_id int NOT NULL AUTO_INCREMENT,
  payment_reference_id int NOT NULL,
  payment_type enum('Package','Hotel','Flight') NOT NULL,
  payment_amount decimal(10,2) NOT NULL,
  payment_method enum('Credit Card','Debit Card','Bank Transfer','Other') NOT NULL,
  payment_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  user_id int NOT NULL,
  PRIMARY KEY (payment_id),
  KEY fk_user_id (user_id),
  CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES `user` (user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES payment WRITE;
/*!40000 ALTER TABLE payment DISABLE KEYS */;
/*!40000 ALTER TABLE payment ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER payment_audit_log_insert AFTER INSERT ON payment FOR EACH ROW BEGIN
    INSERT INTO `audit_log` (table_name, action, changed_data, changed_by)
    VALUES ('payment', 'INSERT', CONCAT('Payment inserted with payment_id = ', NEW.payment_id), NEW.user_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER payment_audit_log_update AFTER UPDATE ON payment FOR EACH ROW BEGIN
    INSERT INTO `audit_log` (table_name, action, changed_data, changed_by)
    VALUES ('payment', 'UPDATE', CONCAT('Payment updated with payment_id = ', OLD.payment_id, ', previous amount: ', OLD.payment_amount, ', new amount: ', NEW.payment_amount), NEW.user_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER payment_audit_log_delete AFTER DELETE ON payment FOR EACH ROW BEGIN
    INSERT INTO `audit_log` (table_name, action, changed_data, changed_by)
    VALUES ('payment', 'DELETE', CONCAT('Payment deleted with payment_id = ', OLD.payment_id), OLD.user_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS review;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE review (
  review_id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  review_type enum('Package','Hotel','Flight') NOT NULL,
  rating int NOT NULL,
  review_content text,
  review_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (review_id),
  KEY user_id (user_id),
  CONSTRAINT review_ibfk_1 FOREIGN KEY (user_id) REFERENCES `user` (user_id) ON DELETE CASCADE,
  CONSTRAINT review_chk_1 CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES review WRITE;
/*!40000 ALTER TABLE review DISABLE KEYS */;
/*!40000 ALTER TABLE review ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS role;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  role_id int NOT NULL AUTO_INCREMENT,
  role_name varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (role_id),
  UNIQUE KEY role_name (role_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES role WRITE;
/*!40000 ALTER TABLE role DISABLE KEYS */;
/*!40000 ALTER TABLE role ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS room;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE room (
  room_id int NOT NULL AUTO_INCREMENT,
  hotel_id int DEFAULT NULL,
  room_type varchar(255) DEFAULT NULL,
  price_per_night decimal(10,2) DEFAULT NULL,
  max_adults int DEFAULT NULL,
  max_children int DEFAULT NULL,
  availability int DEFAULT NULL,
  PRIMARY KEY (room_id),
  KEY hotel_id (hotel_id),
  CONSTRAINT room_ibfk_1 FOREIGN KEY (hotel_id) REFERENCES hotel (hotel_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES room WRITE;
/*!40000 ALTER TABLE room DISABLE KEYS */;
/*!40000 ALTER TABLE room ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS user;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  user_id int NOT NULL AUTO_INCREMENT,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  email varchar(255) NOT NULL,
  password_hash varchar(255) NOT NULL,
  phone_number varchar(15) DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  role_id int NOT NULL,
  loyalty_points int DEFAULT '0',
  PRIMARY KEY (user_id),
  UNIQUE KEY email (email),
  KEY role_id (role_id),
  CONSTRAINT user_ibfk_1 FOREIGN KEY (role_id) REFERENCES `role` (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES user WRITE;
/*!40000 ALTER TABLE user DISABLE KEYS */;
/*!40000 ALTER TABLE user ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_payment_history_view`
--

DROP TABLE IF EXISTS user_payment_history_view;
/*!50001 DROP VIEW IF EXISTS user_payment_history_view*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_payment_history_view` AS SELECT 
 1 AS user_id,
 1 AS user_name,
 1 AS payment_reference_id,
 1 AS payment_type,
 1 AS payment_method,
 1 AS payment_amount,
 1 AS payment_date*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'travel_reservation'
--

--
-- Final view structure for view `user_payment_history_view`
--

/*!50001 DROP VIEW IF EXISTS user_payment_history_view*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=root@localhost SQL SECURITY DEFINER */
/*!50001 VIEW user_payment_history_view AS select u.user_id AS user_id,concat(u.first_name,' ',u.last_name) AS user_name,p.payment_reference_id AS payment_reference_id,p.payment_type AS payment_type,p.payment_method AS payment_method,p.payment_amount AS payment_amount,p.payment_date AS payment_date from (payment p join `user` u on((p.user_id = u.user_id))) */;
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

-- Dump completed
