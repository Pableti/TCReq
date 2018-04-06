import(link) "C:\Users\pyujra\Desktop\PAOLA\2017\3. Investigaciones\3. Compartidas\1. Tipo de cambio real de equilibrio\Beer_Base22mar18.xlsx" range=Base!$B$1:$j$112 colhead=1 na="#N/A" @freq Q 1990Q1 @smpl 1990q1 2017q4
smpl 1991Q1 2017Q3
rename gasto_gobierno gobierno
rename PNTYPT PNTT
rename productividad__indice_percapita_ productividad
rename terminos_de_intercambio TI

' Se desestacionalizan las variables 
tcr.x12
gobierno.x12
gy.x12
'nfa.x12 - como presenta valores negativos la desastacionalización es aditiva
nfa.x13(save="d11", arimasmpl="1991Q1 2017Q3")  @x11(mode=add)
rename nfa_d11 nfa_sa
productividad.x12
'scc.x12 - nota idem a nfa.x12
scc.x13(save="d11", arimasmpl="1991Q1 2017Q3")  @x11(mode=add)
rename scc_d11 scc_sa
ti.x12
pntt.x12
gctey.x12
' Se captura el componente de LP - filtro HP
gobierno_sa.hpf gobierno_hp
gy_sa.hpf gy_hp
nfa.hpf nfa_hp
pntt_sa.hpf pntt_hp
productividad_sa.hpf productividad_hp
scc.hpf scc_hp
ti_sa.hpf ti_hp
gctey_sa.hpf gctey_hp
'****************************************************
'Estimación modelo 1 - VAR en niveles 
var model1.ls 1 4 log(tcr_sa) log(gy_sa) log(pntt_sa) log(ti_sa) nfa_sa log(productividad_sa)  
model1.laglen(8)
'Estimación modelo VEC (menos un rezago)
model1.ec(c,1) 1 3 log(tcr_sa) log(gy_sa) log(pntt_sa) log(ti_sa) nfa_sa log(productividad_sa)
' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m1 = exp(-(3.7758697544*LOG(GY_SA(-1)) - 2.51312615111*LOG(PNTT_SA(-1)) + 1.55821040126*LOG(TI_SA(-1)) - 0.413587699143*NFA_SA(-1) + 2.96107379489*LOG(PRODUCTIVIDAD_SA(-1)) + 9.69505954274))
'componentes de largo plazo 
genr tcr_m1_hp = exp(-(3.7758697544*LOG(GY_HP) - 2.51312615111*LOG(PNTT_HP) + 1.55821040126*LOG(TI_HP) - 0.413587699143*NFA_HP + 2.96107379489*LOG(PRODUCTIVIDAD_HP) + 9.69505954274))

'****************************************************
'Estimación modelo 2 - VAR en niveles
var model2.ls 1 4 log(tcr_sa) log(gobierno_sa) log(pntt_sa) log(ti_sa) scc_sa  
'Estimación modelo VEC (menos un rezago)
model2.ec(c,1) 1 3 log(tcr_sa) log(gobierno_sa) log(pntt_sa) log(ti_sa) scc_sa
' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m2 = exp(-( - 0.259507477967*LOG(GOBIERNO_SA(-1)) + 0.800585077161*LOG(PNTT_SA(-1)) + 0.938895532112*LOG(TI_SA(-1)) - 7.90892345016*SCC_SA(-1) - 9.61557585625))
'componentes de largo plazo 
genr tcr_m2_hp = exp(-( - 0.259507477967*LOG(GOBIERNO_HP) + 0.800585077161*LOG(PNTT_HP) + 0.938895532112*LOG(TI_HP) - 7.90892345016*SCC_HP - 9.61557585625))

'****************************************************
'Estimación modelo 3 - VAR en niveles
var model3.ls 1 4 log(tcr_sa) log(gy_sa) log(pntt_sa) log(ti_sa) scc_sa log(productividad_sa)
'Estimación modelo VEC (menos un rezago)
model3.ec(c,1) 1 3 log(tcr_sa) log(gy_sa) log(pntt_sa) log(ti_sa) scc_sa log(productividad_sa)
' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m3 = exp(-( 2.16142409321*LOG(GY_SA(-1)) - 0.791894654315*LOG(PNTT_SA(-1)) + 1.40524992203*LOG(TI_SA(-1)) - 5.31365410273*SCC_SA(-1) + 1.62211550819*LOG(PRODUCTIVIDAD_SA(-1)) + 1.22218118676))
'componentes de largo plazo 
genr tcr_m3_hp = exp(-(2.16142409321*LOG(GY_HP) - 0.791894654315*LOG(PNTT_HP) + 1.40524992203*LOG(TI_HP) - 5.31365410273*SCC_HP + 1.62211550819*LOG(PRODUCTIVIDAD_HP) + 1.22218118676))

group group_nivel tcr gobierno gy nfa pntt productividad scc ti gctey
group_nivel.line(m)

