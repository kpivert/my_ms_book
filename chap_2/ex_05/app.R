library(shiny)

ui <- fluidPage(
  verbatimTextOutput("part_1"),
  textOutput("part_2"),
  verbatimTextOutput("part_3"),
  verbatimTextOutput("part_4")
)

server <- function(input, output, session) {
  output$part_1 <- renderPrint(summary(mtcars))
  output$part_2 <- renderText("Good morning!")
  output$part_3 <- renderPrint(t.test(1:5, 2:6))
  output$part_4 <- renderPrint(str(lm(mpg ~ wt, data = mtcars)))
}

shinyApp(ui, server)