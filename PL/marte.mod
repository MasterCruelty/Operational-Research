# Esercizio trasmissione da marte 

#Un rover su marte può trasmettere dati sulla Terra solo in intervalli di tempo noti.
#In questi intervalli le memorie possono essere lette e parzialmente svuotate una volta e con bit-rate noto.
#Ogni banco di memoria ha capacità finita ed è gestito in first-in first-out.
#Se la quantità di dati eccede il banco di memoria, i dati vecchi vengono sovrascritti.
#Obiettivo: minimizzare la probabilità di sovrascrittura dei dati.
#Bisogna mantenere il più basso possibile in ogni banco di memoria il rapporto tra spazio occupato e capacità.

/*
  *Commento sul testo:
  *Ci sono intervalli in cui si può operare con dati noti.
  *Capacità finita dei banchi di memoria in gestione FIFO.
  *Non si vogliono sovrascrivere i dati tra un intervallo e l'altro.
  *Si tratta quindi di un problema che da luogo a un modello di gestione del flusso multiperiodo in cui
  *si vogliono minimizzare i dati che verrebbero sovrascritti.
*/


#DATI
param nB;				 #Numero banchi di memoria
set B := 1..nB;		 	 #Insieme dei banchi di memoria
param nI;				 #Numero intervalli temporali
set I := 1..nI;		 #Insieme degli intervalli temporali
param prod_dati{I,B};#Produzione di dati [Mbit]
param capacity{B};	 #Capacità di memoria [Mbit]
param occupato{B};	 #Spazio occupato all'inizio [Mbit]
param time{I};		 #Tempo disponibile [Secondi]
param bit_rate{I};	 #Bit-rate [Kbit / sec ]

#VARIABILI
var x{B,I} >= 0; #dati trasmessi a Terra
var delta >= 0;#minmax
var y{B,I};		#quantità di dati in ogni banco di memoria B dopo ogni intervallo temporale I
#VINCOLI

#def y
subject to def_y{b in B,i in I}:
	y[b,i] = occupato[b] / capacity[b] * x[b,i];

#Vincolo sulla capacità di memoria di ogni banco
#tengo conto anche dello svuotamento della memoria
subject to size_memory{b in B}:
	sum{i in I} (prod_dati[i,b] * x[b,i] - bit_rate[i] * time[i]) <= capacity[b] - occupato[b];

#vincolo controllo di flusso
subject to Flow{b in B,i in I:i>1 and i<7} :
	x[b,i] = x[b,i-1] + + prod_dati[b,i] - y[b,i-1];
subject to Flow_first{b in B,i in I}:
	x[b,1] = occupato[b] + prod_dati[b,1];

#OBIETTIVO
#minimizzare la probabilità di sovrascrittura per eccedenza di memoria
minimize z: delta; 
subject to MinMax{b in B,i in I}:
	delta >= y[b,i];
######
data;

param nB := 6;
param nI := 9;

param prod_dati:  1    2    3    4    5    6 :=
	1		      4   11   31    3   18   27
    2		      6    8   34    4   19   23
    3		      7   23   38    5   21   19
    4		      3   31   35    6   15   18
    5		      3   14   37    7   14   23
    6		      8    8   35    6   14   24
    7		      1   10   31    5   14   25
    8		      3   20   40    4   18   20
    9		      4   13   28    5   19   13;

param capacity:=
1         32
2         60
3        100
4         30
5         50
6         80;

param occupato:=
1         8      
2        15      
3        25      
4         5      
5        16      
6        23;

param time:=
1          490    
2          420    
3          460    
4          485    
5          400    
6          455    
7          480    
8          380    
9          450;

param bit_rate:=
1		195
2		160
3		180
4		195
5		160
6		180
7		195
8		160
9		180;


end;
