# Title: Cleaning tenure variable
# Description: creates consistency for establishment size 
# Author: Vitor Costa 
# Date: October 2018

# Beginning in 2011, codes 0-9 were reported as 1-10. 
var = "establishment_size"
yr2treat = c("2011","2012","2013","2014")

raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("01",0,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("02",1,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("03",2,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("04",3,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("05",4,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("06",5,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("07",6,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("08",7,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("09",8,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("10",9,x)), .SD = var]
