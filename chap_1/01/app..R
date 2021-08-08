require(shiny)

ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  
  # Create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    # Use a reactive expression by calling it like a function
    # dataset <- get(input$dataset, "package:datasets")
    # summary(dataset)
    summary(dataset())
  })
  
  output$table <- renderTable({
    # dataset <- get(input$dataset, "package:datasets")
    dataset()
  })
  
  }

shinyApp(ui, server)