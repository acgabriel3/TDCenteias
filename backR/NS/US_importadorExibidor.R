library(shinyFiles)
library(foreign)
library(data.table)
library(stringi)

importadorUI <- function(id) {
  
  ns <- NS(id)
  
  #***
  #Criar uma interface mais bonita 
  
  fluidRow(
    shinyDirButton(id = ns('directory'), 'Escolha a pasta de trabalho', 'Por favor, selecione uma pasta'), 
    
    selectInput(inputId = ns("formato"), choices = c(".csv", ".dbf"), multiple = TRUE, label = "Selecione o tipo de arquivo para importacao"), 
    
    actionButton(inputId = ns("importar"), label = "Importar"),
    
    #***
    #Acrescentar opcao do usuario escolher a funcao e tipo de arquivo para leitura
    
    #***
    #Pensar em opcao para deszipar arquivos
    
    #***
    #Mostrar tipo do arquivo 
    # textOutput(outputId = ns("rep_serie_historia"))
    dataTableOutput(outputId = ns("rep_serie_historia"))
  ) 
  
}

importadorServer <- function(input, output, session) {
  
  volumes <- getVolumes()
  shinyDirChoose(input, id = 'directory', defaultPath = getwd(), session=session, roots = volumes)
  
  
  caminho <- reactive({
    
    parse <- as.character(parseDirPath(volumes, input$directory))
    
    if(substring(parse, 2, 2) == '/') {
    
      return(substring(parse, 3, 10000))
    
    } else {
      
      return(parse)
      
    }
    
  })
  
  importador <- reactive({
    
    hash <- c(".csv" = "fread", ".dbf" = "read.dbf")
    
    caminho <- isolate(caminho())
    
    nomesArquivos <- NULL
    
    if(length(caminho) != 0) {
    
      for(opcao in isolate(input$formato)) {
        
        #***
        #Podem haver arquivos que deram problema de leitura, uma solucao seria descartar o warning ou tentar outra funcao. 
        nomesArquivos <- c(nomesArquivos, leitura_automatica_por_tipo_arquivo(diretorioAlvo = caminho, 
                                                                              formatoArquivo = opcao, 
                                                                              funcao_de_leitura = hash[opcao]))
      }
      
    }
    
    return(nomesArquivos)
    
  })
  
  observeEvent(input$importar, 
                
              variaveis <<- importador()
               
               )
  
  output$rep_serie_historia <- renderDataTable({
    
    input$importar
    
    dataFrame <- data.frame(tabela = NULL, banco = NULL, serie_historica = NULL)
    
    if(is.null(variaveis)) {
    
      dataFrame <- data.frame(tabela = "aguardando importacao", banco = "aguardando importacao", serie_historica = "aguardando importacao")
      
      return(dataFrame)
    
    } else {
      
      for(i in 1:length(variaveis)) {
        
        analise <- verifica_serie_historica(nomeTabela = variaveis[i], metaDados = metaDados)
        
        
        aux <- data.frame(tabela = variaveis[i], banco = analise[1], serie_historica = analise[2])
        
        dataFrame <- rbind(dataFrame, aux)  
        
      }
      
      return(dataFrame)
      
    }
    
  })
  
}