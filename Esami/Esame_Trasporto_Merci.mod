#Esercizio trasporto merci(Maggio 2023)

/*
  *In una rete logistica vengono trasportate due diverse tipologie di merce.
  *La rete è composta da hub, collegati tra loro su gomma o via nave.
  *Di ogni collegamento tra due hub è nota la quantità  massima trasportabile per ogni mese.
  * I costi unitari di trasporto sono in generale diversi per le due tipologie di merce su ogni tratta
  *Le merci hanno origine da due stabilimenti e confluiscono in un unico hub di destinazione.
  *Si vuole quindi trovare il mix ottimale delle due tipologie che consenta di minimizzare i costi di trasporto complessivi.
  * PROBLEMA DI PLI --> FLUSSO OTTIMO
  * convenzione nomenclatura => hs: hub partenza; hd: nodo arrivo;
*/

#DATI
param nP;					#numero prodotti
set P:=1..nP;				#insieme prodotti
set H;						#insieme degli hub
set A within H cross H;		#insieme degli archi
param cu1{A};				#costo unitario trasporto merce tipo 1 per ogni arco
param cu2{A};				#costo unitario trasporto merce tipo 2 per ogni arco
param maxPeso{A};			#massima quantità trasportabile su ogni arco
param qs1{P};				#quantità merce disponibile da hub sorgente 1
param qs2{P};				#quantità merce disponibile da hub sorgente 2
#VARIABILI
var x{P,A} >= 0 integer;	#quantità di prodotto p che trasporto da hub i a hub j

#VINCOLI
# La quantità  di prodotto p che entra in un nodo deve essere uguale alla quantità  di prodotto che esce da quel nodo
subject to Flow {h in H, p in P : h<>'s1' and h<>'s2' and h<>'t'}:
	sum{hs in H: (hs,h) in A} x[p, hs, h] = sum{hd in H: (h,hd) in A} x[p, h,hd];
# La somma delle quantità  di prodotti in un nodo deve essere minore o uguale al valore imposto maxPeso
subject to peso{hs in H,hd in H:(hs,hd) in A}:
	x[1,hs,hd] + x[2,hs,hd] <= maxPeso[hs,hd];
# vincolo sulla quantità di merce di tipo 1 disponibile in partenza dall'hub s1
subject to capacitys1P1:
	sum{hd in H: ('s1',hd) in A} x[1, 's1', hd] <= qs1[1];
# vincolo sulla quantità di merce di tipo 2 disponibile in partenza dall'hub s1
subject to capacitys1P2:
	sum{hd in H: ('s1',hd) in A} x[2, 's1', hd] <= qs1[2];
# vincolo sulla quantità di merce di tipo 1 disponibile in partenza dall'hub s2
subject to capacitys2P1:
	sum{hd in H: ('s2',hd) in A} x[1, 's2', hd] <= qs2[1];
# vincolo sulla quantità di merce di tipo 2 disponibile in partenza dall'hub s2
subject to capacitys2P2:
	sum{hd in H: ('s2',hd) in A} x[2, 's2', hd] <= qs2[2];


#OBIETTIVI
#massimizzare il flusso di merce trasportato dalle sorgenti alla destinazione
#maximize flusso:sum{hs in H:(hs,'t') in A}(x[1,hs,'t'] + x[2,hs, 't']);

#minimizzare i costi complessivi mantenendo il valore di massimo flusso ottenuto dalla f.o. "flusso" (18)
minimize costi: sum{hs in H:(hs,'t') in A} x[1,hs,'t'] * cu1[hs,'t'] + 
                sum{hs in H:(hs,'t') in A} x[2,hs,'t'] * cu2[hs,'t'];
# impongo che il flusso rimanga uguale al valore ottimo della f.o "flusso"
subject to MaxFlow:
	sum{hs in H:(hs, 't') in A}(x[1,hs, 't'] + x[2, hs, 't']) = 18;

############
data;

param nP := 2;
set H := s1 s2 1 2 3 4 t;

set A := 
(s1, 1)
(s2, 1)
(s2, 2)
(1, 2)
(1, 4)
(2, 3)
(3, 4)
(3, t)
(4, t);

param cu1 :=
s1, 1	2
s2, 1	4
s2, 2 	6
1, 2	8
1, 4	3
2, 3	3
3, 4	6
3, t	3
4, t	2;

param cu2 :=
s1, 1	3
s2, 1	1
s2, 2	5
1, 2	8
1, 4	2
2, 3	2
3, 4	5
3, t	3
4, t	2;

param maxPeso :=
s1, 1	11
s2, 1	 2
s2, 2	 9
1, 2	 9
1, 4	 6
2, 3	13
3, 4	 4
3, t	 8
4, t	12;

param qs1 :=
1	6
2	5;

param qs2 :=
1	4
2	7;

end;
