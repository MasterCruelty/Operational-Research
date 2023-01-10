#Esercizio localizzazione depositi

#Dato un insieme di potenziali depositi, ciascuno con un dato costo corrispondente, 
#ed un insieme di utenti da rifornire, dato il costo di trasporto della merce tra ogni utente e ogni deposito,
#decidere da dove erogare il servizio in modo da minimizzare il costo complessivo.

#Edit: variante con capacità => stesso problema ma ogni deposito ha una data capacità e ogni utente
#una data domanda, ogni utente può essere rifornito anche da più depositi diversi.


#DATI
param nD;
set D:= 1..nD;				#Insieme dei depositi
param nU;
set U:=1..nU;				#Insieme degli utenti
param trasporto{D,U};		#Costo di transporto tra ogni deposito e utente.
param costi{D};				#Costo per ogni deposito
param capacita{D};			#Capacita di ogni deposito
param domanda{U};			#Domanda di ogni utente

#VARIABILI
var erogato{D} binary;		#selezione deposito da cui erogare
var x{D,U} >= 0;					#quantità trasportata

#VINCOLI
#Vincolo sulla soddisfazione della domanda degli utenti
subject to domanda_U{i in U}:
	sum{j in D} x[j,i] = domanda[i];
#Vincolo sulla capacità dei depositi
subject to cap{i in D}:
	sum{j in U} x[i,j] <= capacita[i] *erogato[i];


#OBIETTIVO
minimize z: sum{i in D,j in U} x[i,j] *trasporto[i,j] + sum{i in D} erogato[i] * costi[i];
######
data;

param nD:=5;
param nU:=10;
param trasporto: 1	 2	 3	 4	 5	 6	 7	 8	 9	 10:=
1				35	24	62	57	81	34	36	12	63	24	
2				72	25	42	25	64	14	24	74	84	15	
3				48	37	62	14	56	94	51	76	11	21	
4				26	26	73	83	15	89	89	21	44	53	
5				62	26	37	26	15	37	24	61	54	13;

param: costi	capacita:=
1		35			175
2		32			126
3		38			110
4		38			92
5		41			155;

param domanda:=
1	35
2	28	
3	49
4	37
5	40
6	26	
7	31
8	48
9	28
10	36;
end;
