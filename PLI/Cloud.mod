#Esercizio cloud computing capacity planning

/*
  * Ci sono due tipi di server per offrire servizi cloud. Il primo è a domanda.
  * Si possono accendere e spegnere quando si vuole a seconda della necessità.
  * L'uso di un server ha un costo orario noto. Il secondo server è invece su prenotazione.
  * All'atto della prenotazione si paga un costo fisso per un anno + un costo orario molto più basso.
  * I costi di uso e prenotazione sono noti e ci sono diversi contratti possibili più o meno convenienti a seconda dell'uso.
  * Si vuole minimizzare i costi in funzione della capacità complessiva richiesta(ore di calcolo richieste in un anno)
  ******************************************
  * Il server a domanda lo tratto come particolare server su prenotazione con costo nullo per la prenotazione
  *
*/

#DATI
param nS;		#numero servizi
set S:=1..nS;	#insieme servizi
param p{S};		#costo prenotazione per ogni server[$ all'anno]
param h{S};		#costo orario per ogni server[$ all'ora]
param q;		#capacità richiesta ipotizzata[ore richieste in un anno

#VARIABILI
var x{S} >= 0;		#capacità utilizzata per ogni server[ore di calcolo in un anno]
var y{S} binary;	#necessità pagamento costo prenotazione per ogni server

#VINCOLI
#vincolo relazione tra x e y
subject to integrity{s in S}:
	x[s] <= q*y[s];
#vincolo sulla capacità richiesta ipotizzata
subject to domanda:
	sum{s in S} x[s] = q;
#OBIETTIVO
minimize z: sum{s in S} p[s]*y[s] + sum{s in S} x[s]*h[s];
##########
data;

param nS:=4;
param q:=5000;
param:	p			h:=
1		1560		0.128
2		1280		0.192
3		552			0.312
4		0			0.640;


end;
