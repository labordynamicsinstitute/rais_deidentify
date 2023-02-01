# config.R
# Contains directories used in all programs

## setting directories
## Include the final "/"!!
base = "/home/jrc466/Documents/rais_nonames/"
home = paste(base,"/programs",sep="/")
input.dir = "/home/ecco_rais/data/raw/RAIS-conf/RAIS_txt/"
metadata.dir = paste(base,"/metadata/",sep="/")
output.dir = "/home/ecco_rais/data/de-identified/"
macros.dir = paste(home,"/macros",sep='/')

my.packages = c("data.table","stringi","stringr","bit64")

for(i in my.packages) {
  if(!require(i, character.only = T)) install.packages(i); 
  library(i, character.only = T)
}