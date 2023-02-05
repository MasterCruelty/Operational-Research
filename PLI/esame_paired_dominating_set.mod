#Esercizio esame paired dominating set
/*
  *Dato il grafo stradale di una città, dove le strade sono rettilinee, il problema consiste nel posizionare alcune sentinelle
  *per sorvegliare gli incroci. Ogni sentinella sorveglia l’incrocio in cui è posta e tutti quelli adiacenti. Tutti gli incroci della
  *città devono essere sorvegliati usando il minimo numero di sentinelle. Le sentinelle però devono anche controllarsi a due
  *a due. Formulare il problema e classificarlo.
  *Dati.
  *La città ha 30 incroci, collegati dalle vie elencate in tabella. Alcuni incroci possono avere una sola via incidente.
  *
  **********************************************
  *Commento sul testo:
  *Si tratta di una variante del modello di set covering.
  *Si vogliono coprire tutti gli incroci con il minimo numerodi sentinelle.
  *Vincolo di avere ogni sentinella in un incrocio e averne un'altra nell'incrocio adiacente.
*/

#DATI
param nStrade;
set N:=1..nStrade;
set Archi within N cross N;

#VARIABILI
var x{N} binary;		#scelta dell'incrocio su cui posizionare la sentinella


#VINCOLI
#vincolo di copertura di tutti gli incroci
subject to copertura1{n1 in N}:
	x[n1] + sum{n2 in N:(n1,n2) in Archi} x[n2] >= 1;

#OBIETTIVO
#minimizzare il numero di sentinelle agli incroci
minimize z: sum{n in N} x[n];

########
data;

param nStrade:=30;
set Archi := (1,2)   (1,3)   (1,4)   (2,30)  (3,13)  (3,16)  (4,5)   (4,6)  (4,24)   (5,6)   (5,8)   (5,13)
			 (6,7)   (7,9)   (7,10)  (8,9)   (8,12)  (8,13)  (8,27)  (9,10) (9,27)   (10,11) (11,23) (11,29)
			 (12,13) (12,18) (12,19) (12,27) (13,14) (14,15) (14,18) (15,16) (15,17) (18,19) (18,28) (19,20)
			 (19,28) (20,21) (20,22) (20,29) (24,25) (24,26) (27,29);
end;
