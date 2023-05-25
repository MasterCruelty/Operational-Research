#Esercizio Cammino

/*
  * Su una rete di telecomunicazione un messaggio emesso da nodo s
  * deve essere inviato da un router fino a raggiungere destinazione t.
  * A ogni link sono associati dei tempi(pesi sugli archi) e costi di trasmissione differenti.
  * Si vuole minimizzare entrmabi. Alcuni costi sono negativi ma senza cicli di costo negativo.
  * I tempi sono tutti non negativi.
  **************************************************
  * Commento sul testo:
  * problema di cammino su grafo pesato con nodo origine e destinazione.
  * due obiettivi differenti, minimizzare i costi oppure i tempi.
  * I due obiettivi sono conflittuali, il primo dei costi ha valore 14,
  * il secondo sui tempi ha valore 1.
  * Il punto Utopia ha coordinate (1,14) nello spazio degli obiettivi.
*/

#DATI

param nNodi;			#numero dei nodi
set N := 1..nNodi;		#Insieme dei nodi
set A within N cross N;	#insieme degli archi
param s;				#nodo origine
param t;				#nodo destinazione
param c{A};				#costi per ogni arco

#VARIABILI
var x{A} binary;		#selezione dell'arco da percorrere
#VINCOLI
#vincolo su nodi origine e destinazione
subject to origine:
	sum{j in N: (s,j) in A} x[s,j] = 1;
subject to destinazione:
	sum{i in N: (i,t) in A} x[i,t] = 1;
#vincolo conservazione di flusso
subject to flow_cons{i in N: i<>s and i <>t}:
	sum{j in N:(j,i) in A} x[j,i] = sum{j in N:(i,j) in A} x[i,j];
#vincoli sul non avere cicli
subject to no_cicli_in{i in N}:
	sum{j in N:(j,i) in A} x[j,i] <= 1;
subject to no_cicli_out{i in N}:
	sum{j in N:(i,j) in A} x[i,j] <= 1;
#OBIETTIVO
minimize z: sum{(i,j) in A} x[i,j] * c[i,j];
#############
data;

param nNodi := 7;
param s := 1;
param t := 7;
set A := (1,2) (1,3) (1,4) (1,5) (1,6) (1,7)
		 (2,3) (2,4) (2,5) (2,6) (2,7)
		 (3,2) (3,4) (3,5) (3,6) (3,7) 
         (4,2) (4,3) (4,5) (4,6) (4,7)
		 (5,2) (5,3) (5,4) (5,6) (5,7) 
		 (6,2) (6,3) (6,4) (6,5) (6,7);


#vettore dei costi
/*param c:    1    2    3    4    5    6    7:=
 1  		.   10   34   -8   19   23   59
 2  		.    .    2   18   54   -3   21
 3  		.   18    .   13   22    9   18
 4  		.   16    4    .   11   10   24
 5  		.    7    9   15    .   20   30
 6  		.   32    1   -4   25    .   31
 7  		.    .    .    .    .    .    .;*/

#vettore dei tempi
param c:    1    2    3    4    5    6    7:=
 1			.   40   15   60   31   17    1
 2  		.    .   45   32    1   50   20
 3  		.   32    .   37   28   41   32
 4  		.   34   44    .   39   40   26
 5  		.   43   42   25    .   30   21
 6  		.   33   51   53   25    .   11
 7  		.    .    .    .    .    .    .;



end;
