import "D:\PAOLA\DOCUMENTOS\TCR\TCR equilibrio\08OCT18BASEFINAL.xlsx" range=BASEFINAL colhead=1 namepos=all na="#N/A" names=("date",,,,,,,,,,) @freq Q 1990Q1 @smpl @all
' 1. Transformacion de las series

' a. Se limpian las series de su componente estacional
g_y_cn.x12
gk_y.x12
gnt_y.x12
gt_y.x12
productividad_pc.x12
pntyt.x12
tcr.x12
ti.x12
'b. Se transforman a logaritmos

genr lg_y_cn_sa=log(g_y_cn_sa)
genr lgk_y_sa=log(gk_y_sa)
genr lgnt_y_sa=log(gnt_y_sa)
genr lgt_y_sa=log(gt_y_sa)
genr lproductividad_pc_sa=log(productividad_pc_sa)
genr lpntyt_sa=log(pntyt_sa)
genr ltcr_sa=log(tcr_sa)
genr lti_sa=log(ti_sa)
'c. Test de raiz untaria
cc_y.uroot 
nfa_y.uroot 
lg_y_cn_sa.uroot
lgk_y_sa.uroot
lgnt_y_sa.uroot
lgt_y_sa.uroot
lproductividad_pc_sa.uroot
lpntyt_sa.uroot
ltcr_sa.uroot
lti_sa.uroot

'd. combinacion de modelos 
' Se itera gasto: lg_y_cn lgk_y_sa lgnt_y_sa lgt_y_sa
' Se itera productividad lproductividad_pc_sa lpntyt_sa
' Se itera flujos externos cc_y nfa_y
' Se mantienen siempre fijas ltcr_sa lti_sa

group variables 
for %i lg_y_cn_sa lgk_y_sa lgnt_y_sa lgt_y_sa
	for %j lproductividad_pc_sa lpntyt_sa
		for %k cc_y nfa_y
	var m{%i}_{%j}_{%k}.ls 1 3 ltcr_sa lti_sa  {%i}  {%j}  {%k}
		next
	next
next
' e. modelos seleccionados
' text
'Model	Especificación 														Lags						Numbers of cointegration relation 	NOTA	MODELO ASOCIADO
'1			ltcr_sa lti_sa lg_y_cn_sa lpntyt_sa cc_y 						1-1 ; 1-5					NA	;	1 			SI	(A)
'2			ltcr_sa lti_sa lg_y_cn_sa lpntyt_sa nfa_y 						1-1 ; 1-2 ; 1-5			NA	;	NA	;  1		SI	(B)
'3			ltcr_sa lti_sa lg_y_cn_sa lproductividad_pc_sa cc_y 		1-1 ; 1-2	; 1-3			NA 	;	NA	;  NA		NA	-.-
'4			ltcr_sa lti_sa lg_y_cn_sa lproductividad_pc_sa nfa_y 	1-1 ; 1-2	; 1-4			NA	;	NA	;  NA		NA	-.-
'5			ltcr_sa lti_sa lgk_y_sa lpntyt_sa cc_y 							1-1 ; 1-2 ; 1-4			NA	;	NA	;  1		SI	(C)
'6			ltcr_sa lti_sa lgk_y_sa lpntyt_sa nfa_y 						1-1 ; 1-2 ; 1-4			NA	;	NA	;  1		SI	(D)
'7			ltcr_sa lti_sa lgk_y_sa lproductividad_pc_sa cc_y 		1-1 ; 1-2 ; 1-4			NA	;	NA 	;  1		SI	(E)
'8			ltcr_sa lti_sa lgk_y_sa lproductividad_pc_sa nfa_y 		1-1 ; 1-2	; 1-3; 1-4	NA	; 	NA	;  NA	;  1*	NA	(F)*
'9			ltcr_sa lti_sa lgnt_y_sa lpntyt_sa cc_y 						1-1 ; 1-3 ; 1-4; 1-5	NA	;	1	;  NA	;  1	SI	(G);    (H)
'10		ltcr_sa lti_sa lgnt_y_sa lpntyt_sa nfa_y 						1-1 ; 1-2 ; 1-4			NA	;	NA	;  0		NA
'11		ltcr_sa lti_sa lgnt_y_sa lproductividad_pc_sa cc_y 		1-1 ; 1-2 ; 1-3; 1-4	NA	;	NA	;  0	; 1*	NA	(I)*				
'12		ltcr_sa lti_sa lgnt_y_sa lproductividad_pc_sa nfa_y 		1-2 ; 1-3					NA	;	1*			NA	(J)*	
'13		ltcr_sa lti_sa lgt_y_sa lpntyt_sa cc_y 							1-1 ; 1-3 ; 1-4; 			NA	;   	NA	; NA		NO
'14		ltcr_sa lti_sa lgt_y_sa lpntyt_sa nfa_y 							1-1 ; 1-2 ; 1-4; 1-5	NA	; 	NA	; 0	;  1	SI	(K)
'15		ltcr_sa lti_sa lgt_y_sa lproductividad_pc_sa cc_y			1-1 ; 1-2 ; 1-3; 1-7	NA	;	NA	; NA	;  NA	NA				
'16		ltcr_sa lti_sa lgt_y_sa lproductividad_pc_sa nfa_y 		1-2 ; 1-3					NA	;	1			SI	(L)							
'Modelos:

