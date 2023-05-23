#Esercizio arbitri

/*
  * È noto un calendario delle partite ed è noto un insieme di arbitri disponibili.
  * Si vuole assegnare un arbitro ad ogni partita. Lo stesso arbitro non può arbitrare più di una partite nella stessa giornata.
  * Ogni partita ha bisogno di un solo arbitro.
  * Si vuole che il numero complessivo di volte che ogni arbitro viene assegnato ad ogni squadra sia il più uniforme possibile.
  * Ovvero si vuole minimizzare la differenza tra il massimo ed il minimo numero di volte che uno degli arbitri viene assegnato
  * ad una delle squadre nell'arco di tutto il campionato.
  *****************************************************
  * Commento sul testo:
  * Il problema da luogo a un modello matematico di assegnamento, quindi ci saranno in gioco variabili binarie. PLI quindi.
  * Saranno tante quanti sono gli arbitri e le partite a cui assegnarli.
  * La funzione obiettivo invece è un min max e max min messi insieme dovendo minimizzare il valore assoluto della differenza
  * del numero di volte che uno degli arbitri viene assegnato a una squadra.
*/

#DATI
param nA;			#numero degli arbitri
set A := 1..nA;		#insieme degli arbitri
set S;				#insieme delle squadre
param nG;			#numero delle giornate
set G := 1..nG;		#insieme delle giornate
param nP;			#numero delle partite per giornata
set P := 1..nP;		#insieme delle partite
param cal{G,P,S};	#calendario delle partite

#VARIABILI
#assegnamento di arbitri per ogni giornata e partita
#Vale 1 sse l'arbitro a in A viene assegnato alla partita p in P della giornata g in G
var x{G,P,A} binary;
var lower;
var upper;
#VINCOLI
#vincoli di assegnamento ad ogni partita un solo arbitro
subject to assign{g in G, p in P}:
	sum{a in A} x[g,p,a] = 1;
#vincoli di assegnamento: arbitro assegnato a una sola partita per giornata
subject to assign2{a in A, g in G}:
	sum{p in P} x[g,p,a] <= 1;
#numero di volte che un arbitro viene assegnato a una squadra s
#massimo e minimo
subject to def_lower{a in A,s in S}:
	lower <= sum{g in G, p in P} cal[g,p,s] * x[g,p,a];
subject to def_upper{a in A,s in S}:
	upper >= sum{g in G, p in P} cal[g,p,s] * x[g,p,a];
#OBIETTIVO
minimize z: upper - lower;

############
data;

param nA := 3;
param nG := 5;
param nP := 3;
set S := A B C D E F;

param cal:=
[1,*,*]: 	A	B	C	D	E	F:=
1			1	0	0	0	0	1
2			0	1	0	0	1	0
3			0	0	1	1	0	0

[2,*,*]:	A	B	C	D	E	F:=
1			1	0	0	1	0	0
2			0	1	0	0	0	1
3			0	0	1	0	1	0

[3,*,*]:	A	B	C	D	E	F:=
1			1	1	0	0	0	0
2			0	0	1	0	0	1
3			0	0	0	1	1	0

[4,*,*]: 	A	B	C	D	E	F:=
1			1	0	0	0	1	0
2			0	1	1	0	0	0
3			0	0	0	1	0	1

[5,*,*]: 	A	B	C	D	E	F:=
1			1	0	1	0	0	0
2			0	1	0	1	0	0
3			0	0	0	0	1	1;


#Si consideri il caso con 3 arbitri e con 4 arbitri.


end;
