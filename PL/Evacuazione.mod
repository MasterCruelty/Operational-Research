#Esercizio Evacuazione

/*
  * Bisogna evacuare una zona colpita da alluvione. I residenti sono radunati in alcuni rifugi.
  * Devono poi essere trasportati in strutture più sicure. Sono stati attivati alcuni collegamenti con auto e bus.
  * Per ogni collegamento è stato associato un costo diverso di trasporto per persona.
  * Per ogni collegamento è stato calcolato qual è il tempo di percorrenza medio per ogni persona.
  * Si vogliono minimizzare i costo complessivi di trasporto e anche il tempo per completare il trasporto.
  * È noto il numero di persone da trasportare e sono dati dei limiti di capacità per ogni struttura di destinazione e
  * ogni collegamento.
  ********************************************************
  * Post domande:
  * 1. Minimo costo con tempo non superiore a 120 ore
  * 2. Minimo tempo con costo non superiore a 1.250.000 €
  * 3. Massimo miglioramento di tutti gli obiettivi rispetto ai valori standard indicati sopra.
  * 4. Minimo costo valutando il tempo in 500 euro per ogni ora
*/

#DATI
param nR;		#numero rifugi
set R:=1..nR;	#insieme dei rifugi
param nS;		#numero delle strutture ricettive
set S:=1..nS;	#insieme delle struttura ricettive
param cap{S};	#capacità di ogni struttura ricettiva[n persone]
param dis{R};	#distribuzione dei rifugiati in ogni rifugio[n persone]
param c{R,S};	#costi di spostamento da rifugio a struttura [€/persona]
param t{R,S};	#tempi di spostamento da rifugio a struttura [ore/persona]
#capacità di ogni collegamento: 400

#VARIABILI
var x{R,S} >= 0,<=400;		#numero di rifugiati spostati da r in R a s in S
var maxtime >= 0;			#tempo massimo tra quelli impiegati su ogni collegamento
var costo_totale >= 0;      #costo totale
#VINCOLI
#vincoli capacità struttura ricettiva
subject to capacityS{s in S}:
	sum{r in R} x[r,s] <= cap[s];
#vincolo tutti i rifugiati devono essere spostati
subject to salviamoli{r in R}:
	sum{s in S} x[r,s] = dis[r];
#OBIETTIVO
#obiettivi versione base: minimizzare i costi e i tempi
#minimize z1: costo_totale;
minimize z2: maxtime;
#definizione costo complessivo
subject to def_costototale:
  costo_totale = sum{r in R, s in S} x[r,s] * c[r,s];
#definizione tempo complessivo massimo
subject to minmax:
	maxtime >= sum{r in R, s in S} x[r,s] * t[r,s];
#########
data;

param nR:=3;
param nS:=6;
param cap:=
 1     500
 2     650
 3     550
 4     550
 5     550
 6     400;

param dis:=
 1      850
 2     1250
 3      900;

param c:      1    2    3    4    5    6:=
 1   		250  350  300  380  310  340
 2   		280  420  450  390  375  350
 3   		360  410  420  400  380  290;

param t:      1    2    3    4    5    6:=
 1   		0.20 0.35 0.40 0.25 0.25 0.30 
 2   		0.35 0.50 0.45 0.35 0.45 0.40 
 3   		0.25 0.35 0.45 0.40 0.30 0.40;

end;
