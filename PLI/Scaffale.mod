#Esercizio Scaffale

/*
  * Bisogna immagazzinare un insieme di oggetti rettangolari di dimensioni date su uno scaddale di lunghezza data.
  * Lo scaffale può essere suddiviso da piani orizzontali posti ad altezza variabile.
  * Gli oggetti non possono essere accumulati l'uno sull'altro, ma ciascuno deve essere appoggiato dirattamente su un piano.
  * I piani possono essere posti a qualunque altezza nello scaffale.
  * Obiettivo di minimizzare l'altezza dell'ultimo piano orizzontale, quello che fa da soffitto all'ultimo scomparto
  * occupato da oggetti.
*/

#DATI
param nO;           #numero oggetti
set O := 1..nO;     #insieme oggetti
param nP;           #numero piani necessari(larghezza complessiva oggetti fratto 116)
set P:=1..nP;       #insieme piani necessari
param w{O};         #larghezza ogni oggetto
param h{O};         #altezza ogni oggetto
param wtot;         #larghezza dello scaffale
#VARIABILI
var x{O,P} binary;      #oggetto o in O sul piano p in P
var y{P} >= 0;          #altezza a cui è posto il piano p in P
#VINCOLI
#vincoli di assegnamento(ogni oggetto assegnato ad almeno un piano)
subject to assign{o in O}:
     sum{p in P} x[o,p] = 1;
#vincoli di capacità sulla larghezza dello scaffale
subject to capacity{p in P}:
     sum{o in O} x[o,p]*w[o] <= wtot;
#vincolo sulle altezze(l'altezza di un piano deve essere sufficiente per il più alto sul piano precedente)
subject to height{p in P,o in O:p>1}:
     y[p] - y[p-1] >= h[o]*x[o,p];
subject to firstheight{o in O}:
     y[1] >= h[o]*x[o,1];
#OBIETTIVO
minimize z: y[4];
#############
data;

param nO:= 12;
param nP:=4;
param:      w           h:=
   1        41          10
   2        63          15
   3        10          40
   4        25          25
   5        38          25
   6        40          20
   7        26          31
   8        35          18
   9        14          19
  10        21          33
  11        17          22
  12        26          34;

param wtot :=116;

end;
