library(shiny)

puppies <- tibble::tribble(
  ~breed, ~id, ~author,
  "corgi", "eoqnr8ikwFE", "alvan-nee",
  "labrador", "KCdYn0xu2fU", "shane-guymon",
  "spaniel", "TzjMd7i5WQI", "t-r-photography"
)

ui <- fluidPage(
  selectInput("id", "Pick a breed", choices = setNames(puppies$id, puppies$breed)),
  htmlOutput("source"),
  imageOutput("photo")
)

server <- function(input, output, session) {
  output$photo <- renderImage({
    list(
      src = file.path("puppy-photos", paste0(input$id, "-unsplash", ".jpg")),
      contentType = "image/jpeg",
      width = 500, 
      height = 650
    )
  }, deleteFile = FALSE)
  
  output$source <- renderUI({
    info <- puppies[puppies$id == input$id, , drop = FALSE]
    HTML(glue::glue("<p>
      <a href='https://unsplash.com/photos/{info$id}'>original</a> by
      <a href='https://unsplash.com/@{info$author}'>{info$author}</a>
      </p>"))
  })
}

shinyApp(ui, server)