DROP DATABASE IF EXISTS Snimanje;

CREATE DATABASE Snimanje;

USE Snimanje;

CREATE TABLE Agencija (
 -> idAg INT UNSIGNED NOT NULL AUTO_INCREMENT,
 -> naziv VARCHAR(30) NOT NULL,
 -> PRIMARY KEY(idAg) );

CREATE TABLE Glumac (
 -> idGlumac INT UNSIGNED NOT NULL AUTO_INCREMENT,
 -> mbr VARCHAR(13) NOT NULL,
 -> ime VARCHAR(20) NOT NULL,
 -> prezime VARCHAR(20) NOT NULL,
 -> honorar INT UNSIGNED NOT NULL,
 -> idAg INT UNSIGNED NOT NULL,
 -> PRIMARY KEY (idGlumac) );
 
 CREATE TABLE Film (
 -> idFilm INT UNSIGNED NOT NULL AUTO_INCREMENT,
 -> Naziv VARCHAR(30) NOT NULL,
 -> glavniG INT UNSIGNED NOT NULL,
 -> PRIMARY KEY (idFilm) );
 
 CREATE TABLE Snima (
 -> idGlumac INT UNSIGNED NOT NULL,
 -> idFilm INT UNSIGNED NOT NULL,
 -> brCasova INT NOT NULL,
 -> PRIMARY KEY (idGlumac, idFilm) );
 
ALTER TABLE Glumac ADD CONSTRAINT FK_ag FOREIGN KEY (idAg) REFERENCES Agencija (idAg);

ALTER TABLE Snima ADD CONSTRAINT FK_glumac FOREIGN KEY (idGlumac) REFERENCES Glumac(idGlumac);

ALTER TABLE Snima ADD CONSTRAINT FK_film FOREIGN KEY (idFilm) REFERENCES Film (idFilm);

ALTER TABLE Film ADD CONSTRAINT FK_glavni FOREIGN KEY (glavniG) REFERENCES Glumac (idGlumac);

ALTER TABLE Glumac MODIFY prezime VARCHAR(38);

ALTER TABLE Agencija ADD grad VARCHAR(30);

INSERT INTO Agencija (naziv, grad) VALUES ('Agencija br. 1', 'Beograd');

INSERT INTO Agencija (naziv, grad) VALUES ('Agencija br. 2', 'Beograd');

INSERT INTO Agencija (naziv, grad) VALUES ('Agencija br. 3', 'Valjevo');
 
INSERT INTO Agencija (naziv, grad) VALUES ('Agencija br. 4', 'Novi Sad');

INSERT INTO Glumac (mbr, ime, prezime, honorar, idAg) VALUES ('1234567890345', 'Marko', 'Markovic', 70000, 1);

INSERT INTO Glumac (mbr, ime, prezime, honorar, idAg) VALUES ('1234567890678', 'Petar', 'Petrovic', 90000, 2);

INSERT INTO Glumac (mbr, ime, prezime, honorar, idAg) VALUES ('1234567890198', 'Milica', 'Matic', 50000, 3);

INSERT INTO Glumac (mbr, ime, prezime, honorar, idAg) VALUES ('1234567890888', 'Snezana', 'Jovanovic', 100000, 4);

INSERT INTO Film (naziv, glavniG) VALUES ('Film 1', 1);

INSERT INTO Film (naziv, glavniG) VALUES ('Film 2', 2);

INSERT INTO Film (naziv, glavniG) VALUES ('Film 3', 3);

INSERT INTO Film (naziv, glavniG) VALUES ('Film 4', 4);

INSERT INTO Snima (idGlumac, idFilm, brCasova) VALUES (1, 1, 40);

INSERT INTO Snima (idGlumac, idFilm, brCasova) VALUES (2, 2, 90);

INSERT INTO Snima (idGlumac, idFilm, brCasova) VALUES (3, 3, 20);

INSERT INTO Snima (idGlumac, idFilm, brCasova) VALUES (4, 4, 120);

UPDATE Film SET naziv = 'Sati' WHERE glavniG = 3;

CREATE INDEX MaticniBroj ON Glumac (mbr);

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

CREATE VIEW Spisak AS SELECT ime FROM Glumac WHERE honorar BETWEEN 20000 AND 100000 OR ime LIKE '%a%';

DELETE FROM Glumac WHERE honorar < 11000 AND ime = 'Jovan';

DROP INDEX MaticniBroj ON Glumac;

GRANT ALL ON *.* TO 'student'@'localhost';

REVOKE UPDATE, INSERT ON *.* FROM 'student'@'localhost';

FLUSH PRIVILEGES;
