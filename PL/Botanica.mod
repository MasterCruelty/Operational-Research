#Esercizio Botanica al polo

/*
  *Si vuole ottimizzare il rendimento economico di un progetto scientifico valutandone la fattibilità.
  *Il progetto consiste nel crescere delle piante in regioni sperdute, fornendo artificialmente il nutrimento che in situazioni normali
  *ricaverebbero dall'ambiente. Le piante sono 8 ed elencate nei dati.
  *Sono stati determinati i quantitativi minimi di nutrimento di cui le piante hanno bisogno.
  *Le piante vanno coltivate in apposite superfici di area variabile, ognuna delle quali può contenere piante di un solo tipo e si coltiva
  *una sola volta.
  *I costi del progetto dipendono dalla quantità di nutrimento che deve essere fornito.
  *I ricavi sono determinati in funzione del numero di piantine che riescono a sopravvivere e a svilupparsi,
  *unito al loro valore commerciale.
  *Per ogni piantina si deve coltivare almeno 5mq e non più di 100mq. La  superficie complessiva è di 500 mq.
  *Costo fisso iniziale 50k €.
  ******************************************
  *Commento sul testo:
  *Vi sono un determinato numero di prodotti da coltivare, una superficie limitata e dei costi. Si vuole massimizzare i guadagni delle
  *pianti al netto dei costi.
  *Questo problema da luogo a un modello di ottimizzazione di costi fissi di avviamento.
  ******************************************
  *Rispondere poi alle seguenti domande post ottimali, giustificando la risposta.
  *L'esperimento è conveniente dal punto di vista economico? Si, escludendo i costi fissi iniziali, si ha un profitto.
  *E' possibile espandere la capacità totale dell'area coltivata da 500 a 600 mq ad un prezzo di 1 Euro per ogni mq in più. Valutare la convenienza di tale opportunità. 
  *>Conviene, anche se verrebbero spesi altri 400 euro per le 4 piante convenienti, ci sarebbe un profitto essendo quelle piante convenienti.
  *Si vuole sapere in vista di esperimenti futuri qual è la pianta più redditizia e qual è la pianta meno redditizia da coltivare al Polo.
  *>La più redditizia è la carota e la meno redditizia è l'erba cipollina dopo aver eseguito l'analisi di sensitività, la prima è quella che aumenterebbe di più la funzione obiettivo potendone acquistare altra.
  *>Mentre l'erba cipollina peggiorerebbe la f.o. in ogni caso.
  *Un botanico giapponese suggerisce di usare un tipo di sali minerali, estratto dalle alghe marine, che rende la metà di quello considerato 
  *(nel senso che le piante ne hanno bisogno il doppio), ma costa un quarto. Valutare quantitativamente la proposta del botanico giapponese.
  *>Dopo aver modificato accuratamente i dati, si conferma che tale sale sia più conveniente aumentando la f.o. da 93k a 227k.
  *Infine si vuole sapere quale valore commerciale dovrebbe avere ogni mq di fragoline di bosco per renderne conveniente la coltivazione in quantità massima (100 mq).
  *>Dall'analisi di sensitività si evince che dovrebbe aumentare di 1631 €.
*/

#DATI
param cf;		#costi fissi iniziali [€]
param t;		#superficie totale disponibile[mq]
param lower;	#minima coltivazione per piante[mq]
param upper;	#massima coltivazione per piante[mq]
set Nutri;		#insieme degli elementi nutrizionali delle piante
set Piante;		#insieme delle piante
param c{Nutri};	#costo per ogni elemento nutrizionale[€]
param fabb{Piante,Nutri};	#fabbisogno giornaliero per mq di ogni pianta[€/g l minuti]
param cresci{Piante};		#tempo di crescita per ogni pianta[gg]
param r{Piante};			#ricavo per ogni piante[€/mq]

#VARIABILI
var x{Nutri} >= 0;		#acquisto degli elementi nutrizionali[€]
var y{Piante} >= 0;		#quantità di piante da coltivare

#VINCOLI
#vincolo sul fabbisogno di ogni pianta
subject to satisfy{n in Nutri}:
	x[n] >= sum{p in Piante} y[p] * (fabb[p,n]*cresci[p]);
#vincolo min coltivazione
subject to max_coltivazione{p in Piante}:
	y[p] <= upper;
#vincolo max coltivazione
subject to min_coltivazione{p in Piante}:
	y[p] >= lower;
#vincolo su area complessiva
subject to budget_area:
	sum{p in Piante} y[p] <= t;
#OBIETTIVO
maximize z: sum{p in Piante} y[p]*r[p] - sum{n in Nutri} x[n] * c[n];

###############
data;

param cf := 50000;
param t:=500;
param lower := 5;
param upper := 100;
set Nutri := Acqua_dolce Sali_minerali Calore Luce Vitamine;
set Piante := Azalea Begonia Carota Datteri Erba_cipollina Fragolina_di_bosco Giaggiolo;

param c:=
Acqua_dolce      1 
Sali_minerali    4 
Calore           1 
Luce             1.5
Vitamine         3.6;

param fabb:          Acqua_dolce     Sali_minerali   Calore      Luce    Vitamine:=
Azalea               0.5		       20      			10        100       1.5
Begonia              0.8		        3      			12          3       0.5
Carota               0.1        		5       		5           5        2.4
Datteri              0.2       			90      		50        450         3
Erba_cipollina       0.3       			30       		0          50          0
Fragolina_di_bosco   0.8       			60      		20         40       1.5
Giaggiolo            0.7        		0      			25        150         9;

param cresci:=
Azalea  30 
Begonia  40
Carota  10 
Datteri 100
Erba_cipollina   5 
Fragolina_di_bosco   5 
Giaggiolo  20;

param r:=
Azalea  6000 
Begonia  4000
Carota  2000 
Datteri 18000 
Erba_cipollina   100 
Fragolina_di_bosco   500 
Giaggiolo  7000 ;

end;
