clear
cd "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years"
use "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc1997.dta"
keep if inlist(b15_1,01,63)
gen itm1110 = itm823

append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc1998.dta"
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc1999.dta"
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2000.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2001.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2002.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2003.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2004.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2005.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2006.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2007.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2008.dta", force 
keep if inlist(b15_1,01,63)
replace itm1110 = itm823
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2009.dta", force
keep if inlist(b15_1,01,63)
replace itm1110 = itm1007
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2010.dta", force
keep if inlist(b15_1,01,63)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2011.dta", force
keep if inlist(b15_1,63,65)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2012.dta", force
keep if inlist(b15_1,63,65)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2013.dta", force
keep if inlist(b15_1,63,65)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2014.dta", force
keep if inlist(b15_1,63,65)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2015.dta", force
keep if inlist(b15_1,63,65)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2016.dta", force
keep if inlist(b15_1,63,65)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2017.dta", force
keep if inlist(b15_1,63,65,68)
append using "C:\Users\griff\Downloads\Coding\StataScripts\Taiwan Research\Thesis\years\inc2018.dta", force
keep if inlist(b15_1,63,65,68)

save master

