library(dplyr)
library(foreign)

#* @get /dataframe
function() {
  
  retorno <- head(dado, 500)
  
  return(retorno)
  
}


#* @get /read
function() {
  
  dado <<- read.dbf("dados/IDENG99.dbf")
  
  return(tibble(a = 'funcionou!'))
  
}