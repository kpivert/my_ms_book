library(shiny)

ui <- fluidPage(
  textInput("name", label = "", value = "Your name")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)