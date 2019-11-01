
'%%' <- function(x,y) paste0(x, y) 

verifica_serie_historica <- function(nomeTabela, metaDados) {
  
  bancoFinal <- NULL
  serieFinal <- NULL
  valorDeEcontro <- Inf
  
  eval(parse(text = 'tabelaAtual <-' %% nomeTabela))
  
  bancos <- names(metaDados)
  
  for(banco in bancos) {
    
    bancoSeries <- names(metaDados[[banco]])
    
    colunasSerie <- NULL
    
    for(serie in bancoSeries) {
      
      diferenca <- setdiff(colnames(tabelaAtual), names(metaDados[[banco]][[serie]]))
      tamanho <- length(diferenca)
      
      if(tamanho == 0) {
        
        valorDeEcontro <- 0
        bancoFinal <- banco
        serieFinal <- serie
        break
        
      } else if(tamanho < valorDeEcontro) {
        
        valorDeEcontro <- tamanho
        bancoFinal <- banco
        serieFinal <- serie
        
      }
    
    }
    
  } # Deve registrar se achou zero para mais de um banco, e avaliar os tipos de dados de cada caso (pode ser interessante)
  
  return(c(bancoFinal, serieFinal))
  
}
