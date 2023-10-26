*Appending data sets within my time horizon
append using "inc1992", force
append using "inc1993", force
append using "inc1994", force
append using "inc1995", force
append using "inc1996", force
append using "inc1997", force
append using "inc1998", force
append using "inc1999", force
append using "inc2000", force
append using "inc2001", force
append using "inc2002", force
append using "inc2003", force
append using "inc2004", force
append using "inc2005", force
append using "inc2006", force

*Dropping all vars that do not live in a district in Taipei
drop if !inlist(area, 31,32,33,34,35,36,37,38,39,40,41,42)
