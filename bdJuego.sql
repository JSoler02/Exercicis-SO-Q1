DROP DATABASE IF EXISTS bdFireWater;
CREATE DATABASE bdFireWater;

USE bdFireWater;

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






#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
	MYSQL *conn;
	int err;
// Estructura especial para almacenar resultados de consultas 
	MYSQL_RES *resultado;
	MYSQL_ROW row;
	char nombre[60];
	strcpy(mapa, "'Juan'");
	char consulta [500];
	
	//Creamos una conexion al servidor MYSQL 
	conn = mysql_init(NULL);
	if (conn==NULL) {
		printf ("Error al crear la conexion: %u %s\n", 
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	//inicializar la conexion
	conn = mysql_real_connect (conn, "localhost","root", "mysql", "bdFireWater",0, NULL, 0);
	if (conn==NULL) {
		printf ("Error al inicializar la conexion: %u %s\n", 
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	
	// Ahora vamos a realizar la consulta
	printf ("Ahora encontraremos los id de las partidas cuya duracion sea mayor a 120 y donde Juan haya participado: \n");
	strcpy (consulta,"SELECT partida.id FROM (jugador, partida, historial) WHERE jugador.username = "); 
	strcat (consulta, nombre);
	strcat (consulta," AND jugador.id = historial.id_j AND historial.id_p = partida.id AND partida.id IN (SELECT partida.id FROM(partida) WHERE partida.duracion > 120);");
	// hacemos la consulta 
	err=mysql_query (conn, consulta); 
	if (err!=0) {
		printf ("Error al consultar datos de la base %u %s\n",
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	
	//recogemos el resultado de la consulta 
	resultado = mysql_store_result (conn); 
	row = mysql_fetch_row (resultado);
	if (row == NULL)
		printf ("No se han obtenido datos en la consulta\n");
	else
		while (row != NULL){
			printf("ID: %s\n", row[0]);
			// obtenemos la siguiente fila
			row = mysql_fetch_row (resultado);
	}
		// cerrar la conexion con el servidor MYSQL 
		mysql_close (conn);
		exit(0);
}