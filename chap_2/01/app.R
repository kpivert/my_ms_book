library(shiny)

animals <- c("dog", "cat", "mouse", "bird", "other", "OTTER!")
ui <- fluidPage(
  textInput("name", "What is your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3),
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on vacation next?"),
  selectInput(
    "state", "What are your favorite states?", choices = state.name,
    multiple = TRUE
    ),
  radioButtons("animal", "What's your favorite animal?", choices = animals),
  radioButtons("rb", "Choose one:",
    choiceNames = list(
      icon("angry"),
      icon("smile"),
      icon("sad-tear")
    ),
    choiceValues = list("angry", "happy", "sad")
    ),
  checkboxGroupInput(
    "animals", "What animals do you like?", choices = animals
  ),
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?"),
  fileInput("upload", NULL),
  # actionButton("click", "Click me!"),
  # actionButton("drink", "Drink me!", icon = icon("cocktail")),
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("drink", "Drink me!", icon = icon("cocktail"), class = "btn-lg btn-success"
    )
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block")
  )  
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)