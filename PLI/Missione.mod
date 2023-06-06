#Esercizio missione

/*
  * Bisogna organizzare una missione in Tibet con n scienziati.
  * Ognuno vuole portare con sè m oggetti che gli servono per compiere esperimenti.
  * Per ogni oggetto è noto lo spazio che occupa ed è noto anche il valore dell'esperimento.
  * Lo spazio disponibile negli zaini è limitato e non tutti gli oggetti possono essere trasportati.
  * Si vuole massimizzare il valore degli esperimenti.
  * È necessario tutti gli scienziati nel modo più equo possibile.
  * Si vuole sapere qual è la soluzione che massimizza il minimo tra i valori degli esperimenti dei diversi scienziati.
  * Extra: si vuole confrontare la soluzione con la soluzione ottima che si avrebbe se si potesse massimizzare
  * il valore complessivo di tutti gli esperimenti compiuti. Quanto costa in termini di valore complessivo per 
  * seguire la politica di equità nella prima f.o.? Quanto si perde in equità perseguendo la seconda?
  *************************
  * Risposte:
  * - nel caso dell'equità tutti gli scienziati hanno un valore di almeno 25. Valore complessivo 110.
  * - nel caso del valore complessivo il quarto scienziato produce valore di 10 rispetto agli altri. Valore complessivo 134.
*/

#DATI
param nP;       #numero scienziati
set P:=1..nP;   #insieme scienziati
param nO;       #numero oggetti
set O:=1..nO;   #insieme oggetti
param sp{P,O};  #spazio occupato da ogni oggetto per ogni scienziato
param val{P,O}; #valore di ogni oggetto per ogni scienziato
param size;     #capacità massima disponibile
#VARIABILI
var x{P,O} binary;      #quale scienziato porta quale oggetto
var delta;              #minimo tra i valori degli esperimenti
var val_totale;         #valore totale complessivo
#VINCOLI
#vincolo di capacità
subject to capacity:
     sum{p in P, o in O} x[p,o] * sp[p,o] <= size;
#vincolo definizione val totale
subject to def_valtotale:
     val_totale = sum{p in P,o in O} x[p,o] * val[p,o];
#OBIETTIVO
#massimizzare il minimo tra i valori degli esperimenti
#maximize z: delta;
#massimizzare il valore complessivo totale
maximize z: val_totale;
#minimo tra i valori degli esperimenti dei diversi scienziati
subject to maxmin{p in P}:
     delta <= sum{o in O} x[p,o] * val[p,o];
##########
data;

param nP:=4;
param nO:=6;
param sp:    1  2  3  4  5  6:=
   1     	35 48 12 26 29 40
   2     	18 17 41 36 28 15
   3      	33 20 14 12  8 27
   4      	20 28 31 35  7 15;

param val:   1  2  3  4  5  6:=
   1     	31 40 19 25 33 41
   2      	17 25 36 32 30 19
   3      	25 28 12 18 10 29
   4      	15 18 30 27 10 12;
param size:= 100;

end;
