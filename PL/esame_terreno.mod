#Esame 113 Terreno

/*
  * Si vuole destinare un appezzamento di terra ad uso agricolo.
  * Vi sono dislivelli che ostacolerebbero il movimento dei mezzi agricoli.
  * Si vuole livellare il terreno prima di ararlo, così che ogni quadratino abbia la stessa altezza.
  * Il terreno è rettangolare ed è stato diviso in quadratini uguali(tutti di un 1 metro quadro).
  * Di ogni quadratino si sa l'altezza.
  * Il livellamento va compiuto spostando terra dai quadratini con eccesso a quelli con difetto.
  * Il costo per il livellamento è proporzionale alle quantità di terra spostate e alle distanze.
  * (costo unitario noto per spostare un metro cubo a un metro di distanza)
  *
  ******************************************************
  *Commento sul testo:
  *Ci sono n quadratini di terreno da livellare.
  *Bisogna spostare dei quadratini a una certa distanza per averli tutti alla stessa altezza.
  *è noto il costo di trasporto di un metro cubo di terra a un metro cubo di distanza.
  *Ed è presente una griglia con le quote di ogni cella in metri.
  *Si tratta quindi di un problema che da luogo a un modello di trasporto. 
  *Le sorgenti sono le quote iniziali e le destinazioni sono lo spostamento dei quadratini verso la quota media di altezza. Si minimizzano i costi
*/

#DATI
param base;		#base del rettangolo [m]
param altezza;	#altezza del rettangolo [m]
param cu;		#costo unitario [€]
param nR;		#numero delle righe
set R := 1..nR; #Insieme delle righe
param nC;		#numero colonne
set C:= 1..nC;	#Insieme delle colonne
param griglia{R,C};	#griglia con suddivisione quota delle celle [m]
param M := sum{r in R, c in C} griglia[r,c] / (base*altezza); #Quota media del terreno
param d{r1 in R,c1 in C,r2 in R,c2 in C} := sqrt((r1-r2)^2 +(c1-c2)^2); #distanza tra ogni coppia di celle


#VARIABILI
var x{R,C,R,C} >= 0;		#quantità di terra spostate da ogni cella ad ogni altra. [mc]

#VINCOLI
subject to balancer{r2 in R,c2 in C}:
	sum{r1 in R,c1 in C} x[r1,c1,r2,c2] + griglia[r2,c2] - sum{r1 in R,c1 in C} x[r2,c2,r1,c1] = M;

#OBIETTIVO
minimize z: sum{r1 in R, c1 in C, r2 in R, c2 in C} cu *x[r1,c1,r2,c2] * d[r1,c1,r2,c2];

data;

param base :=    20;
param altezza := 10;
param cu :=      0.50;
param nC :=      20;
param nR :=      10;
param griglia: 	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20 :=
1				-5	-4	-3	-2	-1	0	-1	-1	-1	0	1	1	1	2	3	4	3	3	4	5
2				-5	-4	-3	-2	-1	0	0	0	0	1	2	1	0	1	2	3	2	2	3	4
3				-4	-3	-3	-2	-1	0	1	0	1	0	1	0	-1	0	1	2	1	1	2	3
4				-4	-3	-2	-2	-1	0	1	0	1	1	1	0	-1	-1	0	1	0	0	1	2
5				-3	-2	-2	-2	-1	0	1	0	1	1	1	1	0	0	1	0	-1	-1	0	1
6				-2	-2	-2	-1	-1	0	1	1	1	2	2	2	1	0	0	-1	-2	-2	-1	0
7				-1	-1	-1	0	0	1	2	2	2	3	3	3	2	1	0	-1	-2	-3	-2	-1
8				0	0	-1	0	1	2	3	3	3	4	4	4	3	2	1	0	-1	-2	-3	-2
9				1	1	0	1	2	3	4	4	4	5	5	5	4	3	2	1	0	-1	-2	-3
10				2	2	1	2	3	4	5	5	5	6	6	6	5	4	3	2	1	0	-1	-2;


end;
