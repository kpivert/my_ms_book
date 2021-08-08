## Exercise 4: Upload and Download with Brickr ----

library(shiny)
require(brickr)
require(waiter)

## UI ----

ui <- fluidPage(
  waiter::use_waiter(),
  sidebarLayout(
    sidebarPanel(
      h1("Fun with LEGO"),
      h2("Upload a PNG file!"),
      fileInput("pic", label = "PNG", buttonLabel = "Upload PNG"),
      wellPanel(
        sliderInput(
          "width", 
          "Choose the width of your mosaic", 
          min = 10, max = 200, value = 50
          ),
        sliderInput(
          "height",
          "Choose the height of your mosaic",
          min = 10, max = 200, value = 50 
        ),
        radioButtons(
          "pal",
          "Choose your color palette", 
          choices = c("universal", "generic"), 
          selected = "generic"  
        ),
        actionButton("build", "Let's Construct!")
      )
    ),
    mainPanel(
      column(6,
        imageOutput("orig")
        ),
      column(6,
        plotOutput("plot")
      )
    )
  )
)

## SERVER ----

server <- function(input, output, session) {
  
  ## Upload Handler ----
  
  photo <- reactive({

    req(input$pic)

    ext <- tools::file_ext(input$pic$name)
    validate(need(ext == "png", "Invalid file. Please upload a .png file"))

    input$pic

  })
  
  ## Show Original PNG -----
  
  output$orig <- renderImage({
    
    req(photo())
    
    list(
      src = input$pic$datapath,
      width = 400, 
      # height = 500, 
      contentType = 'image/png'
      )
    },
  deleteFile = FALSE)
  
  ## Create LEGO Mosaic ----
  
  # output$plot <- renderPlot({
  #   
  #   req(input$build)
  #   img_1 <- photo()
  #   
  #   # img_1 <- png::readPNG(input$pic$datapath)
  #   # 
  #   # mosaic_1 <- image_to_mosaic(
  #   #   img_1, 
  #   #   img_size = c(input$widht, input$height)
  #   #   ) 
  #   # 
  #   # build_mosaic(mosaic_1)
  #   
  #   img_1 <- png::readPNG(img_1$datapath)
  #   
  #   mosaic_1 <- image_to_mosaic(
  #     img = img_1, 
  #     img_size = c(input$width, input$height)
  #     ) 
  #   
  #   build_mosaic(mosaic_1)
  #   
  # })
  
  mosaic <- eventReactive(input$build, {
    waiter::Waiter$new(id = "plot")$show()
    
    img_1 <- photo()
    
    img_1 <- png::readPNG(img_1$datapath)
    
    image_to_mosaic(
      img = img_1,
      img_size = c(input$width, input$height)
    )
    
  })
  
  output$plot <- renderPlot({
    
    mosaic_1 <- mosaic()
    
    build_mosaic(mosaic_1)
    
  }, res = 96)
  
}

shinyApp(ui, server)