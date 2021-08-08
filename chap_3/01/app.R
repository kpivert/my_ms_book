library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  # Regular approach
  # output$greeting <- renderText({
  #   paste0("Hello ", input$name, "!")
  # })
  
  # Reactive Approach
  string <- reactive(paste0("Hello ", input$name, "!"))
  output$greeting <- renderText(string())
}

shinyApp(ui, server)