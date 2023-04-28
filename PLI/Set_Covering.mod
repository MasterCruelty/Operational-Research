#Esercizio Set Covering


#Dato un insieme di luoghi da cui si può erogare un servizio, ciascuno con un dato costo
#e un insieme di utenti che possono ricevere il servizio ciascuno da alcuni dei luoghi
#decidere da dove erogare il servizio in modo da minimizzare il costo complessivo.

#Commento:
#Lo scopo dell'esercizio è coprire tutti gli utenti ma minimizzando i costi, quindi erogando da solo alcuni
#dei luoghi disponibili.
#È una variante del problema dello zaino.

#DATI
param nU;			#numero di utenti
set U := 1..nU;		#insieme degli utenti
param nL;			#numero dei luoghi
set L := 1..nL;		#inseieme dei luoghi
param utenti{U,L};	#tabella degli utenti coperti da quali luoghi
param costi{L};		#costo del servizio per ogni luogo

#VARIABILI
var erogato{L} binary; #selezione del luogo dove erogare il servizio.

#VINCOLI
#Vincolo sulla copertura degli utenti
subject to utente_coperto{i in U}:
	sum{j in L} erogato[j] * utenti[i,j] >=1;

#OBIETTIVO
#Minimizzare i costi di erogazione del servizio
minimize z: sum{i in L} costi[i] * erogato[i];

#####
data;
param nL:= 10;
param nU:= 5;
param utenti:	1 2 3 4 5 6 7 8 9 10:=
1 				1 0 0 0 1 1 1 0 1 1
2 				0 0 0 1 1 0 0 0 1 0
3 				0 0 0 0 1 1 0 0 0 0
4 				0 0 0 0 0 0 1 1 1 0
5 				1 1 1 0 0 0 0 1 1 1;

param costi:=
1	205
2	311
3	450
4	274
5	321
6	469
7	327
8	631
9	750
10	400;
end;