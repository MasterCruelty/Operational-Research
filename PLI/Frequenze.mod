#Esercizio Frequenze

#Bisogna assegnare le opportune frequenze ad una nuova emittente della protezione civile così da trasmettere in una data banda.
#Le frequenze disponibili devono essere il più numerose possibile.
#Alcune frequenze sono incompatibili con altre per fenomeni di interferenza elettromagnetica.
#L'emittente non deve ricevere coppie di frequenze incompatibili tra loro.
#Due frequenze interferiscono quando la loro differenza(in valore assoluto) è inferiore ad un valore limite K.
#Obiettivo: massimizzare numero frequenze ma evitando interferenze.

/*
  *Commento sul testo:
  *Si tratta di un problema di assegnamento.
*/

#DATI
param nF;			#numero delle frequenze
set F:=1..nF;		#Insieme delle frequenze
param freq{F};		#Vettore delle frequenze disponibili
param bound;		#Limite entro cui la differenza del val assoluto tra due freq interferiscono.

#VARIABILI
var x{F} binary;		#Scelta della frequenza


#VINCOLI

#vincolo di assegnamento/incompatibilità
subject to assign{i in F,j in F:i<j and freq[j]-freq[i] < bound}:
	x[i] + x[j] <=1;
#	freq[i] * x[i] - freq[j] * x[j] <= bound; non funzionante sempre

#OBIETTIVO

#massimizzare il numero di frequenze
maximize z: sum{i in F} x[i];

###########
data;
param nF:=22;

param freq:=
1 101
2 103
3 105
4 107
5 109
6 110
7 112
8 114
9 116
10 118
11 121
12 124
13 125
14 128
15 129
16 132
17 133
18 134
19 135
20 136
21 138
22 140;
param bound:=5;

end;
