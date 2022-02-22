SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `snimanje`
--
CREATE DATABASE IF NOT EXISTS `snimanje` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `snimanje`;

-- --------------------------------------------------------

--
-- Table structure for table `agencije`
--

DROP TABLE IF EXISTS `agencije`;
CREATE TABLE IF NOT EXISTS `agencije` (
  `idAg` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naziv` varchar(30) NOT NULL,
  PRIMARY KEY (`idAg`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

ALTER TABLE Agencija ADD grad VARCHAR(30);
--
-- Dumping data for table `agencije`
--

INSERT INTO `agencije` (`idAg`, `naziv`, `grad`) VALUES
(1, 'Agencija br. 1', 'Beograd'),
(2, 'Agencija br. 2', 'Beograd'),
(3, 'Agencija br. 3', 'Valjevo'),
(4, 'Agencija br. 4', 'Novi Sad');

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE IF NOT EXISTS `film` (
  `idFilm` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naziv` varchar(30) NOT NULL,
  `glavniG` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idFilm`),
  KEY `FK_glavni` (`glavniG`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `film`
--

INSERT INTO `film` (`idFilm`, `naziv`, `glavniG`) VALUES
(1, 'Film 1', 1),
(2, 'Film 2', 2),
(3, 'Film', 3),
(4, 'Film 4', 4);

UPDATE Film SET naziv = 'Sati' WHERE glavniG = 3;
-- --------------------------------------------------------

--
-- Table structure for table `glumac`
--

DROP TABLE IF EXISTS `glumac`;
CREATE TABLE IF NOT EXISTS `glumac` (
  `idGlumac` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mbr` varchar(13) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(30) DEFAULT NULL,
  `honorar` int(10) UNSIGNED NOT NULL,
  `idAg` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idGlumac`),
  KEY `FK_ag` (`idAg`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

ALTER TABLE Glumac MODIFY prezime VARCHAR(38);
--
-- Dumping data for table `glumac`
--

INSERT INTO `glumac` (`idGlumac`, `mbr`, `ime`, `prezime`, `honorar`, `idAg`) VALUES
(1, '1234567890345', 'Marko', 'Markovic', 70000, 1),
(2, '1234567890678', 'Petar', 'Petrovic', 90000, 2),
(3, '1234567890198', 'Milica', 'Matic', 50000, 3),
(4, '1234567890888', 'Snezana', 'Jovanovic', 100000, 4);

-- --------------------------------------------------------

--
-- Table structure for table `snima`
--

DROP TABLE IF EXISTS `snima`;
CREATE TABLE IF NOT EXISTS `snima` (
  `idGlumac` int(10) UNSIGNED NOT NULL,
  `idFilm` int(10) UNSIGNED NOT NULL,
  `brCasova` int(11) NOT NULL,
  PRIMARY KEY (`idGlumac`,`idFilm`),
  KEY `FK_film` (`idFilm`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `snima`
--

INSERT INTO `snima` (`idGlumac`, `idFilm`, `brCasova`) VALUES
(1, 1, 40),
(2, 2, 90),
(3, 3, 20),
(4, 4, 120);

-- --------------------------------------------------------

--
-- Stand-in structure for view `spisak`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `spisak`;
CREATE TABLE IF NOT EXISTS `spisak` (
`ime` varchar(20)
);

-- --------------------------------------------------------

--
-- Structure for view `spisak`
--
DROP TABLE IF EXISTS `spisak`;
DROP VIEW IF EXISTS `spisak`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `spisak`  AS SELECT `glumac`.`ime` AS `ime` FROM `glumac` WHERE ((`glumac`.`honorar` between 20000 and 100000) OR (`glumac`.`ime` like '%a%')) ;
COMMIT;

SELECT DISTINCT honorar FROM Glumac;

SELECT * FROM Film ORDER BY naziv DESC LIMIT 2;

SELECT SUM(honorar) FROM Glumac WHERE ime LIKE '%r';

SELECT ime, prezime, honorar * 1.2 FROM Glumac;

SELECT ime, prezime, mbr, honorar FROM Glumac WHERE honorar = (SELECT MAX(honorar) FROM Glumac);

SELECT * FROM Glumac WHERE honorar > (SELECT MIN(honorar) FROM Glumac);

SELECT ime, prezime FROM Glumac INNER JOIN Film ON Glumac.idGlumac = Film.glavniG;

SELECT mbr FROM Glumac WHERE ime IN ('Dragan', 'Ana', 'Milena');

SELECT ime, prezime, honorar * 1.3 FROM Glumac INNER JOIN Agencija ON Agencija.grad = 'Beograd';

SELECT Agencija.idAg, AVG(Glumac.honorar) FROM Agencija, Glumac WHERE Glumac.honorar > 2000 GROUP BY Agencija.idAg;

SELECT Film.naziv, Snima.brCasova FROM Film, Snima WHERE Snima.brCasova > 150;

DELETE FROM Glumac WHERE honorar < 11000 AND ime = 'Jovan';

GRANT ALL ON *.* TO 'student'@'localhost';
REVOKE UPDATE, INSERT ON *.* FROM 'student'@'localhost';
FLUSH PRIVILEGES;




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
