# Title: Cleaning eranings variables 
# Description: changes decimal symbol from "," to ".". I also changes format from character to numeric 
# Author: Vitor Costa 
# Date: February 2018

# Setting variable name

localNames = names(raw_panel)
# earn = c("mean_earn","hired_wage","earn_jan","earn_feb","earn_march","earn_april","earn_may","earn_june",
#   "earn_july","earn_august","earn_sept","earn_oct","earn_nov","earn_dec","earn_dec_mw","mean_earn_mw","last_wage")

# earn = earn[earn %chin% names(raw_panel)]

# for (i in earn){
#   var = i
#   raw_panel[, (var) := lapply(.SD, function(x) as.numeric(gsub(",","\\.",x))), .SD = var]
# }

if("mean_earn" %chin% localNames){raw_panel[, mean_earn := as.numeric(gsub(",","\\.",mean_earn))]}
if("hired_wage" %chin% localNames){raw_panel[, hired_wage:= as.numeric(gsub(",","\\.",hired_wage))]}
if("earn_jan" %chin% localNames){raw_panel[, earn_jan:= as.numeric(gsub(",","\\.",earn_jan))]}
if("earn_feb" %chin% localNames){raw_panel[, earn_feb:= as.numeric(gsub(",","\\.",earn_feb))]}
if("earn_march" %chin% localNames){raw_panel[, earn_march:= as.numeric(gsub(",","\\.",earn_march))]}
if("earn_april" %chin% localNames){raw_panel[, earn_april:= as.numeric(gsub(",","\\.",earn_april))]}
if("earn_may" %chin% localNames){raw_panel[, earn_may:= as.numeric(gsub(",","\\.",earn_may))]}
if("earn_june" %chin% localNames){raw_panel[, earn_june:= as.numeric(gsub(",","\\.",earn_june))]}
if("earn_july" %chin% localNames){raw_panel[,earn_july := as.numeric(gsub(",","\\.",earn_july))]}
if("earn_august" %chin% localNames){raw_panel[, earn_august:= as.numeric(gsub(",","\\.",earn_august))]}
if("earn_sept" %chin% localNames){raw_panel[, earn_sept:= as.numeric(gsub(",","\\.",earn_sept))]}
if("earn_oct" %chin% localNames){raw_panel[, earn_oct:= as.numeric(gsub(",","\\.",earn_oct))]}
if("earn_nov" %chin% localNames){raw_panel[, earn_nov:= as.numeric(gsub(",","\\.",earn_nov))]}
if("earn_dec" %chin% localNames){raw_panel[, earn_dec:= as.numeric(gsub(",","\\.",earn_dec))]}
if("earn_dec_mw" %chin% localNames){raw_panel[,earn_dec_mw := as.numeric(gsub(",","\\.",earn_dec_mw))]}
if("mean_earn_mw" %chin% localNames){raw_panel[, mean_earn_mw:= as.numeric(gsub(",","\\.",mean_earn_mw))]}
if("last_wage" %chin% localNames){raw_panel[, last_wage:= as.numeric(gsub(",","\\.",last_wage))]}
