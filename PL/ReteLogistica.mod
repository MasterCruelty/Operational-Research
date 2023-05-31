#Esercizio Rete Logistica

/*
  * Un'impresa nel settore dell'elettronica produce un impianto stereofonico per il mercato uk.
  * Il prodotto è assemblato nello stabilimento di Rotterdam e immagazzinato a Bristol e Middlesborogh.
  * Infine viene trasportato ai punti vendita che sono a Londra, Birmingham, Leeds e Edimburgo, ciascuno con domanda nota.
  * I costi di trasporto di ogni unità dall'impianto di assemblaggio ai magazzini e da questi ai punti vendita sono noti.
  * I due magazzini hanno una capacità limitata.
  * Domanda 1: Quante unità di prodotto devono essere trasportate ogni anno lungo i collegamenti per soddisfare la domanda
  *                    in modo da minimizzare i costi complessivi di trasporto? Qual è il costo di trasporto che l'azienda deve
  *                    sostenere ogni anno?
  * I due magazzini hanno una capacità di 15000 unità e vengono riforniti 10 volte l’anno: 
  * perciò la domanda annua che ciascuno di essi può soddisfare è pari a 150000 unità.
  ***************************************************
  * Commento sul testo:
  * si tratta di un problema di trasporto con punti intermedi prima di arrivare a destinazione.
*/

#DATI
set PV;                 #insieme dei punti vendita
set M;                  #insieme dei magazzini
param domanda{PV};      #domanda per ogni punto vendita[unità /anno]
param cM{M};            #costo trasporto da stabilimento ai magazzini[€/unità]
param cP{M,PV};         #costo trasporto dai magazzini ai punti vendita[€/unità]
param cf;               #costi fissi[€]
param cv;               #costi variabili[€/unità]
param cap{M};           #capacità totale dei magazzini in un anno
#VARIABILI
var x{M,PV} >= 0;       #flusso di merce dai magazzini  ai punti vendita
var y{M} >= 0;          #flusso da stabilimento a magazzini
#VINCOLI
#vincolo su capacità magazzino
subject to capacity{m in M}:
  y[m] <= cap[m];
#vincolo di flusso nei magazzini: n entrano e n escono
subject to Flow{m in M}:
  sum{pv in PV} (x[m,pv] - y[m])= 0;
#vincolo soddisfacimento domanda
subject to dom{pv in PV}:
  sum{m in M} x[m,pv] = domanda[pv];
#OBIETTIVO
minimize z: sum{m in M} y[m] * cM[m] + sum{m in M,pv in PV} x[m,pv] * cP[m,pv] + sum{m in M, pv in PV} x[m,pv] * cv + cf;
#############
data;

set PV := Londra Birmingham Leeds Edimburgo;
set M := Bristol Middlesborough;

param domanda:=
Londra        90000
Birmingham    80000
Leeds         50000
Edimburgo     70000;

param cM:=
Bristol        24.50
Middlesborough 26.00;
 
param cP:       Londra  Birmingham  Leeds  Edimburgo:=
Bristol          9.60     7.00       15.20    28.50
Middlesborough  19.50    13.30        5.00    11.30;

param cap:=
Bristol        150000
Middlesborough 150000;

param cf :=134000;
param cv := 5;
 
end;
