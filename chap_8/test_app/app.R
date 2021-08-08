library(shiny)
library(intrval)

n <- 10^4
x <- round(runif(n, -2, 2), 2)
y <- round(runif(n, -2, 2), 2)
d <- round(sqrt(x^2 + y^2), 2)

ui <- fluidPage(
  titlePanel("Intervals example with Shiny"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bb_x", "Position along x axis",
                  min=min(x), max=max(x), value=range(x),
                  step=round(diff(range(x))/20, 1), animate=TRUE
      ),
      sliderInput("bb_y", "Position along y axis",
                  min = min(y), max = max(y), value = range(y),
                  step=round(diff(range(y))/20, 1), animate=TRUE
      ),
      sliderInput("bb_d", "Radial distance",
                  min = 0, max = max(d), value = c(0, max(d)/2),
                  step=round(max(d)/20, 1), animate=TRUE
      ),
      fileInput("file", "Choose file")
    ),
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("fileinfo")
    )
  )
)

server <- function(input, output) {
  
  ## set file size limit >5MB here
  options(shiny.maxRequestSize=200*1024^2)
  
  output$plot <- renderPlot({
    iv1 <- x %[]% input$bb_x & y %[]% input$bb_y
    iv2 <- x %[]% input$bb_y & y %[]% input$bb_x
    iv3 <- d %()% input$bb_d
    op <- par(mfrow=c(1,2))
    plot(x, y, pch = 19, cex = 0.25, col = iv1 + iv2 + 3,
         main = "Intersecting bounding boxes")
    plot(x, y, pch = 19, cex = 0.25, col = iv3 + 1,
         main = "Deck the halls:\ndistance range from center")
    par(op)
  })
  
  output$fileinfo <- renderPrint({
    req(input$file)
    cat("Size of", input$file$name, "=",
        round(input$file$size/1024^2, 3), "MB")
  })
  
  ## prevent timeout
  autoInvalidate <- reactiveTimer(intervalMs = 50*1000)
  observe({
    autoInvalidate()
    cat(".")
  })
  
}

shinyApp(ui, server)