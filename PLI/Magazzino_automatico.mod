#Esercizio Magazzino Automatico(Febbraio 2022)

#Un magazzino automatico è fatto da una matrice rettangolare di celle di uguale dimensione.
#ogni cella contiene un box con dei materiali.
#Una delle posizioni nella matrice è denominata 'origine' e non contiene materiali ma fa da interfaccia con l'esterno.
#Si tratta della posizione da cui devono essere prelevati i box che vengono immessi nel magazzino 
#e a cui devono essere portati i box che devono uscire dal magazzino.
#Un carrello può muoversi in linea retta da qualsiasi posizione a qualsiasi altra, prelevare un box o consegnare un box.
#Il carrello ha capacità pari a 2 box.
#è noto un insieme di ordini di prelievo e un insieme di ordini di consegna.
#I primi richiedono l'estrazione di un box dal magazzino, i secondi l'inserimento di un box nel magazzino.
#Ciascun ordine può essere soddisfatto accedendo a una data posizione.
#Le posizioni associate agli ordini sono tutte diverse tra loro.
#Gli ordini possono essere soddisfatti in qualsiasi sequenza ed il carrello può soddisfare sia ordini di consegna che prelievo...
#...tra due visite consecutive all'origine.
#Se nello stesso viaggio il carrello esegue sia consegne che prelievi, le consegne hanno priorità sui prelievi.
#obiettivo: pianificare i movimenti del carrello per minimizzare la distanza complessivamente percorsa per occuparsi degli ordini.

#DATI
param nR;			#numero di righe
param nL;			#numero di colonne
param o;			#posizione origine
param dimh;			#dimensione orizzontale[m]
param dimv;			#dimensione verticale[m]
param nP;			#numero prelievi
param nC;			#numero consegne
set P:= 1..nP;		#insieme prelievi
set D:=1..nC;		#numero consegne
param sitoP{P};		#siti di prelievi
param sitoD{D};		#siti di consegna

#dati ausiliari
param rowP{p in P}:=(sitoP[p]-1 div nC)+1;
param rowD{d in D}:=(sitoD[d]-1 div nC)+1;
param colP{p in P}:=(sitoP[p]-1 mod nC)+1;
param colD{d in D}:=(sitoD[d]-1 mod nC)+1;
param row0 := (o-1 div nC)+1;
param col0 := (o-1 mod nC)+1;
#(sito-1 div nC)+1 = row(0..nR-1)
#(sito-1 mod nC)+1 = col(0..nC-1)

param doP{p in P} :=sqrt((dimh*(col0-colP[p]))^2+(dimv*(row0-rowP[p])^2));
param doD{d in D} :=sqrt((dimh*(col0-colD[d]))^2+(dimv*(row0-rowD[d])^2));
param dPo{p in P} :=sqrt((dimh*(col0-colP[p]))^2+(dimv*(row0-rowP[p])^2));
param dDo{d in D} :=sqrt((dimh*(col0-colD[d]))^2+(dimv*(row0-rowD[d])^2));
param dPP{p1 in P,p2 in P} :=sqrt((dimh*(colP[p1]-colP[p2]))^2+(dimv*(rowP[p1]-rowP[p2])^2));
param dDP{d in D,p in P} :=sqrt((dimh*(colP[p]-colD[d]))^2+(dimv*(rowP[p]-rowD[d])^2));
param dDD{d1 in D,d2 in D} :=sqrt((dimh*(colD[d1]-colD[d2]))^2+(dimv*(rowD[d1]-rowD[d2])^2));

#VARIABILI
#Le variabili in questo esercizio rappresentano i percorsi se immaginiamo il cammino del carrello come al cammino in un grafo
var xoP{P} binary;
var xoD{D} binary;
var xPo{P} binary;
var xDo{D} binary;
var xPP{p1 in P,p2 in P:p1<>p2} binary;
var xDP{D,P} binary;
var xDD{d1 in D,d2 in D:d1<>d2} binary;

#VINCOLI
#ogni ordine deve essere soddisfatto vincoli di grado su prelievi e consegne
subject to SoddisfattoINP{p in P}:
	sum{p2 in P:p2<>p} xPP[p2,p] + sum{d in D} xDP[d,p] + xoP[p] = 1;
subject to SoddisfattoOUTP{p in P}:
	sum{p2 in P:p2<>p} xPP[p,p2] + xPo[p] = 1;

subject to SoddisfattoIND{d in D}:
	sum{d2 in D:d2<>d} xDD[d2,d] + xoD[d] = 1;
subject to SoddisfattoOUTD{d1 in D}:
	sum{d2 in D:d2<>d1} xDD[d1,d2] + sum{p in P} xDP[d1,p] + xDo[d1] = 1;

#no terne P
subject to No3P{p1 in P,p2 in P, p3 in P:p1<p2 and p2<p3}:
	xPP[p1,p2] + xPP[p2,p3] + xPP[p1,p3] +
	xPP[p2,p1] + xPP[p3,p2] + xPP[p3,p1] <= 1;

#no terne D
subject to No3D{d1 in D,d2 in D, d3 in D:d1<d2 and d2<d3}:
	xDD[d1,d2] + xDD[d2,d3] + xDD[d1,d3] +
	xDD[d2,d1] + xDD[d3,d2] + xDD[d3,d1] <= 1;

#OBIETTIVO
#minimizzare distanza complessiva
minimize z: sum{p in P} (xoP[p]*doP[p] + xPo[p] * doP[p]) + 
			sum{d in D} (xoD[d]*doD[d] + xDo[d] * doD[d]) + 
			sum{p1 in P,p2 in P:p1<>p2} (xPP[p1,p2]*dPP[p1,p2]) + 
			sum{d1 in D,d2 in D:d1<>d2} (xDD[d1,d2]*dDD[d1,d2]) + 
			sum{p in P,d in D} (xDP[d,p]*dDP[d,p]);
######
data;
param nR:= 5;
param nL:=13;
param o:= 33;
param dimh:=1;
param dimv:=0.6;
param nP:=7;
param nC:=9;


param sitoD:=
1			24		
2			39			
3			12
4			60
5			48
6			49
7			42
8			19
9			5;

param sitoP:=
1			38
2			26
3			11
4			9
5			63
6			18
7			55;
end;
