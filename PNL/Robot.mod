#Esercizio Robot

/*
 *C'� una nuova linea di produzione robotizzata e vi sono N robot
 *Ogni robot pu� ruotare a 360� attorno ad un asse verticale.
 *Le aree di lavoro di ogni robot non devono sovrapporsi.
 *Il coordinamento tra i robot impone che ognuno sia collegato con tutti gli altri con cavi in fibra ottica.
 *I cavi sono costosi, quindi va minimizzata la lunghezza totale di fibre ottiche impiegate.
 ****************************
 *Commento sul testo:
 *A modello finito, se si sposta il cerchio, puoi mettere il cerchio in diversi punti.
 *tutti i punti sono ottimi buoni, quindi sicuramente il problema non � convesso.
 *L'ottimo trovato dal solutore quindi � sicuramente un ottimo locale.
*/

#DATI
param nR;			#numero di robot
set R:= 1..nR;		#insieme dei robot
param r{R};			#Raggio d'azione [cm]

#VARIABILI
var x{R};
var y{R};


#VINCOLI
#vincolo sulla non sovrapposizione delle aree di lavoro dei robot
subject to noOverLap{i in R, j in R:i<j}:
	(x[i]-x[j])^2 + (y[i]-y[j])^2 >= (r[i] + r[j])^2;

#OBIETTIVO
#Minimizzare la lunghezza dei cavi in fibra ottica usati per collegare i robot.
minimize z: sum{i in R,j in R:i<j} sqrt((x[i]-x[j])^2 + (y[i]-y[j])^2);
#################
data;

param nR:= 6;
param r:=
1 120
2 80
3 100
4 70
5 45
6 120;

var:	x	y:=
1		100	200
2		200	300
3		300	400
4		400	500
5		500	600
6		600	700;


end;
