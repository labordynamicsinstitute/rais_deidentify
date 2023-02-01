# Title: Cleaning industry sector - CNAE - codes
# Description: attributes consistent coding for industry code - cnae
# Author: Vitor Costa 
# Date: October 2020

# Setting variable name


localNames = names(raw_panel)

var = "cnae95" 
if(var %chin% localNames){
# Cleaning steps
raw_panel[, (var) := lapply(.SD, function(x) as.integer(gsub("[a-z]| ","",x,ignore.case = T))), .SD = var] }

var = "cnae20" 
if(var %chin% localNames){
# Cleaning steps
raw_panel[, (var) := lapply(.SD, function(x) as.integer(gsub("[a-z]| ","",x,ignore.case = T))), .SD = var] }

var = "cnae20sub" 
if(var %chin% localNames){
# Cleaning steps
raw_panel[, (var) := lapply(.SD, function(x) as.integer(gsub("[a-z]| ","",x,ignore.case = T))), .SD = var] }