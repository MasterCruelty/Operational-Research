#Esercizio Concentratori

/*
  * Una rete connette con cavi in fibra ottica diverse stazioni. Ciascuna può ospitare un concentratore.
  * Ovvero ospita un punto di raccolta di messaggi provenienti da un certo sottoinsieme di stazioni della rete.
  * I concentratori devono essere localizzati in modo che ogni stazione sia assegnata ad un concentratore.
  * Per ogni stazione c'è una domanda, ovvero la quantità di traffico I/O da quella stazione.
  * Ogni concentratore ha una capacità che dipende da dove è stato localizzato.
  * È necessario che la somma delle domande delle stazioni assegnate a un concentratore non eccedano la capacità.
  * Ogni assegnamento di una stazione ad un concentratore ha un costo che è proporzionale alla quantità di traffico.
  * Si vogliono minimizzare i costi complessivi. I concentratori sono in numero limitato.
  * Domande extra:
  * - Di quanto cambierebbero i costi se fosse possibile servire la domanda splittando in concentratori diversi.
  * risposta: aggiungendo condizione >= 0 e <= 1 sulle var y si ottiene un miglioramento da 30k a 25k
*/

#DATI
param nS;               #numero delle stazioni
set S :=1..nS;          #insieme delle stazioni
param C;                #numero di concentratori disponibili
param cu{S,S};           #costo unitario di allocazione del concentratore per ogni coppia di stazioni[€]
param d{S};             #domanda di traffico per ogni stazione
param cap{S};           #capacità di ogni concentratore installabile su ogni stazione

#VARIABILI
var x{S}   binary;      #quali stazioni ospitano il concentratore
var y{S,S} binary;      #la stazione s in S è servita dal concentratore 
#VINCOLI
#vincolo sul numero di concentratori
subject to conc:
     sum{s in S} x[s] = 2;
#vincolo di capacità su ogni concentratore
subject to capacity{s1 in S}:
     sum{s2 in S} y[s2,s1] * d[s2] <= cap[s1]*x[s1];
#vincolo tutte le stazioni devono essere servite
subject to servizio{s1 in S}:
     sum{s2 in S} y[s1,s2] = 1;
#vincolo relazione tra variabili x e y(se la stazione s2 è servita da un concent. allora y[s1,s2] deve essere 1
subject to integrity{s1 in S, s2 in S:s1<>s2}:
     y[s1,s2] <= x[s2];
#OBIETTIVO
#minimizzare i costi complessivi
minimize z: sum{s1 in S,s2 in S} y[s1,s2] * (cu[s1,s2] * d[s1]);
######
data;

param nS:= 6;
param C:=2;

param cu:          1   2   3   4   5   6 :=
   1             12  45  18  27  19  18     
   2             37  34  18  28  35  28
   3             11  10  15  34  23  10
   4             37  39  31  28  29  21
   5             15  34  11  20  28  15
   6             12  30  20  18  27  24;


param d:=
   1         120
   2         150
   3         110
   4         175
   5         210
   6         180;

param cap:=
   1        410
   2        490
   3        400
   4        380
   5        470
   6        440;

end;
