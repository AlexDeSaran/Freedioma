-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: freedioma
-- ------------------------------------------------------
-- Server version	8.0.21
create database if not exists freedioma;
use freedioma;


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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idCategoria` int NOT NULL,
  `nomeCategoria` varchar(60) NOT NULL,
  `idIdioma` int NOT NULL,
  PRIMARY KEY (`idCategoria`,`idIdioma`),
  KEY `fk_Categoria_Idioma1_idx` (`idIdioma`),
  CONSTRAINT `fk_Categoria_Idioma1` FOREIGN KEY (`idIdioma`) REFERENCES `idioma` (`idIdioma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'adjective',1),(1,'adjectif',2),(1,'adjetivo',3),(1,'aggetivo',4),(1,'adjektiv',5),(2,'animal',1),(2,'animal',2),(2,'animal',3),(2,'animale',4),(2,'tier',5),(3,'food',1),(3,'nourriture',2),(3,'comida',3),(3,'cibo',4),(3,'lebensmittel',5),(4,'verb',1),(4,'verbe',2),(4,'verbo',3),(4,'verbo',4),(4,'verb',5),(5,'object',1),(5,'objet',2),(5,'objeto',3),(5,'oggetto',4),(5,'objekt',5);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fase`
--

DROP TABLE IF EXISTS `fase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fase` (
  `idFase` int NOT NULL,
  `idCategoria` int NOT NULL,
  `idIdioma` int NOT NULL,
  `resposta` varchar(60) NOT NULL,
  PRIMARY KEY (`idFase`,`idIdioma`,`idCategoria`),
  KEY `fk_Fase_Categoria1_idx` (`idCategoria`,`idIdioma`),
  CONSTRAINT `fk_Fase_Categoria1` FOREIGN KEY (`idCategoria`, `idIdioma`) REFERENCES `categoria` (`idCategoria`, `idIdioma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fase`
--

LOCK TABLES `fase` WRITE;
/*!40000 ALTER TABLE `fase` DISABLE KEYS */;
INSERT INTO `fase` VALUES (1,1,1,'big'),(1,2,1,'dog'),(1,3,1,'water'),(1,4,1,'cell phone'),(1,5,1,'speak'),(1,1,2,'gros'),(1,2,2,'chien'),(1,3,2,'l eau'),(1,4,2,'telephone portable'),(1,5,2,'parler'),(1,1,3,'grande'),(1,2,3,'perro'),(1,3,3,'agua'),(1,4,3,'telefono movil'),(1,5,3,'habalar'),(1,1,4,'grande'),(1,2,4,'cane'),(1,3,4,'acqua'),(1,4,4,'cellulare'),(1,5,4,'parlare'),(1,1,5,'grob'),(1,2,5,'hund'),(1,3,5,'wasser'),(1,4,5,'mobiltelefon'),(1,5,5,'sprechen'),(2,1,1,'small'),(2,2,1,'cat'),(2,3,1,'apple'),(2,4,1,'car'),(2,5,1,'purchase'),(2,1,2,'petit'),(2,2,2,'chat'),(2,3,2,'pomme'),(2,4,2,'voiture'),(2,5,2,'achat'),(2,1,3,'pequena'),(2,2,3,'gato'),(2,3,3,'manzana'),(2,4,3,'coche'),(2,5,3,'compra'),(2,1,4,'piccolo'),(2,2,4,'gatto'),(2,3,4,'mela'),(2,4,4,'auto'),(2,5,4,'acquista'),(2,1,5,'klein'),(2,2,5,'katze'),(2,3,5,'apfel'),(2,4,5,'wagen'),(2,5,5,'kauf'),(3,1,1,'dirty'),(3,2,1,'mouse'),(3,3,1,'bread'),(3,4,1,'airplane'),(3,5,1,'eat'),(3,1,2,'sale'),(3,2,2,'souris'),(3,3,2,'pain'),(3,4,2,'avion'),(3,5,2,'manger'),(3,1,3,'sucio'),(3,2,3,'raton'),(3,3,3,'un pan'),(3,4,3,'avion'),(3,5,3,'comer'),(3,1,4,'sporco'),(3,2,4,'topo'),(3,3,4,'pane'),(3,4,4,'aereo'),(3,5,4,'mangiare'),(3,1,5,'dreckig'),(3,2,5,'maus'),(3,3,5,'brot'),(3,4,5,'flugzeug'),(3,5,5,'essen'),(4,1,1,'clean'),(4,2,1,'bird'),(4,3,1,'ice cream'),(4,4,1,'ball'),(4,5,1,'run'),(4,1,2,'nettoyer'),(4,2,2,'oiseau'),(4,3,2,'creme glacee'),(4,4,2,'balle'),(4,5,2,'courir'),(4,1,3,'limpiar'),(4,2,3,'pajaro'),(4,3,3,'helado'),(4,4,3,'pelota'),(4,5,3,'correr'),(4,1,4,'pulito'),(4,2,4,'uccello'),(4,3,4,'gelato'),(4,4,4,'pala'),(4,5,4,'correre'),(4,1,5,'sauber'),(4,2,5,'vogel'),(4,3,5,'eiscreme'),(4,4,5,'ball'),(4,5,5,'lauf');
/*!40000 ALTER TABLE `fase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idioma`
--

DROP TABLE IF EXISTS `idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idioma` (
  `idIdioma` int NOT NULL,
  `nomeIdioma` varchar(30) NOT NULL,
  PRIMARY KEY (`idIdioma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idioma`
--

LOCK TABLES `idioma` WRITE;
/*!40000 ALTER TABLE `idioma` DISABLE KEYS */;
INSERT INTO `idioma` VALUES (1,'ingles'),(2,'frances'),(3,'espanhol'),(4,'italiano'),(5,'alemao');
/*!40000 ALTER TABLE `idioma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progresso`
--

DROP TABLE IF EXISTS `progresso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progresso` (
  `idProgresso` int NOT NULL AUTO_INCREMENT,
  `idFase` int NOT NULL,
  `idIdioma` int NOT NULL,
  `idCategoria` int NOT NULL,
  `idUsuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idProgresso`,`idFase`,`idIdioma`,`idCategoria`,`idUsuario`),
  KEY `fk_Progresso_Fase1_idx` (`idFase`,`idIdioma`,`idCategoria`),
  KEY `fk_Progresso_Usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_Progresso_Fase1` FOREIGN KEY (`idFase`, `idIdioma`, `idCategoria`) REFERENCES `fase` (`idFase`, `idIdioma`, `idCategoria`),
  CONSTRAINT `fk_Progresso_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progresso`
--

LOCK TABLES `progresso` WRITE;
/*!40000 ALTER TABLE `progresso` DISABLE KEYS */;
/*!40000 ALTER TABLE `progresso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ranking`
--

DROP TABLE IF EXISTS `ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ranking` (
  `idUsuario` varchar(20) NOT NULL,
  `idFase` int NOT NULL,
  `idIdioma` int NOT NULL,
  `idCategoria` int NOT NULL,
  `tempoConclusao` time DEFAULT NULL,
  PRIMARY KEY (`idUsuario`,`idFase`,`idIdioma`,`idCategoria`),
  KEY `fk_Ranking_Usuario1_idx` (`idUsuario`),
  KEY `fk_Ranking_Fase1_idx` (`idFase`,`idIdioma`,`idCategoria`),
  CONSTRAINT `fk_Ranking_Fase1` FOREIGN KEY (`idFase`, `idIdioma`, `idCategoria`) REFERENCES `fase` (`idFase`, `idIdioma`, `idCategoria`),
  CONSTRAINT `fk_Ranking_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranking`
--

LOCK TABLES `ranking` WRITE;
/*!40000 ALTER TABLE `ranking` DISABLE KEYS */;
/*!40000 ALTER TABLE `ranking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` varchar(20) NOT NULL,
  `nomeUsuario` varchar(80) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'freedioma'
--

--
-- Dumping routines for database 'freedioma'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-07 15:56:38
