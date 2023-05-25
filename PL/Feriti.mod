#Esercizio feriti

/*
  * Vi è una situazione d'emergenza in seguito a un'esplosione.
  * Numerosi feriti devono essere ricoverati presso gli ospedali di zona.
  * Vi sono alcuni punti di triage attorono alla zona dell'incidente.
  * I feriti sono stati classificati in tre tipologie(traumi ortopedici, ustioni, intossicazione).
  * Ogni ospedale ha una capacità limitata nel ricevere i feriti per ciascuna tipologia.
  * Si vuole assegnare i feriti agli ospedali minimizzando il ritardo relativo medio.
  * È definito come il valore medio calcolato su tutta la popolazione dei feriti del ritardo relativo,
  * riferito ad ogni singolo ferito.
  * Il ritardo relativo è il rapporto tra il tempo di percorrenza dal punto di triage all'ospedale assegnato 
  * e il minimo tempo di percorrenza da quel punto di triage ad un ospedale compatibile con la tipologia di ferito.
  * Il numeratore di questo rapporto misura il livello di servizio ricevuto dal ferito.
  * il denominatore indica il livello di servizio migliore possibile che quel ferito avrebbe potuto ricevere nel caso luck.
  ********************************************************
  * Commento sul testo:
  * problema di flusso con termini noti interi, problema di PL.
  * tpmin è stato costruito a mano non era noto, incrociando tp e cap.
  * obiettivo 2: minimizzare il massimo sovraccarico tra gli ospedali.
  * ovvero il massimo tra i valori di sovraccarico riferiti ai singoli ospedali.
  * Per sovraccarico di un ospedale si intende il rapporto tra il numero di feriti
  * assegnati all'ospedale e il numero di feriti che sarebbero stati assegnati all'ospedale
  * se tutti gli ospedali avessero ricevuto i feriti in ugual numero.
*/

#DATI
param nT;           #numero punti di triage
set T:=1..nT;       #insieme dei punti di triage
param nO;           #numero di ospedali
set O:=1..nO;       #insieme degli ospedali
param nF;           #numero tipi feriti
set F:=1..nF;       #insieme dei tipi di feriti
param tp{T,O};      #tempo di percorrenza da punto triage a ospedale[minuti]
param cap{F,O};     #capacità di ogni ospedale per tipo di ferito[n° pazienti]
param tf{T,F};      #numero pazienti di ogni tipo per ogni punto di triage[n° pazienti]
param ftot{F};      #numero totale di feriti per ogni tipologia[n° pazienti]
param tpmin{T,F};   #tempo di percorrenza minimo tra punto triage e ospedali compatibili con tipo feriti.
#VARIABILI
var x{F,T,O} >= 0;   #quali tipi di pazienti da quali triage in quali ospedali
var delta >= 0;      #massimo sovraccarico su tutti gli ospedali(caso 2)
#VINCOLI
#vincolo sulla domanda di servizio
subject to domanda_feriti{f in F, t in T}:
 sum{o in O} x[f,t,o] >=  tf[t,f];
#vincolo sulla capacità di servizio(degli ospedali)
subject to offerta_feriti{f in F, o in O}:
 sum{t in T} x[f,t,o] <= cap[f,o];
#OBIETTIVO
#caso 1: minimizzare il valore medio dei tempi di ritardo(min-sum) (~215.51)
#minimize z1: sum{t in T,o in O,f in F} tp[t,o] / tpmin[t,f] * x[f,t,o];
#caso 2: minimizzare il massimo sovraccarico tra tutti gli ospedali(min-max)
minimize z2: delta;
subject to minmax{o in O}:
 delta >= (sum{t in T, f in F} x[f,t,o]) / 
         (sum{f in F, t in T} tf[t,f] / nO);
#######
data;

param nF:=3;
param nO:= 8;
param nT:=6;

param tp: 1   2   3   4   5   6   7   8:=
1        10  12  15  20  32  36  40  50
2        14   8   5  10  30  38  40  48
3        21  22  10  10  32  25  25  40
4        24  22  15  15  20  15  25  45
5        30  30  25  28  27  22  20  30
6        32  35  30  30  28  25  20  20;

param tpmin:    1   2   3:=
1               10  10  10
2               5   5   5
3               10  10  10  
4               15  15  15
5               20  25  20
6               20  20  20;

param cap: 1   2   3   4   5   6   7   8:=
1         12  10   8  10  15  20  20  20
2          5   0   2   0   8   0   0  10
3         15   8  11   5  20  18  13   0;

param tf: 1   2   3:=
  1       3   0   5
  2      11   1   6
  3      23   9   0
  4      12   5  12
  5      19   2  19
  6      22   3  28;

param ftot:=
1   90
2   20
3   70;
 

end;
