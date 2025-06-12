-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sewalatkamping
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
-- Table structure for table `alat`
--

DROP TABLE IF EXISTS `alat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alat` (
  `id_alat` int NOT NULL AUTO_INCREMENT,
  `id_kategori_alat` int DEFAULT NULL,
  `nama_alat` varchar(100) DEFAULT NULL,
  `stok` int DEFAULT NULL,
  `harga_sewa_perhari` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_alat`),
  KEY `id_kategori_alat` (`id_kategori_alat`),
  CONSTRAINT `alat_ibfk_1` FOREIGN KEY (`id_kategori_alat`) REFERENCES `kategori_alat` (`id_kategori_alat`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alat`
--

LOCK TABLES `alat` WRITE;
/*!40000 ALTER TABLE `alat` DISABLE KEYS */;
INSERT INTO `alat` VALUES (1,1,'Tenda Dome 2 Orang',10,30000.00),(2,2,'Tenda Dome 4 Orang',7,50000.00),(3,2,'Matras Camping',20,10000.00),(4,3,'Kompor Portable',8,25000.00),(5,2,'Sleeping Bag',15,20000.00),(6,5,'Carrier 60L',5,40000.00),(7,4,'Headlamp LED',12,15000.00),(8,3,'Gas Kaleng',25,8000.00),(9,1,'Flysheet',10,12000.00),(10,3,'Cooking Set Camping',6,35000.00);
/*!40000 ALTER TABLE `alat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_penyewaan`
--

DROP TABLE IF EXISTS `detail_penyewaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_penyewaan` (
  `id_detail_penyewaan` int NOT NULL AUTO_INCREMENT,
  `id_penyewaan` int DEFAULT NULL,
  `id_alat` int DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `harga_perhari` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detail_penyewaan`),
  KEY `id_penyewaan` (`id_penyewaan`),
  KEY `id_alat` (`id_alat`),
  CONSTRAINT `detail_penyewaan_ibfk_1` FOREIGN KEY (`id_penyewaan`) REFERENCES `penyewaan` (`id_penyewaan`),
  CONSTRAINT `detail_penyewaan_ibfk_2` FOREIGN KEY (`id_alat`) REFERENCES `alat` (`id_alat`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_penyewaan`
--

LOCK TABLES `detail_penyewaan` WRITE;
/*!40000 ALTER TABLE `detail_penyewaan` DISABLE KEYS */;
INSERT INTO `detail_penyewaan` VALUES (1,1,4,2,NULL),(2,2,5,1,NULL);
/*!40000 ALTER TABLE `detail_penyewaan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori_alat`
--

DROP TABLE IF EXISTS `kategori_alat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategori_alat` (
  `id_kategori_alat` int NOT NULL AUTO_INCREMENT,
  `kategori` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_kategori_alat`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori_alat`
--

LOCK TABLES `kategori_alat` WRITE;
/*!40000 ALTER TABLE `kategori_alat` DISABLE KEYS */;
INSERT INTO `kategori_alat` VALUES (1,'Tenda'),(2,'Alat Tidur'),(3,'Peralatan Masak'),(4,'Pencahayaan'),(5,'Perlengkapan Pribadi');
/*!40000 ALTER TABLE `kategori_alat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pelanggan`
--

DROP TABLE IF EXISTS `pelanggan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pelanggan` (
  `id_pelanggan` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` text,
  `no_hp` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pelanggan`
--

LOCK TABLES `pelanggan` WRITE;
/*!40000 ALTER TABLE `pelanggan` DISABLE KEYS */;
INSERT INTO `pelanggan` VALUES (1,'Ipung',NULL,'0876543456',NULL),(2,'Iwan','Upn','081386553632','iwan@icikiwir.com'),(3,'Rania','Darjo','08854327442','34567654@gmail.com');
/*!40000 ALTER TABLE `pelanggan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penyewaan`
--

DROP TABLE IF EXISTS `penyewaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penyewaan` (
  `id_penyewaan` int NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int DEFAULT NULL,
  `tgl_penyewaan` date DEFAULT NULL,
  `tgl_pengembalian` date DEFAULT NULL,
  `total_biaya` decimal(10,2) DEFAULT NULL,
  `status` enum('disewa','dikembalikan') DEFAULT NULL,
  `jml_denda` int DEFAULT NULL,
  PRIMARY KEY (`id_penyewaan`),
  KEY `id_pelanggan` (`id_pelanggan`),
  CONSTRAINT `penyewaan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penyewaan`
--

LOCK TABLES `penyewaan` WRITE;
/*!40000 ALTER TABLE `penyewaan` DISABLE KEYS */;
INSERT INTO `penyewaan` VALUES (1,2,'2025-03-26','2025-04-02',350000.00,'dikembalikan',710000),(2,3,'2025-06-11','2025-06-13',40000.00,'dikembalikan',0);
/*!40000 ALTER TABLE `penyewaan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-12 10:47:02
