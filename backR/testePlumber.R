library(dplyr)
library(foreign)

'%%' <- function(a,b) paste0(a,b)

#* @get /receiver
function() {
  return("erro")
}

cabeca <- function(size) {
  
  retorno <- head(dado, size)
  
  return(retorno)
  
}


read <- function() {
  
  dado <<- read.dbf("dados/IDENG99.dbf")
  
  return(tibble(a = 'funcionou!'))
  
}

teste <- function(a, b, c) {
  
  return(a + b - c)
  
  
}

#* @filter manager
function(req, res) {
  
  requisicao <<- req
  resposta <<- res
  
  if(!is.null(req$args$servico)) {
    
    print(req$args$servico)
    
    comando <- req$args[[3]] %% '('
    
    if(length(names(req$args)) > 3)
    for(i in 4:length(names(req$args))) {
      
      if(i != length(names(req$args))) {
        comando <- comando %%  names(req$args)[[i]] %% '=' %% req$args[[i]] %% ','
      } else {
        comando <- comando %%  names(req$args)[[i]] %% '=' %% req$args[[i]]
      }
    }
    
    comando <- comando %% ')'
    
    return(eval(parse(text = comando)))
    
  }
  
  plumber::forward()
  
}

