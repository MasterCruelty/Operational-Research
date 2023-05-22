#Esercizio pronto intervento

/*
  *  Ci sono un numero noto di squadre di intervento e determinati obiettivi da sorvegliare.
  *  Le squadre disponibili sono meno rispetto agli obiettivi da sorvegliare.
  *  Non tutti gli obiettivi possono essere controllati direttamente quindi.
  *  Alcuni luoghi sono obiettivi da sorvegliare, altri no.
  *  Si vuole che ogni squadra sappia dove localizzarsi e quali obiettivi le sono assegnati.
  *  l'obiettivo è che in caso d'attacco la squadra intervenga nel minor tempo possibile.
  *  Sono stimati i tempi di intervento da tutti i luoghi in cui può essere localizzata una squadra a tutti gli obiettivi.
  ***********************************
  * Commento sul testo:
  * Il problema è noto come P-center location problem. Problema di localizzazione
  * la funzione obiettivo risulta essere min-max, si deve minimizzare il massimo tempo di intervento.
*/

#DATI
param nO;		#numero degli obiettivi
set O := 1..nO;	#insieme degli obiettivi
param nS;		#numero delle squadre 
param nL;		#numero dei luoghi
set L := 1..nL;	#insieme dei luoghi
param t{L,O};	#tempo di intervento da luogo L a obiettivo O[minuti]

#VARIABILI
var x{L} binary;		#luoghi che possono ospitare le squadre di intervento(var di localizzazione)
var y{O,L} binary;		#assegnamento obiettivo - luogo
var delta >= 0;				#massimo tempo di intervento possibile

#VINCOLI
#vincolo definizione massimo tempo di intervento possibile
subject to def_delta:
	delta >= sum{l in L, o in O} y[o,l]*t[l,o];
#vincoli di assegnamento(no obiettivo assegnato se non c'è la squadra in quel luogo)
subject to assign{l in L, o in O}:
	y[o,l] <= x[l];
#vincolo sul numero di squadre disponibili
subject to Count_squadre:
	sum {l in L} x[l] = nS;
# vincolo che assicura che l'obiettivo sia in un solo luogo:
# la somma dei valori di ogni luogo, per un dato obiettivo = 1
subject to Obiettivo_assign {o in O}:
	sum {l in L} y[o,l] = 1;

#OBIETTIVO
minimize z: delta;

##########
data;

param nO:=7;
param nS:=3;
param nL := 6;

param t: 		1   2   3   4   5   6   7:=
  1            0   9   7  15   3   4   2
  2           12   0   2  14   8   4   3
  3            6   4   9   9  19  11  15
  4            5   1   8   0   6  12  17
  5            2  10  11  10   0   6  20
  6            8   7  15   5   5   0  12;

end;
