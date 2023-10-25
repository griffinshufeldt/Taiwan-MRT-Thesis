*This script is for the creation of variables that tracks the number of stations in each district in each year

gen stations_in_district_1991 = 0
gen stations_in_district_1992 = 0
gen stations_in_district_1993 = 0
gen stations_in_district_1994 = 0
gen stations_in_district_1995 = 0
gen stations_in_district_1996 = 0
*1996
replace stations_in_district_1996 = 0 if inlist(area, 32, 34, 35, 36, 37, 39, 40, 41, 42)
replace stations_in_district_1996 = 2 if area == 31
replace stations_in_district_1996 = 5 if inlist(area, 33, 38)
*1997
gen stations_in_district_1997 = 0
replace stations_in_district_1997 = 0 if inlist(area, 32, 37, 39, 40)
replace stations_in_district_1997 = 1 if inlist(area, 34, 35)
replace stations_in_district_1997 = 2 if inlist(area, 31, 36, 41)
replace stations_in_district_1997 = 5 if inlist(area, 33, 38)
replace stations_in_district_1997 = 7 if inlist(area, 42)
*1998
gen stations_in_district_1998 = 0
replace stations_in_district_1998 = 0 if inlist(area, 32, 37, 39, 40)
replace stations_in_district_1998 = 1 if inlist(area, 34)
replace stations_in_district_1998 = 2 if inlist(area, 31, 36, 41)
replace stations_in_district_1998 = 4 if inlist(area, 35)
replace stations_in_district_1998 = 5 if inlist(area, 33, 38)
replace stations_in_district_1998 = 7 if inlist(area, 42)
*1999
gen stations_in_district_1999 = 0
replace stations_in_district_1999 = 0 if inlist(area, 39, 40)
replace stations_in_district_1999 = 1 if inlist(area, 34, 37)
replace stations_in_district_1999 = 2 if inlist(area, 31, 32, 36, 41)
replace stations_in_district_1999 = 7 if inlist(area, 38, 42)
replace stations_in_district_1999 = 8 if inlist(area, 33, 35)
*2000
gen stations_in_district_2000 = 0
replace stations_in_district_2000 = 0 if inlist(area, 40)
replace stations_in_district_2000 = 1 if inlist(area, 34, 37)
replace stations_in_district_2000 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2000 = 3 if inlist(area, 32)
replace stations_in_district_2000 = 7 if inlist(area, 38, 42)
replace stations_in_district_2000 = 8 if inlist(area, 33, 35)
*2001
gen stations_in_district_2001 = 0
replace stations_in_district_2001 = 0 if inlist(area, 40)
replace stations_in_district_2001 = 1 if inlist(area, 34, 37)
replace stations_in_district_2001 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2001 = 3 if inlist(area, 32)
replace stations_in_district_2001 = 7 if inlist(area, 38, 42)
replace stations_in_district_2001 = 8 if inlist(area, 33, 35)
*2002
gen stations_in_district_2002 = 0
replace stations_in_district_2002 = 0 if inlist(area, 40)
replace stations_in_district_2002 = 1 if inlist(area, 34, 37)
replace stations_in_district_2002 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2002 = 3 if inlist(area, 32)
replace stations_in_district_2002 = 7 if inlist(area, 38, 42)
replace stations_in_district_2002 = 8 if inlist(area, 33, 35)
*2003
gen stations_in_district_2003 = 0
replace stations_in_district_2003 = 0 if inlist(area, 40)
replace stations_in_district_2003 = 1 if inlist(area, 34, 37)
replace stations_in_district_2003 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2003 = 3 if inlist(area, 32)
replace stations_in_district_2003 = 7 if inlist(area, 38, 42)
replace stations_in_district_2003 = 8 if inlist(area, 33, 35)
*2004
gen stations_in_district_2004 = 0
replace stations_in_district_2004 = 0 if inlist(area, 40)
replace stations_in_district_2004 = 1 if inlist(area, 34, 37)
replace stations_in_district_2004 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2004 = 3 if inlist(area, 32)
replace stations_in_district_2004 = 7 if inlist(area, 38, 42)
replace stations_in_district_2004 = 8 if inlist(area, 33, 35)
*2005
gen stations_in_district_2005 = 0
replace stations_in_district_2005 = 0 if inlist(area, 40)
replace stations_in_district_2005 = 1 if inlist(area, 34, 37)
replace stations_in_district_2005 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2005 = 3 if inlist(area, 32)
replace stations_in_district_2005 = 7 if inlist(area, 38, 42)
replace stations_in_district_2005 = 8 if inlist(area, 33, 35)
*2006
gen stations_in_district_2006 = 0
replace stations_in_district_2006 = 0 if inlist(area, 40)
replace stations_in_district_2006 = 1 if inlist(area, 34, 37)
replace stations_in_district_2006 = 2 if inlist(area, 31, 36, 39, 41)
replace stations_in_district_2006 = 3 if inlist(area, 32)
replace stations_in_district_2006 = 7 if inlist(area, 38, 42)
replace stations_in_district_2006 = 8 if inlist(area, 33, 35)

gen num_stations = 0
replace num_stations = stations_in_district_1996 if year == 1996
replace num_stations = stations_in_district_1997 if year == 1997
replace num_stations = stations_in_district_1998 if year == 1998
replace num_stations = stations_in_district_1999 if year == 1999
replace num_stations = stations_in_district_2000 if year == 2000
replace num_stations = stations_in_district_2001 if year == 2001
replace num_stations = stations_in_district_2002 if year == 2002
replace num_stations = stations_in_district_2003 if year == 2003
replace num_stations = stations_in_district_2004 if year == 2004
replace num_stations = stations_in_district_2005 if year == 2005
replace num_stations = stations_in_district_2006 if year == 2006


*Stops at 2006 due to geographical abstraction from districts to cities. Consult Taiwanese gov data and translate
