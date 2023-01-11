#Esercizio Gioco con i numeri

#Ci sono scritte delle cifre da 9 a 1 in ordine decrescente.
#Si possono inserire dei segni '+' tra una cifra e l'altra oppure mantenere le cifre consecutive.
#Si forma così una somma come ad esempio: 9+8+7+65+4+3+2+1 oppure 98+76+54+3+21.
#Il valore di ogni soluzione è dato dal numero ottenuto dalla somma, nel primo caso 99 e nel secondo 252.
#Si vuole ottenere la somma maggiore possibile, purché non superi 1000.

#Commento:
#Lo riscrivo come problema di assegnamento per risolvere il problema delle cifre unità, decine etc.
#Risultato finale: 9+8+7+654+321=999

#DATI
param nC;
set C:=1..nC;			#Insieme delle cifre
param V{C};				#Vettore di cifre date
param lim;
param MaxP:= log(lim)/log(10);
set Potenze := 0..MaxP;

#VARIABILI
var x{C,Potenze} binary;		#assegnamento del simbolo '+' tra posizioni e potenze di 10
var somma;						#Somma delle cifre

#VINCOLI

#definizione somma cifre
subject to def_somma:
	somma =sum{i in C, j in Potenze} V[i] * 10^j * x[i,j];
#vincolo sul limite della somma
subject to limite:
	somma <= lim;

#vincoli di assegnamento
subject to num_potenze{i in C}:
	sum{j in Potenze} x[i,j] = 1;

#vincoli sulla posizione delle potenze
subject to formato{i in C,j in Potenze:j>=1 and i <nC}:
	x[i,j] <= x[i+1,j-1];

#vincolo sull'ultima cifra
subject to Unity:
	x[nC,0]=1;

#OBIETTIVO
maximize z: somma;
##########
data;
param nC:=9;
param lim:=1000;

param V:=
1 9
2 8 
3 7 
4 6
5 5 
6 4
7 3
8 2
9 1;

end;
