#Esercizio Ring Loading
/*
  *Bisogna dimensionare una rete locale, composta da un certo numero di calcolatori collegati in anello da opportuni cavi.
  *Ogni calcolatore può spedire messaggi ad ogni altro calcolatore in senso orario o in senso antiorario lungo l'anello.
  *Ogni calcolatore instrada nello stesso senso (orario o antiorario) tutti i messaggi da lui emessi e aventi la stessa destinazione.
  * E' nota, in base a rilevamenti eseguiti in precedenza, la dimensione massima del traffico 
  *(quantità di dati per unità di tempo) che si prevede ogni calcolatore trasmetterà ad ogni altro. 
  *Si vuole decidere come instradare il traffico dei dati trasmessi da ciascun calcolatore in modo da minimizzare i costi di installazione della rete. 
  *Tali costi dipendono dal numero di archi che compongono l'anello e dal costo di ciascun arco, che è proporzionale alla capacità dell'arco. 
  *La capacità di ogni arco deve essere sufficiente a smaltire il traffico previsto su di esso. Tutti gli archi della rete devono avere la stessa capacità.
*/

#DATI
param N;
set Nodi := 1..N;		#insieme dei calcolatori
param t{Nodi,Nodi};		#matrice di traffico[MB/sec]
#Ogni arco i va da nodo i a nodo i +1(modulo n)

#VARIABILI
var x{Nodi,Nodi} binary;		#1= Orario	0= Antiorario
var q;							#capacità da installare [MB/sec]

#VINCOLI
#vincolo minmax: q deve essere maggiore del traffico su tutti gli archi
subject to minmax{i in Nodi:i<N}:
	q>= sum{j in Nodi, k in Nodi: (j<=i and k >= i+1) or (k>=i+1 and j>k) or (j<=i and k<j)} t[j,k]*x[j,k] +
	    sum{j in Nodi, k in Nodi: (j<=i and k >= i+1) or (k>=i+1 and j>k) or (j<=i and k<j)} t[k,j]*(1-x[k,j]);

#vincolo minmax extra per il caso in cui c'è l'arco dall'ultimo al primo nodo
subject to minmaxspeciale:
	q >= sum{j in Nodi, k in Nodi:(k<j)} t[j,k] * x[j,k] +
		 sum{j in Nodi, k in Nodi:(k<j)} t[k,j] * (1-x[k,j]);

#OBIETTIVO
minimize z: q;


################
data;
param N:=10;

param t: 1	2	3	4	5	6	7	8	9	10:=
1 		 9 	7 	7 	8 	7 	9 	9 	6 	6 	10
2		 7 	7 	7 	7 	7 	8 	5 	7 	10 	9
3 		 7 	5 	8 	8 	8 	10 	6 	10 	9 	10
4  		 7 	10 	7 	10 	9 	8 	5 	10 	7 	9
5   	10 	5 	6 	10 	5 	8 	7 	9 	8 	7
6   	6 	7 	8 	7 	8 	10 	9 	5 	9 	7
7   	9 	5 	8 	9 	7 	10 	8 	9 	10 	7
8   	6 	5 	9 	5 	6 	8 	10 	6 	9 	8
9   	7 	5 	5 	8 	8 	8 	10 	7 	9 	7
10 		8 	5 	5 	7 	8 	9 	7 	6 	5 	8;

end;