group group_sa tcr_sa gobierno_sa gy_sa nfa_sa pntt_sa productividad_sa scc_sa ti_sa gctey_sa
group_sa.line(m)


'****************************************************
'Estimación modelo 4 - VAR en niveles se incluye gasto corriente como proporción del pib
var model4.ls 1 4 log(tcr_sa) log(gctey_sa) log(pntt_sa) log(ti_sa) nfa_sa
'Estimación modelo VEC (menos un rezago)
model4.ec(c,1) 1 3 log(tcr_sa) log(gctey_sa) log(pntt_sa) log(ti_sa) nfa_sa 
' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m4 = exp(-( 0.824061784834*LOG(GCTEY_SA(-1)) - 0.948454808584*LOG(PNTT_SA(-1)) + 0.119067490682*LOG(TI_SA(-1)) - 0.730345489743*NFA_SA(-1) - 4.14249119522))
'componentes de largo plazo 
genr tcr_m4_hp = exp(-(0.824061784834*LOG(GCTEY_HP) - 0.948454808584*LOG(PNTT_HP) + 0.119067490682*LOG(TI_HP) - 0.730345489743*NFA_HP - 4.14249119522))

'****************************************************
'Estimación modelo 5 - VAR en niveles se incluye GCTEY
var model5.ls 1 4 log(tcr_sa) log(gctey_sa) log(pntt_sa) log(ti_sa) nfa_sa
'Estimación modelo VEC (menos un rezago)
model5.ec(c,1) 1 3 log(tcr_sa) log(gctey_sa) log(pntt_sa) log(ti_sa) nfa_sa 
' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m5 = exp(-( 2.4988928118*LOG(GCTEY_SA(-1)) - 2.96976581154*LOG(PNTT_SA(-1)) + 2.90496303219*LOG(PRODUCTIVIDAD_SA(-1)) + 11.9520980187))
'componentes de largo plazo 
genr tcr_m5_hp = exp(-(2.4988928118*LOG(GCTEY_HP) - 2.96976581154*LOG(PNTT_HP) + 2.90496303219*LOG(PRODUCTIVIDAD_HP) + 11.9520980187))

'****************************************************
'Estimación modelo 6 - VAR en niveles se incluye GCTEY
var model6.ls 1 4 log(tcr_sa) log(gctey_sa) log(pntt_sa) log(ti_sa) nfa_sa
'Estimación modelo VEC (menos un rezago)
model6.ec(c,1) 1 3 log(tcr_sa) log(gctey_sa) log(pntt_sa) log(ti_sa) nfa_sa 

' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m6 = exp(-(0.904308185224*LOG(GCTEY_SA(-1)) - 0.458829831225*LOG(PNTT_SA(-1)) + 0.692844945043*LOG(TI_SA(-1)) - 8.08471930956*SCC_SA(-1) + 0.948549237943*LOG(PRODUCTIVIDAD_SA(-1)) + 0.360177941602*NFA_SA(-1) - 1.85837679817))
'componentes de largo plazo 
genr tcr_m6_hp = exp(-(0.904308185224*LOG(GCTEY_HP) - 0.458829831225*LOG(PNTT_HP) + 0.692844945043*LOG(TI_HP) - 8.08471930956*SCC_HP + 0.948549237943*LOG(PRODUCTIVIDAD_HP) + 0.360177941602*NFA_HP - 1.85837679817))
' considera dos vectores de cointegración 
' Estimando el TCR de equilibrio 
' En niveles
genr tcr_m7 = exp(-(1.40988349819*LOG(PNTT_SA(-1)) + 1.6141794419*LOG(TI_SA(-1)) - 12.9445255876*SCC_SA(-1) + 1.44511330392*LOG(PRODUCTIVIDAD_SA(-1)) + 0.800376033314*NFA_SA(-1) - 4.24247807082 ) - 0.00909365093183*( LOG(GCTEY_SA(-1)) - 2.06645628111*LOG(PNTT_SA(-1)) - 1.01882799682*LOG(TI_SA(-1)) + 5.37405981437*SCC_SA(-1) - 0.549109334728*LOG(PRODUCTIVIDAD_SA(-1)) - 0.48677884255*NFA_SA(-1) + 2.63638139254))
'componentes de largo plazo 
genr tcr_m7_hp=exp(-(1.40988349819*LOG(PNTT_HP) + 1.6141794419*LOG(TI_HP) - 12.9445255876*SCC_HP + 1.44511330392*LOG(PRODUCTIVIDAD_HP) + 0.800376033314*NFA_HP - 4.24247807082)) + exp(- (- 2.06645628111*LOG(PNTT_HP) - 1.01882799682*LOG(TI_HP) + 5.37405981437*SCC_HP - 0.549109334728*LOG(PRODUCTIVIDAD_HP) - 0.48677884255*NFA_HP + 2.63638139254))



group group_resultado tcr tcr_m1_hp tcr_m2_hp tcr_m3_hp tcr_m4_hp tcr_m5_hp tcr_m6_hp
group_resultado.line


