# Title: Cleaning firm ID variables 
# Description: consistent FIRM ID types accross years, checks if FIRM ID is valid
# Author: Vitor Costa 
# Date: May 2018

# CNPJ and CEI sometimes are reported without leading zeroes, which make them invalid as firm IDs at first
# sight. 
firmID.lead.00<- function(x,y){
  if (x == "0"){
    leading.0s = ifelse(nchar(y)<12, paste(rep("0",12-nchar(y)),collapse=""), "")
    y = paste(leading.0s,y,sep="")
    return(y)
  } else {
    leading.0s = ifelse(nchar(y)<14, paste(rep("0",14-nchar(y)),collapse=""), "")
    z = paste(leading.0s,y,sep="")
    return(z)
  }
}

# Starting in 2011, some CEI ids were reported with extra two zeros to the left - "00xxxxxxxxxxxx"
# Creates function to deal with such cases.
cei.00 <- function(x,y,z){
  yrs = c("2011","2012","2013","2014")
  if (!(z %in% yrs)) {return(x)} else {
    if (y == "1") {return(x)} else { 
      if (nchar(x)!=14) {return(x)} else {
       cei.split =  strsplit(x,"")
       x = ifelse(cei.split[[1]][1]=="0"  & cei.split[[1]][2]=="0",paste(cei.split[[1]][3:14],collapse=""),x)
       return(x)
      }
    }
  }
}

# Creates function to validate CNPJ
blacklist.cnpj = c("00000000000000","11111111111111","22222222222222","33333333333333","44444444444444",
                   "55555555555555","66666666666666","77777777777777","88888888888888","99999999999999")
weights.cnpj = c(6,5,4,3,2,9,8,7,6,5,4,3,2)
check.CNPJ <- function(x){
  if (x %in% blacklist.cnpj) {check = "bl"} else {
    if (nchar(x)!=14) {check = "wl"} else 
    { split.cnpj = strsplit(x,"")
      sum.cnpj = 0 
      for (i in 1:12) {sum.cnpj = sum.cnpj + weights.cnpj[i+1]*as.numeric(split.cnpj[[1]][i])}
      dv.1 = sum.cnpj %% 11 
      dv.1 = ifelse(dv.1<2, 0, 11-dv.1)
      if (dv.1 != split.cnpj[[1]][13]) {check = "0"} else {
        sum.cnpj = 0
        for (i in 1:13) {sum.cnpj = sum.cnpj + weights.cnpj[i]*as.numeric(split.cnpj[[1]][i])}
        dv.2 = sum.cnpj %% 11 
        dv.2 = ifelse(dv.2<2, 0, 11-dv.2)
        if (dv.2 != split.cnpj[[1]][14]) {check = "0"} else {
          check = "1"
        }
      }
    } 
  }
  return(check)
}

# Creates function to validate CEI
blacklist.cei = c("000000000000","111111111111","222222222222","333333333333","444444444444",
                   "555555555555","666666666666","777777777777","888888888888","999999999999")
weights.cei = c(7,4,1,8,5,2,1,6,3,7,4)
check.CEI <- function(x){
  if (x %in% blacklist.cei) {check = "bl"} else {
    if (nchar(x)!=12) {check = "wl"} else {
      split.cei = strsplit(x,"")
      sum.cei.1 = 0 
      for (i in 1:11) {sum.cei.1 = sum.cei.1 + weights.cei[i]*as.numeric(split.cei[[1]][i])}
      sum.cei.1 = as.character(sum.cei.1)
      sum.cei.2 = as.numeric(strsplit(sum.cei.1,"")[[1]][nchar(sum.cei.1)-1]) +
                  as.numeric(strsplit(sum.cei.1,"")[[1]][nchar(sum.cei.1)])
      sum.cei.2 = as.character(sum.cei.2) 
      dv.aux = as.numeric(strsplit(sum.cei.2,"")[[1]][nchar(sum.cei.2)])
      dv = ifelse(dv.aux==0,0,10-dv.aux)
      if (dv != split.cei[[1]][12]) {check = "0"} else {
        check = "1"
      }
    }    
  }
  return(check)
}

# creates function to validate firmID
check.firmID <- function(x,y){
  if (x=="1"){return(check.CNPJ(y))} else {return(check.CEI(y))}
}

# Replaces "01" by "1" and "03|3" by "0" in firm ID type> If 1, firm is identified by a CNPJ, if 0 by a CEI
var = "firmID_type"
raw_panel[, (var) := lapply(.SD, function(x) gsub("01","1",x)), .SD = var]
raw_panel[, (var) := lapply(.SD, function(x) sub("3|03","0",x)), .SD = var]

# Removes empty space, dot, comma and dash
var = "firmID"
raw_panel[, (var) := lapply(.SD, function(x) gsub(" |\\.|-|,","",x)), .SD = var]

# Inserts leading zeroes
raw_panel[, firmID := mapply(firmID.lead.00,firmID_type,firmID)]

# Starting in 2011, some CEI ids were reported with extra two leading zeros - "00xxxxxxxxxxxx"
# Let's clean such cases
var = "firmID"
raw_panel[, firmID := mapply(cei.00,firmID,firmID_type,yr)]

# Validating firm ID
raw_panel[, valid_firmID := mapply(check.firmID, firmID_type, firmID)]

