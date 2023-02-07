#Esercizio cavallo pazzo(catena di markov)

/*
  *Su una scacchiera di 4x4 caselle, c'è un cavallo pazzo. Ad ogni mossa salta
  *secondo le regole degli scacchi con una probabilità uguale per ciascuna mossa
  *possibile: se ha due mosse possibili, ciascuna ha probabilità 1/2; se ne ha tre,
  *ognuna ha probabilità 1/3 e cos`i via.
  **************************
  *1. Dopo un grande numero di mosse (quando l’effetto della posizione iniziale non conta più), 
  *qual è la probabilità di trovare il Cavallo nella casella in basso a sinistra?
  *2. Qual è la probabilità di trovarlo in una qualsiasi delle quattro caselle centrali?
  *********************************
  *Commento sul testo:
  *Sfruttando la simmetria, invece di avere un sistema con 16 stati, ci riduciamo a 3 stati: angolo, centrale e laterale.
  *Se sono in angolo, posso saltare in due modi e in entrambi finisco in centrale.
  *Se sono in laterale, posso saltare in tre modi: in due vado in laterale e in uno in centrale.
  *Se sono in centrale, posso saltare in quattro modi: in due vado in angolo, negli altri due in laterale.
  *Con queste informazioni, possiamo costruire una matrice delle frequenze per ogni stato.
*/

#DATI
#set S := Angolo Laterale Centrale ;   #insieme degli stati
#param freq{S,S};                     #matrice delle frequenze
/*param freq:  Angolo Laterale Centrale:=
Angolo                   .            .        1
Centrale                .          .67      .33
Laterale                .50      .50         .
;*/

#VARIABILI
var pA >= 0;     #probabilità di essere in casella angolo
var pL >= 0;     #probabilità di essere in casella centrale
var pC >= 0;     #probabilità di essere in casella laterale
#VINCOLI
#normalizzazione delle probabilità
subject to normal:
  pA + pL + pC = 1;
#vincoli di bilanciamento delle probabilità
subject to balPA:
  pA = (0 * pA) + (0*pL) + (.50 * pC);
subject to balPL:
  pL = (0 *pA) + (.67 *pL) + (.50 *pC);
subject to balPC:
  pC = (1 *pA) + (.33 *pL) + (0*pC);
###########
data;


end;
