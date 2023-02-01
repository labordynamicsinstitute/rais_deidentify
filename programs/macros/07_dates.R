# Title: Cleaning dates variables 
# Description: gets day, month and year of admission  
# Author: Vitor Costa 
# Date: January 2020

####
#### Functions to handle dates
####

# Dates come in different formats, with varying number of digits. But mostly in the DDMMYYYY format

# when input has 4 digits
date.4 = function(x){
  year = as.numeric(str_sub(x,3,4))
  if(year>12) {year = 1900+year} else {year = 2000+year}
  d2 = as.numeric(str_sub(x,2,2))
  d1 = as.numeric(str_sub(x,1,1))
  if(d2==0 & d1<=1){
    month = as.numeric(str_sub(x,1,2))
    day = NA}
  if(d2==0 & d1>1){
    month=NA
    day=NA}
  if(d2>0){
    month = d2
    day = d1
  }
  z = list(day=day,month=month,year=year)
  return(z)
}

# when input has 5 digits
date.5 = function(x){
  year = as.numeric(str_sub(x,3,5))
  d3 = as.numeric(str_sub(x,3,3))
  if(d3==0){year = 2000+year}
  if(d3==9){year = 1000+year}
  d2 = as.numeric(str_sub(x,2,2))
  d1 = as.numeric(str_sub(x,1,1))
  if(d2==0){month=NA} else {month=d2}
  day=d1
  z = list(day=day,month=month,year=year)
  return(z)
}

# when input has 8 integer digits
date.8 = function(x){
  year = as.numeric(str_sub(x,5,8))
  if(year>=1920){ #from exploration of debug sample
    day = as.numeric(str_sub(x,1,2))
    month = as.numeric(str_sub(x,3,4)) 
  } else {
    year = as.numeric(str_sub(x,1,4))
    month = as.numeric(str_sub(x,5,6))
    day = as.numeric(str_sub(x,7,8))
  }
  z = list(day=day,month=month,year=year)
  return(z)
}

# when input has 6 integer digits
date.6 = function(x) {
  day = as.numeric(str_sub(x,1,1))
  month = as.numeric(str_sub(x,2,2))
  year = as.numeric(str_sub(x,3,6))
  z = list(day=day,month=month,year=year)
  return(z)
}

# when input has 6 integer digits in fix round
date.6.fix = function(x){
  
  d456 = as.numeric(str_sub(x,4,6))
  d123 = as.numeric(str_sub(x,1,3))
  d12  = as.numeric(str_sub(x,1,2))
  d23  = as.numeric(str_sub(x,2,3))
  d45  = as.numeric(str_sub(x,4,5))
  d56  = as.numeric(str_sub(x,5,6))
  d1   = as.numeric(str_sub(x,1,1))
  d2   = as.numeric(str_sub(x,2,2))
  d3   = as.numeric(str_sub(x,3,3))
  d4   = as.numeric(str_sub(x,4,4))
  d5   = as.numeric(str_sub(x,5,5))
  d6   = as.numeric(str_sub(x,6,6))
  
  if(d456>=944){
    year = 1000+d456
    month = d3
    day = d12}
  
  if(d456 %between% c(13,930)){ # there no d456 between 930 and 944 (as seen from previous exploration of data)
    year = 2000+d3
    month = d4
    day = d56}
  
  if(d456 %between% c(0,12)){
    year = 2000+d456
    day = d12
    month = d3}
    
    z = list(day=day,month=month,year=year)
    return(z)}

# when input has 7 integer digits
date.7 = function(x) {
  sep = strsplit(as.character(x),"")
  d1 = as.numeric(sep[[1]][1])
  d2 = as.numeric(sep[[1]][2])
  d3 = as.numeric(sep[[1]][3])
  year = as.numeric(str_sub(x,4,7))
  if(d2>1|d2==1 & d1==3 & d3>2|d2==1 & d1==2 & d3>2|d2==1 & d1==1 & d3>2) {
    day = as.numeric(str_sub(x,1,2))
    month = as.numeric(str_sub(x,3,3))}
  else if(d2==0 & d1>3|d2==1 & d1>3|d2==1 & d1==3 & d3==2|d2==1 & d1==3 & d3==0|d2==1 & d1==2 & d3==0|d2==1 & d1==1 & d3==0){
    day = as.numeric(str_sub(x,1,1))
    month = as.numeric(str_sub(x,2,3))} 
  else if(d2==0 & d1<=3){
    day = NA
    month = as.numeric(str_sub(x,3,3))}
  else {
    day = NA
    month = NA}
  
  z = list(day=day,month=month,year=year)
  return(z)
}

# putting it all together for admission date
date.conv.adm = function(x) {
  if(is.na(as.numeric(x))){
    z = list(day=NA,month=NA,year=NA)
    return(z)} else {
      n.dig = nchar(x)
      if(n.dig==6){date.6(x)}
      else if(n.dig==7){date.7(x)}
      else {date.8(x)}
    } 
}

date.conv.adm.fix = function(x) {
  if(is.na(as.numeric(x))){
    z = list(day=NA,month=NA,year=NA)
    return(z)} else {
      n.dig = nchar(x)
      if(n.dig==4){date.4(x)}
      else if(n.dig==5){date.5(x)}
      else {date.6.fix(x)}
    } 
}

####
#### Converting dates on data
####

# First, getting termination year
raw_panel[termination_month!=0, termination_year := yr]
raw_panel[termination_month==0, termination_year := 0]

# Now, dealing with dates of admission
date.dt = data.table(adm_date=unique(raw_panel$adm_date))

dates = lapply(date.dt$adm_date,date.conv.adm)

date.dt[,adm_day:=unlist(lapply(dates,'[[',1))]
date.dt[,adm_month:=unlist(lapply(dates,'[[',2))]
date.dt[,adm_year:=unlist(lapply(dates,'[[',3))]

########## 
## For years 2011 and 2012, an unusual number of NAs, dealing with them below
##########
if(year=="2011"|year=="2012"){
  date.dt.na = date.dt[is.na(adm_year),.(adm_date)]
  date.dt.na[,new_adm_date:=gsub("/","",adm_date)]
  
  dates.fix = lapply(date.dt.na$new_adm_date,date.conv.adm.fix)
  
  date.dt.na[,adm_day:=unlist(lapply(dates.fix,'[[',1))]
  date.dt.na[,adm_month:=unlist(lapply(dates.fix,'[[',2))]
  date.dt.na[,adm_year:=unlist(lapply(dates.fix,'[[',3))]
  date.dt.na[,new_adm_date:=NULL]
  
  date.dt = date.dt[!is.na(adm_year)]
  
  date.dt = rbindlist(list(date.dt,date.dt.na),use.names = T, fill = T)
}

raw_panel = merge(raw_panel,date.dt,by="adm_date",all.x=T)
