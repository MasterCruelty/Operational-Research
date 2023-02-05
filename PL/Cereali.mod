#Esercizio Cereali

#Una fattoria ha due lotti di terreno.
#Un terreno A di 200 acri e un terreno B di 400 acri.
#Possono essere coltivati 6 tipi di cereali.
#È noto per ogni quintale il profitto generato dai cereali.
#Per ogni quintale di cereale, è nota la quantità di area e acqua necessaria.
#Il volume totale di acqua disponibile è noto
#Obiettivo: ottimizzare la quantità di cereali coltivati nei due terreni.

/*
  *Commento sul testo:
  *Ho delle risorse limitate(gli acri dei terreni)
  *Ho 6 tipi di prodotti da coltivare(i cereali)
  *È noto il profitto generato dai cereali
  *Ogni cereale consuma terreno e acqua(limitata anch'essa) per essere prodotto.
  *Si tratta quindi di un problema che da luogo a un modello di pianificazione della produzione.
*/

#DATI
param nC;			#Numero dei tipi di cereali
set C := 1..nC;		#Insieme dei cereali
param nT;			#Numero dei terreni
set T := 1..nT;		#Insieme dei terreni
param cs{T,C};		#Consumo di suolo per tipo di cereale [Acri / q]
param ca{C};		#Consumo di acqua per tipo di cereale [mc / q ]
param p{C};			#Prezzo per ogni cereale [€ / q]
param capacity{T};	#Suolo disponibile sui due terreni [acri]
param acqua;		#Acqua disponibile [mc]

#VARIABILI
var x{T,C} >= 0; #Produzione di cereali su ogni terreno [ q ]

#VINCOLI

#Vincolo sul consumo dell'acqua [mc]
subject to consumo_acqua{i in T}:
	sum{j in C} ca[j] * x[i,j] <= acqua;

#Vincolo sul consumo di suolo [acri]
subject to consumo_suolo{i in T}:
	sum{j in C} cs[i,j] * x[i,j] <= capacity[i];

#OBIETTIVO
#massimizzare profitto totale [€]
maximize z: sum{j in T,i in C} p[i] * x[j,i];

######
data;

param nC:=6;
param nT:=2;

param cs:      1       2       3       4       5       6:=
1	           0.02    0.03    0.02    0.016   0.05    0.04
2	           0.02    0.034   0.024   0.02    0.06    0.034;

param:	 p			 ca:=
1	     48		     0.120
2	     62		     0.160
3	     28		     0.100
4	     36		     0.140
5	    122		     0.215
6	     94		     0.180;

param capacity:=
1	200
2	400;

param acqua :=400000;
