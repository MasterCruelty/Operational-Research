#Esercizio Patate

#Un'azienda produce pacchi di patate surgelate in 3 tipi diversi(A,B,C).
#L'azienda acquista da 2 fornitori con rese differenti.
#l'avanzo del 30% per entrambi i fornitori è lo scarto non recuperabile.
#Profitto: 2 centesimi per Kg di patate da fornitore 1 e 3 centesimi per Kg di patate da fornitore 2.
#Limiti sulle quantità massima di ogni prodotto noti ed espressi in Tonnellate.
#Obiettivo: massimizzare i profitti

#DATI
set Patate;
param nF;
set F := 1..nF;
param rese{F,Patate};		#rese per ogni patate e ogni fornitore [%]
param prezzi{F};			#profitto per ogni fornitore [€ / q]
param produz{Patate};		#produzione massima per tipo di patata [q]

#VARIABILI
var x{F} >= 0;		#acquisto patate da ogni fornitore[q]

#VINCOLI

#vincolo sulla produzione di patate
subject to prod_patate{i in Patate}:
	sum{j in F} rese[j,i] * x[j] <= produz[i];


#OBIETTIVO
#Massimizzare i profitti
maximize z: sum{j in F} prezzi[j] * x[j];

data;

set Patate := A B C;
param nF:= 2;

param rese:		 A	 B	 C:=
1				.20	.20	.30
2				.30	.10	.30;


param prezzi:=
1			0.02
2			0.03;

param produz:=
A			6000
B			4000
C			8000;


end;
