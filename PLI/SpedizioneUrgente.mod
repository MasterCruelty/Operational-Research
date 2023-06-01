#Esercizio spedizione urgente

/*
  * Bisogna inviare materiale di primo soccorso: tende attrezzi e medicinali.
  * La spedizione avviene per via aerea per motivi di tempestività.
  * Vi sono regolamenti rigidi sulla massima quantità di merce trasportabile sui velivolo in ogni viaggio.
  * Sia il volume che il peso delle merci spedite sono limitate da valori imposti per legge.
  * Sono disponibili due voli. Le quantità in eccesso verranno trasportate via nave con tempi maggiori.
  * Bisogna trovare il modo migliore di effettuare la spedizione ripartendo gli imbali sui due voli.
  * Così da minimizzare il numero di imballi che dovranno viaggiare via nave.
  * A parità di numero di imballi spediti, si dovrà anche minimizzare il costo complessivo delle spedizioni aeree.
  * I due voli hanno costo fisso + costo variabile proporzionale al peso e volume della merce caricata.
  *********************************************
  * Si tratta di un problema dello zaino con minimizzazione dei costi oltre al numero di oggetti fuori zaino.
  * Gli zaini sono 2.
  * Risposte: Minimizzando il numero di imballi non spediti via aereo, il risultato è 11, quindi solo 1 imballo verrà spedito via nave.
  * A parità di imballi spediti via aereo(11), il costo minimo risulta essere
*/

#DATI
param nI;			#numeri di imballi
set I := 1..nI;		#insieme degli imballi
param nV;			#numero di voli
set V:=1..nV;		#insieme dei voli
param vol{I};		#volume di ogni imballo[mq]
param p{I};			#peso di ogni imballo[kg]
param pmax{V};		#peso massimo per ogni volo[kg]
param volmax{V};	#volume massimo per ogni volo[mq]
param cf{V};		#costo fisso per ogni volo[€]
param cvP{V};		#costo variabile per ogni volo sul peso[€/kg]
param cvV{V};		#costo variabile per ogni volo sul volume[€/mq]
#VARIABILI
var x{I,V} binary;		#quale imballo va su quale volo
#VINCOLI
#vincolo su peso massimo per ogni volo
subject to peso{v in V}:
	sum{i in I} x[i,v] * p[i] <= pmax[v];
#vincolo su volume massimo per ogni volo
subject to volumeMax{v in V}:
	sum{i in I} x[i,v] * vol[i] <= volmax[v];
#vincolo assegnamtno, un imballo su un volo non può essere anche sull'altro volo
subject to assign{i in I,v1 in V,v2 in V: v1<>v2}:
	x[i,v1] + x[i,v2] <= 1;
#OBIETTIVO
#minimizzare i costi di viaggio aereo
minimize z1: sum{i in I,v in V} x[i,v] * cf[v] + sum{i in I,v in V} x[i,v] * (p[i] *cvP[v] + vol[i] * cvV[v]);
#vincolo sul spedire almeno 11 imballi come da soluzione di z2
subject to minspedizione:
	sum{i in I,v in V} x[i,v] = 11;
#minimizzare gli imballi non caricati ==> massimizzare gli assegnamenti(risultato 11)
#maximize z2: sum{i in I,v in V} x[i,v];
##########
data;

param nI := 12;
param nV :=2;

param:		p		vol:=
   1      400      9
   2      250     12
   3       70      8
   4     1000     20
   5      550     15
   6      810     25
   7      320     15
   8      125     26
   9      480     18
  10      225      4
  11      250      3
  12      400     23;

param: pmax		volmax		cf				cvP			cvV:=
  1    2900        90        2.0             8           2
  2    1950       100        1.5             5           3;

end;
