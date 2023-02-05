#Esercizio Biscotti 

#Una ditta produce 4 tipi di biscotti.
#Ogni biscotto contiene una percentuale di ingredienti.
#L'addetto agli acquisti richiede che i quantitativi acquistati siano superiori a certi limiti minimi.
#l'addetto al marketing richiede che vengano messe in vendita quantità minime e massime per ogni biscotto.
#l'azienda deve pianificare la sua produzione per il prossimo trimestre(12 sett di 5 gg)
#l'azienda ha a disposizione un budget dato.

# trimestre = 12 sett di 5 giorni lavorativi => 1 sett = 5gg & 12 sett = 60gg

/*
  *Commento sul testo:
  *Siccome si tratta di avere delle materie prime(ingredienti) e dei prodotti(biscotti),
  *posso indicare con a_ij la quantità di ingrediente i per fare il prodotto j.
  *la risorsa disponibile per fare i prodotti è costituita dal budget trimestrale.
  *I prezzi di vendita indicano il profitto lordo.
  *Questo problema è quindi un modello di pianificazione della produzione.
*/

#DATI
set B;  							#biscotti
set I; 								#ingredienti
param perc_ingr{I,B}; #percentuale di ingredienti per ogni biscotto [%]
param prod_gg{B};	 #produzione massima giornaliera per ogni biscotto [Kg / giorno]
param prezzi{B};			 #prezzi di vendita per ogni biscotto [€ / Kg]
param costi{I};			 #costi per ogni ingrediente [€ / Kg]
param min_buy{I};		 #Quantità minime di ingredienti da acquistare [Kg / settimana]
param lower_prod{B}; #Quantità minima da produrre per ogni biscotto [ Kg / settimana ]
param upper_prod{B}; #Quantità massima da produrre per ogni biscotto [ Kg / settimana ]
param budget; 			  #Budget disponibile per il trimestre(60gg) [€]
#param costo_pub;	 #Costo per la campagna pubblicitaria ogni trimestre [€ / trimestre ]

#VARIABILI
var x{B} >= 0; #Produzione di biscotti [ Kg / giorno ]
var y{I} >= 0;   #Quantità di ingredienti acquistate [ Kg / settimana ]

#VINCOLI

#vincolo su produzione massima giornaliera di biscotti [Kg / giorno ]
subject to max_prod_daily{i in B}:
	sum{j in I} perc_ingr[j,i] * x[i] <= prod_gg[i];

#vincolo su quantità minima di ingredienti da acquistare [ Kg / settimana ]
subject to min_ingr_buy{i in I}:
	y[i] >= min_buy[i];

#vincolo su quantità minma da produrre per ogni biscotto [ kg / settimana ]
subject to min_prod{i in B}:
	sum{j in I} perc_ingr[j,i] * x[i] * 5 >= lower_prod[i];

#vincolo su quantità massima da produrre per ogni biscotto [ kg / settimana ]
subject to max_prod{i in B}:
	sum{j in I} perc_ingr[j,i] * x[i] * 5 <= upper_prod[i];

#Vincolo sul budget [€]
subject to max_budget{b in B}:
	sum {i in I} costi[i] * y[i] <= budget;


#OBIETTIVO

maximize z: sum {j in B, i in I} (prezzi[j] - costi[i]) * x[j];

#######
data;

set B := Svegliallegra Frollino Alba ProntiVia;
set I := Farina Uova Zucchero Burro Latte Additivi Nocciole Acqua;

param perc_ingr:          Svegliallegra   		Frollino        	Alba      		ProntiVia :=
Farina          			.20           			.25           	.30           		.20
Uova            			.15    			       	.0     		    .10   		        .20
Zucchero       				.20           			.15           	.25           		.10
Burro            			.0         				.0         		.10           		.10
Latte           			.10           			.20           	.20           		.15
Additivi        			.15           			.20            	.0         			.15
Nocciole        			.10            			.0 	        	.0       			 .0
Acqua           			.10           			.20            	.5         			.10
;


param prod_gg :=
Svegliallegra    		165
Frollino 			    250
Alba      				500
ProntiVia      	 		250
;


param prezzi :=
Svegliallegra     		1.75
Frollino 			    1.00
Alba			        1.25
ProntiVia	        	1.50
;


param costi :=
Farina    		0.5
Uova      		2
Zucchero 	 	0.5
Burro     		1
Latte     		1.5
Additivi  		1
Nocciole  		5
Acqua			0
;


param min_buy :=
Farina    			450
Uova      			200
Zucchero  			320
Burro     			140
Latte     			320
Additivi  			100
Nocciole   			50
Acqua 				0
;


param lower_prod :=
Svegliallegra 					50
Frollino 						100
Alba 							500
ProntiVia 						300
;

param upper_prod :=
Svegliallegra 					300
Frollino 						500
Alba 							1000
ProntiVia 						500
;

param budget := 21600;
#param costo_pub := 5000;

end;
