library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  
  user_name <- reactive({
    input$name
  })
  
  output$greeting <- renderText({
    paste0("Hello, ", user_name())
  })
}

shinyApp(ui, server)