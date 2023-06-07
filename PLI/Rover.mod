#Esercizio Rover

/*
  * Un rover esplora marte e sono stati segnalati diversi siti di interesse.
  * Il rover conosce la propria posizione, la posizione dei siti e il valore atteso della loro esplorazione.
  * Il rover conosce anche quanto tempo e quanta energia richiede l'esplorazione dei siti e lo spostamento da un sito all'altro.
  * Il rover ha risorse limitate in termini di tempo e energia.
  * La scarsità di risorse può precludere l'osservazione di tutti i siti, sarebbe necessario massimizzare il valore atteso delle esplorazioni.
  * Se invece fosse possibile visitare tutti i siti, allora l'obiettivo sarebbe quello di minimizzare il consumo complessivo di energia.
*/

#DATI
param nS;
set S:=1..nS;
param tsp{S,S};		#tempo di spostamento tra un sito e l'altro[minuti]
param tes{S};		#tempo di esplorazione di ogni sito[minuti]
param c{S};			#consumo per l'esplorazione di ogni sito[joule]
param val{S};		#valore ottenuto da ogni sito esplorato
param csp;			#consumo per gli spostamenti[joule al minuto]
param capE;			#energia disponibile
param capT;			#tempo disponibile

#VARIABILI
var x{S} binary;	#selezione del sito da visitare
var y{S,S} binary;	#percorso svolto dal rover (raggiungo un sito j da sito i)
var e{S} >= 0;		#energia consumata
var t{S} >= 0;		#tempo consumato
var emove{S,S} >= 0;#energia spostamenti da s1 a s2
#VINCOLI
#vincolo relazione tra var x e var y
subject to integrity{s1 in S}:
	x[s1] <= sum{s2 in S} y[s1,s2];
#vincolo un sito viene visitato solo una volta
subject to integrity2{s in S}:
	x[s] <= 1;
#vincolo flusso (grado uscente da ogni sito non ecceda il grado entrante) tranne il sito 7
subject to flow{s1 in S:s1<=6}:
	sum{s2 in S} y[s1,s2] <= sum{s2 in S} y[s2,s1];
#vincolo flusso sito 7 limitato superiormente a 1(parto da li ma non ci torno)
subject to flowSito7{s in S}:
	y[7,s] <= 1;
#vincolo per impedire auto-anelli/cicli
subject to noanelli{s in S}:
	y[s,s] = 0;
#vincolo definizione consumo per gli spostamenti
subject to energyMove{s1 in S,s2 in S}:
	emove[s1,s2] = tsp[s1,s2] * csp;
#vincolo su energia disponibile
subject to energyTot:
	sum{s in S} e[s] <= capE;
#vincolo sul tempo disponibile
subject to time:
	sum{s in S} t[s] <= capT;
#vincolo calcolo consumi di energia e tempo(impedisce anche sottocicli)
/*
  *l'energia utilizzata dal sito s1 di partenza deve essere maggiore di quella utilizzata dal nodo che devo ancora raggiungere
  * + i costi degli spostamenti + esplorazione - l'energia totale moltiplicata per lo spostamento effettuato.
  * Operazione analoga per il calcolo del consumo del tempo
*/
subject to calcoloEnergy{s1 in S,s2 in S:s1<>s2 and s2<7}:
	e[s1] >= (e[s2] +c[s2]+emove[s2,s1]) - (capE*(1-y[s2,s1]));
subject to calcoloTime{s1 in S,s2 in S:s1<>s2 and s2<7}:
	t[s1] >= (t[s2]+tes[s2]+tsp[s2,s1]) - (capT*(1-y[s2,s1]));
#OBIETTIVO
maximize z: sum{s in S:s<7} x[s] * val[s];
############
data;

param csp:=8;
param capE:=1000;
param capT:=400;
param nS:=7;

param tsp:      1    2   3   4   5   6  7:=
 1   			0   13  14  16  13  13 13 
 2  			13   0  15  14  16  14 11
 3  			14  15   0  15  18  13 17
 4  			16  14  15   0  17  16 18
 5  			13  16  18  17   0  18 15
 6  			13  14  13  16  18   0 15
 7  			13  11  17  18  15  15  0;

param tes:=
  1      35
  2      20
  3      40
  4      60
  5      25
  6      10;

param c:=
  1      60
  2      45
  3      70
  4     110
  5      50
  6      25;

param val:=
  1      90
  2      50
  3      20
  4     100
  5     120
  6      50;

end;
