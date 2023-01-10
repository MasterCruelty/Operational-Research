#Esercizio pianificazione multiperiodo

#Bisogna pianificare produzione di gelati per i mesi di Giugno, Luglio, Agosto e Settembre.
#Il responsabile delle vendite chiede che siano disponibili 200,300,500 e 400 ton per mese da mettere sul mercato.
#La capacità produttiva varia tra i 4 mesi.
#prezzi per la produzione di ogni mese noti.
#costi stoccaggio noti (€ / kg)
#Obiettivo: pianificare quantità di gelato da produrre in ciascuno dei 4 mesi estivi.

#I mesi sono stati trascritti come gli interi da 1 a 4

#DATI
set M:=1..4;
param domanda{M}; #gelato da rendere disponibile nei 4 mesi da mettere sul mercato[Ton]
param cap_prod{M};#Capacità produttiva dei gelati nei 4 mesi [Ton]
param prezzo{M};  #prezzo per ogni mese [€ / Ton]
param c_unitario{M}; #costo di stoccaggio gelato eccedente [€ / Ton]
param s0;			#stock iniziale[Ton]

#VARIABILI
var x{m in M} >= 0, <= cap_prod[m]; #quantità di gelato prodotto per mese[Ton ]
var s{M} >= 0; #quantità di gelato invenduto a fine mese [Ton]

#VINCOLI

#vincolo sulla conservazione del flusso [Ton]
subject to flow_conservation{i in M:i>1}:
	s[i-1] + x[i] = domanda[i] + s[i];
subject to first_period:
	s0 + x[1] = domanda[1] + s[1];


#OBIETTIVO
#minimizzare i costi [€]
minimize z: sum {m in M} (prezzo[m]*x[m] + c_unitario[m]*s[m]);

data;
param s0 := 0;


param:	domanda		cap_prod		prezzo			c_unitario:=
1		200			400				34				2000
2		300			500				36				3000
3		500			300				32				2000
4		400			500				38				3000;

end;
