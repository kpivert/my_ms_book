library(shiny)
require(reactable)

ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic"),
  reactableOutput("react")
)

server <- function(input, output, session) {
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
  output$react <- renderReactable({
    reactable(iris)
    })
}

shinyApp(ui, server)