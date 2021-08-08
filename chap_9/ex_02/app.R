## Exercise 2: T-Test----

library(shiny)
require(vroom)
require(dplyr)
require(broom)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h1("Let's do a T-Test!"),
      fileInput("file", "Upload a file", accept = c(".csv", ".tsv")),
      selectInput("group_var", "Select a group variable", choices = NULL),
      selectInput("val_var", "Select a numeric variable", choices = "")
    ),
    mainPanel(
      fluidRow(tableOutput("tbl")),
      fluidRow(tableOutput("mdl"))
      )
    )
  )


server <- function(input, output, session) {
  
  data <- reactive({
    req(input$file)
    
    ext <- tools::file_ext(input$file$name)
    
    switch(ext,
      csv = vroom::vroom(input$file$datapath, delim = ","),
      tsv = vroom::vroom(input$file$datapath, delim = "\t"),
      validate("Invalid file; Please upload a .csv or .tsv file")
    )
    
  })
  
outVar = reactive({
  mydata <- data()
  names(mydata)
})

observe({
  updateSelectInput(
    session, "val_var", choices = outVar()
  )
})

observe({
  updateSelectInput(
    session, "group_var", choices = outVar()
  )
})

# data_names <- names(data())
#   
#   updateSelectInput({
#     choices = data_names
#   })
#   
  t_test <- reactive({

    req(input$file)

    df <- data()

    x <- df %>%
      pull(input$val_var)

    y <- df %>%
      pull(input$group_var)

    t.test(x ~ y, data = df)


  })
  
  output$tbl <- renderTable({
    head(data(), n = 10)
  })
  
  output$mdl <- renderTable(
    broom::tidy(t_test())
  )
}

shinyApp(ui, server)