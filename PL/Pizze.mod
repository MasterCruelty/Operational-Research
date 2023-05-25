#Esercizio Pizze

/*
  * Per festeggiare il superamento dell'esame di Ricerca Operativa,
  * due amici vanno in pizzeria e ordinano 3 pizze diverse affamati per l'immane sforzo compiuto.
  * Entrambi danno diversi valori di gradimento percentuale alle tre pizze. I valori sono noti
  * Si vuole dividere le pizze in modo che entrambi siano il più contenti possibile.
  * Considerare i seguenti casi/obiettivi:
  * - Senza vincoli sulla quantità di pizza mangiata da ciascuno.
  * - Con il vincolo che ciascuno mangi l'equivalente di una pizza e mezzo.
  *********************************************
  * Commento sul testo:
  * Sembra una variante del mix produttivo ottimale PL in cui il profitto da massimizzare
  * è la contentezza dei due amici. Ho dei prodotti e un indice di gradimento per ciascuno di essi 
  * e per ogni amico.
*/

#DATI
set A:= 1..2;       #insieme degli amici
set P;              #insieme delle pizze
param g{A,P};       #tabella di gradimento per ogni amico e ogni pizza[%]
#VARIABILI
var x {A,P} >= 0;     #frazione di pizza per ogni amico
var c{A} >= 0;        #valore di contentezza di ogni amico
#VINCOLI
#vincolo sul distribuire tutta la quantità di pizza
subject to eat_all{p in P}:
 sum{a in A} x[a,p] = 1;
#definizione contentezza
subject to def_contentezza{a in A}:
 c[a] = sum{p in P} x[a,p] * g[a,p];

 
#OBIETTIVO
#massimizzare la contentezza dei due amici
maximize z: sum{a in A} c[a];
############
data;

set P := Formaggi Salumi Verdure;

param g:    Formaggi   Salumi  Verdure:=
  1         0.3         0.5     0.2
  2         0.7         0.2     0.1;


end;
