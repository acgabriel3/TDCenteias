library(shiny)
library(jsonlite)
# library(shinyjs)

source("CRISPDM.R")
source("NS.R")

ui <- fluidPage(
  # useShinyjs(),
  
  navbarPage("Centeias", id = "tabs", 
             
             #Cada um destes itens pode ser constituido em um arquivo NS
             tabPanel("Pagina Inicial",
                      value = "initialPage",
                      # pag_Inicial_Ui("pagInicial")
                      h1("olah mundo")
             ),
             tabPanel("Importador e Exibidor",
                      value = "importadorExibidor",
                        importadorUI("importador")
                      )
             
  )
)

server <- function(input, output, session) {
  
  metaDados <<- fromJSON("NS/metaDados/metadados_bancos.json")
  variaveis <<- NULL
  callModule(importadorServer, "importador")
  
}

shinyApp(ui, server)