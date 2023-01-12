#Esercizio Tripartizione

/*
E’ dato un insieme di punti nel piano Cartesiano, divisi in tre sottoinsiemi. Si
vuole trovare un modo di separare i tre sottoinsiemi con tre semirette aventi
l’origine in comune. Tra i vari modi in cui `e possibile ottenere la partizione
si vuole scegliere quello per cui l’origine risulta:
	1. il pi`u possibile vicino all’origine degli assi Cartesiani;
	2. il pi`u lontano possibile dall’origine degli assi Cartesiani;
	3. all’interno di un quadrato di lato 2 con lati paralleli agli assi e centrato nell’origine degli assi;
	4. all’esterno del quadrato suddetto.
*/

#DATI
param nC;		#numero di cluster
set C:= 0..nC-1;	#insieme di cluster

param nP{C};	#cardinalità di ogni cluster
set P{k in C} := 1..nP[k];	#set di punti in ogni cluster

param x{k in C,P[k]};	#ascisse punti
param y{k in C,P[k]};	#ordinate punti

#VARIABILI
#coordinate punto di originde semirette
var xx;
var yy;
# Parametri della semiretta k che separa cluster k-1 da cluster +1
var a{C};
var b{C};
var c{C};

#VINCOLI

#normalizzazione
subject to normalizzazione{k in C}:
	a[k]^2 + b[k]^2 = 1;

#passaggio dall'origine
subject to Origine{k in C}:
	a[k] *xx + b[k] *yy + c[k] = 0;

#separazione cluster
subject to sx{k in C,i in P[(k-1+nC) mod nC]}:
	a[k] *x[(k-1+nC) mod nC,i] + b[k] *y[(k-1+nC) mod nC,i + c[k] <= 0;

subject to dx{k in C,i in P[(k+1) mod nC]}:
	a[k] *x[(k+1) mod nC,i] + b[k] *y[(k+1) mod nC,i + c[k] >= 0;


#OBIETTIVO
minimize z1: xx^2 + yy^2;

##############
data;

param nC:=3;
param nP :=
0	8
1   6
2  12;

param x :=
[0,1] -5
[0,2] 10
[0,3]  5
[0,4]  3
[0,5] -1
[0,6] -2
[0,7]  2
[0,8] 10

[1,1] -10
[1,2]  -4
[1,3] -19
[1,4] -11
[1,5]  -7
[1,6] -12

[2,1]  -3
[2,2]  -1
[2,3]   1
[2,4]  -2
[2,5]  11
[2,6]   2
[2,7]   3
[2,8]   0 
[2,9]   1
[2,10]  2
[2,11] -3
[2,12] -4;

param y :=
[0,1] 12
[0,2]  8
[0,3]  5
[0,4]  0
[0,5]  3
[0,6]  9
[0,7] 10
[0,8]  6

[1,1]  2
[1,2]  3
[1,3] 15
[1,4]  0
[1,5] -3
[1,6] -9

[2,1]  -6
[2,2]  -8
[2,3]  -5
[2,4]  -9
[2,5]  -1
[2,6]  -9
[2,7]   0
[2,8]  -2
[2,9]  -8
[2,10] -2
[2,11] -6
[2,12] -9;

# Inizializzazione dei coefficienti delle rette per aiutare il solutore
var:    a   b   c :=
0      -1   1   0
1       0  -1   0 
2       2   1   0;


end;
