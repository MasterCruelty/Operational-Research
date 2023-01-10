#Esercizio Zaino PLI

#Dato uno zaino, massimizzare il valore degli oggetti scelti per essere messi all'interno
#Senza sforare la sua capacità

#DATI
param capacity;
param nO;
set O:=1..nO;
param volume{O};
param valore{O};

#VARIABILI
var x{O} binary; #selezione dell'oggetto

#VINCOLI
subject to cap:
	sum{i in O} volume[i] * x[i] <= capacity;

#OBIETTIVO
maximize z: sum{i in O} valore[i] * x[i];

#######
data;
param nO:=10;
param capacity:=100;
param: volume valore:=
1		8		4
2		9		6
3		13		40
4		24		15
5		28		20
6		36		20
7		41		21
8		57		38
9		68		46
10		70		56;
end;
