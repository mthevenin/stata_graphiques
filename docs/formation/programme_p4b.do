colorpalette rocket, select(9 14)

grstyle init
grstyle set plain

sysuse nlsw88, clear

grstyle init
grstyle set mesh, compact horizontal

******* HISTOGRAMME *******

tw histogram wage, fc("225 50 67%80") lc(black) lw(*.2) percent

* Empilement histogramme: not good

local opts  lc(black) lw(*.2) percent 
tw histogram wage if !south, fc("247 208 181%80")   `opts' ///
|| histogram wage if  south, fc("225 50 67%80")  `opts'    ///
|| , legend(order(1 "Not South" 2 "South") region(color(%0)))

local opts  fc(%0) lw(*1) percent 
tw histogram wage if !south, lc("247 208 181%80")    `opts'    ///
|| histogram wage if  south, lc("225 50 67%80")      `opts'    ///
|| , legend(order(1 "Not South" 2 "South") region(color(%0)))

* Facette histogram: good
tw histogram wage , fc("225 50 67%80") lc(black) lw(*.2) percent  by(south,  note(" "))  ylabel(0(5)25)


******* DENSITES *******

* net from https://raw.githubusercontent.com/benjann/violinplot/main/
* net install violinplot, replace


** pas de comparaison
* une densité avec kdensity
kdensity wage, note("")  recast(area) fc("225 50 67") lc(black) lw(*.5) title("")

*  une densité avec violinplot
violinplot wage, colors("225 50 67") fill p1(lc(black) lw(*.2))  ///
left nomed nobox nowhisker

* une densité en mirroir avec liolinplot
violinplot wage, colors("225 50 67") fill p1(lc(black) lw(*.2)) ///
nomed nobox nowhisker


violinplot wage,                                                                            ///
over(south)  horizontal left nomed nobox                                                    ///
colors("247 208 181" "225 50 67",  opacity(80)) lcolors(black) fill p1(lw(*.2)) p2(lw(*.2)) ///
legend(order(1 "Not South" 2 "South") region(color(%0)))


**** Comparaison
* Overlay demi Remplissage
violinplot wage,                                                                            ///
over(south) overlay horizontal left nomed                                                   ///
colors("247 208 181" "225 50 67",  opacity(80)) lcolors(black) fill p1(lw(*.2)) p2(lw(*.2)) ///
legend(order(1 "Not South" 2 "South") region(color(%0)))

* Overlay demi  sans remplissage
violinplot wage,                                                                            ///
over(south) overlay horizontal nomed left                                                   ///
colors("247 208 181" "225 50 67",     opacity(80))                                          ///
legend(order(1 "Not South" 2 "South") region(color(%0)))    

* Split
violinplot wage,  split(south) nomed nobox nowhisker   ///
colors("247 208 181" "225 50 67")                      ///
legend(order(1 "Not South" 2 "South") region(color(%0)))   
 
* Overlay mirroir sans remplissage
violinplot wage,                                               ///
over(south) overlay  nomed                                     ///
colors("247 208 181" "225 50 67")                              ///
legend(order(1 "Not South" 2 "South") region(color(%0)))    




*** Facette
violinplot wage,                                                                            ///
by(south) overlay horizontal left nomed                                                     ///
colors("225 50 67") lcolors(black) fill                                                     ///
legend(order(1 "Not South" 2 "South") region(color(%0))) p1(lw(*.5))


*** Si trop de modalité sur l'axe discret: préferer l'option over() sans overlay

recode occupation (9 10 11 12 = 13 )

violinplot wage,  over(occupation) nomed nobox nowhisker   ///
colors(tableau)  pdf(ll(0))

gridge wage, over(occupation) sortrev(median) range(0 40)








                                



