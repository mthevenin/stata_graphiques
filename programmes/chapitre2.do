

* g19a

grstyle init
grstyle set mesh, compact 

sysuse auto, clear
gen rep= rep78<4
label define rep 0 "rep<4" 1 "rep>=4", modify
label value rep rep

local X rep
local labn: value label `X'
levelsof `X', local(l)
foreach l2 of local l {
local lab`l2': label `labn'  `l2'
}


#delimit ;

tw scatter price mpg if  `X', 
   mc("237 248 177")   mlc(black) mlw(*.3)  msiz(*1.5) jitter(2)  
   
|| scatter price mpg if !`X', 
   mc("65 182 196")    mlc(black) mlw(*.3) msiz(*1.5) jitter(2)  
   
|| , legend(order(1 "`lab0'" 2 "`lab1'") pos(11) region(color(%0)))         
     title("Variable `X'") 
;

#delimit cr



* g19b

grstyle init
grstyle set mesh, compact 

sysuse auto, clear
gen rep= rep78<4
label define rep 0 "rep<4" 1 "rep>=4", modify
label value rep rep

local X foreign
local labn: value label `X'
levelsof `X', local(l)
foreach l2 of local l {
local lab`l2': label `labn'  `l2'
}


#delimit ;

tw scatter price mpg if  `X', 
   mc("237 248 177")   mlc(black) mlw(*.3)  msiz(*1.5) jitter(2)  
   
|| scatter price mpg if !`X', 
   mc("65 182 196")    mlc(black) mlw(*.3) msiz(*1.5) jitter(2)  
   
|| , legend(order(1 "`lab0'" 2 "`lab1'") pos(11) region(color(%0)))         
     title("Variable `X'") 
;

#delimit cr


* g19c
sysuse auto, clear
gen rep= rep78<4
label define rep 0 "rep<4" 1 "rep>=4", modify
label value rep rep


local varlist rep foreign

