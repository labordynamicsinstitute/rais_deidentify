# Title: Cleaning sex/gender codification
# Description: attributes consistent coding for sex/gender
# Author: Vitor Costa 
# Date: February 2018

# Setting variable name

var = "sex" 

# Cleaning steps
raw_panel[, (var) := lapply(.SD, function(x) gsub("1|MASCULINO|01",0,x)), .SD = var]
raw_panel[, (var) := lapply(.SD, function(x) gsub("2|FEMININO|02",1,x)), .SD = var]
