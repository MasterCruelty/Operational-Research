#Esercizio investimenti

/*
  *Ci sono 3 capitali in Svizzera, Colombia e Principato di monaco.
  *Si possono scegliere 3 mercati finanziari in cui investire: USA, Europa e Giappone. In ognuno si possono acquistare n azioni di tipo diverso, ognuna con soglia massima.
  *I rendimenti dei fondi azionari sono noti.
  **********************************************
  *Commento sul testo:
  *Si tratta di ottimizzare il rendimento degli investimenti, quindi sarà un modello derivato dal mix produttivo ottimale .
  */

#DATI
set FUSA;                   #insieme dei fondi sul mercato USA  
set AUSA;                   #insieme delle azioni sul mercato USA
param rendi_USA{FUSA};      #rendimento per ogni fondo sul mercato USA [%]
param acq_USA{AUSA};        #massimo importo acquistabile per azione sul mercato USA[M €]
param comp_USA{AUSA,FUSA};  #composizione dei fondi per ogni tipo di azione in ogni fondo sul mercato USA[%]
set AUE;                    #Insieme dei fondi europei
set FUE;                    #insieme delle azioni europee
param rendi_UE{FUE};        #rendimento per ogni fondo sul mercato UE[%]
param acq_UE{AUE};          #massimo importo acquistabile per azione sul mercato UE[M €]
param comp_UE{AUE,FUE};     #composizione dei fondi per ogni tipo di azione in ogni fondo sul mercato UE[%]
set AGP;                    #insieme delle azioni sul mercato giapponese
set FGP;                    #insieme dei fondi sul mercato giapponese
param rendi_GP{FGP};        #rendimento per ogni fondo sul mercato giapponese[%]
param acq_GP{AGP};          #massimo importo acquistabile per azione sul mercato giapponese[M €]
param comp_GP{AGP,FGP};     #composizione dei fondi per ogni tipo di azione in ogni fondo sul mercato giapponese [%]
set B;                      #insieme delle banche dove sono presenti i capitali
param cap{B};               #capitali disponibili [M €]

#VARIABILI
var x{FUSA} >= 0;
var y{FUE}  >= 0;
var w{FGP}  >= 0;

#VINCOLI
#vincolo su soglia massima acquistabile per azione
subject to max_usa{au in AUSA}:
   sum{fu in FUSA} x[fu] <= acq_USA[au];
subject to max_ue{aue in AUE}:
   sum{fue in FUE} y[fue] <= acq_UE[aue];
subject to max_gp{agp in AGP}:
   sum{fg in FGP} w[fg] <= acq_GP[agp];
#vincolo sul capitale disponibile
subject to capacity:
   sum{au in FUSA,aue in FUE,agp in FGP} (x[au] + y[aue] + w[agp]) <= sum{b in B} cap[b];

#OBIETTIVO
maximize z: sum{au in AUSA, fu in FUSA} x[fu]* comp_USA[au,fu] * rendi_USA[fu] + sum{aue in AUE,fue in FUE} y[fue] *comp_UE[aue,fue] * rendi_UE[fue] + sum{ag in AGP, fg in FGP} w[fg]*comp_GP[ag,fg] * rendi_GP[fg];

############
data;
set FUSA := Stars Stripes Yankee HotDog;
set AUSA := MMA DDS RP MLF;

param rendi_USA:=
Stars                   .35
Stripes                 .10
Yankee                  .60
HotDog                  .40;

param acq_USA:=
MMA         100
DDS         100
RP           79
MLF          98;

param comp_USA:      Stars  Stripes  Yankee  HotDog:=
MMA                    .50     .10     .25     .20
DDS                    .30     .80     .20      .0
RP                     .20      .0     .35     .30
MLF                     .0     .10     .20     .50;

set FUE := Colosseo Tour_Eiffel Plaza_de_Toros Westminster;
set AUE := CA E NP BFC;

param rendi_UE:=
Colosseo                .10
Tour_Eiffel             .30
Plaza_de_Toros          .80
Westminster             .30;

param acq_UE:=
CA             150
E              120
NP              80
BFC             90;

param comp_UE:      Colosseo    Tour_Eiffel Plaza_de_Toros Westminster:=
CA                      .90        .20            .0          .10
E                       .10        .30           .20          .70
NP                       .0        .40            .0          .10
BFC                      .0        .10           .80          .10;

set FGP := Sol_Levante Banzai Kimono Kung_Fu;
set AGP := KA SF MW NSC;

param rendi_GP:=
Sol_Levante         .40
Banzai              .30
Kimono              .20
Kung_Fu             .10;

param acq_GP:=
KA                110
SF                 90
MW                200
NSC               130;
  
param comp_GP:      Sol_Levante Banzai  Kimono   Kung_Fu:=
KA                      .70       .0     .10       .20
SF                      .20      .10     .50       .20
MW                      .10      .10     .30       .60
NSC                      .0      .80     .10        .0;

set B:= Svizzera Colombia Monaco;

param cap:=
Svizzera             433
Colombia             320
Monaco               377;

end;
