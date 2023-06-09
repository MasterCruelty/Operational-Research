#Esercizio nutrie

/*
  * Bisogna contrastare un'invasione di nutrie. Vengono assoldate squadre di cacciatori.
  * Le squadre abbattono o catturano gli animali. In ogni paesi vi è una stima sulla popolazione di nutrie.
  * Si vuole ripartire il compito tra i cacciatori in modo che ciascuno possa cacciare un numero equo di nutrie.
  * Ogni cacciatore può operare in massimo 3 paesi diversi, senza sconfinare negli altri.
  * In base ai cacciatori assegnati ai paesi si può calcolare il numero di nutrie che ci si aspetta da ogni cacciatore.
  * Si vuole minimizzare il massimo di tali valori target che ci si aspetta da ogni cacciatore.
  * valore ottimo 85. PROBLEMA PNL
*/

#DATI
param nC;		#numero cacciatori
set C:=1..nC;	#insieme cacciatori
set P;			#insieme paesi
param pop{P};	#popolazione nutrie in ogni paese
param maxP;		#massimo numero di paesi assegnabili a un cacciatore
#VARIABILI
var x{C,P} binary;		#assegnamento cacciatore c in C a paese p in P
var y{P} >= 0 integer;	#numero di cacciatori assegnati per ogni paese
var k{C} >= 0;			#target di ogni cacciatore 
var delta;				#massimo numero di nutrie abbattute su tutti i cacciatori
#VINCOLI
#vincolo sul massimo di 3 paesi per ogni cacciatore
subject to maxPaesi{c in C}:
	sum{p in P} x[c,p] <= maxP;
#vincolo ogni cacciatore deve essere assegnato almeno a un paese
subject to assign{p in P}:
	sum{c in C} x[c,p] >= 1;
#vincolo definizione y(per ogni paese quanti cacciatori sono assegnati)
subject to def_y{p in P}:
	y[p] = sum{c in C} x[c,p];
subject to un_cacciatore{p in P}:
	y[p] >= 1;
#vincolo definizione target var k
subject to target{c in C}:
	k[c] = sum{p in P} (pop[p] / y[p] * x[c,p]);
#OBIETTIVO
minimize z: delta;
#vincolo per minmax
subject to minmax{c in C}:
	delta >= k[c];
###########
data;

param nC:=5;
param maxP :=3;
set P := A B C D E F G H I L;
param pop:=
A 20
B 30
C 24
D 36
E 80
F 72
G 54
H 37
I 25
L 47;

end;
