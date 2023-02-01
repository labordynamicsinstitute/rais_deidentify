# Title: Cleaning occupation code - CBO
# Description: attributes consistent coding for occupation code - CBO
# Author: Vitor Costa 
# Date: October 2020


localNames = names(raw_panel)

# Setting variable name
var = "cbo94" 
if(var %chin% localNames){
  # Cleaning steps
  raw_panel[, (var) := lapply(.SD, function(x) as.integer(gsub("[a-z]| ","",x,ignore.case = T))), .SD = var]
}

var = "cbo02" 

if(var %chin% localNames){
  # Cleaning steps
  raw_panel[, (var) := lapply(.SD, function(x) as.integer(gsub("[a-z]| ","",x,ignore.case = T))), .SD = var]
}