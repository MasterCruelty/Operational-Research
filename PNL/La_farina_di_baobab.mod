#Esercizio farina di baobab

#Un'azienda farmaceutica vuole decidere se inserirsi o sul mercato della farina di baobab.
#Deve decidere se e in quale misura conviene iniziare la nuova produzione.
#l'ufficio acquisti ha stimato che i costi saranno dovti in parte ai costi di produzione
#Questi costi sono una quantit� fissa.
#In parte saranno dovuti da una quantit� proporzionale alla produzione.
#e in parte di costi di acquisto della materia prima.
#Questi ultimi non sono proporzionali alla quantit� acquistata.
#Maggiore � la quantit� acquistata e minore � il suo prezzo.
#vale la relazione p = k / sqrt(A)
#p � il prezzo in euro
#k � una costante
#A � la quantit� di corteccia acquistata in Kg.
#il mercato potrebbe assorbire qualunque quantit� del nuovo prodotto
#fino a un massimo valore V
#Per� il prezzo di vendita non dovrebbe superare un valore noto
#1. Coonviene?
#2. Con quale valore di produzione?
#3. quanto tempo sar� necessario per ammortizzare i costi iniziali?
#fino a che livello sarebbe tollerabile la diminuzione del prezzo?

#DATI
param cf;		#costi fissi [�]
param cv;		#costi variabili[� / kg]
param k;		#costante [� / rad(kg) al mese]
param V;		#Valore massimo mercato [kg / mese]
param pM;		#prezzo massimo di vendita [� / kg

#VARIABILI
var x >= 0 :=70;		#produzione [kg / mese]

#VINCOLI

#vincolo sul valore massimo[kg / mese]
subject to massimo:
	x <= V;
	
#OBIETTIVO
#massimizzare i profitti
maximize z: pM*x - cv*x - k*sqrt(x);


#######
data;

param cf:= 1000;
param cv := 10;
param k := 80;
param V:= 70;
param pM:=20;

end;
