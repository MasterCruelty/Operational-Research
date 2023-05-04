#esame 115 testi scolastici
/*
  *testi scolastici.
  *Una casa editrice ha stampato alcune copie del suo “Manuale di Ricerca Operativa” utilizzato in alcune scuole italiane
  *e ne ha lasciate date quantità nei suoi magazzini (Tabella 1).
  *Sono note le quantità richieste da alcuni distributori in alcune altre città (Tabella 2).
  *Per effettuare le consegne, la casa editrice utilizza un corriere chiamato “Tutto Trasporti A” che rende disponibile sui
  *propri furgoncini uno spazio diverso per ciascuna coppia di città poiché la capacità rimanente del furgoncino è già stata
  *assegnata ad altri servizi. Le quantità di libri che è possibile spedire tra ciascuna coppia di città sono indicate nella Tabella 3.
  *Il costo unitario di spedizione è indicato nella Tabella 4 (prezzi espressi in Euro per ogni libro).
  *Si vuole soddisfare il massimo numero di ordini, minimizzando i costi di spedizione
  *
  **************************************************
  *Commento sul testo:
  *Vi sono n magazzini(le sorgenti) e m distributori(le destinazioni).
  *È nota la domanda dei distributori in termini di quantità di copie di libri.
  *C'è una capacità limitata sul furgone in funzione della tratta di trasporto.
  *È noto un costo per il trasporto.
  *Si tratta quindi di un problema che da luogo a un modello di trasporto in cui si vogliono minimizzare i costi di trasporto complessivi.
*/

#DATI
param nM;		#numero magazzini
set M:= 1..nM;	#insieme dei magazzini
param nD;		#numero dei distributori
set D:=1..nD;	#insieme dei distributori
param offerta{M};	#offerta di libri[numero copie/magazzino]
param domanda{D};	#domanda di libri[numero copie/distributore]
param cap{M,D};		#capacità disponibili per ogni tratta magazzino=>distributore[numero copie]
param cu{M,D};		#costo unitario di trasporto per ogni tratta magazzino=>distributore[€]

#VARIABILI
var x{M,D} >= 0; #quantità di libri trasportati dai magazzini ai distributori

#VINCOLI
#vincoli su domanda e offerta di copie di libri
subject to max_offerta{m in M}:
	sum{d in D} x[m,d] <= offerta[m];
subject to min_domanda{d in D}:
	sum{m in M} x[m,d] >= domanda[d];

#vincolo su capacità massima
subject to capacity{m in M,d in D}:
	x[m,d] <= cap[m,d];


#OBIETTIVO
#minimizzare i costi di trasporto dei libri
minimize z: sum{m in M,d in D} x[m,d] *cu[m,d];

data;

param nM:= 3;
param nD:=4;
#TO = 1
#NA = 2
#PA = 3
param offerta:=
1 1200
2 1400
3 800;

#MI = 1
#BO = 2
#RM = 3
#BA = 4
param domanda:=
1 1000
2 1200
3 700
4 500;


param cap: 		1	2	 3	  4:=
1 				500 1000 1000 1000
2 				500 800 800 800
3 				800 600 600 600;



param cu:	1	2	3	4:=
1 7.5 2.6 1.7 1.6
2 6.4 2.2 2.0 1.5
3 5.8 2.4 1.8 1.4;


/*1
Prezzo-base MI BO RM BA
TO 3,9 1,4 1,1 1,4
NA 2,7 0,9 1,2 0,9
PA 2,4 1,4 1,7 1,3
Tabella 5: Prezzi-base del trasportatore "Tutto Trasporti B".
*/
end;
