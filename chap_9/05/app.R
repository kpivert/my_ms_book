## DOWNLOADING REPORTS

library(shiny)

report_path <- tempfile(fileext = ".Rmd")
file.copy("report.Rmd", report_path, overwrite = TRUE)

ui <- fluidPage(
  sliderInput("n", "Number of points", min = 1, max = 100, value = 50),
  downloadButton("report", "Generate report")
)

server <- function(input, output, session) {
  output$report <- downloadHandler(
    filename = "report.html",
    content = function(file) {
      params <- list(n = input$n)  
      
      id <- showNotification(
        "Rendering report...",
        duration = NULL,
        closeButton = FALSE
      )
      on.exit(removeNotification(id), add = TRUE)
      
      # rmarkdown::render("report.Rmd",
      rmarkdown::render(report_path,
        output_file = file,
        params = params,
        envir = new.env(parent = globalenv()))
    }
  )
}

shinyApp(ui, server)