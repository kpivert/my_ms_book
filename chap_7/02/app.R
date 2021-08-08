library(shiny)
require(ggplot2)

ui <- fluidPage(
  plotOutput("plot", click = "plot_click"),
  tableOutput("data")
)

server_base <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  }, res = 96)
  
  output$data <- renderTable({
    nearPoints(mtcars, input$plot_click, xvar = "wt", yvar = "mpg")
  })
}

server_ggplot <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  }, res = 96)
  
  output$data <- renderTable({
    req(input$plot_click)
    # browser()
    nearPoints(mtcars, input$plot_click)
  })
}

shinyApp(ui, server_ggplot)