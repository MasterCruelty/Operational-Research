#Esercizio Birra

/*
  *Vi sono un'insieme di siti produttivi, ognuno con una massima capacità e costo unitario di produzione.
  *Vi sono un'insieme di punti vendite, ognuno con una data domanda da soddisfare.
  *Sono note le distanze tra i siti produttivi e i punti vendita(in alcuni casi coincidono).
  *I costi di trasporto sono proporzionali alle quantità trasportate e alle distanze con un coeff. dato.
  *Si vogliono minimizzare i costi di produzione e di trasporto
  *****************************************************
  *Commento sul testo v3: multi-obiettivo, si vuole minimizzare l'uso di siti e anche i costi.
  *Si introducono var binarie quindi sempre PLI come v2.
  *Ottimizzando l'obiettivo secondario sui costi, si ottiene lo stesso valore ottimo in v2, 
  *ma utilizzando solo 3 siti produttivi.
  *****************************************************
  *
  */

#DATI
set SP;         #insieme dei siti produttivi
set PV;         #insieme dei punti vendita
param d{SP,PV}; #matrice delle distanze per andare da ogni sito produttivo a ogni punto vendita
param cp{SP};   #costo unitario di produzione per ogni sito di produzione [€/unità]
param cap{SP};  #capacità massima di produzione per ogni sito produttivo
param dom{PV};  #domanda per ogni punto vendita[unità/gg]
set T;          #insieme dei veicoli
param capV{T};  #capacità di ogni tipo di veicolo[unità/viaggio]
param ctV{T};   #costo di trasporto per ogni tipo di veicolo[€/km]

#VARIABILI
var x{SP,PV} >= 0;              #quantità di prodotto trasportato dai siti di produzione ai punti vendita[unità/gg]
var y{SP,PV,T} >= 0 integer;    #numero di viaggi con veicoli di un certo tipo dai siti produttivi ai punti vendita
var w{SP} binary;               #numero di siti produttivi utilizzati 1=usato,0=non usato
#VINCOLI
#vincolo su capacità produttiva
subject to capacity{s in SP}:
     sum{v in PV} x[s,v]  <= cap[s]*w[s];
#vincolo su domanda
subject to domanda{v in PV}:
     sum{s in SP} x[s,v] >= dom[v];
#vincolo di capacità veicoli
subject to capacityV{s in SP,v in PV}:
  x[s,v] <= sum{t in T} capV[t] * y[s,v,t];
#OBIETTIVO
minimize z1: sum{s in SP} w[s];
#minimize z2: sum{s in SP,v in PV} (cp[s] * x[s,v]) + sum{s in SP,v in PV,t in T} (ctV[t]*d[s,v] * y[s,v,t]);

##########
data;

set SP := A B C D F G J M;
set PV := A B C D E F G H J K L M;

param d:	A	B	 C	    D	 E	    F	G	H	J	K	 L  	M:=
A		    0	565	 401	529	 505	295	720	550	817	891	 539	855
B		    565	0	 210	474	 309	799	665	760	936	1008 979	1420
C		    401	210	 0	    309	 289	635	500	674	771	949	 838	1255
D		    529	474	 309	0	 114	375	194	377	465	643	 579	1012
F		    295	799	 635	375	 431	0	411	259	394	599	 293	634
G		    720	665	 500	194	 271	411	0	281	861	450	 570	681
J		    817	936	 771	465	 553	394	861	117	0	220	 378	593
M		    855	1420 1255	1012 956	634	681	527	593	705	 285	0;

param: cp    cap:=
A      10   300 
B      15   200
C      18   200
D      20   300
F      12   200
G      16   200
J      16   300
M      10   300;

param dom:=
A   80
B   70
C   60
D   70
E   80
F   40
G   60
H   70
J   150
K   40
L   30
M   50;

set T := Small Big;

param capV:=
Small   20
Big     30;

param ctV:=
Small   0.80
Big     1;

end;
