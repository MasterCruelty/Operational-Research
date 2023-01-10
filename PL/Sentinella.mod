#Esercizio prigioniero e Sentinella(Catena di Markov)

#Un prigioniero è riuscito a rbuare la chiave della sua cella e vuole tentare la fuga.
#Vi è una sentinella che pattuglia giorno e notte il perimetro.
#Il carcere è quadrato con 4 porte orientate nei 4 punti cardinali.
#La sentinella passeggia casualmente lungo il perimetro, ogni tanto inverte la direzione.
#È nota una tabella che ci dice con che frequenza la sentinella si muove da un lato all'altro.
#Obiettivo: decidere quale porta è migliore(probabilità minore di essere scoperto)

#Commento:
#Problema del tipo Catene di Markov
#I 4 punti considerati come un grafo
#Le variabili sono date dalle probabilità di essere in tali stati

#DATI
set S;              #Insieme dei punti cardinali
param freq{S,S};    #Tabella delle frequenze

#VARIABILI
var p{S} >= 0;

#VINCOLI

#vincolo sulla normalizzazione della probabilità
subject to normal:
        sum{i in S} p[i] = 1;

#Vincolo sul bilanciamento(somma delle entrate e somma delle uscite dagli stati)
subject to balancer {j in S}:
        sum{i in S} freq[i,j] * p[i] = sum{k in S} freq[j,k]*p[j];

data;

set S:= N E S O;

param freq: N   E   S   O:=
N           0   .40 0   .60
E           .20 0   .80 0
S           0   .50 0   .50
O           .75 0   .25 0;

end;
