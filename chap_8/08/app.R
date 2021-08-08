library(shiny)

ui <- fluidPage(
  waiter::use_waitress(),
  numericInput("steps", "How many steps?", value = 10),
  actionButton("go", "go"),
  textOutput("result")
)

# # Create a new progress bar
# waitress <- waiter::Waitress$new(max = input$steps)
# # Automatically close it when done
# on.exit(waitress$close())
# 
# for (i in seq_len(input$steps)) {
#   Sys.sleep(0.5)
#   # increment 1 step
#   waitress$inc(1)
# }

server <- function(input, output, session) {
  
  data <- eventReactive(input$go, {
    # Create a new progress bar
    # waitress <- waiter::Waitress$new(max = input$steps)
    # waitress <- waiter::Waitress$new(max = input$steps, theme = "overlay")
    # waitress <- waiter::Waitress$new(max = input$steps, theme = "overlay-opacity")
    # waitress <- waiter::Waitress$new(max = input$steps, theme = "overlay-percent")
    waitress <- waiter::Waitress$new(selector = "#steps", theme = "overlay")
    # Automatically close it when done
    on.exit(waitress$close())
    
    for (i in seq_len(input$steps)) {
      Sys.sleep(0.5)
      # increment 1 step
      waitress$inc(1)
    }
  
    runif(1)
    })

  output$result <- renderText(round(data(), 2))
}

shinyApp(ui, server)