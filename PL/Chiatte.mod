#Esercizio Chiatte

/*
  * Un'idrovia collega un porto marittimo a un porto fluviale e ci sono 2 canali navigabili paralleli.
  * Le chiatte cariche di merce, tutte uguali e con capacit� nota, possono navigare in entrambe le direzioni,
  * e su entrambi i canali. Le chiatte vanno alla stessa velocit� nota e costante rispetto all'acqua sui canali.
  * La corrente influisce lungo i canali navigabili a velocit� nota e costante da monte verso valle.
  * QUindi rispetto alla terra le chiatte che risalgono verso monte navigano pi� lentamente rispetto a
  * quelle che scendono verso valle.
  * Lungo entrambi i canali c'� una strettoia nella quale le chiatte devono navigare a senso unico alternato,
  * sono note le lunghezze dei tratti.
  * Le chiatte sono in numero illimitato e lavorano a ciclo continuo tra i due porti senza sosta.
  * Si vuole sapere la massima quantit� di merce per unit� di tempo che si pu� trasportare da valle a monte
  * e da monte a valle in questo modo.
  * Si vuole sapere quante chiatte instradare in ciascuno dei due canali per ottenere questo risultato.
  ******************************************
  * Commento sul testo:
  * problema di flusso con rete composta dai due canali parelleli bidirezionali che collegano 2 nodi.
  *
*/

#DATI
param nC;       #numero dei canali
set C:=1..nC;   #insieme dei canali
param nD;       #numero direzioni
set D:=1..nD;   #insieme direzioni
param st{C};    #lunghezza strettoia per ogni canale[km]
param vel{C};   #velocit� della corrente per ogni canale[km/h]
param speed;    #velocit� delle chiatte rispetto all'acqua[km/h]
param cap;      #capacit� di ogni chiatta[tonnellate]
#VARIABILI
var x{C,D} >= 0;        #numero di chiatte per unit� di tempo
#VINCOLI
#vincolo di flusso(non c'� accumulo di chiatte nel tempo, i flussi devono essere bilanciati)
subject to flow:
  sum{c in C} x[c,1] = sum{c in C} x[c,2];
#vincolo su frazioni di tempo complessivamente disponibili al traffico in ogni direzione e su ogni canale
subject to tempo{c in C}:
  x[c,1]*st[c]/(speed-vel[c]) + x[c,2]*st[c]/(speed+vel[c]) <= 1;
#OBIETTIVO
#massimizzare il flusso di merce(unit� di peso per unit� di tempo)
#non fa alcuna differenza massimizzare in salita o in discesa
maximize z: sum{c in C} x[c,1] *cap;
#######
data;

param nC:=2;
param nD:=2;
param speed:=10;
param cap:=1500;

param:             st                       vel:=
  1                0.5                       2 
  2                0.75                      1;

end;
