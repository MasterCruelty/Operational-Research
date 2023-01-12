#Esercizio Elettrodotto

/*
Per portare la corrente elettrica in una valle sperduta, l'azienda elettrica deve decidere il
tracciato di un elettrodotto. Lungo la valle, che si biforca anche in valli laterali minori, ci sono vari
paesini che devono essere elettrificati e l'elettrodotto deve raggiungerli in sequenza, per altitudine
crescente, come mostrato in figura.
Schema dell'elettrodotto. Il sito A indica l'impianto produttivo.
Nei pressi di ogni paesino verrà installata una cabina di trasformazione da alta tensione alla
normale tensione di 220 Volt. Ogni cabina di trasformazione verrà poi collegata ad una centralina
nel corrispondente paese tramite cavi elettrici interrati. L'azienda elettrica deve sostenere i costi per
l'installazione dell'elettrodotto ad alta tensione, che deve collegare con dei segmenti rettilinei ogni
cabina di trasformazione alla successiva, e per gli scavi, anch'essi rettilinei, per collegare ogni
cabina di trasformazione alla centralina del suo paese. Le posizioni delle centraline nei vari paesi
sono date ed è data anche la posizione dell'impianto a fondo-valle (località indicata con "A") da cui
l'elettrodotto deve partire. La posizione delle cabine di trasformazione invece può essere scelta
liberamente, purché ogni cabina di trasformazione non disti dalla centralina del suo paese più di una
data distanza limite.
Due managers, Tizio e Caio, nell'azienda elettrica hanno opinioni diverse sul tracciato
dell'elettrodotto: Tizio sostiene che sia necessario minimizzare la lunghezza complessiva delle linee
interrate, mentre Caio sostiene che sia necessario minimizzare la lunghezza complessiva dei cavi ad
alta tensione. Sapreste dire quale sarebbe la lunghezza complessiva degli scavi e quale la lunghezza
complessiva dell'elettrodotto nei due casi e dove andrebbero costruite nei due casi le cabine di
trasformazione?
Formulare il problema, classificarlo e risolverlo con i dati del file ELETTRODOTTO.TXT.
Il super-manager Sempronio decide che l'elettrodotto debba essere costruito in modo da
minimizzare i costi complessivi. Sapendo che ogni chilometro di scavo costa una volta e mezzo un
chilometro di elettrodotto, sapreste dire dove devono essere realizzate le cabine di trasformazione?
[E' consentito trascurare il dislivello dovuto alla diversa altitudine dei paesi e risolvere il problema
in sole due dimensioni.]
*/

#DATI
set Paesi;
param x{Paesi};
param y{Paesi};
param dist_lim;

#VARIABILI
#posizione cabine di trasformazione
var xc{Paesi};
var yc{Paesi};

#VINCOLI
#distanza limite tra cabine e centraline
subject to distanza_limite{i in Paesi}:
	(x[i]-xc[i])^2 + (y[i]-yc[i])^2 <= dist_lim^2;

#OBIETTIVO
#somma di tutte le lunghezze dei segmenti
minimize zTizio: sum{i in Paesi} sqrt((x[i]-xc[i])^2 + (y[i]-yc[i])^2);
#minimize zCaio: 

###############
data;

param dist_lim:=2;
set Paesi:= A B C D E F G H I L M N O P Q R;


param:  x y:=
A 		0 0
B 		4 8
C 		10 12
D 		15 12
E 		22 28
F 		31 30
G 		40 34
H 		42 46
I 		50 50
L 		25 15
M 		32 15
N 		37 10
O 		46 13
P 		31 38
Q 		28 45
R 		35 54;

end;
