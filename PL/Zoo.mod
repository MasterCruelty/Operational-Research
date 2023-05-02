#Esercizio Zoo

/*Uno zoo ospita diversi animali, ognuno ha un fabbisogno nutritivo giornaliero.
  *La direzione può acquistare 4 diversi tipi di cibo per animali. È nota la composizione di tali cibi, ovvero la percentuale di sostanze nutritive contenute.
  *Si vuole soddisfare minimizzandone il costo le esigenze nutritive degli animali dello zoo.
  *Oltre a ciò, si vuole capire se conviene l'acquisto di un altro prodotto, composto solo da carne, latte, frutta e verdura.
  *Si vuole anche sapere se accettare il dono di 5 elefanti e 8 giraffe, oltre all'acqua necessaria per mantenerli regalati da un sultano.
  *Quanti elefanti e giraffe potrebbe accettare lo zoo senza aumentare i propri costi?
  *Infine si vuole sapere se conviene avere un orso in più.
  ************************************
  *Dati aggiuntivi per le risposte extra:
  *Prodotto P5:
  *Composizione: carne 50%, latte 5%, frutta 10%, verdura 35%.
  *Prezzo: 0.5 Euro / kg.
  *L'acquisto di un ulteriore orso porterebbe un incasso aggiuntivo di 90 Euro al giorno.
  *************************************
  *Commento sul testo:
  *Si tratta di un problema di PL con l'obiettivo di minimizzare i costo complessivi di gestione. 
  *Risposta alle domande extra:
  *1. La soluzione è unica poichè ogni colonna posta fuori base ha un costo ridotto diverso da zero.
  *2. conviene prendere il prodotto 5? No. Contiene tutte sostanze di cui abbiamo un surplus dopo aver risolto il problema all'ottimo.
  *Non conviene neanche se regalato.
  *3. Il mantenimento di altri elefanti al netto dell'acqua regalata, userebbe risorse scarse come zuccherri e grassi,
  *i costi aumenterebbero e quindi non conviene. Invece per le altre giraffe, oltre all'acqua, servono solo risorse non scarse, 
  *il cui surplus basta (e avanza) per 8 giraffe.
  *Infine il mantenimento di un orso in più non comporta costi aggiuntivi per quanto riguarda le prime 4 risorse (prezzo ombra nullo),
  *Però costerebbe per quanto riguarda l'acqua. Poichè il prezzo ombra dell'acqua è pari a 8 Euro/litro,
  *e il fabbisogno giornaliero dell'orso è pari a 10 litri, il costo giornaliero per lo zoo aumenterebbe di 80 Euro, 
  *ma poichè l'orso ha un rendimento giornaliero stimato pari a 90 Euro, il suo acquisto è vantaggioso.
*/

#DATI
set Animali;		#insieme degli animali
param q{Animali};	#quantità per ogni animale presente nello zoo
set Sostanze;		#insieme delle sostanze nutritive
param nP;			#numero dei prodotti
set P :=1..nP;		#insieme dei prodotti
param perc_p{Sostanze,P};	#composizione di ogni prodotto in percentuale di sostanze nutritive[%]
param fabb{Animali,Sostanze};#Fabbisogno di sostanze nutritive per ogni animale[kg/animale]
param c{P};					#costi per ogni prodotto[€ / kg]

#VARIABILI
var x{P} >= 0;		#acquisto di prodotti

#VINCOLI
#vincolo sul fabbisogno nutritivo di ogni animale[kg/animale]
subject to satisfy{s in Sostanze}:
	sum{p in P} x[p] * perc_p[s,p] >= sum{a in Animali} fabb[a,s];

#OBIETTIVO
#minimizzare i costi per il mantenimento degli animali in funzione dei prodotti acquistati[€]
minimize z: sum{p in P} x[p] * c[p];


#############
data;

set Animali :=  Antilope Babbuino Canguro Dromedario Elefante Fringuello Giraffa Ippopotamo Koala Leone Muflone Narvalo Orso Pappagallo Rinoceronte Serpente_a_sonagli Tapiro Upupa Visone Zebra;
param nP:=4;
set Sostanze := Carne Latte Frutta Verdure Zuccheri Grassi Farine Acqua;

param q :=
Antilope	1
Babbuino	2
Canguro		1
Dromedario	1
Elefante	1
Fringuello	8
Giraffa		1
Ippopotamo	1
Koala		3
Leone		2
Muflone		2
Narvalo		1
Orso		1
Pappagallo	8
Rinoceronte	1
Serpente_a_sonagli	6
Tapiro		1
Upupa		4
Visone		4
Zebra		2;

param perc_p:	1		  2		   3		4:=
Carne     		.80      .5       .0      .25
Latte      		.0       .5       .0       .0
Frutta     		.0      .25      .30       .5
Verdure    		.5      .40      .25      .10
Zuccheri   		.5       .0       .0       .0
Grassi     		.0       .0       .0      .15
Farine     		.0       .0      .25       .0
Acqua     		.10     .25      .20      .45;

param fabb:	Carne	Latte	Frutta	Verdure	Zuccheri	Grassi	Farine	Acqua:=
Antilope   	0.0  	0.0  	0.0  	2.0  	0.2  		0.5  	1.0  	3.0
Babbuino   	1.0  	1.0  	3.0  	0.3  	0.2  		0.2  	0.0  	2.0
Canguro   	0.1  	0.5  	0.1  	1.0  	0.1  		0.3  	0.0  	4.0
Dromedario  0.5  	0.5  	1.0  	0.5  	0.1  		0.5  	0.5  	5.0
Elefante   	0.0  	0.5  	5.0  	9.0  	0.5  		1.0  	1.0  	9.0
Fringuello  0.0  	0.0  	0.0  	0.0  	0.0  		0.0  	0.1  	0.1
Giraffa   	0.0  	0.0  	0.2  	3.0  	0.0  		0.0  	0.0  	4.0
Ippopotamo  0.0  	0.0  	8.0  	6.0  	0.5  		1.0  	0.0 	20.0
Koala   	0.0  	1.0  	1.0  	1.0  	0.0  		0.0  	0.2  	0.5
Leone   	5.0  	0.0  	0.0  	0.0  	1.0  		0.5  	0.0  	5.0
Muflone   	0.0  	1.0  	0.0  	5.0  	0.0  		0.0  	0.0  	3.0
Narvalo   	0.0  	0.0  	0.0  	0.0  	0.0  		0.0  	3.0  	0.0
Orso   		5.0  	0.5  	3.0  	1.0  	0.0  		0.0  	0.0 	10.0
Pappagallo  0.0  	0.0  	0.0  	0.0  	0.0  		0.0  	0.2  	0.5
Rinoceronte 1.0  	0.0  	0.0 	12.0  	0.0  		2.0  	0.0 	15.0
Serpente_a_sonagli  0.5  0.0  0.0  0.1  0.0  0.0  0.0  0.1
Tapiro   	0.0  	0.2  	1.0  	9.0  	0.2  		0.5  	0.0  	6.0
Upupa   	0.0  	0.0  	0.0  	0.5  	0.1  		0.0  	0.5  	1.0
Visone   	0.0  	0.2  	0.5  	3.0  	0.0  		0.0  	1.0  	1.0
Zebra   	0.0  	0.0  	0.0  	5.0  	0.5  		0.2  	0.5  	5.0;

param c:=
1   5
2   2
3   3
4   4 ;

end;
