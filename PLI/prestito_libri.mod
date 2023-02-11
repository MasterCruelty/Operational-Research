#Esercizio Prestito Libri PLI

/*
  * Vi è un nuovo sistema di prestito libri nella biblioteca.
  * Il sistema consente a ogni utente di prenotare uno o più libri specificando data di inizio e fine del prestito.
  * Ogni utente paga, non solo in denaro, ma ad esempio in punti a scalare da una donazione iniziale in proporzione della durata del prestito.
  * Bisogna risolvere eventuali conflitti tra richieste.
  * Quando due o più richieste per lo stesso libro si sovrappongono nel tempo, solo una può essere accolta.
  * Dato lo scopo di incentivare la lettura da parte degli utenti, vi sono 2 obiettivi:
  * 1. massimizzare il numero di richieste accettate.
  * 2.massimizzare la durata totale dei prestiti effettuati.
  * Si sospetta che i due obiettivi siano in conflitto tra loro, si vuole confrontare le due soluzioni ottime.
  ****************************************************
  * Risposte:
  * Nel primo obiettivo si riescono a soddisfare 26 richieste.
  * Nel secondo obiettivo si riesce a massimizzare a 180 giorni la durata dei prestiti, 
  * ma si soddisfano 22 richieste, quindi si aveva ragione a temere che i due obiettivi fossero incompatibili.
*/

#DATI
param nR;       #numero di richieste
set R:= 1..nR;  #insieme delle richieste
param s{R};     #giorno inizio prestito
param e{R};     #giorno fine prestito
param libro{R}; #libro richiesto

#VARIABILI
var x{R} binary;       #scelta della richiesta da soddisfare
var tot_prestati >= 0 integer;      #var ausiliaria per z2 per controllare in fretta il numero di libri prestati
#VINCOLI
#vincolo di incompatibilità tra richieste
subject to incompat{r1 in R,r2 in R:(r1<>r2) and (e[r2] >= s[r1]) and (e[r1] >= s[r2]) and (libro[r1]=libro[r2])}:
   x[r1] + x[r2] <=1;

#vincolo per definire tot_prestati
subject to def_totale_prestati:
   tot_prestati = sum{r in R} x[r];

#OBIETTIVO
#massimizzare numero richieste soddisfatte
#maximize z1: sum{r in R} x[r];
#massimizzare durata complessiva prestiti
maximize z2: sum{r in R} (e[r]-s[r]+1) * x[r];


data;

param nR :=40;

param:  s   e   libro:=
1       1   4   2
2       1   6   1
3       1   10  2
4       1   5   3
5       1   7   3
6       2   25  6
7       2   12  1
8       2   10  1
9       3   15  3
10      3   17  4
11      3   6   4
12      4   20  5
13      6   12  3
14      6   9   2
15      7   15  1
16      7   14  4
17      8   13  1
18      10  15  2
19      11  18  1
20      13  22  2
21      15  22  1
22      17  40  2
23      18  40  5
24      22  24  5
25      23  25  1
26      23  30  7
27      24  42  6
28      25  27  2
29      25  28  5
30      25  31  7
31      26  27  1
32      28  31  1
33      28  31  2
34      30  33  5
35      32  39  7
36      32  34  1
37      35  37  2
38      35  39  5
39      35  42  1
40      36  41  5;

end;
