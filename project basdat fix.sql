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
);

insert into alat (id_kategori_alat, nama_alat, stok, harga_sewa_perhari)values
(1, 'Tenda', 10, 30000),
(1, 'Flysheet', 10, 10000),
(1, 'Groundsheet', 10, 10000),
(1, 'Sleeping Bag', 10, 15000),
(1, 'Matras Gulung', 10, 5000),
(2, 'Kompor Portable', 10, 20000),
(2, 'Tabung Gas', 10, 8000),
(2, 'Panci & Wajan Lipat', 10, 5000),
(2, 'Nesting', 10, 7000),
(2, 'Sendok, Garpu, Pisau Lipat', 10, 12000),
(2, 'Mug / Tumbler Tahan Panas', 10, 5000),
(2, 'Wadah Makanan Kedap Udara', 10, 5000),
(3, 'Carrier', 10, 30000),
(3, 'Dry Bag', 10, 7000),
(3, 'Jas Hujan', 10, 15000),
(3, 'Sarung Tangan', 10, 5000),
(3, 'Sepatu', 10, 30000),
(4, 'Headlamp / Senter', 10, 10000),
(4, 'Lentera Camping', 10, 10000),
(4, 'Kompas', 10, 5000);


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
); ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
); ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


insert into kategori_alat (kategori) values 
('Perlengkapan Tempat Tidur & Tempat Berteduh'),
('Perlengkapan Masak & Makan'),
('Perlengkapan Pribadi & Ransel'),
('Penerangan & Navigasi');

select * from kategori_alat
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
); ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
select * from pelanggan; 
DELETE dp FROM detail_penyewaan dp
JOIN penyewaan p ON dp.id_penyewaan = p.id_penyewaan
WHERE p.id_pelanggan = 2;
DELETE FROM detail_penyewaan
WHERE id_penyewaan IN (
  SELECT id_penyewaan FROM penyewaan WHERE id_pelanggan = 2
);
DELETE FROM penyewaan WHERE id_pelanggan = 2;

DELETE FROM pelanggan WHERE id_pelanggan = 2;

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
); ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- biar tampil barang dan kuantitas yang disewa pada fitur tampilkan semua penyewa
SELECT 
    p.id_penyewaan,
    pel.nama AS nama_pelanggan,
    p.tgl_penyewaan,
    p.tgl_pengembalian,
    p.status,
    a.nama_alat,
    dp.jumlah
FROM penyewaan p
JOIN pelanggan pel ON p.id_pelanggan = pel.id_pelanggan
JOIN detail_penyewaan dp ON p.id_penyewaan = dp.id_penyewaan
JOIN alat a ON dp.id_alat = a.id_alat
ORDER BY p.id_penyewaan, a.nama_alat;

SELECT * FROM detail_penyewaan;
SELECT * FROM detail_penyewaan dp
JOIN alat a ON dp.id_alat = a.id_alat;



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
);


select * from penyewaan;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;


-- Dump completed on 2025-06-12 10:47:02

select * from user;
DELETE FROM user
WHERE id = 2;

-- masukkan data user
insert into user (username, password) values
('iwan', '1'),
('cipung', '2'),
('rania', '3'),
('nafisa', '4');


-- TRIGGER UNTUK UPDATE STOK
DELIMITER //

CREATE TRIGGER tambah_stok_setelah_dikembalikan
AFTER UPDATE ON penyewaan
FOR EACH ROW
BEGIN
    -- hanya jika status berubah ke 'dikembalikan'
    IF NEW.status = 'dikembalikan' AND OLD.status = 'disewa' THEN
        -- tambahkan stok kembali berdasarkan detail penyewaan
        UPDATE alat a
        JOIN detail_penyewaan dp ON a.id_alat = dp.id_alat
        SET a.stok = a.stok + dp.jumlah
        WHERE dp.id_penyewaan = NEW.id_penyewaan;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS HitungTotalBayar;
use sewalatcamping;

SELECT DATABASE();

-- STORED PROCEDURE Hitung Total Bayar   PR BANGET

create definer = root@localhost
PROCEDURE HitungTotalBayar(
    IN id_penyewaan_param INT,
    OUT total_bayar DECIMAL(10,2)
)
BEGIN
    DECLARE total_sewa DECIMAL(10,2);
    DECLARE denda DECIMAL(10,2);

    -- Ambil total biaya sewa
    SELECT COALESCE(total_biaya, 0)
    INTO total_sewa
    FROM penyewaan
    WHERE id_penyewaan = id_penyewaan_param;

    -- Ambil jumlah denda
    SELECT COALESCE(jml_denda, 0)
    INTO denda
    FROM penyewaan
    WHERE id_penyewaan = id_penyewaan_param;

    -- Hitung total bayar = sewa + denda
    SET total_bayar = total_sewa + denda;
END 



CALL HitungTotalBayar(2, @hasil);
SELECT @hasil AS total_bayar;




CALL HitungTotalBayar(2, @hasil);
SELECT @hasil AS total_bayar;






-- apus penyewaan
DELETE FROM detail_penyewaan WHERE id_penyewaan = 12;
DELETE FROM penyewaan WHERE id_penyewaan = 12;


DELETE FROM detail_penyewaan
WHERE id_penyewaan IN (
  SELECT id_penyewaan FROM penyewaan WHERE id_pelanggan = 4
);

-- 2. Hapus data penyewaan milik pelanggan 2
DELETE FROM penyewaan
WHERE id_pelanggan = 4;

-- 3. Terakhir, hapus data pelanggan
DELETE FROM pelanggan
WHERE id_pelanggan = 4;

select * from pelanggan;


DELETE FROM detail_penyewaan;
DELETE FROM penyewaan;
DELETE FROM pelanggan;

ALTER TABLE detail_penyewaan AUTO_INCREMENT = 1;
ALTER TABLE penyewaan AUTO_INCREMENT = 1;
ALTER TABLE pelanggan AUTO_INCREMENT = 1;



SELECT 
    p.id_penyewaan,
    MAX(CASE WHEN a.nama_alat = 'Tenda' THEN dp.jumlah ELSE 0 END) AS Tenda,
    MAX(CASE WHEN a.nama_alat = 'Flysheet' THEN dp.jumlah ELSE 0 END) AS Flysheet,
    MAX(CASE WHEN a.nama_alat = 'Carrier' THEN dp.jumlah ELSE 0 END) AS Carrier,
    MAX(CASE WHEN a.nama_alat = 'Jas Hujan' THEN dp.jumlah ELSE 0 END) AS JasHujan
FROM penyewaan p
JOIN detail_penyewaan dp ON p.id_penyewaan = dp.id_penyewaan
JOIN alat a ON dp.id_alat = a.id_alat
GROUP BY p.id_penyewaan;


WITH TotalBiayaPelanggan AS (
    SELECT 
        p.id_pelanggan,
        SUM(p.total_biaya + p.jml_denda) AS total_dibayar
    FROM penyewaan p
    GROUP BY p.id_pelanggan
)
SELECT 
    pl.nama,
    tbp.total_dibayar
FROM TotalBiayaPelanggan tbp
JOIN pelanggan pl ON tbp.id_pelanggan = pl.id_pelanggan
ORDER BY tbp.total_dibayar DESC;

SELECT 
    pl.nama,
    (SELECT COUNT(*) 
     FROM penyewaan p 
     WHERE p.id_pelanggan = pl.id_pelanggan) AS jumlah_penyewaan
FROM pelanggan pl
ORDER BY jumlah_penyewaan DESC;





