library(shiny)

ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500)
      ),
    mainPanel(
        plotOutput("distPlot")
      )
    )
  )


server <- function(input, output, session) {
  
  output$distPlot <- renderPlot({
    plot(input$obs)
  })
}

shinyApp(ui, server)