#Esercizio somma 8612

#Quesito:
#Si ha un numero di 4 cifre tutte diverse l'una dall'altra e fra le quali non c'è lo zero.
#Queste cifre vengono fatte  'vagare' spostando quella delle migliaia al posto delle decine,
#quella delle centinaia al posto delle unità, quella delle decine al posto delle centinaia,
#e quella delle unità al posto delle migliaia.
#Fatto ciò ne risulta un numero diverso che sommato a quello iniziale dà come somma 8612.
#due delle cifre che formano questo totale compaiono in entrambi i numeri sommati.
#Obiettivo: trovare il numero iniziale.

#Commento:
#Diventa un problema di assegnamento delle cifre

#DATI
param N;		#Numero di posizioni 0=unità fino a 3=migliaia
set Pos:=0..N-1;#Ogni posizione p pesa 10^p
set C:=1..9;
set Speciale within C;
param s;
param k;

#VARIABILI
var x1{Pos,C} binary; #Assegnamento cifre numero 1
var x2{Pos,C} binary; #Assegnamento cifre numero 2

#VINCOLI
#la stessa cifra deve comparire una volta
subject to tutte_diverse{i in C}:
	sum{j in Pos} x1[j,i] <= 1;

#una cifra per ogni posizione
subject to assign{p in Pos}:
	sum{c in C} x1[p,c] = 1;

#permutazione cifre
#migliaia 1 = decine 2
subject to permut1{c in C}: x1[3,c] = x2[1,c];
#cetinaia 1 = unità 2
subject to permut2{c in C}: x1[2,c] = x2[0,c];
#decine 1 = centinaia 2
subject to permut3{c in C}: x1[1,c] = x2[2,c];
#unita 1 = migliaia 2
subject to permut4{c in C}: x1[0,c] = x2[3,c];

#Somma
subject to Somma:
	sum{p in Pos} 10^p * (sum{c in C} x1[p,c] * c) +
	sum{p in Pos} 10^p * (sum{c in C} x2[p,c] * c) = s;

#k cifre speciali
subject to special:
	sum{p in Pos,c in Speciale} x1[p,c] = k;

#####
data;
set Speciale := 1 2 6 8;
param s:= 8612;
param N:= 4;
param k:=2;
end;
