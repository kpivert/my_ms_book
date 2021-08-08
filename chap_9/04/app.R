## DOWNLOADING DATA -----

library(shiny)

ui <- fluidPage(
  selectInput("dataset", "Pick a dataset", ls(package:datasets)),
  tableOutput("preview"),
  downloadButton("download", "Download .tsv")
)

server <- function(input, output, session) {
  data <- reactive({
    out <- get(input$dataset, "package:datasets")
    if(!is.data.frame(out)) {
      validate(paste0("'", input$dataset, "' is not a data frame"))
    }
    
    out
  })
  
  output$download <- downloadHandler(
    filename = function() {
      paste0(input$dataset, ".tsv")
    },
    content = function(file) {
      # write.csv(data(), file, sep = "\t")
      vroom::vroom_write(data(), file)
    }
  )
  
  output$preview <- renderTable({
    head(data())
  })
}

shinyApp(ui, server)