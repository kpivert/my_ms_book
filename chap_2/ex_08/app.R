library(shiny)
require(reactable)

ui <- fluidPage(
  reactableOutput("table")
)
 
server <- function(input, output, session) {
  output$table <- renderReactable({
    reactable(
      mtcars,
      searchable = TRUE,
      filterable = TRUE
      )
  })
}

shinyApp(ui, server)