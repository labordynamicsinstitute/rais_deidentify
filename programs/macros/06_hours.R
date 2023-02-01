# Title: Cleaning sex/gender codification
# Description: attributes consistent coding for sex/gender
# Author: Vitor Costa 
# Date: October 2018

# Beginning in 2011, hours 1-9 were reported as 01-09.

var = "hired_hours"
yr2treat = c("2011","2012","2013","2014")

raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("01",1,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("02",2,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("03",3,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("03",4,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("04",5,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("05",6,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("06",5,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("07",7,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("08",8,x)), .SD = var]
raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("09",9,x)), .SD = var]
