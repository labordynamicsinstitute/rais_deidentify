# Title: Cleaning tenure variable
# Description: creates consistency for schooling 
# Author: Vitor Costa 
# Date: October 2018

# Beginning in 2011, categories 1-9 were reported as 01-09
var = "schooling"
yr2treat = c("2011","2012","2013","2014")
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("01",1,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("02",2,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("03",3,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("04",4,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("05",5,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("06",6,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("07",7,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("08",8,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("09",9,x)), .SD = var]

##################
## ATTENTION !!! #
##################
# In 2008, based on the metadata, table 5_4_5_schooling.csv, I will assume the code for '10' -
# college graduate - was mistakenly reported as '-1'; and the code for '11' - masters graduate -
# was mistakenly reported as '10'.
raw_panel[yr == "2008", (var) := lapply(.SD, function(x) gsub("10",11,x)), .SD = var]
raw_panel[yr == "2008", (var) := lapply(.SD, function(x) gsub("-1",10,x)), .SD = var]


