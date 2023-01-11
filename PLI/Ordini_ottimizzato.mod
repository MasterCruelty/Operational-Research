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
var y{O,O} binary;			#Matrice di assegnamento y(i,j)=1 sse ordine i in posizione j
var s{O} >= 0;					#tempo di inizio di ogni ordine
var t{O} >=0;				#ritardo per ogni ordine
var ritardo_massimo >= 0;		#ritardo massimo complessivo
#VINCOLI

subject to AssegnaOrdini{i in O}:
	sum{p in O} y[i,p] = 1;
subject to AssegnaPosizioni{p in O}:
	sum{i in O} y[i,p] = 1;

subject to Start{q in O}:
	s[q] = sum{j in O,p in O:p<q} tempo_lavoro[j] * y[j,p];

subject to Tardiness{q in O}:
	t[q] >= s[q] + sum{i in O} tempo_lavoro[i] * y[i,q] - sum{i in O} scadenza[i] * y[i,q];

#OBIETTIVO
#Minimizzare somma ritardi
minimize z1: sum{q in O} t[q];

#minimizzare il ritardo massimo
#minimize z2: ritardo_massimo;
#subject to max_tardiness{i in O}:
	#ritardo_massimo >= t[i];

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
