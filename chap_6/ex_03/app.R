library(shiny)
require(ggplot2)
require(dplyr)
require(ggthemes)
  
jnj <- datasets::JohnsonJohnson %>% 
    tsibble::as_tsibble() %>% 
    mutate(date = lubridate::as_date(index))

theme_list <- grep("^theme", lsf.str("package:ggthemes"), value = TRUE)  #%>% 
  # paste0("()")

ui <- fluidPage(
  fluidRow(
    column(6, 
      plotOutput("left")
      ),
    column(6,
      plotOutput("right")
      )
    ),
  fluidRow(
    column(6,
      numericInput("num", "Pick a number", min = 100, max = 5000, value = 500)
      ),
    column(6,
      selectInput("theme", "Pick a theme", choices = theme_list, 
                  selected = "theme_economist", width = "100%"))
  )
)

server <- function(input, output, session) {
  
  sm_diamonds <- reactive(diamonds %>% slice_sample(n = input$num))
  
  output$left <- renderPlot({
    
    ggplot(
      sm_diamonds(), 
      aes(
        x = carat, 
        y = price,
        fill = cut
        )
      ) +
    # geom_point(
    #   # color = "#fffff3"
    # )
    geom_hex(
      color = "#fffff3"
    ) +
    get(input$theme)()
  })
  
  output$right <- renderPlot({
    
    ggplot(
      jnj,
      aes(
        x = date,
        y = value
      )
    ) +
    geom_line() +
    get(input$theme)()
    
  })
}

shinyApp(ui, server)