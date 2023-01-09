#Esercizio Idrocarburi

#Una raffineria deve miscelare 4 sostanze(A,B,C,D) per produrre benzina super,normale e benzina verde.
#Ogni benzina deve contenere una percentuale delle sostanze entro i limiti indicati.
#Le risorse disponibili sono note e dimensionate in barili giornalieri per ognuna delle 4 sostanze.
#il costo delle 4 sostanze è noto.
#I ricavi ottenuti dalla produzione di ogni tipo di benzina sono noti.
#Obiettivo: massimizzare i guadagni

#DATI
param nS;			#Numero delle sostanze
set S:=1..nS;		#Insieme delle sostanze
set B;				#Insieme dei tipi di benzina
param capacity{S};	#Quantità disponibile per ogni sostanza [Barili / giorno]
param pS{S};		#Prezzo di acquisto per ogni sostanza [$ / barile]
param pB{B};		#Prezzo di vendita per ogni benzina [$ /Barile]
param lower{S,B};	#Quantità minima di sostanza presente in ogni benzina [%]
param upper{S,B};	#Quantità massima di sostanza presente in ogni benzina [%]

#VARIABILI
var x{S,B} >= 0;	#Quantità di sostanza i che mettiamo in ogni benzina j
var totb {B};  		#Produzione di ogni benzina [ barili / g]
var tots {S};   	#Consumo totale di ogni sostanza [ barili / g]

#VINCOLI

#Definizione totale benzine e totale sostanze [ barili / g]
subject to tot_benzina{j in B}:  totb[j] = sum {i in S} x[i,j];
subject to tot_sostanza{i in S}: tots[i] = sum{j in B} x[i,j];


#Vincolo su frazione minima per ogni sostanza e ogni benzina [barili / g]
subject to lower_sostanza{i in S,j in B}:
	x[i,j] >= lower[i,j] * totb[j];

#Vincolo su frazione massima per ogni sostanza e ogni benzina [barili / g]
subject to upper_sostanza{i in S,j in B}:
	x[i,j] <= upper[i,j] * totb[j];


#Vincolo su disponibilità sostanze[Barili / giorno] Non serve più dopo l'introduzione di y
subject to consumo_sostanze{i in S}:
	sum{j in B} x[i,j] <= capacity[i];


#OBIETTIVO
#massimizzare i guadagni(ricavi - costi) [$ / g]
maximize z: sum{i in B} pB[i]*totb[i] - sum{j in S} pS[j]*tots[j];

#####
data;

set B:= Super Normale Verde;
param nS:=4;

param:		capacity	pS:=
1			3000		3
2			2000		6
3			4000		4
4			1000		5;

param pB:=
Super		5.5
Normale		4.5
Verde		3.5;

param lower:	Super	Normale	Verde:=
1				0.0		0.0		0.0
2				0.4		0.1		0.0
3				0.0		0.0		0.0
4				0.0		0.0		0.0;

param upper:	Super	Normale	Verde:=
1				0.3		0.5		0.7
2				1.0		1.0		1.0
3				0.5		1.0		1.0
4				1.0		1.0		1.0;

end;
