#Esercizio Autostrada

/*
  * C'è un'autostrada suddivisa su diversi tratti con diversi caselli.
  * Il pedaggio e il vantaggio è studiato per far trovare conveniente l'autostrada agli utenti.
  * l'ente ha quantificato in euro il massimo prezzo in euro che ogni utente è disposto a pagare a seconda de tratto.
  * Obiettivo far si che gli utenti che attualmente trovano conveniente l'autostrada, continuino a servirsene.
*/

#DATI
param nC;           #numero di caselli
set C:=0..nC;       #insieme dei caselli
param flux{C,C};    #flusso di veicoli da casello in a casello out[n veicoli / ora]
param gain{C,C};    #vantaggio rispetto a percorsi alternativi da casello in a casello out

#VARIABILI
var x{C} >= 0;      #pedaggio da far pagare su ogni tratto di autostrada[€]
#VINCOLI
#vincolo tariffe vantaggiose su ogni tratta
subject to vantaggio{c1 in C,c2 in C:c2>c1}:
     gain[c1,c2] >= sum{k in C:k>= c1 and k<c2} x[k];
#OBIETTIVO
maximize z: sum{c1 in C,c2 in C:c2>c1} flux[c1,c2] * sum{k in C:k>=c1 and k <c2} x[k];
############
data;

param nC:=7;

param flux: 0   1   2   3   4   5   6   7:=
 0          0 460 510 450 325 430 450 500
 1          .   0 120 150 150 220 240 250
 2          .   .   0 260 150 120 110  90
 3          .   .   .   0  80 130 140 130
 4          .   .   .   .   0 200 210 240
 5          .   .   .   .   .   0 340 200
 6          .   .   .   .   .   .   0 185
 7          .   .   .   .   .   .   .   0;

param gain:     0  1  2  3  4  5  6  7:=
0               0 10 15 20 26 33 38 41
1               .  0 10 18 21 30 34 37
2               .  .  0 10 15 24 30 33
3               .  .  .  0 10 17 21 31
4               .  .  .  .  0 10 14 19
5               .  .  .  .  .  0 10 14
6               .  .  .  .  .  .  0 10
7               .  .  .  .  .  .  .  0;

end;
