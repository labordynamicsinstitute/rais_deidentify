# This code sets the column structure of the panel
# First edit: 20210622
# Author Joao Vitor Rego Costa  

# Declaring scheme - column names taken from the reference table in metadata
col_scheme = data.table(
  active1231=character(),
  adm_date=character(),
  adm_type=character(),
  age=character(),
  alvara_ind=character(),           
  cbo02=character(),
  cbo94=character(),
  cei=character(),
  cei_avail=character(),
  cnae20=character(),          
  cnae20sub=character(),
  cnae95=character(),
  cnpj_root=character(),
  contract_type=character(),
  cpf=character(),
  ctps=character(),
  disability_type=character(),
  disabled=character(),
  dob=character(),
  earn_april=character(),
  earn_august=character(),
  earn_dec=character(),
  earn_dec_mw=character(),
  earn_feb=character(),
  earn_jan=character(),             
  earn_july=character(),
  earn_june=character(),
  earn_march=character(),
  earn_may=character(),
  earn_nov=character(),  
  earn_oct=character(),
  earn_sept=character(),
  estab_name=character(),
  establishment_size=character(),
  firmID=character(),               
  firmID_type=character(),
  hired_hours=character(),
  hired_wage=character(),
  ibge_subsetor=character(),
  intermittent_contract=character(),
  last_wage=character(),
  legal_form=character(),
  mean_earn=character(),
  mean_earn_mw=character(),
  muni=character(),                 
  muni_job=character(),
  nationality=character(), 
  partial_job=character(),
  pat=character(),                  
  pis=character(),
  race_color=character(),  
  schooling=character(),
  separation_cause=character(),
  sex=character(),                  
  simples=character(),   
  tenure=character(),    
  termination_day=character(),
  termination_month=character(),
  termination_year=character(),
  union=character(),                
  wage_type=character(),
  yr=character(),
  yr_arrival=character(),
  zip_establishment=character()    
)