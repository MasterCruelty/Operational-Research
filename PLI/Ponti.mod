#Esercizio ponti

/*
  * Si vuole collegare tra di loro due isole vicine. Sono stati identificati un numero noto di siti per la costruzione di un ponte.
  * Il budget disponibile è noto e consente la costruzione di un dato numero di ponti, il budget è inferiore rispetto ai ponti possibili in assoluto.
  * I ponti serviranno al collegamento tra siti di importanza sociale e commerciale sulle due isole.
  * Sono state identificate alcune coppie di siti su isole diverse tra i quali è previsto traffico intenso.
  * L'obiettivo è minimizzare una funzione delle distanze minime che dovranno essere percorse tra i siti di ogni coppia identificata.
  * 2 criteri proposti: 
  * -minimizzare la distanza media per ogni coppia.
  * -minimizzare la distanza massima tra tutte le coppie.
  **********************************************************
  * Commento sul testo:
  * problema di assegnamtno in cui si devono assegnare 2 dei 4 ponti a ognuna delle coppie o/d
  * 
*/
param nP;           #numero di ponti possibili
set P := 1..nP;     #insieme dei ponti possibili
param psize;        #numero ponti che si possono costruire
set C;              #insieme delle coppie origine-destinazione
param d{C,P};       #distanze da percorrere per ogni coppia o/d usando ciascuno dei 4 ponti possibili

#VARIABILI
var x{P} binary;    #scelta del ponte da costruire tra quelli possibili
var y{P,C} binary;  #x[p,c] = 1 collegamento tra la coppia c usando il ponte p
var delta;
#VINCOLI
#vincoli di assegnamento, ogni coppia deve essere collegata tramite un ponte
subject to link_bridge{c in C}:
     sum{p in P} y[p,c] = 1;
subject to link_build_bridge{p in P,c in C}:
    y[p,c] <= x[p];
#vincolo sul massimo numero di ponti che si possono costruire
subject to build_bridge:
     sum{p in P} x[p] = 2;

#OBIETTIVO
#minimize z1: sum{p in P,c in C} y[p,c] * d[c,p];
minimize z2: delta;
#min max
subject to minmax{c in C, p in P}:
     delta >= d[c,p] * y[p,c];
##############
data;

param nP := 4;
param psize := 2;
set C := A B C D E;


param d:     1  2  3  4:=
 A          12 14 20 24
 B           9 17 23 27
 C          18 10 12 16
 D          25 15 15 15
 E          26 16 10 10;

end;
