

******** g1 **********

sysuse uslifeexp.dta , clear

graph drop _all
tw line  le_male le_female year, name(g1)

#delimit ;
tw line  le_male le_female year,                                          
   lc(*.8 *1.2)                                                                  
   lw(*4 *4)                                                               
   title("Espérance de vie aux USA", pos(11))                                      
   legend(order(1 "Hommes" 2 "Femmes") pos(4) col(1) ring(0))             
   ylabel(35(5)80, angle(0)) 
   xtitle("Année")   
   graphr(color(white)) plotr(color(white))
   name(g2)
;   

#delimit cr
graph combine g1 g2, ///
plotr(color(wite)) graphr(color(white)) ysize(15) xsize(10) col(1)


******** g2 **********

graph drop _all

sysuse auto, clear

#delimit
tw 
   scatter price mpg if !foreign
|| scatter price mpg if  foreign
||, legend(order(1 "US" 2 "Autres")) name(g1)
;


#delimit ;
tw 
   scatter price mpg if !foreign, 
   mc("31 161 135%60") msize(*1.5) mlc(black)  mlw(.3)  jitter(1)
|| scatter price mpg if  foreign, 
   mc("207 225 28%60") msize(*1.5) mlc(black)  mlw(.3)  jitter(1) 

||,
    title("{bf: Prix et consommation selon l'origine}", pos(11))   
    legend(order(1 "US" 2 "Autres"))
    ylabel(5000 "5k" 10000 "10k" 15000 "15k", angle(0)) 
    xtitle("Consommation (miles par gallon)") 
	ytitle("Prix")
    graphr(color(white)) plotr(color(white)) name(g2)
;

# delimit cr
graph combine g1 g2, ///
plotr(color(wite)) graphr(color(white)) ysize(15) xsize(10) col(1)



preserve
separate price, by(foreign)

#delimit ;
tw scatter price0 price1 mpg,                                                 
	mc("31 161 135%60" "207 225 28%60") mlc(black black)
	msize(*1.5 *1.5)  mlw(.3)  
	jitter(1)
	
	title("{bf: Prix et consommation selon l'origine}", pos(11))   
    legend(order(1 "US" 2 "Autres"))
    ylabel(5000 "5k" 10000 "10k" 15000 "15k", angle(0)) 
    xtitle("Consommation (miles par gallon)") 
	ytitle("Prix")
    graphr(color(white)) plotr(color(white)) 
;

restore 


**** Exo 1

sysuse auto, clear

qui separate mpg, by(foreign)

kdensity mpg0 , g(x1 d1) nograph k(gauss) n(200)
kdensity mpg1 , g(x0 d0) nograph k(gauss) n(200)
 
* histogrammes 
#delimit ; 
tw 
   histogram mpg0  , bin(10)  density fcolor("34 94 168%70")   lc(black) lw(vvthin)   
|| histogram mpg1  , bin(10)  density fcolor("139 209 187%70") lc(black) lw(vvthin)   
|| , legend(order(1 "Domestic" 2 "Foreign") region(lcolor(%0))) 
	 xlabel(10(10)50)
;

* densités
#delimit ;
tw area d1 d0 x0, 
   fc("34 94 168%70" "139 209 187%70") lc(black black) lw(vthin vthin) 
   legend(order(1 "Domestic" 2 "Foreign") region(lcolor(%0))) 
   xlabel(10(10)50) 
;
   
**** Exo 2

#delimit ;
tw 
|| scatter price mpg  if !foreign,
   msize(*1.5)  mlc(black) mlw(*.5) mc("34 94 168*.5") jitter(1)   
|| scatter price mpg  if foreign,  
   msize(*1.5)  mlc(black) mlw(*.5) mc("139 209 187*.5") jitter(1)  
	
||  lfitci  price mpg  if !foreign, 
	clc("34 94 168*1.2")    fc("34 94 168%25")  alc(%0)       
|| lfitci  price mpg  if foreign,  
    clc("139 209 187*1.2")  fc("139 209 187%25") alc(%0) 
	
|| , legend(order(1 "Domestic" 2 "Foreign") region(lc(%0))) ///                                          
     ytitle("price") 
	 xtitle("mpg")
	 plotr(color(white)) graphr(color(white)) 
;


tw scatter price mpg, msize(*1.5) mc("34 94 168") mlc(black) mlw(*.2) ///
plotr(color(white)) graphr(color(white)) ///
ylabel(, angle(0) glc(black) glw(vthin)) ///
xtitle("{bf:mpg}", place(right) height(5)) ytitle("{bf:price}", orient(horizontal) place(top) width(5)) ///
title("Modification du placement des titres des axes", pos(11))




********* combinaison 

grstyle init
grstyle set mesh, compact

tw scatteri 1 1, ylab(,nogrid) xlab(,nogrid) mc(%0) xtitle("") ytitle("") yscale(off noline) xscale(off noline) nodraw ///
                name(gv,replace) xsize(25) ysize(25) text(1 1 "Prix et" "consommation")



#delimit ;

 histogram price, bin(20) freq
 fc("31 161 135%70") lc(%0)   
 xtitle(, color(%0)) 
 ytitle(, color(%100)) 
 xlabel(,glw(*.2)) 
 ylabel(, labc(%0) glw(*.3))
 fxsize(50) fysize(100)
 xscale(reverse)
 name(g1,replace) horizontal 
 ;


 histogram mpg, bin(20) freq
 fc("31 161 135%70") lc(%0) 
 xtitle(,color(%0)) 
 ytitle(,color(%0)) 
 ylabel(, glw(*.2)) 
 xlabel(, labc(%0) glw(*.3))
 fxsize(100) fysize(50)
 name(g2,replace) 
 ;


tw scatter price mpg,  
mc("31 161 135%70") mlc(black) mlw(*.6)  jitter(1) 
ytitle(, color(%0)) 
fxsize(100) fysize(100) 
name(g3,replace)
;

graph combine   gv g2 g1 g3, xsize(20) ysize(20) col(2) graphr(margin(5 5 5 5)) imargin(-5 -5 -5 -5);


*********  exo avec box

#delimit ;
graph box price, 
box(1,fc("31 161 135%70") lc(gs8) lw(*1)) 
marker(1, mc("31 161 135%70") mlc(black) mlw(*.6))
cwhiskers lines(lc(gs8) lw(*1.5))
name(g1,replace)
fxsize(25) fysize(100)
ylabel(, labc(%00) glw(*0))
graphr(margin(5 0 0 0))
nooutsides note("")

;

#delimit ;
graph hbox mpg, 
box(1,fc("31 161 135%70") lc(gs8) lw(*1)) 
marker(1, mlw(*0))
cwhiskers lines(lc(gs8) lw(*1.5))
name(g2,replace)
fysize(25) fxsize(100)
ylabel(, labc(%00) glw(*0))
ytitle(, c(%0))
graphr(margin(9 0 0 0))
nooutsides note("")
;


#delimit ;
graph combine   gv g2 g1 g3, xsize(20) ysize(20) col(2) imargin(-3 -3 -3 -3) note("") ;








