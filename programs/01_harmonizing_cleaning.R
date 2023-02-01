# This code implements the cleaning and harmonization of the RAIS files from the beginning
## de-identified version
# First edit: 20210614
# Author: Joao Vitor Rego Costa  

# Setting the years to be read by this code
# years = as.character(c(2002:2004))
years = as.character(c(2002:2017))

# Loading reference for column names
setwd(metadata.dir)
colref = fread("0001_clean_panel_reference_nonames.csv")
yrNames = colref$yr_file_name

# Loading common column structure
setwd(home)
source("02_columns_scheme.R")

# Creating function to read the files and harmonize columns
rais.harmo = function(x){
  
  # Harmonizing column names
  names = data.table(local=names(x))
  names[,std:=stri_trans_general(str=local,id="Latin-ASCII")]
  names[,std:=toupper(gsub(" |/|\\(|\\)",".",std))]
  names = merge(names,colref[-1],by.x="std",by.y="yr_file_name",all.x=T) 
  
  cols2keep = as.vector(names[!is.na(panel_name),local])
  harmo = as.vector(names[!is.na(panel_name),panel_name])
  
  product = x[, cols2keep, with=F]
  setnames(product,cols2keep,harmo)
  
  # Declaring return
  return(product)
}


# Declaring files to be read and ignored
setwd(input.dir)
allFiles = list.files(recursive = T)[grep(paste(years,collapse="|"),list.files(recursive = T))]
files2ignore = c("2013/Estb2013ID5.txt","2007/sudeste07.TXT","2015/ESTB2015ID.txt","2016/Estb2016ID.txt","2017/ESTB2017ID.txt")
files2read = allFiles[!(allFiles %chin% files2ignore)]
past_year = 2001

# Executing the routine
for(r in files2read){
  
  cat("Starting ",r," \n \n")
  
  # 1. Harmonizing columns
  setwd(input.dir)
  raw_panel = fread(r,colClasses = "character",encoding = "Latin-1")
  raw_panel = as.data.table(rais.harmo(raw_panel))
  
  # 2. Adding year column
  year = substr(r,1,4)
  if(year==past_year){app = T} else {app=F}
  raw_panel[,yr:=year]
  
  # 3. Conforming file to common column structure
  raw_panel = rbindlist(list(col_scheme,raw_panel),use.names = T, fill = T)
  
  # 4. Applying macros
  source(paste(macros.dir,"03_sex.R",sep="/"))
  source(paste(macros.dir,"05_earnings.R",sep="/"))
  source(paste(macros.dir,"06_hours.R",sep="/"))
  source(paste(macros.dir,"07_dates.R",sep="/"))
  source(paste(macros.dir,"09_tenure.R",sep="/"))
  source(paste(macros.dir,"12_race_color.R",sep="/"))
  source(paste(macros.dir,"15_schooling.R",sep="/"))
  source(paste(macros.dir,"16_contract_type.R",sep="/"))
  source(paste(macros.dir,"17_firmIDtype.R",sep="/"))
  source(paste(macros.dir,"18_ind_sector_cnae.R",sep="/"))
  source(paste(macros.dir,"19_occupation_code_cbo.R",sep="/"))
  
  # 5. Creating debug file
  rows4debug = sample(1:nrow(raw_panel),floor(nrow(raw_panel)/20),replace = T) # debug is a 5% random sample of raw files
  debugFile = raw_panel[rows4debug]
  
  # De-identifying: remove pis, ctps, cpf, firmID, cnpj_root, cei
  raw_panel[,pis:=NA][,ctps:=NA][,cpf:=NA][,cpf:=NA][,firmID:=NA][,cnpj_root:=NA][,cei:=NA]
  
  # 6. Exporting files
  file.name = paste("harmo_nonames_",year,".csv",sep="")  
  file.name.debug = paste("harmo_nonames_",year,"_debug.csv",sep="")
  
  setwd(output.dir)
  fwrite(raw_panel,file.name,row.names = F, append = app)
  fwrite(debugFile,file.name.debug,row.names = F, append = app)
  
  # Updating past year
  past_year = year

  cat(r,"finished \n \n")
}