foreach X of local varlist {

local labn: value label `X'
levelsof `X', local(l)
foreach l2 of local l {
local lab`l2': label `labn'  `l2'
}


#delimit ;
tw scatter price mpg if  `X', 
   mc("237 248 177")   mlc(black) mlw(*.3)  msiz(*1.5) jitter(2)  
   
|| scatter price mpg if !`X', 
   mc("65 182 196")    mlc(black) mlw(*.3) msiz(*1.5) jitter(2)  
   
|| , legend(order(1 "`lab0'" 2 "`lab1'") pos(11) region(color(%0)))         
     title("Variable `X'") name(`X', replace) 
;
#delimit cr

}

graph combine `varlist', xsize(20) ysize(10)



************ g20

* récupération des moyennes de price et mpg
local varlist price mpg
foreach v of loc varlist {
qui sum `v'
local  m`v' : di %6.2f `r(mean)'
}

* Récupération des labels de la variable foreign
local X foreign
local labn: value label `X'
levelsof `X', local(l)
foreach l2 of local l {
local lab`l2': label `labn'  `l2'
}


* graphique
#delimit ; 

tw scatter price mpg if !foreign, mlc(black) mlw(*.3) mc("254 196 79") msiz(*1.5)  jitter(2) 
|| scatter price mpg if foreign,  mlc(black) mlw(*.3) mc("153 52 4")   msiz(*1.5)  jitter(2) 

|| , legend(order(1 "`lab0'" 2 "`lab1'") pos(11) region(color(%0))) 
     yline(`mprice', lc("236 112 20") lw(*1.5)) 
	 xline(`mmpg'  , lc("236 112 20") lw(*1.5))
	 note("{bf:Moyenne Price = `mprice'}" 
	      "{bf:Moyenne Mpg   = `mmpg'}")
;

#delimit cr


******** g21

recode rep78 (1=2)  

local i=1
levelsof rep78, local(l)

foreach v of local l {
qui sum displacement  if rep78==`v'
local m`i++' = `r(mean)'
}

qui sum displacement 
local mean `r(mean)'

#delimit ;
tw  scatteri 2 `m1',  msymbol(|) mc("210 50 0") msize(*5) mlw(*3)
||  scatteri 3 `m2',  msymbol(|) mc("210 50 0") msize(*5) mlw(*3)
||  scatteri 4 `m3',  msymbol(|) mc("210 50 0") msize(*5) mlw(*3)
||  scatteri 5 `m4',  msymbol(|) mc("210 50 0") msize(*5) mlw(*3)

|| pci 1.985 `mean' 5.015 `mean', lw(*2.5) lc("210 50 0")

|| pci 2 `mean' 2 `m1'  , lw(*2.5) lc("210 50 0")
|| pci 3 `mean' 3 `m2'  , lw(*2.5) lc("210 50 0")
|| pci 4 `mean' 4 `m3'  , lw(*2.5) lc("210 50 0")
|| pci 5 `mean' 5 `m4'  , lw(*2.5) lc("210 50 0")

||  scatter rep78 displacement,  mc("255 117 0%70") mlc(210 50 0) mlw(*.5) msize(*1) jitter(5)
 
|| , 
xlabel(,glw(*1.2)) ylabel(,glw(*.5) angle(0)) yscale(range(1.8, 5.2))
legend(off)
title("Averages of displacement") ytitle("Number of repairs")
;


******** g22
sysuse auto, clear
tempvar qdisp
local varlist price displacement `qdisp'
tokenize `varlist'
xtile `qdisp' = `2', n(4)
qui sum `2', d
return list

#delimit ;
tw scatter `1' `2' if `3'==1, mlc(black) mlw(*.5) mc("68 1 84%60")    msiz(*1.5) jitter(1)
|| scatter `1' `2' if `3'==2, mlc(black) mlw(*.5) mc("49 104 142%60") msiz(*1.5) jitter(1)
|| scatter `1' `2' if `3'==4, mlc(black) mlw(*.5) mc("53 183 121%60") msiz(*1.5) jitter(1)
|| scatter `1' `2' if `3'==3, mlc(black) mlw(*.5) mc("253 231 37%60") msiz(*1.5) jitter(1)

||, legend(off) xlabel( `r(p25)' "`r(p25)'" `r(p50)' "`r(p50)'" `r(p75)' "`r(p75)'"  )
; 



* g23
sysuse auto, clear
graph set window fontface Magneto


tempvar rep
gen    `rep' = rep78
recode `rep' (1=2)  

#delimit ;
tw scatter price mpg if `rep'==2, mc("145 50 5")    mlw(*.5) mlc(black)  msiz(*1.5)  
|| scatter price mpg if `rep'==3, mc("221 95 11")   mlw(*.5) mlc(black)  msiz(*1.5)  
|| scatter price mpg if `rep'==4, mc("254 162 50")  mlw(*.5) mlc(black)  msiz(*1.5)  
|| scatter price mpg if `rep'==5, mc("254 211 112") mlw(*.5) mlc(black)  msiz(*1.5)    

|| , legend(off)                                                                           
                              
ylabel(, labc("254 211 112") glc("254 211 112") glw(*.2) angle(0))                                
xlabel(, labc("254 211 112") glc("254 211 112") glw(*.2)) 
                               
ytitle(, color("254 211 112")) 
xtitle(, color("254 211 112"))                               
title("Price versus Mpg", color("254 211 112") pos(11)) 

graphr(color("102 37 6*4"))  plotr(color("102 37 6*4"))      
;


tempvar rep
gen    `rep' = rep78
recode `rep' (1=2)  
local mopt "mlw(*.5) mlc(black)  msiz(*1.5)"
local col1 "254 211 112"
local col2 "102 37 6*4"

#delimit ;
tw scatter price mpg if `rep'==2, mc("145 50 5")    `mopt'   
|| scatter price mpg if `rep'==3, mc("221 95 11")   `mopt' 
|| scatter price mpg if `rep'==4, mc("254 162 50")  `mopt'
|| scatter price mpg if `rep'==5, mc("254 211 112") `mopt'   

|| , legend(off)                                                                           
                              
ylabel(, labc(`col1') glc(`col1') glw(*.2) angle(0))                                
xlabel(, labc(`col1') glc(`col1') glw(*.2)) 
                               
ytitle(, color(`col1')) xtitle(, color(`col1'))                               
title("Price versus Mpg", color(`col1') pos(11)) 

graphr(color(`col2'))  plotr(color(`col2'))      
;


tempvar rep
gen    `rep' = rep78
recode `rep' (1=2)  

local mopt "mlw(*.5) mlc(white) m()  msiz(*1.5) jitter(2)"
local col1 white
local col2 black

#delimit ;
tw scatter price mpg if `rep'==2, mc("145 50 5")    `mopt'   
|| scatter price mpg if `rep'==3, mc("221 95 11")   `mopt' 
|| scatter price mpg if `rep'==4, mc("254 162 50")  `mopt'
|| scatter price mpg if `rep'==5, mc("254 211 112") `mopt'   

|| , legend(off)                                                                           
     ylabel(, labc(`col1') glc(`col1') glw(*.2) angle(0))                                
     xlabel(, labc(`col1') glc(`col1') glw(*.2)) 
     ytitle(, color(`col1')) xtitle(, color(`col1'))                               
     title("Price versus Mpg", color(`col1') pos(11)) 
     graphr(color(`col2'))  plotr(color(`col2'))      
;


graph set window fontface arial

* g24

capture program drop sgraph 
program define sgraph

syntax varlist(min=3 max=3), [gops(string)]

tokenize `varlist'

* Légende
qui levelsof `3', local(l)
local i=1
local labn: value label `3'
foreach l2 of local l {
local lab`l2': label `labn' `l2'
local lab`l2' `""`lab`l2''""' 
local ord `ord' `i++' `lab`l2''
}

* syntaxe graphique
local i=1
foreach l2 of local l{
local ops "mlc(black) mlw(*.3) jitter(3) mc(%80) msiz(*1) mlc(`mlc')" 
local scat `scat' scatter `1' `2' if `3'==`l2', `ops' ||
}


tw `scat', legend(order(`ord') rows(1) pos(6) region(color(%0))) `title' `gops'

end

sgraph price mpg foreign, 
sgraph price mpg foreign, gops(graphr(color(black)) )


grstyle init 
grstyle set mesh, compact horizontal
grstyle set color hue, n(2)
foreach X of varlist mpg trunk weight length {
#delimit ;
sgraph price `X' foreign,
       gops( title("`X'") 
             name(`X', replace) nodraw
             ylabel(, labs(*.6)))
;
#delimit cr

local g `g' `X'	
}

mac list _g

grc1leg `g', legendfrom(mpg) pos(11) title("Variables combinées avec" "la variable price")










