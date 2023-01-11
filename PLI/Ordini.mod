#Esercizio Ordini(branch & bound)

#L'ufficio marketing di un'azienda ha icevuto diversi ordini dai suoi clienti.
#Ogni ordine implica un certo tempo di lavorazione noto.
#Gli ordini possono essere prodotti solo uno per volta.
#La produzione di ciascun ordine una volta iniziata non può essere interrotta.
#Si vuole determinare quale sia la sequenza migliore in cui effettuare la produzione dei vari ordini,
#in modo da minimizzare:
#1. il ritardo complessivo(la somma di tutti gli eventuali ritardi rispetto alle scadenze richieste)
#2. il ritardo massimo.
#Discutere unicità e ottimalità soluzione ottenuta.

#DATI
param nO;						#Numero degli ordini
set O:=1..nO;					#Insieme degli ordini
param tempo_lavoro{O};			#tempo di lavorazione per ogni ordine
param scadenza{O};				#Scadenza per ogni ordine

#VARIABILI
var x{O,O} binary;			#Matrice di precedenze x(i,j)=1 sse i precede j
var c{O};					#tempo completamento di ogni ordine
var t{O} >=0;				#ritardo per ogni ordine
var ritardo_massimo;		#ritardo massimo complessivo
#VINCOLI
subject to noLoop3{i in O, j in O, k in O:i<>j and j<>k and i <>k}:
	x[i,j] + x[j,k] + x[k,i] <= 2;

subject to nodiag{i in O}:
	x[i,i]=0;

subject to preced{i in O, j in O:i <>j}:
	x[i,j] + x[j,i] = 1;

subject to completion{i in O}:
	c[i] = sum{j in O} tempo_lavoro[j] * x[j,i] + tempo_lavoro[i];

subject to tardiness{i in O}:
	t[i] >= c[i] - scadenza[i];

#OBIETTIVO
#Minimizzare somma ritardi
#minimize z1: sum{i in O} t[i];

#minimizzare il ritardo massimo
minimize z2: ritardo_massimo;
subject to max_tardiness{i in O}:
	ritardo_massimo >= t[i];

#########
data;
param nO:= 10;

param:		tempo_lavoro		scadenza:=
1				24					50
2				12					50
3				30					90
4				15					70
5				18					50
6				7					80
7				8					100
8				15					90
9				14					120
10				22					150;

end;