'mlg_y_cn_sa_lpntyt_sa_cc_y.ec(c,1) 1 4 ltcr_sa lti_sa lg_y_cn_sa lpntyt_sa cc_y   					'M-A'
'mlg_y_cn_sa_lpntyt_sa_nfa_y.ec(c,1) 1 4 ltcr_sa lti_sa lg_y_cn_sa lpntyt_sa nfa_y  					'M-B'
mlgk_y_sa_lpntyt_sa_cc_y.ec(c,1) 1 3 ltcr_sa lti_sa lgk_y_sa lpntyt_sa cc_y 								'M-C'
mlgk_y_sa_lpntyt_sa_nfa_y.ec(c,1) 1 3 ltcr_sa lti_sa lgk_y_sa lpntyt_sa nfa_y 							'M-D'
mlgk_y_sa_lproductividad_pc_sa_cc_y.ec(c,1) 1 3 ltcr_sa lti_sa lgk_y_sa lproductividad_pc_sa cc_y 	'M-E'
'mlgk_y_sa_lproductividad_pc_sa_nfa_y.ec(c,1) 1 3 ltcr_sa lti_sa lgk_y_sa lproductividad_pc_sa nfa_y 	'M-F'**
mlgnt_y_sa_lpntyt_sa_cc_y.ec(c,1) 1 2 ltcr_sa lti_sa lgnt_y_sa lpntyt_sa cc_y 							'M-G'
'mlgnt_y_sa_lpntyt_sa_cc_y.ec(c,1) 1 4 ltcr_sa lti_sa lgnt_y_sa lpntyt_sa cc_y 							'M-H'
'mlgnt_y_sa_lproductividad_pc_sa_cc_y.ec(c,1) 1 3 ltcr_sa lti_sa lgnt_y_sa lproductividad_pc_sa cc_y 	'M-I'
'mlgnt_y_sa_lproductividad_pc_sa_nfa_y.ec(c,1) 1 2 ltcr_sa lti_sa lgnt_y_sa lproductividad_pc_sa nfa_y 	'M-J'
'mlgt_y_sa_lpntyt_sa_nfa_y.ec(c,1) 1 4 ltcr_sa lti_sa lgt_y_sa lpntyt_sa nfa_y 							'M-K'
'mlgt_y_sa_lproductividad_pc_sa_nfa_y.ec(c,1) 1 2 ltcr_sa lti_sa lgt_y_sa lproductividad_pc_sa nfa_y 	'M-L'


' f. TCR equilibrio
' Componentes de tendencia 
cc_y.hpf cc_y_hp 
nfa_y.hpf nfa_y_hp
lg_y_cn_sa.hpf lgy_cn_hp
lgk_y_sa.hpf lgk_y_hp
lgnt_y_sa.hpf lgnt_y_hp
lgt_y_sa.hpf lgt_y_hp
lproductividad_pc_sa.hpf lproductividad_pc_hp
lpntyt_sa.hpf lpntyt_hp
ltcr_sa.hpf ltcr_hp
lti_sa.hpf lti_hp

' MODELOS DE EQUUILIBRIO
'genr Eq_TCR_A = EXP(-(1.47163796945*LTI_HP - 1.28219978934*LGY_CN_HP + 3.30030804739*LPNTYT_HP - 15.2514426563*CC_Y_HP - 12.6094917983 )) 

'genr Eq_TCR_B= EXP(-(0.68869127092*LTI_HP - 0.0496830103808*LGY_CN_HP + 0.762675406378*LPNTYT_HP - 1.48780163913*NFA_Y_HP - 7.42928343794 ))

genr Eq_TCR_C= EXP(-(0.450499146292*LTI_HP + 0.432855213773*LGK_Y_HP + 0.127495362631*LPNTYT_HP - 6.48290603516*CC_Y_HP - 5.3606999565 )) 

genr Eq_TCR_D=EXP(-(0.0220104781329*LTI_HP + 0.511644246759*LGK_Y_HP - 0.497136938408*LPNTYT_HP - 0.709996874582*NFA_Y_HP - 3.48968118371 ))

genr Eq_TCR_E=EXP(-(0.456491117191*LTI_HP + 0.591103322889*LGK_Y_HP + 0.49464121021*LPRODUCTIVIDAD_PC_HP - 5.61142968717*CC_Y_HP - 2.67715676759 ))

'genr Eq_TCR_F=EXP(-(- 0.0542304780829*LTI_HP + 1.06807697114*LGK_Y_HP + 1.56118228002*LPRODUCTIVIDAD_PC_HP - 0.152367652659*NFA_Y_HP + 5.70396560676 )) 
 
genr Eq_TCR_G=EXP(-(0.299697229528*LTI_HP + 0.929551864131*LGNT_Y_HP - 0.746087416864*LPNTYT_HP - 5.7589741131*CC_Y_HP - 4.7099464965 ))

'genr Eq_TCR_H=EXP(-(0.857503955412*LTI_HP + 0.390141926174*LGNT_Y_HP + 0.468832123596*LPNTYT_HP - 8.53640965124*CC_Y_HP - 7.5548903133 ))

'genr Eq_TCR_I=EXP(-(0.868392452582*LTI_HP + 0.375917746169*LGNT_Y_HP - 0.195211769568*LPRODUCTIVIDAD_PC_HP - 8.34840158145*CC_Y_HP - 8.63792561202 )) 

'genr Eq_TCR_J=EXP(-(0.145142011318*LTI_HP + 0.217901798893*LGNT_Y_HP - 1.48190046728*LPRODUCTIVIDAD_PC_HP - 1.08195485484*NFA_Y_HP - 11.899632362 ))

'genr Eq_TCR_K=EXP(-(0.586252734996*LTI_HP + 0.157572453121*LGT_Y_HP + 0.420085266147*LPNTYT_HP - 1.17882197891*NFA_Y_HP - 6.77027246809 )) 

'genr Eq_TCR_L=EXP(-(0.0994063674156*LTI_HP + 0.240182381517*LGT_Y_HP - 1.59867731342*LPRODUCTIVIDAD_PC_HP - 1.05887990709*NFA_Y_HP - 12.2605407917 ))


