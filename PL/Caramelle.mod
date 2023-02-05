#Esercizio Caramelle

#Un'industria dolciaria deve ottimizzare la propria produzione di caramelle.
#Vengono prodotti 7 tipi diversi di caramelle.
#Per ciascun tipo occorrono ingredienti in proporzioni diverse.
#Le caramelle hanno tutte un diverso valore commerciale.
#Sono note le quantità di ingredienti disponibili per ogni giorno.
#Tutte le caramelle pesano 10 grammi.(dato superfluo)
#Obiettivo: massimizzare e ottimizzare produzione delle caramelle.


/*
  *Commento sul testo:
  *Ho una serie di prodotti(le caramelle) e una serie di materie prime per pdrodurli(gli ingredienti)
  *C'è una quantità di ingredienti disponibili per ogni giorno
  *E posso indicare con a_ij la quantità di ingrediente i per creare il prodotto j.
  *C'è un prezzo che indica il profitto lordo dato dai prodotti.
  *Questo è quindi un problema che da luogo a un modello di pianificazione della produzione.
*/


#DATI
set I; 					#Insieme degli ingredienti
set C;					#Insieme delle caramelle
param perc_Ingr{I,C};	#Composizione caramelle [%]
param capacity{I};		#Disponibilità ingredienti [Kg/giorno]:
param prezzi_Ingr{I};	#I prezzi degli ingredienti  [€/Kg]
param prezzi_Car{C};	#Prezzi di vendita delle caramelle [€ / Kg]

#VARIABILI
var x{C} >= 0; #Produzione caramelle [Kg / giorno ]

#VINCOLI
#vincolo sui consumi degli ingredienti [Kg / giorno ]
subject to consumo{i in I}:
	sum{j in C} perc_Ingr[i,j]/100 * x[j] <= capacity[i];

#OBIETTIVO
#massimizzare i profitti, cioè dei ricavi [€ / giorno]
maximize z: sum{i in C} prezzi_Car[i] * x[i];

######
data;


set I := Fruttosio, Saccarosio, Glucosio,Destrosio, 
Estratti_di_erbe, Estratti_di_frutta, Coloranti, Conservanti, Aromatizzanti;
set C := Dolce, Delizia, Bacetto, Golosa, Sfizio, Slurp, Sweety;

param perc_Ingr: 	Dolce Delizia Bacetto Golosa Sfizio 	Slurp Sweety :=
Fruttosio 		 	30		0 		5 		5 		5 	 	10 		10
Saccarosio 		 	20 		30 		0 		5 		5 		5 		10
Glucosio		 	15 		20 		30 		0 		5 		5 		5
Destrosio		 	10 		15 		20 		30 		0 		5 		5
Estratti_di_erbe 	10 		10 		15 		20 		30 		0 		5
Estratti_di_frutta 	5 		10 		10 		15 		20 		30 		0
Coloranti 			5 		5 		10 		10 		15 		20 		30
Conservanti 		5 		5 		5 		10 		10 		15 		20
Aromatizzanti 		0 		5 		5 		5 		10 		10 		15;


param capacity:=
Fruttosio 			9
Saccarosio 			5
Glucosio 			20
Destrosio 			18
Estratti_di_erbe 	20
Estratti_di_frutta 	17
Coloranti 			18.4
Conservanti 		12.5
Aromatizzanti 		10;

param prezzi_Ingr:=
Fruttosio 			4
Saccarosio 			2
Glucosio 			1
Destrosio 			3.5
Estratti_di_erbe 	8
Estratti_di_frutta 	10
Coloranti 			2
Conservanti 		5
Aromatizzanti 		6;


param prezzi_Car:=
Dolce 				5
Delizia 			4
Bacetto 			8
Golosa 				5
Sfizio 				6
Slurp 				7.5
Sweety 				4.5;


end;
