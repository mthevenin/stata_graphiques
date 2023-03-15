capt program drop addnlab
program define addnlab

	syntax varlist [if] [in], [back]

    marksample touse
	local X `varlist'

	if "`back'"=="" { 
		foreach var of local X {
			local labn : value label `var'

			* check if  n(n) already added
			local eval = regexm("`labn'", "_N_")
			if `eval'==1 {
				di as error "One or more Variables have already observations added to label"
				di as error "First, execute: {it:addnlab varlist, back}""
				di as error "{it:varlist}: previous variable(s) added to addnlab"
				exit	

			}

			qui levelsof `var', local(l)			
			foreach i of local l {
				qui sum `var' if `var'==`i' & `touse'
				local n`i' = `r(N)'
				local lab`i' : label  `labn' `i' 
				local lab `lab' `i' "`lab`i'' (`n`i'')"	
			}

			label define `labn'_N_ `lab', modify
			label value `var' `labn'_N_
		}

	}

	if "`back'"!="" {

		local X `varlist'
		foreach var of local X {

			local labn : value label `var'
            local lab  : subinstr local labn "_N_" " "
            label drop `labn'
 			label value `var' `lab'
		}
	}
end


