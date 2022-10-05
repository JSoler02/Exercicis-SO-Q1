/* File to create the DB and all the necessary tables for our SO project*/

DROP DATABASE IF EXISTS bdFireWater;
CREATE DATABASE bdFireWater;
USE bdFireWater;


/* We create three tables. Historial one will be used to relate the other two.*/
CREATE TABLE jugador (
	id INT NOT NULL,
	username VARCHAR(60) NOT NULL,
	password VARCHAR (60) NOT NULL,
	PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE partida (
	id INT NOT NULL,
	mapa	VARCHAR(30) NOT NULL,
	fecha VARCHAR(10),
	hora VARCHAR(8),
	duracion INT, 
	resultado VARCHAR(15),
	PRIMARY KEY (id)
	
)ENGINE=InnoDB;

CREATE TABLE historial (
	id_j INT NOT NULL,
	id_p INT NOT NULL,
	puntos INT,
	posicion INT,
	FOREIGN KEY (id_j)REFERENCES jugador(id),
	FOREIGN KEY (id_p)REFERENCES partida(id)
)ENGINE=InnoDB;

/*We add parameters into the tables.*/
INSERT INTO jugador VALUES(1,"Juan","123");
INSERT INTO jugador VALUES(2,"Maria","123");
INSERT INTO jugador VALUES(3,"Bernat","contrasenya");


INSERT INTO partida VALUES(1,"templo","01/10/2022", "10:00:00", 120, "Superado");
INSERT INTO partida VALUES(2,"templo","01/10/2022", "11:50:00", 120, "Superado");
INSERT INTO partida VALUES(3,"campo","02/10/2022", "17:00:00", 180, "No Superado");

	
INSERT INTO historial VALUES(1,1,10,1);
INSERT INTO historial VALUES(2,1,20,2);
INSERT INTO historial VALUES(3,2,100,1);
INSERT INTO historial VALUES(1,2,10,2);
INSERT INTO historial VALUES(2,2,12,3);
INSERT INTO historial VALUES(3,3,0, 1);
INSERT INTO historial VALUES(1,3,10,2);
INSERT INTO historial VALUES(2,3,15,3);
