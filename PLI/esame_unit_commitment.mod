#Esercizio Esame Unit commitment
/*
In una regione sono presenti impianti termoelettrici ed idroelettrici per la produzione di energia.
Quando un impianto termoelettrico `e acceso, `e vincolato ad operare tra un dato un livello minimo 
ed un dato livello massimo di potenza (in generale questi limiti sono diversi per ogni impianto); 
se invece `e spento, ovviamente la sua produzione `e nulla. 
Si ipotizzi che ogni impianto termoelettrico possa cambiare stato solo al passaggio da un giorno al successivo 
e non durante il giorno. Mantenere un impianto termoelettrico acceso ha un costo fisso, che
si paga per ogni giorno durante il quale l’impianto `e acceso. Ogni impianto termoelettrico ha un costo unitario noto per la produzione di energia.
Ogni impianto idroelettrico `e caratterizzato da una capacit`a del bacino, un volume di acqua inizialmente disponibile ed una portata di acqua in ingresso
(dovuta agli affluenti che lo alimentano), che si assume costante nel tempo.
`E noto un coefficiente che si usa per trasformare una quantit`a di acqua in un’equivalente quantit`a di energia prodotta con quell’acqua. 
Tale coefficiente si assume uguale per tutti gli impianti idroelettrici.
`E nota la domanda complessiva di energia (frutto di una previsione) per alcuni giorni. 
Si vuole calcolare il piano di produzione di energia di minimo costo, che soddisfi la domanda.
Formulare il problema, classificarlo e risolverlo.

u.e.: unità di misura energia
u.v.: unità di misura del volume di acqua
u.d.: unità di misura del denaro
g: giorno
*/


#DATI
param nT;			#numero impianti termoelettrici
set T:=1..nT;		#insieme impianti termoelettrici
param nI;			#numero impianti idroelettrici
set I :=1..nI;		#insieme impianti idroelettrici
param gg;			#numero giorni da pianificare
set G :=1..gg;		#insieme dei giorni
param k;			#coefficiente di trasformazione
param prod_min{T};	#prod minimia per termo [u.e./g]
param prod_max{T};	#prod massima per termo [u.e./g]
param cf{T};	#costi fissi termo		[u.d./u.e.]
param cu{T};	#costo unitario termo	[u.d./u.e.]
param cap{I};	#capacità idro[u.v.]
param vol{I};	#volume iniziale idro [u.v.]
param alim{I};	#alimentazione idro[u.v./g]
param domanda{G};	#domanda per ogni giorno[u.e.]

#VARIABILI
#variabili per impianti termo
var x{T,G} >= 0; #quanta energia produrre con i termo in ogni giorno
var y{T,G} binary;   #stato di acceso/spento dell'impianto in ogni giorno
#variabili per impianti idro
var w{I,G} >= 0;			#livello di bacino acqua dell'impianto h in H al termine del giorno g in G.
var u{I,G} >= 0;		#quantità di acqua usata

#VINCOLI
#vincoli produzione termo
subject to produzione_minima{t in T,g in G}:
	x[t,g] >= prod_min[t] *y[t,g];
subject to produzione_massima{t in T,g in G}:
	x[t,g] <= prod_max[t] *y[t,g];

#vincoli capacità idro
subject to capacity{i in I,g in G}:
	w[i,g] <= cap[i];

#vincoli conservazione di flusso
subject to flow_conservation{h in I,g in G:g>1}:
	w[h,g-1] + alim[h] = u[h,g] + w[h,g];
subject to primo_giorno{h in I}:
	w[h,1] + alim[h] = u[h,1] + w[h,1];

#vincolo di domanda
subject to sodd_domanda{g in G}:
	sum{t in T} x[t,g] + sum{i in I} k * u[i,g] = domanda[g];

#OBIETTIVO
minimize z: sum{t in T,g in G} (cf[t]*y[t,g] + x[t,g]*cu[t]);



#########
data;

param k := 0.05;
param nT:= 3;
param nI:=3;
param gg:=7;


param: prod_min		prod_max		cf		cu:=
1 		10 			90 				60 		2
2 		20 			100 			50 		3
3 		20 			20 				40 		5;


param:  cap		vol		alim:=
1 		600 	500 	200
2 		2000 	1500 	400
3 		300 	100 	100;

param domanda:=
1 200
2 180
3 150
4 200
5 250
6 250
7 180;

end;
