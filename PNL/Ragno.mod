#Esercizio Ragno

#Un ragno esperto di ottimizzazione deve costruire la struttura portante della ragnatela.
#Ha a disposizione tre appigli A,B,C in posizione fissa e nota.
#La struttura portante sarà un triangolo quindi e ognuno dei vertici dovrà essere collegato.
#Il triangolo portante deve avere area non inferiore ad una certa soglia minima, 
#altrimenti la ragnatela costruita non è abbastanza utile per catturare insetti.
#Il ragno è vecchio quindi deve minimizzare la quanittà di filo per costruire.
#E unire i tre lati del triangolo con un appiglio.

#DATI
set N:= 0..2;
param xa{N};		#x appiglio cm
param ya{N};		#y appiglio cm
param za{N};		#z appiglio cm
param Amin;			#area minima ragnatela [cmq]

#VARIABILI
var x{i in N}:= xa[i]/2;	#cm
var y{i in N}:= ya[i]/2;	#cm
var z{i in N}:= za[i]/2;	#cm
#lunghezza del alto[cm]
var lato{i in N} =	sqrt((x[(i+1) mod 3]-x[(i+2) mod 3])^2 
			  	   +(y[(i+1)mod 3]-y[(i+2)mod 3])^2 
			  	   +(z[(i+1) mod 3]-z[(i+2) mod 3])^2);
#semiperimetro
var p =sum{i in N} lato[i] / 2;;	
#definizione lunghezza collegamenti [cm^2]
#colelgamento agli appigli[cm]
var link{i in N} = sqrt((x[i]-xa[i])^2 
                 + (y[i]-ya[i])^2 
			     + (z[i]-za[i])^2);
	
#VINCOLI

#definizione area triangolo[cmq^2]
subject to Area:
	p*(p-lato[0])*(p-lato[1])*(p-lato[2]) >=Amin^2;

#OBIETTIVO
#minimizzare lunghezza struttura portante[cm]
minimize w: sum{i in N} (lato[i] + link[i]);
#################
data;
param:  xa	ya	za:=
0		30  50  50
1		60  10  45
2		40  30  10;

param Amin:= 100;

end;
