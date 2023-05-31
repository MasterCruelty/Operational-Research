#Esercizio Scheduling

/*
  * Un impianto produttivo deve realizzare dei prodotti eseguendo in sequenza delle lavorazioni.
  * Le lavorazioni e la sequenza sono uguali per tutti i prodotti.
  * Ogni prodotto viene realizzato in un unico lotto.
  * Alcune lavorazioni possono essere realizzate su più macchine che lavorano in parallelo.
  * I tempi di lavorazioni sono noti per ogni unità di prodotto e ogni lavorazione.
  * I prodotti vanno realizzati in sequenza prefissata secondo la loro numerazione.
  * Ogni prodotto può passare alla lavorazione successiva solo quando quella precedente è completa(su tutte le macchine).
  * Ogni prodotto ha un diverso profitto unitario e l'obiettivo è massimizzare il profitto.
  * Tutta la produzione deve concludersi nell'arco di un turno di 8 ore. Il prodotto è continuo, non discreto.
  ******************************************
  * Domanda 1: quali sono i tempi di fermo-macchina previsti nella soluzione ottima?
  * Domanda 2: Quale lavorazione è il collo di bottiglia nella produzione?
  * 
*/

#DATI
param nM;                   #numero macchine
set M:=1..nM;               #insieme macchine
param nL;                   #numero lavorazioni
set L:=1..nL;               #insieme lavorazioni
param nP;                   #numero prodotti
set P:=1..nP;               #insieme prodotti
param ml{M,L};              #quale macchina fa quale lavorazione
param c{P};                 #profitto unitario per ogni prodotto[€/unità]
param t{L,P};               #tempo di lavorazione per ogni prodotto e tipo lavorazione[secondi/unità]
param maxtime := 3600 * 8;  #tempo massimo 8 ore => 3600 *8 secondi

#VARIABILI
var s{P,M} >= 0;        #istante di inizio della lavorazione per prodotto p su macchina m
var e{P,M} >= 0;        #istante di fine della lavorazione per prodotto p su macchina m
var x{M,P} >= 0;        #quantità totale di prodotto p lavorato su macchina m
var y{P} >= 0;          #quantità totale di prodotto per ogni tipo
#VINCOLI
#vincolo di non sovrapposizione delle lavorazioni per prodotti diversi su ogni singola macchina
subject to incompat{m in M,p in P:p <7}:
  e[p,m] <= s[p+1,m];
#vincolo sulla durata massima di lavorazione
subject to time{m in M, p in P:p = 7}:
  e[p,m] <= maxtime;
#vincolo sull'ordinamento delle lavorazioni(ogni prodotto p la fine in m1 precede l'inizio di p su m2)
subject to ordLav{l in L,p in P, m1 in M, m2 in M: (m1<>m2) and (l < 3) and (ml[m1,l] = 1) and (ml[m2,l+1] = 1)}:
  e[p,m1] <= s[p,m2];
#vincolo passaggio dai tempi s ed e alle quantità prodotte(t tempo unitario di lavorazione l e x quantità totale prodotta di p su m)
subject to timespent{l in L,m in M,p in P,m1 in M, m2 in M:l<3 and ml[m1,l] = 1 and ml[m,l] = 1}:
  e[p,m]  = s[p,m] + t[l,p] * x[m,p];
#vincolo su coerenze quantità prodotte per ogni prodotto
subject to integrity{l in L,p in P}:
  sum{m in M:ml[m,l] = 1} x[m,p] = y[p];
#OBIETTIVO
maximize z: sum{p in P} y[p] * c[p];
########
data;

#Le macchine sono 6, per 3 lavorazioni diverse. I tipi di prodotti sono 7.
param nM := 6;
param nL := 3;
param nP := 7;

param ml:   1   2   3:=
   1        1   0   0
   2        1   0   0
   3        0   1   0
   4        0   0   1
   5        0   0   1
   6        0   0   1;

param c:=
    1            23
    2            31
    3            30
    4            28
    5            25
    6            26
    7            32;

param t:     1    2    3    4    5    6    7:=
1           120  125  180  230  230  120  120
2            80   95  110  150  150   90   90
3            50   45  190  100  100  130  130;

end;
