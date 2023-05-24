#Esercizio Noleggio auto

/*
  * Il gestore di un autonoleggio riceve un insieme di richieste dalle agenzie viaggi.
  * Deve comunicare all'agenzia quali intende soddisfare e quali no.
  * Il numero di automobili disponibili è noto, sono limitate e non si possono soddisfare tutte le richieste.
  * Il profitto ricavante da ogni servizio è dato da una quota fissa + una quota proporzionale alla durata del noleggio.[gg]
  * Viene incluso sia il primo giorno che l'ultimo. È noto un insieme di richieste ricevuto dall'agenzia.[30 gg]
  * Obiettivo decidere quali richieste accettare e quali no. Qual è il massimo ricavo ottenibile?
  ************************************************
  * Commento sul testo:
  * Problema di assegnamento in cui si devono scegliere quali richieste soddisfare per massimizzare il profitto
  * Variante del problema dello zaino, abbiamo una capienza che sono le auto disponibili e vogliamo scegliere come occuparle
  * massimizzando il valore.
*/

#DATI
param c;		#numero di automobili
param qf;		#quota fissa noleggio
param qv;		#quota variabile noleggio
param nG;		#numero dei giorni
set G := 1..nG;	#insieme dei giorni
param start{G};	#giorno inizio noleggio
param ends{G};	#giorno fine noleggio
#VARIABILI
var x{G} binary;	#selezione della richiesta
#VINCOLI
#vincolo automobili disponibili
subject to cars{g in G}:
	x[g] <= c;
#vincolo di incompatibilità
subject to incomp{g1 in G,g2 in G:g1<>g2 and  ends[g1] >= start[g2]}:
	sum{g3 in G} x[g3] <= c;
#OBIETTIVO
#maximize z: sum{g in G} x[g] * ((qv*ends[g]-start[g]+1) + qf);
maximize z: sum{g in G} x[g] * ((qv*ends[g]-start[g]+1) + qf) - 1000;
##########
data;

param c:=5;
param qf:=20;
param qv:=40;
param nG:=31;

param: 		start	ends:=
	1		2		5
	2		2		10
	3		2		12
	4		2		13
	5		3		8
	6		3		24
	7		5		7
	8		5		15
	9		7		12
	10		7		14
	11		7		28
	12		10		15
	13		12		19
	14		14		26
	15		14		30
	16		16		20
	17		16		27
	18		16		33
	19		18		30
	20		21		22
	21		21		26
	22		25		25
	23		25		26
	24		25		30
	25		28		30
	26		29		34
	27		29		35
	28		30		30
	29		30		32
	30		30		34
	31		30		35;

end;
