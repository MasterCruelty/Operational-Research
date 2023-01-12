#Esercizio Classificatore

/*
Sono dati N oggetti. Ogni oggetto ha un insieme di tre attributi: i primi due sono
le coordinate in uno spazio Euclideo bidimensionale; il terzo è un attributo di tipo logico,
“vero” o “falso”. Si vuole trovare la retta che separa i punti in due sottoinsiemi in modo
che tutti i punti “veri” giacciano da un lato e tutti i punti “falsi” dall’altro rispetto alla
retta. Se ciò non è possibile, si vuole comunque minimizzare il numero di punti che
cadono dalla parte sbagliata rispetto alla retta.
*/

#DATI
param nP;
set P:= 1..nP;
param x{P};
param y{P};
param label{P};
param M:=max{i in P,j in P}sqrt((x[i]-x[j])^2 + (y[i]-y[j])^2);

#VARIABILI
var a;
var b;
var c;
var w{P} binary;		#w=1 per misclassification

#VINCOLI
#normalizzazione coefficienti
subject to normalizzazione: a^2+b^2=1;

#separazione dei punti
subject to Separazione0{i in P:label[i]=0}:
	a*x[i] + b* y[i] + c <=M*w[i];
subject to Separazione1{i in P:label[i]=1}:
	a*x[i] + b* y[i] + c >= -M*w[i];

#OBIETTIVO
#minimizzare punti che cadono nella parte sbagliata
minimize z: sum{i in P} w[i];

#############
data;
param nP:=20;


param:  x	y	label:=
1 		12 29 	1
2 		16 26 	1
3 		24 25 	1
4 		8 7 	1
5 		30 50 	1
6 		11 41 	1
7 		5 2 	1
8 		6 11 	1
9 		40 12 	1
10 		23 27 	1
11 		21 43 	1
12 		51 18 	1
13 		2 36 	0
14 		2 33 	0
15 		11 6 	0
16 		33 7 	0
17 		28 45 	0
18 		25 42 	0
19 		20 50 	0
20 		20 18 	0;

var a:= +0.7;
var b:=-0.7;
var c:=0;

end;
