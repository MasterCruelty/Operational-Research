#Esercizio Editoria

#Il nuovo editore di una rivista scientifica deve pianificare il contenuto del prossimo volume della rivista.
#Si ha a disposizione un certo numero di articoli di diversa lunghezza già pronti per essere pubblicati.
#Gli articoli vanno inseriti in un dato numero di fascicoli.
#Ogni fascicolo ha sempre lo stesso numero di pagine.
#Le pagine non occupate da articoli vengono riempite con annunci pubblicitari.
#Il numero di articoli è elevato e non ci entrano tutti nel prossimo volume.
#Quelli che avanzano andranno nel prossimo.
#Si vuole minimizzare il numero di articoli da rimandare.
#Il numero di pagine dedicate agli annunci dunque deve essere bilanciato tra tutti i fascicoli.
#Gli articoli sono divisi per urgenza, vanno pubblicati in funzione di essa.

/*
  *Commento sul testo:
  *Bisogna assegnare un certo numero di articoli a 3 fascicoli.
  *Ci sono vincoli sull'urgenza degli articoli e sul numero di pagine disponibili per ogni fascicoli.
  *Si tratta di un problema che da luogo a un modello di assegnamento.
*/

#DATI
param nA;
set A:=1..nA;		#insieme articoli
param p{A};			#numero pagine per ogni articolo
param u{A};			#urgenza
param nF;
set F:=1..nF;		#Insieme di fascicoli
param nP;			#Numero di pagine per fascicolo

#VARIABILI
var x{A,F} binary;		#assegnamento dell'articolo A al fascicolo F
var upper;
var lower;

#VINCOLI
#vincoli di assegnamento
subject to assign{a in A}:
	sum{f in F} x[a,f] <= 1;

#vincolo pagine disponibili su ogni fascicolo
subject to capacity{f in F}:
	sum{a in A} p[a] * x[a,f] <= nP;

#vincolo sull'urgenza
subject to urgenza{a in A}:
	sum{f in F}  f*x[a,f] <=4-u[a];

#OBIETTIVO

#obiettivo 1: rinviare il minimo numeri di articoli
#maximize z1: sum{a in A,f in F} x[a,f];

#obiettivo 2: equilibrare i fascicoli
minimize z2: upper - lower;
subject to maxmin{f in F}: lower <= sum{a in A} p[a] *x[a,f];
subject to minmax{f in F}: upper >=sum{a in A} p[a] *x[a,f];
subject to non_peggioro: sum{a in A, f in F} x[a,f] >= 11;#valore ottimo di z1


#########
data;
param nA:=12;
param nF:=3;
param nP:=44;

param:		  p			u:=    
   1          5         2
   2         11			0
   3         17         2
   4         10			0
   5         18         3 
   6          8			0
   7         14			0
   8          9         1
   9         16         1
   10        12			0
   11        14			0
   12        13			0;

end;
