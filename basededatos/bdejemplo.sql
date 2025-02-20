-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: bdejemplo
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `Num_Cli` int NOT NULL,
  `Empresa` varchar(20) NOT NULL,
  `Rep_Cli` int DEFAULT NULL,
  `Limite_Credito` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`Num_Cli`),
  KEY `FK_Clientes_Representantes` (`Rep_Cli`),
  CONSTRAINT `FK_Clientes_Representantes` FOREIGN KEY (`Rep_Cli`) REFERENCES `representantes` (`Num_Empl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (2101,'Jerandilla Ltd',106,65000.0000),(2102,'Filas',101,65000.0000),(2103,'Acme',105,50000.0000),(2105,'AAA Inversiones',101,45000.0000),(2106,'F. Lopez S.A',102,65000.0000),(2107,'Ace internacional',110,35000.0000),(2108,'Henche & López',109,55000.0000),(2109,'Chen Asociados',103,25000.0000),(2111,'JCP S.A.',103,50000.0000),(2112,'Zeta Producciones',108,50000.0000),(2113,'Íbero & Sagaz',104,20000.0000),(2114,'Orión Ltd.',102,20000.0000),(2115,'Sierras S.A',101,20000.0000),(2117,'J. P. Sotoca',106,35000.0000),(2118,'Mejorada Sistemas',108,60000.0000),(2119,'Salomón S.A',109,25000.0000),(2120,'Rico S.A',102,50000.0000),(2121,'QMA Asociados',103,45000.0000),(2122,'Toledo S.A',105,30000.0000),(2123,'Cruz e hijos',102,40000.0000),(2124,'Pascual Hermanos',107,40000.0000),(2125,'La Cucaracha',109,55000.0000);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficinas`
--

DROP TABLE IF EXISTS `oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oficinas` (
  `Oficina` int NOT NULL,
  `Ciudad` varchar(15) NOT NULL,
  `Region` varchar(10) NOT NULL,
  `Jef` int DEFAULT NULL,
  `Objetivo` decimal(19,4) DEFAULT NULL,
  `Ventas` decimal(19,4) NOT NULL,
  PRIMARY KEY (`Oficina`),
  KEY `FK_Oficinas_Representantes` (`Jef`),
  CONSTRAINT `FK_Oficinas_Representantes` FOREIGN KEY (`Jef`) REFERENCES `representantes` (`Num_Empl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficinas`
--

LOCK TABLES `oficinas` WRITE;
/*!40000 ALTER TABLE `oficinas` DISABLE KEYS */;
INSERT INTO `oficinas` VALUES (11,'Navarra','Este',106,575000.0000,692637.0000),(12,'Castellón ','Este',104,800000.0000,735042.0000),(13,'Almería','Este',105,350000.0000,367911.0000),(21,'León','Oeste',108,745000.0000,835915.0000),(22,'Daimiel','Oeste',108,300000.0000,186042.0000);
/*!40000 ALTER TABLE `oficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `Num_Pedido` int NOT NULL,
  `Fecha_Pedido` date NOT NULL,
  `Cliente` int NOT NULL,
  `Rep` int DEFAULT NULL,
  `Fab` char(3) NOT NULL,
  `Producto` char(5) NOT NULL,
  `Cantidad` int NOT NULL,
  `Importe` decimal(19,4) NOT NULL,
  PRIMARY KEY (`Num_Pedido`),
  KEY `FK_Pedidos_Productos` (`Fab`,`Producto`),
  KEY `FK_Pedidos_Clientes` (`Cliente`),
  KEY `FK_Pedidos_Representantes` (`Rep`),
  CONSTRAINT `FK_Pedidos_Clientes` FOREIGN KEY (`Cliente`) REFERENCES `clientes` (`Num_Cli`) ON DELETE CASCADE,
  CONSTRAINT `FK_Pedidos_Productos` FOREIGN KEY (`Fab`, `Producto`) REFERENCES `productos` (`Id_fab`, `Id_producto`),
  CONSTRAINT `FK_Pedidos_Representantes` FOREIGN KEY (`Rep`) REFERENCES `representantes` (`Num_Empl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (112961,'1989-12-17',2117,106,'REI','2A44L',7,31500.0000),(112963,'1989-12-17',2103,105,'ACI','41004',28,3276.0000),(112975,'1989-10-10',2111,103,'REI','2A44G',6,2100.0000),(112979,'1989-10-10',2114,102,'ACI','4100Z',6,15000.0000),(112983,'1989-12-27',2103,105,'ACI','41004',6,702.0000),(112987,'1989-12-31',2103,105,'ACI','4100Y',11,27500.0000),(112989,'1990-01-03',2101,106,'FEA','114',6,1458.0000),(112992,'1989-11-04',2118,108,'ACI','41002',10,760.0000),(112993,'1989-01-04',2106,102,'REI','2A45C',24,1896.0000),(112997,'1990-01-08',2124,107,'BIC','41003',1,652.0000),(113003,'1990-01-25',2108,109,'IMM','779C',3,5625.0000),(113007,'1990-01-08',2112,108,'IMM','773C',3,2925.0000),(113012,'1990-01-11',2111,105,'ACI','41003',35,3745.0000),(113013,'1990-01-14',2118,108,'BIC','41003',1,652.0000),(113024,'1990-01-20',2114,108,'QSA','XK47',20,7100.0000),(113027,'1990-01-22',2103,105,'ACI','41002',54,4104.0000),(113034,'1990-01-29',2107,110,'REI','2A45C',8,632.0000),(113042,'1990-02-02',2113,101,'REI','2A44R',5,22500.0000),(113045,'1990-02-02',2112,108,'REI','2A44R',10,45000.0000),(113048,'1990-02-10',2120,102,'IMM','779C',2,3750.0000),(113049,'1990-02-10',2118,108,'QSA','XK47',2,776.0000),(113051,'1990-02-10',2118,108,'QSA','XK47',4,1420.0000),(113055,'1990-02-15',2108,101,'ACI','4100X',6,150.0000),(113057,'1990-02-18',2111,103,'ACI','4100X',24,600.0000),(113058,'1990-02-23',2108,109,'FEA','112',10,1480.0000),(113062,'1990-02-24',2124,107,'FEA','114',10,2430.0000),(113065,'1990-02-27',2106,102,'QSA','XK47',6,2130.0000),(113069,'1990-03-02',2109,107,'IMM','775C',22,31350.0000);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `Id_fab` char(3) NOT NULL,
  `Id_producto` char(5) NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  `Precio` decimal(19,4) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`Id_fab`,`Id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES ('ACI','1405','Llaves inglesa',15.2000,45),('ACI','1407','Llaves Prueba',15.2000,45),('ACI','41001','Serie 1, cable',55.0000,277),('ACI','41002','Serie 2, cable',76.0000,167),('ACI','41003','Serie 3, cable',7.0000,207),('ACI','41004','Serie 4. cable',117.0000,139),('ACI','4100X','Zapata Grande',25.0000,37),('ACI','4100Y','Zapata Pequeña',2750.0000,25),('ACI','4100Z','Zapata Mediana',2500.0000,28),('ACI','7851','prueba3000',78.5000,45),('BIC','1401','Mesas',78.5000,45),('BIC','1402','Alambre nuevo',150.2000,89),('BIC','41003','Hélice',652.0000,3),('BIC','41089','Retén ',225.0000,78),('BIC','41672','Plato',180.0000,0),('BIC','785','prueba145',74.1200,66),('FEA','112','Huso',148.0000,115),('FEA','114','Montura del Motor',243.0000,15),('FEA','7820','Cemento',256.3000,150),('IMM','773C','30 - kg brazo',975.0000,28),('IMM','775C','50-kg brazo',1425.0000,5),('IMM','779C','90- kg brazo',1875.0000,9),('IMM','7854','Mortero',78.5000,150),('IMM','887H','Barrilete',54.0000,223),('IMM','887P','Bulón ',250.0000,24),('IMM','887X','Brazo retén ',475.0000,32),('QSA','XK47','Reductora',355.0000,38),('QSA','XK48','Reductora',134.0000,203),('QSA','XK48A','Reducción',177.0000,37),('REI','2A44G','Hilo de Cobre',350.0000,14),('REI','2A44L','Llave',4500.0000,12),('REI','2A44R','Riostra',4500.0000,12),('REI','2A45C','Rueda',79.0000,210);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `representantes`
--

DROP TABLE IF EXISTS `representantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `representantes` (
  `Num_Empl` int NOT NULL,
  `Nombre` varchar(16) NOT NULL,
  `Edad` int DEFAULT NULL,
  `Oficina_Rep` int DEFAULT NULL,
  `Puesto` varchar(13) DEFAULT NULL,
  `Fecha_Contrato` date NOT NULL,
  `Jefe` int DEFAULT NULL,
  `Cuota` decimal(19,4) DEFAULT NULL,
  `Ventas` decimal(19,4) NOT NULL,
  PRIMARY KEY (`Num_Empl`),
  KEY `FK_Representantes_Oficinas` (`Oficina_Rep`),
  KEY `FK_Representantes_Representantes` (`Jefe`),
  CONSTRAINT `FK_Representantes_Oficinas` FOREIGN KEY (`Oficina_Rep`) REFERENCES `oficinas` (`Oficina`),
  CONSTRAINT `FK_Representantes_Representantes` FOREIGN KEY (`Jefe`) REFERENCES `representantes` (`Num_Empl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `representantes`
--

LOCK TABLES `representantes` WRITE;
/*!40000 ALTER TABLE `representantes` DISABLE KEYS */;
INSERT INTO `representantes` VALUES (101,'Daniel Ruidrobo',45,12,'Representante','1986-10-20',104,300000.0000,305673.0000),(102,'Susana Santos',48,21,'Representante','1986-12-10',NULL,350000.0000,474050.0000),(103,'Pablo Cruz',29,12,'Representante','1987-03-01',104,275000.0000,286775.0000),(104,'Bernardo Sánchez',33,12,'Jefe Ventas','1987-05-19',106,200000.0000,142594.0000),(105,'Bruno Arteaga',37,13,'Representante','1988-02-12',104,350000.0000,367911.0000),(106,'Samuel Clavel',52,11,'VP Ventas','1988-06-14',NULL,275000.0000,299912.0000),(107,'Neus Azcárate',49,22,'Representante','1988-11-14',108,300000.0000,186042.0000),(108,'León Freire',62,21,'Jefe Ventas','1989-10-12',106,350000.0000,361865.0000),(109,'María Jiménez',31,11,'Representante','1989-10-12',106,320000.0000,392725.0000),(110,'Tomás Saz',41,NULL,'Representante','1990-01-13',101,NULL,75985.0000);
/*!40000 ALTER TABLE `representantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_prueba`
--

DROP TABLE IF EXISTS `vista_prueba`;
/*!50001 DROP VIEW IF EXISTS `vista_prueba`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_prueba` AS SELECT 
 1 AS `NUM_PEDIDO`,
 1 AS `Importe`,
 1 AS `EMPRESA`,
 1 AS `NOMBRE`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_prueba`
--

/*!50001 DROP VIEW IF EXISTS `vista_prueba`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_prueba` AS select `p`.`Num_Pedido` AS `NUM_PEDIDO`,`p`.`Importe` AS `Importe`,`c`.`Empresa` AS `EMPRESA`,`r`.`Nombre` AS `NOMBRE` from ((`pedidos` `p` join `clientes` `c`) join `representantes` `r`) where ((`r`.`Num_Empl` = `c`.`Rep_Cli`) and (`c`.`Num_Cli` = `p`.`Cliente`) and (`p`.`Importe` > 25000)) */;
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

-- Dump completed on 2021-08-12 13:11:22
