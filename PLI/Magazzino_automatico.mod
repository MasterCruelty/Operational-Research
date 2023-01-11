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



######
data;

Il magazzino è una matrice con 13 colonne e 5 righe.
Le posizioni sono da 1 a 65 per righe: riga 1 da 1 a 13, riga 2 da 14 a 26,etc.etc.
Origine in posizione 33, cioè riga 3 e colonna 7.
Dimensioni di ogni cella della matrice: in orizzontale 1 metro e in verticale 0.6 metri.

consegna	sito	
1			24		
2			39			
3			12
4			60
5			48
6			49
7			42
8			19
9			5;

prelievo	sito
1			38
2			26
3			11
4			9
5			63
6			18
7			55;
end;
