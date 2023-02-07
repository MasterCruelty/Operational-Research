#Esercizio Impianti idroelettrici

/*
  *Un sistema di produzione di energia è basato su un dato insieme impianti idroelettrici. 
  *Ciascuno ha un bacino di data capacità massima e può generare energia entro un dato limite massimo per ogni giorno. 
  *La conversione dal volume di acqua consumata all’energia prodotta è data da un coefficiente costante e noto.
  *L’acqua che alimenta il bacino proviene da torrenti di montagna, di cui è stata stimata la portata, cioè la quantità di acqua riversata nel bacino in ogni giorno.
  *Se il bacino è pieno, l’acqua in eccesso viene smaltita attraverso un canale di sfioro che la disperde. 
  *L’energia generata viene immessa nella rete elettrica. 
  *E’ noto il fabbisogno energetico giornaliero e sono note le condizioni iniziali dei bacini.
  *Quando la produzione idroelettrica non basta a coprire il fabbisogno, è necessario acquistare energia da altre fonti, ad un dato costo che è variabile di giorno in giorno.
  *Esiste un limite noto e variabile nel tempo sulla quantità di energia acquistabile ogni giorno.
  *Si vuole pianificare l’attività dei bacini idroelettrici in un dato periodo di tempo, conoscendo lo stato iniziale di ciascuno e
  *la minima quantità di acqua che deve restare disponibile in ciascuno al termine del periodo di pianificazione.
  *Per produrre 1MWh servono 3600 mc di acqua per tutti gli impianti.
  *Qual è il modo ottimale di gestire gli impianti che consenta di soddisfare il fabbisogno energetico di ciascun giorno minimizzando i costi di acquisto dell’energia?
  *
  *******************************
  *Commento sul testo:
  *Si tratta di un problema che da luogo a un modello di flusso con minimizzazione dei costi.
*/

#DATI
param nI;		#numero degli impianti
set I:=1..nI;	#insieme degli impianti
param gg;		#numero dei giorni
set G:=1..gg;	#insieme dei giorni
param cap{I};	#Capacità massima dei bacini di ogni impianto[mc]
param alim{I};	#quantità di acqua riversata nei bacini dai torrenti ogni giorno[mc/g]
param prod_max{I};#produzione massima di energia di ogni impianto[MWh/g]
param vol_iniz{I};#volume iniziale dei bacini[mc]
param vol_fin{I}; #volume finale dei bacini dopo la pianificazione[mc]
param fab{G};	 #fabbisogno giornaliero di energia[MWh]
param c{G};		#costo dell'energia per ogni giorno
param k;		#coefficiente di trasformazione acqua in energia.
param max_acq;#massima energia acquistabile ogni giorno

#VARIABILI
var y{G};	#quantità di energia da acquistare[MWh/g]
var volume{I,G};	#quantità di acqua presente nel bacino i al termine del periodo g[mc]
var x{I,G};		#quantità di acqua usata per l'impianto i nel periodo g[mc]
#VINCOLI

#vincolo su acquisto giornaliero di energia
subject to acquisto{g in G}:
	y[g] <= max_acq;

#vincolo su fabbisogno giornaliero[MWh/g]
subject to fabbisogno{g in G}:
	sum{i in I} (x[i,g]/k) + y[g] = fab[g];

#vincolo su produzione massima di energia per ogni impianto[MWh/g]
subject to produzione{i in I,g in G}:
	(x[i,g]/k) <= prod_max[i];

#VINCOLI DI FLUSSO
#vincolo su volume iniziale e finale[mc]
subject to iniziale{i in I}:
	alim[i] + vol_iniz[i] >=  x[i,1]+ volume[i,1];
#vincolo su volume finale[mc]
subject to finale{i in I}:
	volume[i,20] >= vol_fin[i];
#vincolo conservazione del flusso[mc]
subject to flow_conservation{i in I,g in G:g>1}:
	alim[i] + volume[i,g-1] >= x[i,g] + volume[i,g];
#vincolo su massima quantità nei bacini[mc]
subject to max_acqua{i in I,g in G}:
	volume[i,g] <= cap[i];
#vincolo su minima quantità di acqua nei bacini[mc]
subject to min_acqua{i in I,g in G}:
	volume[i,g] >= 0;

#OBIETTIVO
#minimizzare i costi dell'energia
minimize z: sum{g in G} c[g] * y[g];

#########
data;

param nI:=3;
param gg:=20;
param max_acq := 30;
param k := 3600;

param:			cap			  alim		 	prod_max vol_iniz   vol_fin :=
1      			1000000       25000          24       500000     250000
2      			1200000       55000          30       600000     300000
3      			1800000       40000          30       900000     450000;

param:					fab			c :=
1      				 	90       3000
2       				84       3000
3       				82       3000
4       				74       3000
5       				66       3000
6       				62       3500
7       				52       3500
8       				40       3500
9       				40       3500
10       				40       3500
11       				70       4000
12       				90       4000
13       				70       4000
14       				66       4000
15       				68       4000
16       				68       5000
17       				74       5000
18       				76       5000
19       				80       5000
20       				82       5000;

end;
