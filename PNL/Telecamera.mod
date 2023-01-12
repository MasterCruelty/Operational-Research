#Esercizio Telecamera

#In un museo si vuole installar un sistema di sorveglianza.
#sul soffitto di ogni sala deve essere appeso un sensore.
#Dalla sua posizione, il sensore vede ciascuno dei quadri appesi ai muri sotto un diverso angolo.
#Secondo tizio è opportuno massimizzare la somma complessiva delle ampiezze di tali angoli.
#Secondo Caio è opportuno massimizzare il minimo di tali angoli.

#DATI
param nQ;		#numero quadri
set Q:= 1..nQ;	#insieme quadri
#coordinate dei punti estremi	
param xa{Q};
param ya{Q};
param xb{Q};
param yb{Q};
param L;	#dimensione stanza
param dmin;	#distanza minima dalle pareti
param C{q in Q} = sqrt((xa[q]-xb[q])^2 + (ya[q]-yb[q])^2);

#VARIABILI
#coordinate sensore
var x >=dmin,<=L-dmin,:=L/2;
var y >=dmin,<=L-dmin,:=L/2;
var angolo{Q} >=0,<=3.14;
var A{q in Q} = sqrt((x-xa[q])^2 + (y-ya[q])^2);
var B{q in Q} = sqrt((x-xb[q])^2 + (y-yb[q])^2);
var angolominimo;

#VINCOLI
subject to formula{q in Q}:
	C[q]^2 = A[q]^2 + B[q]^2 - 2 * A[q] * B[q] * cos(angolo[q]);



#OBIETTIVO
#massimizzare somma angoli
#maximize zTizio: sum{q in Q} angolo[q];

#massimizzare il minimo angolo
maximize zCaio: angolominimo;
subject to maxmin{q in Q}:
	angolominimo <= angolo[q];
###########
data;

param L:=16;
param:	xa	ya	xb	yb:=
1 		0	0	0	4
2 		0	10 	6	16
3 		10	0 	15	0;
param nQ:=3;
param dmin:=1;

end;
