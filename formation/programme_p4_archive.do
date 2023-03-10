


webuse set https://github.com/mthevenin/stata_graphiques/tree/main/bases
use rbnb_paris, replace
webuse set

drop if price==.
drop if price > 300

histogram price , fraction ///
ylabel(,angle(0)) fc("217 83 93") lc("237 176 129") lw(*.5)


qui sum price, d
local med = `r(p50)'
histogram price  , by(zone) fraction fc("217 83 93") lc("237 176 129") lw(*.5) xline(`med', lc("143 51 113"))

egen mp = median(price), by(zone)
egen tag = tag(zone)
egen rank = rank(-mp) if tag==1
replace rank=0 if rank==.
bysort zone: egen rank2 = total(rank)

egen zone2   = axis(rank2 zone) , label(zone)
drop rank rank2


qui sum price, d
local med = `r(p50)'
histogram price  , by(zone2) fraction ///
fc("217 83 93") lc("237 176 129") lw(*.5) xline(`med', lc("143 51 113"))


*** Densité

capt kdensity price if price<300, gen(x d) n(100) nograph 
tw line d x if x>0, recast(area) 

grstyle init
grstyle set imesh, compact
grstyle set color flare, select(9 1) opacity(80)
grstyle set legend 11, nobox


local z 3 8
local j =1 
**# Bookmark #1

foreach z2 of local z {
local i = `j++'
capt kdensity price if price<300 & zone==`z2', gen(x`i' d`i') n(100) nograph    
 }

#delimit ;

tw line d1 x1 if x1>0, recast(area) 
|| line d2 x2 if x2>0, recast(area) 
|| , legend(order(1 "Buttes Chaumont" 2 "Louvre")) 
      ylab(, labc(%0)) ytitle("")
	  ;

histogram price  , by(zone2) fraction ///
fc("%0") lc("%0")  kdensity kdenopts(lw(*0) recast(area) fc("217 83 93"))
	  

	  
** ridge	  
tempvar x0 d0
qui kdensity price, gen(`x0' `d0') kernel(gauss) nograph
qui sum `d0'
local maxd `r(max)'

glevelsof -zone2, local(l)
qui sum zone2
local ymin `r(min)'
local ymax `r(max)'

local wc: word count(`l') 
local n_1= `wc' - 1
local yrange = `ymax' - `ymin'

local iscale `yrange'/(`n_1'*`maxd')

* Syntaxe du graphique
foreach j of local l {
gen y0_`j' = `j'
qui kdensity p if zone2==`j', kernel(gauss) n(50) bw(4) gen(x_`j' d_`j') nograph
qui gen y1_`j' = y0_`j' + d_`j'*`iscale'*2

colorpalette tab 20, nograph n(20) opacity(100) 

local graph `graph' rarea y0_`j' y1_`j' x_`j' if x_`j'>=0 , ///
                    lw(0) fc("`r(p`j')'") ||                            ///
                    rline  y0_`j' y1_`j' x_`j' if x_`j'>=0, lw(.2) lc(gs15) ||	
					}

* labels sur l'axe y
local labn: value label zone2
forv i=1/20 {
local  ylab`i' : label `labn' `i'
local ylab `ylab' `i' "`ylab`i''"
}
* Exécution du graphique
tw `graph',  legend(off)                                    ///
 graphr(color(gs15)) plotr(color(gs15))                     ///
 ylabel(`ylab', glw(0) labs(2) angle(0)) xlabel(,glw(0) labs(1.8))   ///
 title("Prix locations", pos(11) color(gs2)) xtitle("")

drop d_*
drop y* x* 
	  
	  
	  
	  
	  
	  
*************************	  
*** Lollipop + haltere **	  
*************************


* lollipop

sysuse nlsw88, clear	  
	  
drop if inlist(occupation,9,10,12)   

egen mwage = mean(wage), by(occupation)
egen occ   = axis(mwage occupation) , label(occupation)

#delimit ;
tw scatter occ mwage || dropline mwage occ, horizontal  
|| , ylab(1/10, valuelabel angle(0)) 
     xlab(0(2)12)
     legend(off)
;

qui sum wage
local m = `r(mean)' 
di `m'

local mopts mc("220 87 92") msize(*2) mlc(black) mlw(*.1) 
local lopts lc("220 87 92") lw(*1.2)

#delimit ;
tw dropline mwage occ, base(`m') horizontal  `lopts' 
|| scatter occ mwage, `mopts'
|| , ylab(1/10, valuelabel angle(0)) 
     xlab(0(1)12)
	 xline(`m', noext `lopts')
     legend(off)
	 xtitle("Salaires moyen")
	 ytitle("Emplois")
;

* haltère

sysuse nlsw88, clear

grstyle init
grstyle set imesh, horizontal
grstyle set color flare, select(1 6 11)
grstyle set legend 11, nobox



drop if inlist(occupation,9,10,12) 
drop if occupation==.
drop if union==.

preserve
collapse wage, by(occupation union)
reshape wide wage, i(occ) j(union)

egen wage3= rowmean(wage0 wage1)
egen occ = axis(wage3 occupation) , label(occupation)

#delimit ;
tw rspike wage0 wage1 occ, horizontal   
|| scatter occ wage0,                 
|| scatter occ wage1,  
            
|| , ylab(1/10, valuelabel)
     xlab(0(1)12)  
xtitle("Salaires moyens") ytitle("Emplois")
title("Salaire moyen selon la syndicalisation") 
legend(order(2 "Non syndiqué" 3 "Syndiqué")) 
;

restore