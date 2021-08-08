library(shiny)
require(ggplot2)
require(bslib)

theme_test <- bslib::bs_theme(
  bg = "#0b3d91",
  fg = "white",
  base_font = "Avenir"
)

ui <- fluidPage(
  # theme = bslib::bs_theme(bootswatch = "darkly"),
  theme = theme_test,
  titlePanel("A themed plot"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  thematic::thematic_shiny()
  
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point() +
      geom_smooth()
  }, res = 96)
}

shinyApp(ui, server)