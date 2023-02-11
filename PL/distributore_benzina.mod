#Esercizio Distributore di benzina PL(catena di markov)

/*
  * Ad un distributore di benzina arriva mediamente un'automobile ogni minuto.
  * Gli automobilisti osservano la coda e decidono se restare o andare ad un altro distributore.
  * Se c'è già un automobilista in stazione, in media due su tre decidono di restare in coda.
  * Se ci sono già due automobilisti, in media uno su tre decide di restare in coda.
  * Se ci sono già tre automobilisti, nessuno decide di restare in coda.
  * Il rifornimento dura 5 minuti.
  * 1. Quanti automobilisti ci sono mediamente nella stazione?
  * 2. A che valore dovrebbe scendere il tempo medio di rifornimento per garantire una presenza media di non più di due automobilisti nella stazione?
  ************************************************
  * Il sistema descritto ha 4 stati da 0 a 3. Le frequenze di transizione si ricavano dal testo.
  * Il rifornimento ogni 5 minuti ci indica un valore di 1/5 quindi 0.2.
  ************************************************
  * Risposta alle due domande:
  * 1. Dopo aver risolto il sistema delle equazioni di bilanciamento ottengo queste probabilità per i 4 stati.
  * p0 = 0.0198462
  * p1 = 0.099231
  * p2 = 0.332424
  * p3 = 0.548499
  * Per ottenere il numero di veicoli mediamente presenti faccio la sommatoria per n che varia tra 0 e 3 di n che moltiplica ogni probabilità.
  * Aggiungo una variabile veicoli_medi e vincolo apposta per calcolare questo numero.
  * Il valore ottenuto è 2.40958.
  *
  * 2. In questo caso il tempo di rifornimento non è più un dato ma una variabile poiché vogliamo minimizzare il tempo medio di rifornimento.
  * Imponiamo un vincolo sul numero medio di veicoli nella stazione e infine minimizziamo il tempo medio di rifornimento.
*/

#DATI

set S := 0..3;          #insieme degli stati del sistema a catena di markov
param r := .2;          #tempo di rifornimento pari a 5 minuti ==> 1/5 = 0.2

#VARIABILI
var p{S} >= 0;          #probabilità per ogni stato del sistema
var veicoli_medi >= 0;  #numero medio di veicoli presenti nella stazione
#vincolo extra per domanda 1
subject to media_veicoli:
 veicoli_medi = sum{s in S} s*p[s];

#VINCOLI
#normalizzazione probabilità
subject to normal:
 sum{s in S} p[s] = 1;

#vincoli bilanciamento per ogni stato di transizione
#probabilità stato 1 * frequenza dello stato da 1 auto a 0 per completamento servizio = probabilità stato 0 * frequenza entra un auto con zero in stazione
subject to stato0:
 (p[1] * r) = (p[0] * 1);
#probabilità stato zero * frequenza entra un auto con zero in stazione + probabilità stato 2 * completamento servizio = probabilità stato 1 *
#completamento servizio + frequenza entra un auto quando c'è già un auto in stazione.
subject to stato1:
 (p[0] * 1) + (p[2] * r) = p[1] * .87;#(.2 + .67);
#probabilità stato 1 * entra un auto quando c'è già un auto in stazione + probabilità stato 3 * completamento servizio = probabilità stato 2 *
#completamento servizio + frequenza entra un auto quando ce ne sono già 2.
subject to stato2:
 (p[1] * .67) + (p[3] * r) = p[2] * .53;#(.2 * .33);
#probabilità stato 2 * entra un auto quando ce ne sono già 2 = probabilità stato 3 * completamento servizio.
subject to stato3:
 (p[2] * .33) = (p[3] * r);


data;


end;
