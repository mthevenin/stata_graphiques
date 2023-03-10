

***** NJ COX *******

* autres contributeurs on trouvera les programmes dans leur supports (liens donnés)

ssc install fabplot //commande d'origine


* Exemple 1 : effet spaghetti

net install fabplot2, ///
from("https://raw.githubusercontent.com/mthevenin/stata_graphiques/master/ressources/fabplot2/") replace // ajout d'une option

ssc install sencode // changement format avec contrôle des valeurs pour les labels


* préparation données

use "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/bases/fecondite.dta", clear

grstyle init
grstyle set plain, compact
grstyle set color flare, n(2) reverse


* Nettoyage base
replace pays = substr(pays,4,.)
drop if y1950==.

keep if inlist(pays,"Argentina", "United States of America", "Japan", "China, Taiwan Province of China", "Republic of Korea", "France", "Germany", "Italy", "Iceland" ) | inlist(pays, "TÃ¼rkiye", "Israel", "Portugal")

replace pays="Turkey" if pays=="TÃ¼rkiye"
replace pays="Taiwan" if pays=="China, Taiwan Province of China"


sencode pays, gen(pays50)  gsort(-y1950)
sencode pays, gen(pays22)  gsort(-y2022)
sencode pays, replace

order pays50 pays22, after(pays)

reshape long y, i(code) j(year)
order pays50, after(pays)

* graphique

fabplot2 line y year,  ///
by(pays22, title("Taux de fécondité", pos(11)) note("Source: GGP Datalab-Ined"))  ///
frontopts(lc("209 74 97") lw(*2)) xlabel(1950(10)2022, alt labsize(*.7)) backopts(lw(*.7) lc("gs10")) ///
xtitle("Year") ytitle("") ylabel(0(1)6)


* Exemple 2: effet paella

ssc install egermore // pour la commande axis (toujours NJ.Cox) pour l'ordre des sous graphiques, ici le salaire horaire moyen par profession.

sysuse nlsw88, clear

egen mwage = mean(-wage) if occupation!=., by(occupation)
egen occup = axis(mwage), label(occupation)

fabplot2 scatter wage ttl_exp, by(occup, title("Small multiple avec fabplot", pos(11)))   ///
frontopts(msize(*.7) mc("238 84 63")  msymbol(O)   mlc(black)   mlw(*.2))     ///
backopts(msize(*.7)  mc("gs15") msymbol(O) mlc(black) mlw(*.2))   


***** catplot

ssc install catplot

use "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/bases/titanic.dta", clear

use titanic, clear
collapse survived, by(age sex class)  // utiliser des frames si possible si stata v17

catplot age sex [aw=100*survived],                                     ///
by(class, title("Catplot de NJ.Cox", pos(11)) compact note("") col(1)) ///
bar(1, blcolor(white) bfcolor(84 163 205) blw(*.2))                    /// 
blabel(bar, format(%4.1f) pos(base))                                   ///
subtitle(, pos(9) ring(1) bcolor(none) nobexpand place(e))             ///
ytitle("% survived from Titanic", place(6))                            ///
var1opts(gap(0)) var2opts(gap(*.2)) outergap(*.2) ysize(5) yla(0(25)100, glcolor(%0) glw(*0)) plotr(lc(%0))

***** B JANN *******

ssc install heatplot

* hexplot

use "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/ressources/gjoint/logement.dta", clear

hexplot prix surface, ///
color(flare, reverse) p(lcolor(black) lalign(center) lw(*.5)) ///
legend(region(color(%0)) subtitle("%")) title("Hexplot de B.Jann", pos(11))

* heatplot












