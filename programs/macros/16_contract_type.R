# Title: Cleaning tenure variable
# Description: creates consistency for contract type 
# Author: Vitor Costa 
# Date: October 2018

# Year 2002 is the only where contract type was recorded with its labels and not numeric codes.

var = "contract_type"
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT U/PJ IND",10,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT U/PF IND",15,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT R/PJ IND",20,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT R/PF IND",25,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("ESTATUTARIO",30,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("ESTAT RGPS",31,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("ESTAT N/EFET",35,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("AVULSO",40,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("TEMPORARIO",50,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("APREND CONTR",55,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT U/PJ DET",60,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT U/PF DET",65,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT R/PJ DET",70,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CLT R/PF DET",75,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("DIRETOR",80,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CONT PRZ DET",90,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CONT TMP DET",95,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CONT LEI EST",96,x)), .SD = var]
raw_panel[yr == "2002", (var) := lapply(.SD, function(x) gsub("CONT LEI MUN",97,x)), .SD = var]


