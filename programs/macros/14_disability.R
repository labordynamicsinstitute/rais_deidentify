# Title: Cleaning tenure variable
# Description: creates consistency for disability type 
# Author: Vitor Costa 
# Date: October 2018

# Beginning in 2011, codes 0-6 were reported as 00-06

var = "disability_type"
yr2treat = c("2011","2012","2013","2014")
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("00",0,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("01",1,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("02",2,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("03",3,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("04",4,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("05",5,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("06",6,x)), .SD = var]

var = "disabled"
raw_panel[!(yr %in% c("2002",yr2treat)), (var) := lapply(.SD, function(x) ifelse(x=="0","1","0")), .SD = var]

# For all years, I'll treat code "-1" as NA
raw_panel[, (var) := lapply(.SD, function(x) gsub("-1","NA",x)), .SD = var]