# Title: Cleaning tenure variable
# Description: creates consistency for workers race
# Author: Vitor Costa 
# Date: October 2018

# Beginning in 2011, codes 1,2,4,6,8,9 were coded as 01,02,04,06,08,09

localNames = names(raw_panel)

var = "race_color"

if(var %chin% localNames){
  yr2treat = c("2011","2012","2013","2014")
  
  raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("01",1,x)), .SD = var]
  raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("02",2,x)), .SD = var]
  raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("04",4,x)), .SD = var]
  raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("06",6,x)), .SD = var]
  raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("08",8,x)), .SD = var]
  raw_panel[yr %in% yr2treat, (var) := lapply(.SD, function(x) gsub("09",9,x)), .SD = var]
  
  # For years 2003-2010, NAs were coded as "-1". From 2011 to 2014, as "99"
  raw_panel[, (var) := lapply(.SD, function(x) gsub("-1|99","",x)), .SD = var]
}
