## DOWNLOADING REPORTS: Robust with callr

library(shiny)

report_path <- tempfile(fileext = ".Rmd")
file.copy("report.Rmd", report_path, overwrite = TRUE)

ui <- fluidPage(
  sliderInput("n", "Number of points", min = 1, max = 100, value = 50),
  downloadButton("report", "Generate report")
)

render_report <- function(input, output, params) {
  rmarkdown::render(input,
    output_file = output, 
    params = params,
    envir = new.env(parent = globalenv())
    )
}

server <- function(input, output, session) {
  output$report <- downloadHandler(
    filename = "report.html",
    content = function(file) {
      params <- list(n = input$n)
      callr::r(
        render_report, 
        list(input = report_path, output = file, params = params)
      )
    }
  )
}

shinyApp(ui, server)