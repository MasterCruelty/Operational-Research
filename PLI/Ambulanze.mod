#Esercizio Ambulanze

/*
  * Conoscendo la popolazione residente in ciascuno dei centri abitati, 
  *localizzare le ambulanze in modo da massimizzare la copertura della popolazione.
  *Valore ottimo: 3040 di popolazione in 3 centri abitati differenti.

*/

#DATI
param nC;           #numero dei centri abitati
set C := 1..nC;     #insieme dei centri abitati
param nP;           #numero delle postazioni in cui possono sostare le ambulanze
set P := 1..nP;     #insieme delle postazioni
param nA;           #numero delle ambulanze
param pop{C};       #popolazione per ogni centro abitato[n abitanti]
param tempo_i{C,P}; #tempo di intervento per ogni centro abitato da ogni postazione[minuti]
param max_time;     #tempo massimo per l'intervento

#VARIABILI
var x{P,C} binary;  #Quale ambulanza copre quali paesi

#VINCOLI
#vincolo di copertura tempo massimo
subject to copertura{c in C,p in P}:
   x[p,c]*tempo_i[c,p] <= max_time;
#vincolo sul numero di ambulanze
subject to max_ambulanze:
   sum{p in P,c in C} x[p,c] <= nA;
#vincolo di integralità
subject to integrity{p1 in P,p2 in P,c in C:p1<>p2}:
   x[p1,c] + x[p2,c]  <= 1;
   
#OBIETTIVO
maximize z: sum{p in P,c in C} x[p,c]*pop[c];

#########
data;

param nC := 9;
param nP := 6;
param nA := 3;

param pop:=
  1           250
  2           450
  3          1000
  4           825
  5          1100
  6           940
  7           120
  8           280
  9           480;

param tempo_i:         1    2    3    4    5    6:=
1                      1    3   12    6   12    4
2                      2    2   11    2   13    8
3                      5    3   12    0   19    7
4                      7    5   14    1   21    9
5                      5    0    8    3   11    3
6                     14    8    0   12    6   12
7                     17   12    3   16    2    9
8                     12    8    8   12    2    4
9                      7    3   12    7    7    0;

param max_time := 8;

end;
