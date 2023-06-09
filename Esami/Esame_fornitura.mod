#Esercizio Fornitura

/*
  * Un'impresa artigiana rifornisce un centro commeciale di due tipi di lavorati.
  * Gli operai lavorano in 3 turni(6-14; 14-22; 22-6)
  * Il costo della produzione di ogni tipo di lavorato varia da turno a turno.
  * A fine di ogni turno, parte dei lavorati prodotti viene trasportata al centro commeciale.
  * Parte può essere immagazzinata in una cella frigorifera e trasportata al centro commerciale.
  * Anche la conservazione dei lavorati nella cella ha un costo.
  * La produzione di ciascun lavorato richiede l'utilizzo di alcune materie prime conservate in cella esterna limitata.
  * Il rifornimento di materie prime deve essere effettuato una volta al giorno, all'inizio del primo turno.
  * L'impresa deve assicurare una fornitura minima giornaliera al centro commerciale. 
  * A causa di convenzioni con i trasportatori, sono fissati dei limiti minimi e massimi alla quantità totale di lavorati,
  * trasportabili dall'impresa al centro commerciale alla fine di ogni turno.
  * Obiettivo: minimizzare i costi pianificando produzione giornaliera e operazioni di rifornimento.
  * Domanda extra: potendo spendere un dato budget per modificare qualcuno dei vincoli del problema, su quali vincoli
  *                              avrebbe senso agire e con quali miglioramenti possibili?
  *****************************************
 * Problema PL minimizzare costi 
 * Il prezzo-ombra del vincolo sulla fornitura minima `e pari a 16.7176.
 * Quindi per ogni Kg in meno di fornitura giornaliera richiesta, si avrebbe un risparmio giornaliero di 16,7176 euro.
 * Anche su trasp_min e trasp_max c'è 0.4 e -1.8. Nel primo caso risparmio diminuendo, nel secondo aumentando.
 * sul vincolo capacity avrei un risparmio di circa 25 centesimi al giorno per ogni decimetro cubo aggiuntivo.
 * I risparmi ovviamente si avrebbero solo all'interno del range definito dall'analisi di sensitivitò, non per ogni valore.
 * Ovvero finchè la base ottima non cambia.
*/

#DATI
param nT;       #numero turni
set T:=0..nT-1; #insieme turni
set L;          #insieme lavorati
param cp{T,L};  #costi produzione in funzione del turno[€ / kg]
param cl{L};    #costi conservazione in cella per ogni lavorato[€/kg]
param capCella; #capacità della cella[decimetri cubi]
param fmin;     #fornitura minima giornaliera per il centro commerciale[kg]
set I;          #insieme ingredienti per produrre i lavorati A e B
param comp{I,L};#percentuale di ingredienti per produrre i due lavorati[%]
param vol{I};   #volume degli ingredienti[decimetri cubi/kg]
param qmin{T};  #quantità minima trasportabile per ogni turno[kg]
param qmax{T};  #quantità massima trasportabile per ogni turno[kg]
#VARIABILI
var x{L,T} >= 0;      #produzione di lavorati per ogni turno[kg]
var y{L,T} >= 0;      #quantità trasportata al centro commerciale per ogni turno[kg]
var s{L,T} >= 0;      #stock nel magazzino per ogni prodotto e ogni turno[kg]
var b{I} >= 0;      #quantità consumata in ogni giorno per ogni ingrediente
#VINCOLI
#vincolo su capacità cella per gli ingredienti[decimetri cubi/kg]
subject to capacity:
     sum{i in I} vol[i]*b[i] <= capCella;
#vincolo fornitura minima giornaliera al centro commerciale
subject to forn_min:
     sum{l in L,t in T} y[l,t] >= fmin;
#vincoli quantità minima e massima trasportabile
subject to trasp_min{t in T}:
     sum{l in L} y[l,t] >=qmin[t];
subject to trasp_max{t in T}:
     sum{l in L} y[l,t] <= qmax[t];
#vincolo conservazione flusso per legare var s a var x
# lo stock del turno prima + la produzione del turno attuale devono essere uguali a:
# lo stock del turno attuale + la quantità trasportata nel turno attuale
subject to flow{l in L, t in T}:
     s[l,(t-1) mod 3] + x[l,t] = s[l,t] + y[l,t];
#vincolo sul consumo di ingredienti
subject to consumo{i in I}:
     b[i] = sum{l in L,t in T}x[l,t]*comp[i,l];
#OBIETTIVO
minimize z: sum{l in L,t in T} (x[l,t] *cp[t,l] + cl[l]*s[l,t]);
##########
data;

param nT:=3;
set L:= A B;
set I:= X Y Z;
param capCella:=7100;
param fmin:=300;

param cp:    A   B:=
0           12  15
1           8   11.5
2           10  12;

param cl:=
A 1.8
B 0.4;

param comp:   A     B:=
X           .20   .50
Y           .60   .10
Z           .20   .40;

param vol:=
X 20
Y 35
Z 15;

param:  qmin    qmax:=
0        65      135
1        70      135
2        50      135;

end;
