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
	strcpy (nombre, "'Juan'");
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