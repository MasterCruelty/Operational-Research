#Esercizio camerieri

/*
  * Il gestore di un ristorante ha osservato che il numero di clienti varia a seconda del giorno.
  * Dal numero di clienti dipende il minimo numero di camerieri necessari a garntire un buon servizio.
  * Il minimo numero di camerieri richiesto per ogni giorno della settimana è noto.
  * I turni di lavoro dei camerieri possono iniziare in qualunque giorno e durano 4 giorni consecutivi.
  * Un cameriere che inizia Giovedì, lavora fino a domenica.
  * Un cameriere che inizia Sabato, lavora fino a martedì.
  * Domanda 1: minimo numero di camerieri necessario per soddisfare il fabbisogno e quali giorno per i turni.
  * Domanda 2: considerare il caso in cui lavorano 5 giorni consecutivi anzichè 4.
  * Domanda 3: Se si pagano i camerieri 80€ al giorno per 4 giorni consecutivi oppure 75 per 5 giorni, quale
  *                     soluzione ha costo minimo?
*/

#DATI
param nG;
set G := 0..nG-1;         #insieme dei giorni della settimana
param nc{G};            #numero di camerieri per giorno della settimana
param turno;            #durata del turno
param costo;            #costo di ogni cameriere[€ al giorno]
param turno2;           #durata del turno per la domanda 2
param costo2;           #costo di ogni cameriere per la domanda 2[€ al giorno]
#VARIABILI
var x{G} >= 0 integer;     #numero di camerieri che iniziano il turno nel giorno g in G

#VINCOLI
#vincolo sulla domanda di camerieri per ogni giorno
#subject to disponibili1 {g in G}:
#	x[g] + sum {r in 1..turno-1} x[(g-r) mod nG] >= nc[g];
#vincolo sulla domanda di camerieri nel caso del turno di 5 giorni (solo uno dei due vincoli non commentato se no non funziona)
subject to disponibili2 {g in G}:
	x[g] + sum {r in 1..turno2-1} x[(g-r) mod nG] >= nc[g];
#OBIETTIVO
#minimize z3: sum{g in G} x[g] * costo * turno; 
minimize z4: sum{g in G} x[g] * costo2 * turno2;
#########
data;

param nG:=7;
param turno := 4;
param costo:=80;
param turno2 := 5;
param costo2 := 75;
param nc:=
 0        4
 1        5
 2        5
 3       10
 4       12
 5       12
 6        2;

end;
