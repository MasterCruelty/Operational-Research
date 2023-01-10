#Esercizio Cavalli

#In una corsa di cavalli i favoriti sono Fulmine, Freccia, Dardo e Lampo.
#I cavalli sono quotati rispettivamente 3:1,4:1,5:1 e 6:1.
#Il budget disponibile per puntare è di 57 euro.
#Obiettivo: massimizzare la vincita nel caso peggiore.


#Commento:
#Siccome si vuole massimizzare la vincita nel caso peggiore, 
#Definisco m come vincita minima, così da rendere lineare la funzione obiettivo.
#Definisco un vincolo a parte dove dico che y deve essere minore di ogni vincita,
#ovvero il prodotto tra la puntata e la quota.

#DATI
param budget;			#budget disponibile [€]
set Cavalli;			#Insieme dei cavalli
param quota{Cavalli};	#Quotazione per ogni cavallo [adimensionale]

#VARIABILI
var p{Cavalli} >= 0; #puntata per ogni cavallo [€]
var m >= 0;	   #vincita minima [€]
#VINCOLI

#Vincolo sul budget disponibile [€]
subject to within_budget:
	sum{i in Cavalli} p[i] <= budget;

#Vincolo su vincita minima
subject to MaxMin{i in Cavalli}:
	m <= quota[i] * p[i];

#OBIETTIVO
#Massimizzare nel caso di vincita minima
maximize z: m;

#####
data;

set Cavalli := Fulmine Freccia Dardo Lampo;
param 		quota:=
Fulmine		3
Freccia		4
Dardo		5
Lampo		6;

param budget := 57;



end;
