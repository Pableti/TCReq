' Estimación de las ecuaciones de comercio 
' Metodología FEER
create q 1990 2017
import "C:\Users\hrocha\Documents\Investigación\Exchange rate\Base de datos\BD_nuevo_FEER_170606.xlsx" range=BD colhead=1 na="#N/A" @id @date(series01) @smpl @all

genr x_r0=x_ine_r*3.025
x_r0.x12(mode=a)
genr ln_x_r0=log(x_r0_sa)
genr x_r1=x_ine/def_x
x_r1.x12(mode=a)
genr ln_x_r1=log(x_r1_sa)
genr x_r2=x_ine/ippbx
x_r2.x12(mode=a)
genr ln_x_r2=log(x_r2_sa)

genr m_r0=m_ine_r*3.025
m_r0.x12(mode=a)
genr ln_m_r0=log(m_r0_sa)
genr m_r1=m_ine/def_m
m_r1.x12(mode=a)
genr ln_m_r1=log(m_r1_sa)
genr m_r2=m_ine/ipe
m_r2.x12(mode=a)
genr ln_m_r2=log(m_r2_sa)

genr pib_r0=pib_r*3.025
pib_r0.x12(mode=a)
genr ln_pib_r0=log(pib_r0_sa)
genr pib_r1=pib/def_pib
pib_r1.x12(mode=a)
genr ln_pib_r1=log(pib_r1_sa)

pbie.x12(mode=a)
genr ln_pbie=log(pbie_sa)

genr ln_tcr=log(tcr)

genr ln_ippbx=log(ippbx)

genr rin_pib=(rin*tcn)/pib
rin_pib.x12(mode=a)
genr rin_pib=rin_pib_sa

series d08q4=@during("2008Q4")
series d09q1=@during("2009Q1")
series d06q111q4=@during("2006Q1 2011Q4" )
series d05q312q1=@during("2005Q3 2012Q1" )
series d03q214q3=@during("2003Q2 2014q3")
series d99q403q2=@during("1999Q4 2003q2")
series d00q103q2=@during("2000Q1 2003q2")
series d12q314q3=@during("2012Q3 2014q3")
series d99q4=@during("1999Q4")
series d03q311q3=@during("2003Q3 2011Q3" )
series d03q3=@during("2003Q3" )
series d14q3=@during("2014Q3")
series d01q4=@during("2001Q4")
series d02q3=@during("2002Q3")
series d04q1=@during("2004Q1")
series d13q4=@during("2013Q4")
series d16q1=@during("2016Q1")
series d14q316q4=@during("2014Q3 2016Q4")
series d05q409q4=@during("2005Q4 2009Q4")
series d03q311q3=@during("2003Q3 2011Q3")
series d08q309q3=@during("2008Q3 2009Q3")
series d04q2=@during("2004Q2")
series d14q317q4=@during("2014Q3 2017q4")
series d13q417q4=@during("2013Q4 2017q4")
series d99q103q2=@during("1999q1 2003q2")
series d13q117q4=@during("2013Q1 2017q4")
series d99q104q2=@during("1999q1 2004q2")
series d99q103q3=@during("1999q1 2003q3")
series d16q117q4=@during("2016Q1 2017q4")
series d13q115q4=@during("2013Q1 2015q4")
series d16q117q4=@during("2016Q1 2017q4")
series d12q317q4=@during("2012Q3 2017q4")
series d99q401q3=@during("1999Q4 2001q3")
series d06q108q4=@during("2006Q1 2008Q4")
series d09q416q1=@during("2009Q4 2016Q1")
series d99q401q2=@during("1999Q4 2001Q2")
series d02q103q2=@during("2002Q1 2003Q2")
series d05q105q3=@during("2005Q1 2005Q3")
series d08q409q4=@during("2008Q4 2009Q4")
series d06q116q1=@during("2006Q1 2016Q1")

smpl 1999.1 2016.4

'***********
'***********
'***** EXPORTACIONES
'***********
'***********
'regresiones lineares de largo plazo exportaciones Cobb Douglas
equation exp_011 'esta buena ****************************************************G
exp_011.ls ln_x_r0 ln_pbie ln_tcr ln_ippbx
equation exp_012 'ippbx neg no sign*********
exp_012.ls ln_x_r0 c ln_pbie ln_tcr ln_ippbx

equation exp_111 'tcr neg
exp_111.ls ln_x_r1 ln_pbie ln_tcr ln_ippbx
equation exp_112 'ippbx neg no sig
exp_112.ls ln_x_r1 c ln_pbie ln_tcr ln_ippbx

equation exp_211 'tcr neg ippbx neg no sig
exp_211.ls ln_x_r2 ln_pbie ln_tcr ln_ippbx
equation exp_212 'ippbx neg ****************
exp_212.ls ln_x_r2 c ln_pbie ln_tcr ln_ippbx

'***********
'***********
'***** IMPORTACIONES
'***********
'***********

'regresiones lineares de largo plazo importaciones Cobb Douglas
equation imp_001 'esta buena ***************************************************G
imp_001.ls ln_m_r0 ln_pib_r0 ln_tcr
equation imp_002 'tcr posi
imp_002.ls ln_m_r0 c ln_pib_r0 ln_tcr
equation imp_011 'tcr posi
imp_011.ls ln_m_r0 ln_pib_r1 ln_tcr
equation imp_012 'tcr posi
imp_012.ls ln_m_r0 c ln_pib_r1 ln_tcr

equation imp_101 'tcr muy alto*******************************
imp_101.ls ln_m_r1 ln_pib_r0 ln_tcr
equation imp_102 'tcr posi
imp_102.ls ln_m_r1 c ln_pib_r0 ln_tcr
equation imp_111 'esta buena ***************************************************
imp_111.ls ln_m_r1 ln_pib_r1 ln_tcr
equation imp_112 'tcr posi
imp_112.ls ln_m_r1 c ln_pib_r1 ln_tcr

equation imp_201 'tcr muy alta*******************************
imp_201.ls ln_m_r2 ln_pib_r0 ln_tcr
equation imp_202 'tcr posi
imp_202.ls ln_m_r2 c ln_pib_r0 ln_tcr
equation imp_211 'tcr muy alta*******************************
imp_211.ls ln_m_r2 ln_pib_r1 ln_tcr
equation imp_212 'tcr posi
imp_212.ls ln_m_r2 c ln_pib_r1 ln_tcr

'***********
'***********
'***** OTRAS ESTIMACIONES
'***********
'***********

smpl 1990.1 2017.4

pib.x12(mode=a)
pib_sa.hpf pib_hp
x_ine.x12(mode=a)
x_ine_sa.hpf x_hp
m_ine.x12(mode=a)
m_ine.hpf m_hp

tcr.hpf tcr_hp
x_r0_sa.hpf x_r0_hp
m_r0_sa.hpf m_r0_hp

pbie_sa.hpf pbie_hp
pib_r0_sa.hpf pib_r0_hp
ippbx.hpf ippbx_hp

serv.hpf serv_hp
ing1.hpf ing1_hp
ing2.hpf ing2_hp
cc.hpf cc_hp


show pib_hp x_hp m_hp cc cc_hp tcn

ln_pbie.hpf ln_pbie_hp 
ln_pib_r0.hpf ln_pib_r0_hp 
ln_ippbx.hpf ln_ippbx_hp

'show ln_pbie_hp ln_pib_r0_hp ln_ippbx_hp

'show tcr_hp x_r0_hp m_r0_hp x_hp m_hp pbie_hp pib_hp pib_r0_hp ippbx_hp serv_hp ing1_hp ing2_hp cc_hp


