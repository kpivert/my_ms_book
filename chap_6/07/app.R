library(shiny)
require(bslib)

theme_test <- bslib::bs_theme(
  bg = "#0b3d91",
  fg = "white",
  base_font = "Avenir"
)

ui <- fluidPage(
  # theme = bslib::bs_theme(bootswatch = "flatly"),
  theme = theme_test,
  sidebarLayout(
    sidebarPanel(
      textInput("txt", "Text input:", value = "text here"),
      sliderInput("slider", "Slider input:", min = 1, max = 100, value = 30)
    ),
    mainPanel(
      h1(paste0("Theme: flatly")),
      h2("Header 2"),
      p("Some text")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)