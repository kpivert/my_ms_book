library(shiny)
require(ggplot2)
require(plotly)
require(thematic)
require(extrafont)
loadfonts(quiet = TRUE)
require(bslib)

# theme <- bs_theme(
#   theme = "flatly", 
#   bg = "#fffff3", 
#   primary = "#FF0049", 
#   base_font = font_google("Noto Sans"), 
#   fg = "#000"
#   )  

ui <- fluidPage(
  theme = bs_theme(
    bootswatch =  "default", 
    bg = "#fffff3", 
    primary = "#FF0049", 
    base_font = font_google("Roboto"), 
    fg = "#000"
  ),
  
  plotlyOutput("plot")
)

server <- function(input, output, session) {
  
  output$plot <- renderPlotly({
    
    g <- ggplot(
      mtcars, 
      aes(disp, mpg)
    ) +
    geom_point(
      color = "#FF0049"
    ) +
    geom_smooth(
      method = "lm",
      se = FALSE
    ) +
    theme_minimal(
      base_size = 12,
      base_family = "Roboto"
    ) +
    theme(
      plot.background = element_rect(
        fill = "#fffff3",
        color = "#fffff3"
      ),
      panel.background = element_rect(
        fill = "#fffff3",
        color = "#fffff3"
      )
    )  
    
    ggplotly(g)
    
  })
  
}

shinyApp(ui, server)