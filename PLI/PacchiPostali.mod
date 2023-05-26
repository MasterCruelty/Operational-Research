#Esercizio pacchi postali

/*
  * Bisogna spedire per posta pacchi in apposite confezioni.
  * Ogni tipo di confezione ha diverso costo di spedizione.
  * Ogni confezione deve essere riempita in modo da soddisfare vincoli di peso e volume degli oggetti.
  * Tali vincoli riguardano sia valore massimo che minimo del contenuto di ogni pacco.
  * Si vuole organizzare la spedizione di alcuni oggetti in modo da soddisfare tutti i vincoli imposti.
  * Obiettivo di minimizzare i costi.
  ****************************************
  * Commento sul testo:
  * Problema dello zaino con due diversi tipi di zaino e diversi oggetti da metterci dentro.
  * In questo caso non massimizziamo i valori degli oggetti ma minimizziamo i costi per porli dentro.
  * Inoltre in questo caso non si esclude nessun oggetto, bisogna solo scegliere come ripartirli.
*/

#DATI
set CT;             #insieme dei tipi di pacchi
set CP;             #insieme dei pacchi
param nO;           #numero degli oggetti
set O :=1..nO;      #insieme degli oggetti    
param minV{CT};      #volume minimo per ogni confezione
param maxV{CT};      #volume massimo per ogni confezione
param minP{CT};      #peso minimo per ogni confezione
param maxP{CT};      #peso massimo per ogni confezione
param costi{CT};     #costo per ogni confezione
param vol{O};       #volume di ogni oggetto
param peso{O};      #peso di ogni oggetto

#VARIABILI
var x{O,CT,CP} binary;    #quale oggetto va in quale confezione
var y{CT,CP} binary;      #selezione del tipo di confezione e del pacco

#VINCOLI
#vincoli sull'assegnamento di ogni oggetto a un pacco
subject to assign{o in O}:
  sum{ct in CT, cp in CP} x[o,ct,cp] = 1;
#vincoli su volume minimo e massimo di ogni oggetto per tipo di confezione
subject to minimo_volume{ct in CT,cp in CP}:
     sum{o in O} x[o,ct,cp] * vol[o] >= minV[ct] * y[ct,cp];
subject to volume_massimo{ct in CT,cp in CP}:
     sum{o in O} x[o,ct,cp] * vol[o] <= maxV[ct] * y[ct,cp];
#vincoli su peso minimo e massimo di ogni oggetto per tipo di confezione
subject to minimo_peso{ct in CT,cp in CP}:
     sum{o in O} x[o,ct,cp] * peso[o] >= minP[ct] * y[ct,cp];
subject to massimo_peso{ct in CT,cp in CP}:
     sum{o in O} x[o,ct,cp] * peso[o] <= maxP[ct] * y[ct,cp];
#OBIETTIVO
minimize z: sum{ct in CT, cp in CP} costi[ct] * y[ct,cp];
############
data;

param nO:=11;
set CT := 1 2;
set CP := 1 2;

param:  costi       minV     maxV    minP   maxP:=
 1      10000         0      150       0    1500
 2      15000       120     1000    1000    4000;

param:     vol       peso:=
  1        14        750
  2        13        520
  3        62        140
  4        28        910
  5        19        230
  6        20        250
  7        31        600
  8         4        315
  9        10        800
 10        15        320
 11        15        480;

end;
