* v0.1 juillet 2022
* Marc Thevenin - Ined Sms

capture program drop gridge
program define gridge
syntax varlist(min=1 max=1) [if], over(string)    ///
                     [super(real 1.8)]            ///
					 [sort(string)]               ///
					 [sortrev(string)]            ///
					 [bw(real 1.5)]               ///
					 [PALette(string)]            ///
					 [OPac(integer 80)]           ///
					 [Range(numlist min=2 max=2)] /// 
					 [lc(integer 2)]              ///
			         [lw(real .5)]                ///
					 [gopts(string)]              

local varname `varlist'

	
if "`range'"!="" {	
tokenize `range'
local rmin = `1'
local rmax = `2'
}	


	
local packg colorpalette grstyle gtools
foreach p of local packg {
capture which `p'
if _rc==111 ssc install `p'
if _rc==111 di "Installation de  `p'"
} 


marksample touse      
markin if `touse'


if "`sort'"!="" {
tempvar stat 
tempvar tag 
tempvar rank 
tempvar rank2
tempvar over2
	
qui egen `stat' = `sort'(`varname')  if `touse', by(`over')
qui egen `tag' =  tag(`over') if `touse'
qui egen `rank' = rank(`stat') if `tag'==1 & `touse'
qui replace `rank'=0 if `rank'==. & `touse'
qui bysort `over': egen `rank2' = total(`rank') if `touse'
qui egen `over2'   = axis(`rank2' `over') , label(`over')	
}


if "`sortrev'"!="" {
tempvar stat 
tempvar tag 
tempvar rank 
tempvar rank2
tempvar over2
	
qui egen `stat' = `sortrev'(`varname'), by(`over')
qui egen `tag' =  tag(`over')
qui egen `rank' = rank(-`stat') if `tag'==1
qui replace `rank'=0 if `rank'==.
qui bysort `over': egen `rank2' = total(`rank')
qui egen `over2'   = axis(`rank2' `over') , label(`over')	
}



if "`sort'"=="" & "`sortrev'"=="" {
local over2 `over'	
}


if "`palette'"==""{
local pal viridis	
}
if "`palette'"!="" {
local pal `palette'			
}


tempvar x0 d0
qui kdensity `varname' if `touse', gen(`x0' `d0') kernel(gauss) nograph 
qui sum `d0'
local maxd `r(max)'

qui glevelsof -`over2' if `touse', local(l)

*local wc `r(j)'

qui sum `over2' if `touse'
local ymin `r(min)'
local ymax `r(max)'

local wc: word count(`l') 

local n_1= `wc' - 1
local yrange = `ymax' - `ymin'

local iscale `yrange'/(`n_1'*`maxd')

local i=`ymax'
local c=1

* Syntaxe du graphique

foreach j of local l {
gen y0_`j' = `i--'
qui kdensity `varname' if `over2'==`j' & `touse', kernel(gauss) n(200) gen(x_`j' d_`j') bw(`bw') nograph
qui gen y1_`j' = y0_`j' + d_`j'*`iscale'*`super' if `touse'

colorpalette `pal', nograph n(`wc') opacity(`opac') 

if "`range'" =="" {
local graph `graph' rarea y0_`j' y1_`j' x_`j'  ,                           ///
                    lw(0) fc("`r(p`c++')'")  ||                            ///
                    rline  y0_`j' y1_`j' x_`j' , lw(*`lw') lc(gs`lc') ||				

				
					
}

if "`range'" !="" {
local graph `graph' rarea y0_`j' y1_`j' x_`j' if x_`j'>=`rmin' & x_`j'<=`rmax'  ,                      ///
                    lw(0) fc("`r(p`c++')'")  ||                                                        ///
                    rline  y0_`j' y1_`j' x_`j' if x_`j'>=`rmin' & x_`j'<=`rmax' , lw(*`lw') lc(gs`lc') ||				
					}				
							
}


qui glevelsof -`over2' if `touse', local(l)				
local i = `ymax'			
local labn: value label `over2'
foreach l2 of local l {
local  ylab`l2' : label `labn' `l2'
local ylab `ylab' `i--' "`ylab`l2''"
}


* Exécution du graphique
tw `graph',  legend(off) ylabel(`ylab', glw(0) labs(2) angle(0))  `gopts'

drop x* d* y* 

end

