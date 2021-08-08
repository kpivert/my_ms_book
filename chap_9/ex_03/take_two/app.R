## HAVE TO FIX THIS!!!!!! ----


library(shiny)


ui <- fluidPage(
  sidebarPanel(
    fileInput("file", "Upload a file"),
    selectInput("var", "Select a numeric variable to plot", choices = NULL),
    actionButton("viz", "Visualize It!"),
    radioButtons("ext", "Choose your image type", 
                 # choices = c(".png", ".pdf", ".svg")
                 choices = set_names(
                   c(".png", ".pdf", ".svg"),
                   ~stringr::str_sub(c(".png", ".pdf", ".svg"), start = 2)
                 )
    ),
    downloadButton("download", "Download your file!")
  ),
  mainPanel(
    plotOutput("plot")
  )
)  

server <- function(input, output, session) {
  
  # Data --------------------------------------------------------------------
  
  data <- reactive({
    
    req(input$file)
    
    ext <- tools::file_ext(input$file$name)
    
    switch(ext,
           csv = vroom::vroom(input$file$datapath, delim = ","),
           tsv = vroom::vroom(input$file$datapath, delim = "\t"),
           validate("Invalid file; Please upload a .csv or .tsv file")
    )
    
  })
  
  
  # Dynamic Variable Names --------------------------------------------------
  
  outVar = reactive({
    mydata <- data()
    names(mydata)
  })
  
  observe({
    updateSelectInput(
      session, "var", choices = outVar()
    )
  })
  
  
  # Create Histogram --------------------------------------------------------
  
  # output$plot <- renderPlot({
  #   
  #   # Don't render until button clicked
  #   
  #   req(input$viz)
  #   
  #   # Acquire dataset
  #   
  #   df <- data() 
  #   
  #   # # Acquire variable for histogram
  #   # ex <- sym(input$var)
  #   # # hist_var <- input$var
  #   # num_var <- is.numeric(df %>% pull(!!ex))
  #   # shinyFeedback::feedbackDanger("var", !num_var, "Variable must be numeric!")
  #   # req(num_var, cancelOutput = TRUE)
  # 
  #   # # plot(df)
  #   
  #   req(is.numeric(input$var))  
  #   
  #   ggplot(
  #     df,
  #     aes_string(
  #       x = input$var
  #     )
  #   ) +
  #     geom_histogram(
  #       bins = 100
  #       ) +
  #     geom_freqpoly(
  #       bins = 50
  #     )
  # 
  #   
  # })
  # 
  
  # plot_output <- reactive({
  #   
  #   
  #   # req(is.numeric(input$var))
  #   
  #   ggplot(data()) +
  #     aes_string(x = input$var) +
  #     geom_histogram(bins = 100) +
  #     geom_freqpoly(bins = 50)
  #   
  # })

  # is_num <- reactive({
  #   
  #   validate(
  #     need(
  #       is.numeric(input$var) == TRUE,
  #       "This column isn't numeric."
  #       )
  #     )
  #   
  #   input$var
  #   
  # })
  
  num_num <- reactive({
    
    if (is.numeric(input$var)) {
      
      input$var
      
    } else {
      validate("This col isn't numeric")
    }
    
  })
  
  
  plot_output <- reactive({
    
    
    req(num_num())
    
    x <- num_num()
    
    ggplot(data()) +
      aes_string(x = x) +
      # aes_string(x = input$var) +
      geom_histogram(bins = 100) +
      geom_freqpoly(bins = 50)
    
  })
  
  output$plot <- renderPlot({
    req(input$viz)
    plot_output()
  }, res = 96)
  
  
  # Select Image Type -------------------------------------------------------
  
  
  
  
  # Save Image --------------------------------------------------------------
  
  
  
  output$download <- downloadHandler(
    filename = function() {
      paste0(input$var, "_histogram", input$ext)
    },
    content = function(file) {
      ggsave(
        filename = file,
        plot_output(),
        device = names(input$ext)
      )
    }
  )
  
}

shinyApp(ui, server)