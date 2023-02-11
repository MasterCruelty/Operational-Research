#Esercizio Zaino con penalità

/*
 *Problema dello zaino variante con la penalità
 *La funzione da massimizzare è il valore degli oggetti a cui si sottrae la massima penalità tra quelle associate agli oggetti scelti.
 *Per catturare la massima penalità introduco una variabile dedicata e la costringo ad essere maggiore di tutte.
 *le penalità degli oggetti scelti, quindi moltiplicando per la var binaria di selezione.
*/

#DATI
param nO;               #Numero degli oggetti
set O:=1..nO;           #Insieme degli oggetti
param capacity;         #Spazio disponibile sullo zaino
param val{O};           #Valore di ogni oggetto
param vol{O};           #volume occupato da ogni oggetto
param pena{O};          #Penalità associata ad ogni oggetto

#VARIABILI
var x{O} binary;        #Selezione dell'oggetto
var delta_pena;         #Massimo della penalità tra gli oggetti scelti

#VINCOLI
#Vincolo sulla capacità dello zaino
subject to limite_zaino:
     sum{i in O} vol[i] * x[i] <= capacity;

#OBIETTIVO
#massimizzare il valore degli oggetti meno la penalità massima tra tutti gli oggetti
maximize z: sum{i in O} (val[i] * x[i]) - delta_pena;
#vincolo sul massimo della pena
subject to minmax{i in O}:
     delta_pena >= x[i]*pena[i];
     
     
#########
data;

param nO:=30;
param capacity:=1000;

param:  val     vol     pena:=
1       27      10      34
2       41      58      59
3       23      97      87
4       32      23      34
5       39      19      40
6       8       5       29
7       50      71      84
8       2       94      67
9       30      81      53
10      54      92      48
11      85      74      53
12      2       3       85
13      23      41      37
14      18      57      49   
15      73      12      85
16      41      47      37
17      78      10      90
18      32      25      57
19      18      61      62
20      23      23      34
21      34      74      75
22      58      28      88
23      12      62      43
24      31      35      75
25      63      63      93
26      14      49      75
27      13      13      39
28      87      95      58
29      56      87      37
30      32      23      3;


end;
