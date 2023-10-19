*Creating dummies that track treatment to a specific year's expansion in a district and whether or not the survey was taken at the time of the survey opening 
gen timeoftreat1 =.
gen treatment1 =.

gen timeoftreat2 =.
gen treatment2 =.

gen timeoftreat3 =.
gen treatment3 =.

gen timeoftreat4 =.
gen treatment4 =.

*Assigning values to treatment and pre/post indicator variables from the first line
replace timeoftreat1 = 1 if inlist(year, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace timeoftreat1 = 0 if !inlist(year, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace treatment1 = 1 if inlist(area, 31, 33, 38)
replace treatment1 = 0 if !inlist(area, 31, 33, 38)

*Assigning values to treatment and pre/post indicator variables from the second line
replace timeoftreat2 = 1 if inlist(year, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace timeoftreat2 = 0 if !inlist(year, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace treatment2 = 1 if inlist(area, 36, 35, 34, 41, 42)
replace treatment2 = 0 if !inlist(area, 36, 35, 34, 41, 42)

*Assigning values to treatment and pre/post indicator variables from the fourth line
replace timeoftreat3 = 1 if inlist(year, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace timeoftreat3 = 0 if !inlist(year, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace treatment3 = 1 if inlist(area, 37, 32)
replace treatment3 = 0 if !inlist(area, 37, 32)

*Assigning values to treatment and pre/post indicator variables from the fifth line
replace timeoftreat5 = 1 if inlist(year, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace timeoftreat5 = 0 if !inlist(year, 2000, 2001, 2002, 2003, 2004, 2005, 2006)
replace treatment4 = 1 if inlist(area, 39)
replace treatment4 = 0 if !inlist(area, 39)
