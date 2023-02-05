#Esercizio Antitrust

#Una grande azienda deve dividersi in due aziende di dimensioni minori.
#I dirigenti designati competono per prendersi la maggior parte del mercato dell'azienda madre.
#Bisogna formulare matematicamente il problema e trovare la spartizione più equa.
#l'azienda madre vende un dato numero di prodotti tramite un dato numero di filiali.
#Per ciascuna filiale si conosce quanto fattura ogni prodotto.
#Ogni filiale è indivisibile e va assegnata a solo una delle due aziende figlie.
#Si vuole che entrambe le figlie abbiano quote il più uniforme possibile di mercato per tutti i prodotti.
#Minimizzare la massima differenza tra il fatturato di un'azienda figlia e quello dell'altra rispetto
#ad uno stesso prodotto.

#Edit: Come cambierebbe il problema e la soluzione ottima se si volesse minimizzare la differenza di 
#fatturato complessivo tra le due aziende figlie?

/*
  *Commento sul testo:
  *Si voglio assegnare un certo numero di filiali a una delle due aziende figlie.
  *Le quote tra le due figlie deve essere equa.
  *Si tratta quindi di un problema che da luogo a un modello di assegnamento in cui,
  *l'obiettivo è minimizzare la massima differenza tra i fatturati delle due figlie.
*/

#DATI
param nF;
set F:= 1..nF;          #Insieme delle filiali
param nP;
set P:=1..nP;            #insieme dei prodotti
param fatt{F,P};        #fatturato di ogni filiale per ogni prodotto [M€]

#VARIABILI
var x{P} binary;  #Assegno a figlia 1 se = 0, altrimenti figlia 2 se =1
var delta;
var y1{P} >= 0;   #fatturato prima azienda per ogni prodotto
var y2{P} >= 0;   #fatturato seconda azienda per ogni prodotto
#VINCOLI

#vincoli per definire yi
subject to def_y1{j in P}:
     y1[j] = sum{i in F} fatt[i,j] *(1-x[j]);
subject to def_y2{j in P}:
     y2[j] = sum{i in F} fatt[i,j] *x[j];


#OBIETTIVO
#minimizzo delta definita come il massimo della differenza tra y1 e y2 in valore assoluto
#Dove y1 e y2 sono definite come il fatturato su tutti i prodotti delle due aziende figlie
minimize z: delta;
#vincolo minmax
subject to minmax1{i in P}:
     delta >= y1[i] - y2[i];
subject to minmax2{i in P}:
     delta >= y2[i] - y1[i];


######
data;

param nF:=7;
param nP:=3;


param fatt: 1   2   3:=
1           83  14  42
2           38  63  56
3           28  24  12
4           59  7   53
5           25  35  83
6           52  86  85
7           59  64  25;

end;
