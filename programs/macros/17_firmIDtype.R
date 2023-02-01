# Title: Cleaning tenure variable
# Description: creates consistency for firm ID type (either CEI or CNPJ)
# Author: Vitor Costa 
# Date: November 2018

# Year 2002 is the only where contract type was recorded with its labels and not numeric codes.

var = "firmID_type"
raw_panel[,(var):= lapply(.SD, function(x) gsub("01","1",x)), .SD = var]
raw_panel[,(var):= lapply(.SD, function(x) gsub("03|3","0",x)), .SD = var]
