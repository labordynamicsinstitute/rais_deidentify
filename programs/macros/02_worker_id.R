# Title: Cleaning firm ID variables 
# Description: consistent FIRM ID types accross years, checks if FIRM ID is valid
# Author: Vitor Costa 
# Date: July 2018


# Creates function to insert leading zeroes to CPF
# CPF.lead.00<- function(x){
#     if(x=="0"){return(x)} else {
#       leading.0s = ifelse(nchar(x)<11, paste(rep("0",11-nchar(x)),collapse=""), "")
#       x = paste(leading.0s,x,sep="")
#       return(x) 
#     }
# }

#Creates function to check PIS
blacklist.pis = c("00000000000","11111111111","22222222222","33333333333","44444444444",
                  "55555555555","66666666666","77777777777","88888888888","99999999999")
weights.pis = c(3,2,9,8,7,6,5,4,3,2)
check.PIS <- function(x){
  if (nchar(x) != 11) {check = "0"} else {
    if (x %in% blacklist.pis) {check = "bl"} else {
      split.pis = strsplit(x,"")
      sum.pis = 0 
      for (i in 1:10) {sum.pis = sum.pis + weights.pis[i]*as.numeric(split.pis[[1]][i])}
      dv = sum.pis %% 11
      dv = ifelse(dv<2,0,11-dv)
      if (dv != split.pis[[1]][11]) { check = "0" } else {
        check = "1"
      }
    }
  }
  return(check)
}

# Creates function to validate CPF
# blacklist.cpf = c("00000000000","11111111111","22222222222","33333333333","44444444444",
#                    "55555555555","66666666666","77777777777","88888888888","99999999999")
# weights.cpf = c(11,10,9,8,7,6,5,4,3,2)
# check.CPF <- function(x){
#   if (nchar(x)!=11) {check = "wl"} else {
#     if (x %in% blacklist.cpf) {check = "bl"} else 
#     { split.cpf = strsplit(x,"")
#       sum.cpf = 0 
#       for (i in 1:9) {sum.cpf = sum.cpf + weights.cpf[i+1]*as.numeric(split.cpf[[1]][i])}
#       dv.1 = sum.cpf %% 11 
#       dv.1 = ifelse(dv.1<2, 0, 11-dv.1)
#       if (dv.1 != split.cpf[[1]][10]) {check = "0"} else {
#         sum.cpf = 0
#         for (i in 1:10) {sum.cpf = sum.cpf + weights.cpf[i]*as.numeric(split.cpf[[1]][i])}
#         dv.2 = sum.cpf %% 11 
#         dv.2 = ifelse(dv.2<2, 0, 11-dv.2)
#         if (dv.2 != split.cpf[[1]][11]) {check = "0"} else {
#           check = "1"
#         }
#       }
#     } 
#   }
#   return(check)
# }

# Removes empty space, dot, comma and dash
var = "pis"
raw_panel[, (var) := lapply(.SD, function(x) gsub(" |\\.|-|,","",x)), .SD = var]
var = "cpf"
raw_panel[, (var) := lapply(.SD, function(x) gsub(" |\\.|-|,","",x)), .SD = var]


# Validating PIS
raw_panel[, valid_PIS := mapply(check.PIS,pis)]

# Adds leading zeroes to CPF
# raw_panel[, cpf := mapply(CPF.lead.00,cpf)]

# Validating CPF
# raw_panel[, valid_CPF := mapply(check.CPF,cpf)]

