#Esercizio Assegnamento lineare PLI

#Dato un insieme N persone e N mansioni, conoscendo il costo di attribuzione 
#di ogni mansione ad ogni persona.
#decidere come attribuire una mansione ad ogni persona per minimizzare il costo complessivo.

#Commento:
#Per funzionare la cardinalità delle persone è uguale a quella delle mansioni
#unico vincolo è che una sola persona prende una sola mansione
#Si risolve con una coppia di vincoli simmetrici e variabile binaria.

#DATI
param nP;
set P := 1..nP;			#Insieme delle persone
param nM;
set M:=1..nM;			#Insieme delle mansioni
param mansioni{P,M};	#tabella persone e mansioni
#VARIABILI
var x{P,M} binary; #selezione della persona p  e della mansione m

#VINCOLI

subject to una_persona{i in P}:
	sum{j in M}x[i,j] = 1;

subject to una_mansione{i in M}:
	sum{j in P}x[j,i] = 1;

#OBIETTIVO

minimize z: sum{i in P,j in M} mansioni[i,j] * x[i,j];
data;
param nP:= 4;
param nM:= 4;

param mansioni:	1	2	3	4	:=
1				35	24	62	57	
2				72	25	42	25	
3				48	37	62	14	
4				26	26	73	83;	

end;