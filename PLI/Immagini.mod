#Esercizio Immagini da Satellite

#Un satellite può eseguire osservazioni di porzioni della superficie terrestre immagazzinando le immagini sotto forma di files.
#I files sono in una memoria di bordo e vengono ritrasmessi a terra successivamente.
#Le immagini vengono acquisite a pagamento per conto di utenti che avanzano le proprie richieste in anticipo.
#In seguito, avviene una fase di pianificazione delle attività del satellite, durante la quale, alcune delle richieste sono messe in piano
#e altre invece no. Non è detto sia possibile soddisfare tutte le richieste perché alcune possono sovrapporsi.
#Per ogni richiesta sono noti gli istanti di inizio e di fine per l'acquisizione dell'immagine.
#Il tempo disponibile per l'acquisizione delle immagini è limitato, non si può acquisire più immagini di quante se ne possono trasmettere
#a terra. Il tempo necessario per ogni immagine è noto.
#Obiettivo: ogni immagine ha un valore economico, quindi massimizzare il ricavo complessivo che si ottiene dalle immagini acquisite.

#Domande extra:
#1.Se il tempo disponibile per la trasmissione a terra venisse allungato, sarebbe conveniente farlo? In che misura e con quale 
#miglioramento rspetto a prima?
#2.Supponendo alcune richieste non in conflitto tra loro debbano essere soddisfatte per forza per motivi di emergenza,
#di quanto peggiorerebbe il valore ottimo del ricavo?

#È una variante del problema dello zaino. Il vincolo aggiuntivo è la compatibilità tra immagini per gli istanti di acquisizione

#Risposte domande extra:
#1.Aumentando il tempo ovviamente potremmo acquisire più immagini, ma servirebbe un'analisi
#parametrica accurata da svolgere a mano in quanto il solutore da solo non riesce a farlo.
#Dovremmo spostare appena al di là della soluzione ottima e verificare di quanto si guadagna.
#2. Il valore ottimo senza le immagini forzate è di 5878. Introducendole scendiamo a 4924.


#DATI

param nI;			#Numero delle immagini
set I:=1..nI;		#Insieme delle immagini
param init{I};		#Istante iniziale acquisizione[Sec]
param ends{I};		#Istante finale acquisizione[Sec]
param tempo_richiesto{I};#Tempo richiesto per la trasmissione di ogni immagine[Sec]
param valore{I};		 #Valore economico per ogni immagine[€]
param tempo_budget;
set forzate within I;

#VARIABILI
var x{I} binary;		#Selezione dell'immagine

#VINCOLI
#Vincolo sul tempo disponibile per l'acquisizione
subject to tempoMax:
	sum{i in I} x[i] * tempo_richiesto[i] <= tempo_budget;

#Vincolo su incompatibilità immagini
subject to compat{i in I,j in I:(i<>j) and (ends[i] > init[j]) and (ends[j] > init[i])}:
	x[i] + x[j] <= 1;

#Vincolo su immagini forzate per emergenze
subject to emergenza{j in forzate}:
	x[j] = 1;


#OBIETTIVO
#massimizzare il valore economico ottenuto dalle immagini
maximize z: sum{i in I} valore[i] * x[i];

#####
data;
param nI:= 40;


param init:=
1 0 
2 4 
3 8 
4 12 
5 16
6 20 
7 20
8 22
9 24
10 28
11 32
12 36
13 40
14 40
15 40
16 42
17 44
18 45
19 46
20 47
21 48
22 50
23 54
24 58
25 60
26 61
27 62
28 63
29 64
30 65
31 66
32 66
33 66
34 68
35 70
36 72
37 74
38 75
39 75
40 78;


param ends:=
1 6
2 8
3 10
4 14
5 18
6 21
7 22
8 24
9 28
10 30
11 35
12 40
13 42
14 44
15 48
16 50
17 48
18 48
19 52
20 50
21 56
22 54
23 56
24 70
25 62
26 66
27 64
28 64
29 68
30 70
31 68
32 70
33 72
34 72
35 72
36 78
37 76
38 78
39 76
40 80;

param tempo_richiesto:=
1 10
2 12
3 18
4 17
5 15
6 21
7 10
8 28
9 24
10 15
11 16
12 18
13 24
14 17
15 25
16 12
17 11
18 16
19 16
20 17
21 15
22 12
23 15
24 11
25 15
26 19
27 18
28 20
29 12
30 28
31 13
32 16
33 17
34 13
35 14
36 14
37 19
38 14
39 19
40 10;

param valore:=
1 400
2 280
3 186
4 325
5 315
6 290
7 281
8 256
9 289
10 333
11 401
12 286
13 245
14 197
15 245
16 197
17 245
18 233
19 168
20 312
21 176 
22 348
23 194
24 396
25 296
26 339
27 229
28 201
29 300
30 360
31 411
32 284
33 293
34 330
35 209
36 248
37 190
38 248
39 190
40 184;

param tempo_budget:=400;
set forzate:= 2 3 6 13 16 24 37;

end;
