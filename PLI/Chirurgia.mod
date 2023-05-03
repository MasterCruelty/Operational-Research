#Esercizio chirurgia

/*
  *Un'ospedale ha 3 sale operatorie, due disponibili per 6 ore e la terza per 7 ore.
  *10 pazienti in attesa, ognuno con durata nota dell'intervento.
  *Massimizzare il numero di pazienti operabili e in quali sale.
  **************************************************
  *Commento post-ottimale: 
  *si riescono ad assegnare tutti i pazienti ma avendo 2 sale indistinguibili, esistono sicuramente soluzioni simmetriche e quindi non è unica.
*/

#DATI
param nS;       #numero delle sale
set S:=1..nS;   #insieme delle sale
param tempo_sale{S};    #tempo disponibile per ogni sala[minuti]
param nP;               #numero dei pazienti
set P:=1..nP;           #insieme dei pazienti
param durata_paziente{P};       #durata intervento per ogni paziente[minuti]

#VARIABILI
var x{P,S} binary;      #assegnamento dei pazienti in quale sala

#VINCOLI
#vincolo sul tempo disponibile in ogni sala operatoria
subject to capacity{s in S}:
     sum{p in P} x[p,s] * durata_paziente[p] <= tempo_sale[s];
#vincoli di assegnamento
subject to assign{s1 in S,s2 in S,p in P:s1<>s2}:
     x[p,s1] + x[p,s2] <= 1;

#OBIETTIVO
maximize z: sum{s in S,p in P} x[p,s];

##############
data;

param nS:= 3;
param nP:=10;

param tempo_sale:=
1       360
2       360
3       420;

param durata_paziente:=          
   1		120
   2		60
   3		75
   4		80
   5		130
   6		110
   7		90
   8		150
   9		140
  10		180;

end;
