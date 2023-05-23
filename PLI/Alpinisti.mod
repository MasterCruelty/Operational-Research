#Esercizio Alpinisti

/*
  * Un comandante deve scegliere i componenti di un numero di squadre per un'azione alpinistica coordinata.
  * Ogni squadra sarà composta da un noto numero di alpinisti e dovrà attaccare una montagna diversa.
  * Ogni squadra deve avere un noto numero di skills.
  * Ogni candidato ha in misura maggiore o minore delle skills note.
  * Le skills devono essere quindi distribuite e combinate in modo opportuno nelle squadre.
  * Le skills sono valutate da 1 a 5 e sono di 3 tipi diversi.
  * Si vuole che le valutazioni complessive dei componenti di ogni squadra siano maggiori o uguali a un valore noto soglia per ogni skill.
  * Inoltre l'impiego di ogni alpinista comporta un rischio in caso di incidente. 
  * Si vuole quindi scegliere l'insieme che minimizza la somma degli indici di rischio individuali.
  ***********************************************
  * Commento sul testo:
  * Si tratta di un problema di assegnamento dove bisogna scegliere quali alpinisti assegnare a quali squadre.
  * Inoltre bisogna tenere conto dei vincoli sulle skills e minimizzare il rischio complessivo delle squadre.
*/

#DATI
param nA;           #numero degli alpinisti
set A := 1..nA;     #insieme degli alpinisti
param nS;           #numero delle skill
set S:= 1..nS;      #insieme delle skill
param nSQ;          #numero delle squadre da comporre
set SQ := 1..nSQ;   #insieme delle squadre da comporre
param skill{A,S};   #matrice delle skill per ogni alpinista
param size;         #numero di alpinisti per ogni squadra
param risk{A};      #indice di rischio per ogni alpinista
param soglia{S};    #requisiti soglia per ogni skill

#VARIABILI
var x{A,SQ} binary;  #assegnamento degli alpinisti alle squadre

#VINCOLI
#vincoli di assegnamento ogni alpinista assegnato una sola volta
subject to assign{a in A}:
     sum{sq in SQ} x[a,sq] <= 1;
#vincoli sulla grandezza delle squadre
subject to size_squad{sq in SQ}:
     sum{a in A} x[a,sq] = size;
#vincoli sulle skills
subject to skills_req{sq in SQ,s in S}:
     sum{a in A} skill[a,s] * x[a,sq] >= soglia[s];
#OBIETTIVO  
#minimizzare somma degli indici di rischio individuali per ogni squadra composta.
minimize z: sum{a in A,sq in SQ} risk[a] * x[a,sq];
###########
data;

param nA := 20;
param nS := 3;
param nSQ := 4;
param size := 4;

param skill:  1  2  3:=
 1            3  2  5
 2            3  2  5
 3            4  5  4
 4            4  5  5
 5            2  4  4
 6            1  4  4
 7            2  5  3
 8            5  5  3
 9            4  5  4
10            5  3  5
11            3  2  5
12            3  5  4
13            4  5  5
14            4  5  4
15            5  4  2
16            5  4  2
17            5  4  3
18            3  1  4
19            4  3  5
20            5  5  4;


param risk:=
 1              0.21
 2              0.15
 3              0.12
 4              0.11
 5              0.12
 6              0.14
 7              0.08
 8              0.10
 9              0.05
10              0.19
11              0.13
12              0.01
13              0.07
14              0.15
15              0.18
16              0.16
17              0.09
18              0.08
19              0.02
20              0.10;

param soglia:=
 1         16
 2         16
 3         16;

end;
