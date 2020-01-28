library(dplyr)
library(foreign)

'%%' <- function(a,b) paste0(a,b, sep = "")

#* @get /receiver
function() {
  return("erro")
}

cabeca <- function(size) {
  
  retorno <- head(dado, size)
  
  return(retorno)
  
}


read <- function(caminho = NULL, arquivo) {
  
  path <- paste(caminho, arquivo, sep = '/')
  
  print(path)
  
  dado <<- read.dbf(file = path)
  
  return(tibble(a = 'funcionou!'))
  
}

teste <- function(a, b, c, d, e, f) {
  
  return(a + b - c + d + e + f)
  
  
}

#* @filter manager
function(req, res) {
  
  requisicao <<- req
  resposta <<- res
  
  if(!is.null(req$args$servico)) {
    
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
    
    print(comando)
    
    return(eval(parse(text = comando)))
    
  }
  
  plumber::forward()
  
}

