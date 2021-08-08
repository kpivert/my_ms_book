library(shiny)

ui_html <- fluidPage(
  HTML(r"(
    <h1>This is a heading</h1>
    <p class ="my-class">This is some text!</p>
    <ul>
      <li>First bullet</li>
      <li>Second bullet</li>
    </ul>
    )")
  )

ui_shiny <- fluidPage(
  h1("This is a heading"),
  p("This is some text", class = "my-class"),
  tags$ul(
    tags$li("First bullet"),
    tags$li("Second bullet")
  ),
  tags$p(
    "You made ",
    tags$b("$", textOutput("amount", inline = TRUE)),
    " in the last ", 
    textOutput("days", inline = TRUE),
    " days "
  )
)

server <- function(input, output, session) {
  
  output$days <- reactive(11L)
  
  output$amount <- reactive("5000")
  
}

shinyApp(ui_shiny, server)