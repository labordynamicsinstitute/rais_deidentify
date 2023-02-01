# Title: Cleaning tenure variable
# Description: changes decimal symbol from "," to ".". I also changes format from character to numeric 
# Author: Vitor Costa 
# Date: February 2018

# Setting variable name
var = "tenure"

raw_panel[, (var) := lapply(.SD, function(x) as.numeric(gsub(",","\\.",x))), .SD = var]