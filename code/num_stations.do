*This script is for the creation of variables that tracks the number of stations in each district in each year

gen stations_in_district_1991 = 0
gen stations_in_district_1992 = 0
gen stations_in_district_1993 = 0
gen stations_in_district_1994 = 0
gen stations_in_district_1995 = 0
gen stations_in_district_1996 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_1997 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_1998 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_1999 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2000 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2001 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2002 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2003 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2004 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2005 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )
gen stations_in_district_2006 = 0 if inlist(area, ) | 1 if inlist(area, ) | 2 if inlist(area, ) | 2 if inlist(area, ) | 3 if inlist(area, )

*Stops at 2006 due to geographical abstraction from districts to cities. Consult Taiwanese gov data and translate
