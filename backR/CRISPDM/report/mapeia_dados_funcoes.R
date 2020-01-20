'%%' <- function(x,y) paste0(x, y) 

mapeia_dados_funcoes <- function(colunas, nomesTabelas) {
  
  hash <- NULL
  
  for(coluna in colunas) {
    
    for(tabela in nomesTabelas) {
      
      eval(parse( text = 'tabelaAtual <<-' %% tabela))
      
      if((coluna %in% colnames(tabelaAtual))) {
        
        eval(parse(text ='hash <- append(hash, list(' %% coluna %% '= class(tabelaAtual[[coluna]])))'))
  
        break
        
      }
      
      
    }
    
  }
  
  return(hash)
  
}
