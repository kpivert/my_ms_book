library(shiny)

ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("print")
)

server <- function(input, output, session) {
  output$text <- renderText("hello!")
  output$print <- renderPrint("hello!")
}

shinyApp(ui, server)