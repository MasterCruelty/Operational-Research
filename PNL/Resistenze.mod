#Esercizio Resistenze

/*
Si vuole progettare un semplice componente resistivo combinando in serie due blocchi,
ciascuno dei quali è formato da due resistori in parallelo. I quattro resistori da usare possono essere
scelti all’interno di un insieme di resistori disponibili.
Come effetto si vuole ottenere un componente la cui resistenza sia il più vicina possibile
(non importa se maggiore o minore) ad un valore desiderato.
Formulare il problema, classificarlo e risolverlo con i dati del file RESISTEN.TXT.
*/

#DATI
param nT;
set T:=1..nT;
param n{T};
param r{T};
param target;
set P:=1..4;	#Posizioni

#VARIABILI
var x{T,P} binary;	#Assegnamento tipo-posizione
var R{p in P} = sum{t in T} r[t] * x[t,p];
var RR;
var delta;

#VINCOLI
#un resistore per ogni posizione
subject to Assign1{p in P}:
	sum{t in T} x[t,p] =1;
#non più di n[t] resistori possono essere usati
subject to Assign2{t in T}:
	sum{p in P} x[t,p] <= n[t];
	
#resistenza risultante
subject to totale:
	RR= R[1]*R[2]/(R[1]+R[2]) + R[3]*R[4]/(R[3]+R[4]);

#OBIETTIVO

minimize z:delta;
subject to minabs1: delta >= RR-target;
subject to minabs2: delta >= target-RR;

#############
data;

param nT:=6;




param:  n		  r:=
 1      1         12
 2      1         15
 3      2         20
 4      2         22
 5      1         30
 6      1         40;

param target :=65;

end;
