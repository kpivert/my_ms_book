library(shiny)

ui <- fluidPage(
  sliderInput(
    "val_range", "Range", min = 0, max = 100, value = c(0,5),
    animate = TRUE,
    step = 5,
    dragRange = TRUE
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)