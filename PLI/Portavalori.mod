#Esercizio portavalori

/*
  *Si hanno a disposizione alcuni furgoni con capacità in KG e costo orario €/h.
  *Si hanno a disposizione diverse guardie giurate con diverso costo orario €/h e velocità di caricamento KG/h.
  *È nota la quantità in KG da trasportare.
  *Si vuole minimizzare il costo totale dato dal costo dei furgoni e del personale, 
  *il quale è dato dal tempo impiegato per il viaggio e il caricamento.
  *******************************************************
  *L'effetto di utilizzare una variabile n è quello di ripartire Q in tante quantità n[g] in modo da minimizzare
  *il massimo rapporto n[g] /vel[g].
*/

#DATI
param nF;
set F:=1..nF;	#insieme dei furgoni
param nG;
set G:=1..nG;	#insieme delle guardie
param T;		#tempo fisso di viaggio [h]
param Q;		#quantità da trasportare[kg]
param cap{F};	#capacità di ogni furgone[kg]
param cf{F};	#costo orario di ogni furgone[€/h]
param cg{G};	#costo orario di ogni guardia[€/h]
param vel{G};	#velocità di caricamento di ogni guardia[Kg/h]
param M:= Q / vel[3];#parametro MAxTime(rapporto tra la quantità da caricare e la minima velocità di caricamento)

#VARIABILI
var x{F} binary;		#scelta del furgone
var y{G} binary;		#scelta della guardia
var tf{F} >= 0;			#tempo impiegato per il caricamento di ogni furgone
var tg{G} >= 0;			#tempo impiegato da ogni guardia per il caricamento
var time >= 0;			#var ausiliaria per definire il tempo complessivo
var n{G} >= 0;			#quantità caricata da ogni singola guardia[kg]
#VINCOLI
#definizione variabile n
subject to def_n:
	sum{g in G} n[g] = Q;
#vincolo definizione time(min-max)
subject to def_time{g in G}:
	time >= n[g] / vel[g];
#vincolo su quantità non positiva per una guardia non utilizzata
subject to no_guardia{g in G}:
	n[g] <= Q * y[g];
#vincolo sul tempo complessivo, facendo uso dei vincoli e variabili ausiliarie introdotte
subject to time_complete1{f in F}:
	tf[f] >= time - M;
subject to time_complete2{g in G}:
	tg[g] >= time - M;
#vincolo sulla capacità dei veicoli
subject to capacity:
	sum{f in F} cap[f] * x[f] >= Q;
#vincolo su abbastanza guardie per guidare i veicoli scelti
subject to drive:
	sum{g in G} y[g] >= sum{f in F}x[f];

#OBIETTIVO
#minimizzare il costo totale dato dai costi orari dei furgoni e delle guardie(tempo di viaggio + caricamento)
minimize z: sum{f in F} (tf[f] +time * cf[f]) + sum{g in G} (tg[g] +time)*cg[g];

#############
data;

param nF:=3;
param nG:=3;
param T:= 2.5;
param Q:=3500;

param:		cap			cf:=
1         1000        19.00
2         1500        22.00
3         4000        27.00;

param:		vel			cg:=
1          600        18.00
2          700        19.50
3          500        17.00;

end;
