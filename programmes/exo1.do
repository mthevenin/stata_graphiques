sysuse auto, clear

* Graphique(s) 1 

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
   legend(order(1 "Domestic" 2 "Foreign")  region(lcolor(%0))) 
   xlabel(10(10)50) 
;
   
drop mpg0 mpg1 x0 x1 d0 d1 // mettre des tempvar en amont pour alléger le prog (voir section macros)

* Graphique 2

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
