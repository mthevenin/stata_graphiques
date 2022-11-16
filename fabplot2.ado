*! 1.2.1 NJC 7  May 2021 
*! 1.2.0 NJC 5  January 2021 
*! 1.1.0 NJC 27 August 2020  
*! 1.0.0 NJC 10 June 2018 

capt program drop fabplot2
program fabplot2
	version 9     
	gettoken cmd 0 : 0 
	gettoken y 0 : 0 
	gettoken x 0 : 0, parse(" ,")

	unab y : `y' 
	capture confirm numeric variable `y' 
	local error = _rc
	unab x : `x' 
	capture confirm numeric variable `x'
	local error = max(`error', _rc) 
	 
	if `error' { 
		di as err "syntax is fabplot {it:command} {it:yvar xvar}" 
		exit 198 
	} 

	syntax [if] [in], by(str asis) ///
	[ front(str) frontopts(str asis) backopts(str asis) NEEDvars(str) ADDPLOT(str asis) ///
	select(str asis) MISSing *] 
	
	gettoken byvar byopts : by, parse(,) 
	gettoken comma byopts : byopts, parse(,) 
	confirm variable `byvar' 
	
	local varlist `y' `x' 
	marksample touse
	if "`missing'" == "" markout `touse' `byvar', strok 
	quietly count if `touse' 
	if r(N) == 0 error 2000
 		
	quietly if `"`select'"' != "" { 
		capture levelsof `byvar' if `select', local(levels) sep(,) 
		if _rc { 
			di "select(`select') error?" 
			exit 498
		} 
	}

	preserve 
	
	quietly { 
		keep if `touse' 
		keep `varlist' `byvar' `needvars' 

		tempvar id panel group 
		gen long `id' = _n
		egen `panel' = group(`byvar'), label `missing'  
		su `panel', meanonly 
		expand `r(max)' 
		bysort `id' : gen long `group' = _n  
		label val `group' `panel' 
		separate `y', by(`panel' == `group')
	}
	
	local ytitle : variable label `y' 
	if `"`ytitle'"' == "" local ytitle "`y'" 
	if "`front'" == "" local front "`cmd'" 
	sort `group' `byvar' `x'

	if inlist("`cmd'", "line", "connected")   local lopts c(L) 
	if inlist("`front'", "line", "connected") local flopts lp(solid) lc(blue) 

	quietly if `"`select'"' != "" { 
		levelsof `panel' if inlist(`byvar', `levels'), ///
		local(LEVELS) sep(,) 
		keep if inlist(`group', `LEVELS') 
	}

	twoway  `cmd' `y'0 `x'            , mc(gs10) ms(+) `backopts'  ///
	by(`group', note("`note'") legend(off) `byopts')               ///
	subtitle(, fcolor())                                 ///
	ytitle(`"`ytitle'"') yla(, ang(h))   `lopts'  `options'        ///
	|| `front' `y'1 `x', mc(blue) ms(oh) `flopts' `frontopts'      ///
	|| `addplot'  

end
 
