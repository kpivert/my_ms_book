## Exercise 1: Download ----

require(ambient)
library(shiny)
require(shinycssloaders)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h3("1. Pick Your Plot Size and Distance Value"),
      sliderInput("x", "Size", min = 10, max = 1000, value = 100),
      radioButtons(
        "dist", "Distance Metric", 
         choices = c("distance", "distance2"),
         selected = "distance"
        ),
      h3("2. Hit the button to generate your plot!"),
      actionButton("make_plot", "Generate Plot!"),
      downloadButton("save", "Download PNG")
    ),
    mainPanel(
      withSpinner(plotOutput("plot"))
    )
  )
)


server <- function(input, output, session) {
  

# Input Plot Variables ----------------------------------------------------

grid_data <- eventReactive(input$make_plot, {

  grid <- long_grid(
    seq(1, 10, length.out = input$x), 
    seq(1, 10, length.out = input$x)
    )
  
  grid$noise <- gen_worley(
    grid$x, 
    grid$y, 
    value = input$dist)
  
  grid
  
})  

# Generate Worley Noise ---------------------------------------------------


output$plot <- renderPlot({
  
  grid <- grid_data()
  
  plot(grid, noise)
  }, res = 96
)

# Download a PNG ----------------------------------------------------------

  
  output$save <- downloadHandler(
    filename = function() {
      paste0("worley_", input$x, ".png")
    },
    content = function(file) {
      df <- grid_data()
      png(filename = file, type = "cairo")
      plot(df, noise)
      dev.off()
    }
  )
}

shinyApp(ui, server)


## Examples from Ambient ----

# library(ambient)
# Using the generator and another value metric
# grid <- long_grid(seq(1, 10, length.out = 1000), seq(1, 10, length.out = 1000))
# grid$noise <- gen_worley(grid$x, grid$y, value = 'distance')
# plot(grid, noise)
# grid <- long_grid(seq(1, 10, length.out = 1000), seq(1, 10, length.out = 1000))
# grid$noise <- gen_worley(grid$x, grid$y, value = 'distance2')
# plot(grid, noise)

# library(dplyr)
# 
# long_grid(x = seq(0, 10, length.out = 1000), 
#           y = seq(0, 10, length.out = 1000)) %>% 
#   mutate(
#     x1 = x + gen_simplex(x, y) / 2, 
#     y1 = y + gen_simplex(x, y) / 2,
#     worley = gen_worley(x, y, value = 'distance', seed = 5),
#     worley_frac = fracture(gen_worley, ridged, octaves = 8, x = x, y = y, 
#                            value = 'distance', seed = 5),
#     full = blend(normalise(worley), normalise(worley_frac), gen_spheres(x1, y1))
#   ) %>% 
#   plot(full)