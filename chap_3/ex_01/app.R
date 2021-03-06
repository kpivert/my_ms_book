library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server1 <- function(input, output, session) {
  # input$greeting <- renderText(paste0("Hello ", name))
  output$greeting <- renderText({
    paste0("Hello ", input$name)
    })
}

server2 <- function(input, output, session) {
  # greeting <- paste0("Hello ", input$name)
  # output$greeting <- renderText(greeting)
  greeting <- reactive({paste0("Hello ", input$name)})
  output$greeting <- renderText(greeting())
}

server3 <- function(input, output, session) {
  # output$greting <- paste0("Hello ", input$name)
  output$greeting <- renderText({
    paste0("Hello ", input$name)
    })
}

shinyApp(ui, server3)