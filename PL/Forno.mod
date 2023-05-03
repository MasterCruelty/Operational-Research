#Esercizio Forno
/*
  * Un forno deve ogni giorno produrre dei biscotti, con dei tempi di produzione per kg noti.
  *Diversi biscotti possono cuocere insieme, ma l'area del forno è limitata a 4 metri quadri. È noto lo spazio occupato da un kg di ogni prodotto.
  *Esistono dei fabbisogni minimi di alcuni tipi di prodotti. Il forno funziona per 6 ore al giorno complessivamente. Sono noti i prezzi di vendita dei prodotti.
  *Un ulteriore vincolo specifica che nessun prodotto deve essere sfornato in quantità superiore al doppio di un altro.
  *Commento sul testo: è un mix produttivo ottimale in cui si voule massimizzare i guadagni ricavati dai biscotti.
  *************************************************
*/

#DATI
set P;              #insieme dei prodotti
param volt{P};      #volume e tempo di preparazione[mqh/kg]
param prod_gg{P};   #produzione giornaliera minima per ogni prodotto[kg]
param c{P};         #prezzo di vendita per ogni prodotto[€/kg]
param cap;          #risorse disponibili[mq/h] 6 ore * 4 mq

#VARIABILI
var x{P} >= 0;      #produzione di prodotti nel forno[kg]

#VINCOLI
#vincolo sulla produzione minima giornaliera
subject to min_prod{p in P}:
     x[p] >= prod_gg[p];
#vincolo su area disponibile nel forno
subject to capacity:
     sum{p in P} x[p] * volt[p] <= cap;
#OBIETTIVO
#massimizzare i profitti
maximize z: sum{p in P} x[p] * c[p];

#############
data;

set P := Pane Biscotti Focacce Paste;

param volt:=
Pane        1
Biscotti    0.6
Focacce     2.25
Paste       3;

param prod_gg:=
Pane          5
Biscotti      2
Focacce       3
Paste         2;

param c:=
Pane       2.50
Biscotti   4.00
Focacce    2.00
Paste      5.50;

#param A := 4;
#param T := 6;
param cap := 24;

end;
