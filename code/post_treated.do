*gen DiD
gen did1 = treatment_group1 * year
gen did2 = treatment_group2 * year
gen did3 = treatment_group3 * year
gen did4 = treatment_group4 * year

*Insert outcome
*regress *INSERT OUTCOME* treatment time post_treatment *CONTROLS*

gen treatment_group1 = 1 if inlist(area, 31,33,38)
gen treatment_group2 = 1 if inlist(area, 36, 35, 34, 41, 42)
gen treatment_group3 = 1 if inlist(area, 32, 37)
gen treatment_group4 = 1 if inlist(area, 39)
gen control_group = 1 if inlist(area, 40)

foreach var in treatment_group1 treatment_group2 treatment_group3 treatment_group4 control_group {
  local varname "`var'"
  replace `varname' = 0 if missing(`varname')
}

foreach var in treatment_group1 treatment_group2 treatment_group3 treatment_group4 control_group {
	local varname "`var'"
	gen treat1_"`var'"_mean = mean("`var'") if 
}

egen avg_itm823_treatment1 = mean(itm823) if treatment_group1 == 1, by(year)
egen avg_itm823_treatment2 = mean(itm823) if treatment_group1 == 2, by(year)

foreach var in itm820 itm821 itm822 itm823 itm825 itm826 itm827 itm828 {
	local varname "`var'"
	egen avg_`var'_treatment1 = mean(`var') if treatment_group1 == 1, by(year)
	egen avg_`var'_treatment2 = mean(`var') if treatment_group2 == 1, by(year)
	egen avg_`var'_treatment3 = mean(`var') if treatment_group3 == 1, by(year)
	egen avg_`var'_treatment4 = mean(`var') if treatment_group4 == 1, by(year)
	egen avg_`var'_control = mean(`var') if control_group == 1, by(year)
}


foreach var in itm760 itm761 itm762 itm763 itm770 itm771 itm775 itm777 {
	local varname "`var'"
	egen avg_`var'_treatment1 = mean(`var') if treatment_group1 == 1, by(year)
	egen avg_`var'_treatment2 = mean(`var') if treatment_group2 == 1, by(year)
	egen avg_`var'_treatment3 = mean(`var') if treatment_group3 == 1, by(year)
	egen avg_`var'_treatment4 = mean(`var') if treatment_group4 == 1, by(year)
	egen avg_`var'_control = mean(`var') if control_group == 1, by(year)
}

gen transit_industry = 1 if b8_1 == 61
