source(here::here("chap_4", "neiss_data.R"))

prod_codes <- setNames(products$prod_code, products$title)

count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarize(n = as.integer(sum(weight)))
}

# Exercise 2
# count_top <- function(df, var, n = 5) {
#   df %>%
#     mutate({{ var }} := fct_infreq(fct_lump({{ var }}, n = n))) %>%
#     group_by({{ var }}) %>%
#     summarize(n = as.integer(sum(weight)))
# }

ui <- fluidPage(
  fluidRow(
    column(8, 
      selectInput("code", "Product", 
        choices = setNames(products$prod_code, products$title),
        width = "100%"
        )
    ),
    column(2,
      selectInput("y", "Y axis", c("rate", "count"))),
    column(2, 
      numericInput("rows", "Table Length in Rows", value = 5, min = 1, max = 10)
      )
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location")
    )
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ),
  fluidRow(
    column(1, actionButton("back", "\u25C0")),
    # column(2, actionButton("story", "Tell me a story")),
    column(10, textOutput("narrative")),
    column(1, actionButton("forward", "\u25b6"))
  )
)

server <- function(input, output, session) {
  
  selected <- reactive(injuries %>% filter(prod_code == input$code))
  
  values <- reactiveValues(dat_index = 1)
  
  # Part 1
  # output$diag <- renderTable(
  #   selected() %>% count(diag, wt = weight, sort = TRUE)
  # )
  # 
  # output$body_part <- renderTable(
  #   selected() %>% count(body_part, wt = weight, sort = TRUE)
  # )
  # 
  # output$location <- renderTable(
  #   selected() %>% count(location, wt = weight, sort = TRUE)
  # )
  
  # Part 2
  
  # WRONG! 
  # output$diag <- renderTable(count_top(selected(), diag, n = input$rows), width = "100%")
  # output$body_part <- renderTable(count_top(selected(), body_part, n = input$rows), width = "100%")
  # output$location <- renderTable(count_top(selected(), location, n = input$rows), width = "100%")
  
  # Correct from Maya Gans
  
  # Find the maximum possible of rows.
  max_no_rows <- reactive(
    max(length(unique(selected()$diag)),
        length(unique(selected()$body_part)),
        length(unique(selected()$location)))
  )
  
  # Update the maximum value for the numericInput based on max_no_rows().
  observeEvent(input$code, {
    updateNumericInput(session, "rows", max = max_no_rows())
  })
  
  table_rows <- reactive(input$rows - 1)  
  output$diag <- renderTable(count_top(selected(), diag, n = table_rows()), width = "100%")
  output$body_part <- renderTable(count_top(selected(), body_part, n = table_rows()), width = "100%")
  output$location <- renderTable(count_top(selected(), location, n = table_rows()), width = "100%")
  
  summary <- reactive({
    selected() %>% 
      count(age, sex, wt = weight) %>% 
      left_join(population, by = c("age", "sex")) %>% 
      mutate(rate = n / population *1e4)
  })
  
  output$age_sex <- renderPlot({
    if (input$y == "count"){
      summary() %>% 
        ggplot(
          aes(
            x = age,  
            y = n, 
            color = sex
            )
          ) +
        geom_line() +
        labs(y = "Estimated number of injuries")
    } else {
      summary() %>% 
        ggplot(
          aes(
            x = age, 
            y = rate,
            color = sex
          )
        ) +
        geom_line() +
        labs(y = "Injuries per 10,000 people")
    }
  }, res = 96)
  
  # narrative_sample <- eventReactive(
  #   list(input$story, selected()),
  #   selected() %>% pull(narrative) %>% sample(1)
  # )
  
  
  # output$narrative <- renderText(narrative_sample())
  
  observeEvent(input$back, {
    values$dat_index <- if_else(
      values$dat_index == 1,
      as.integer(nrow(selected())),
      as.integer(values$dat_index - 1)
    )
  })
  
  observeEvent(input$forward, {
    values$dat_index <- if_else(
      values$dat_index == as.integer(nrow(selected())),
      1L,
      as.integer(values$dat_index + 1L)
    )
  })
  
  observeEvent(input$code, {
    values$dat_index <- 1
  })
  
  output$narrative <- renderText({
    
    selected() %>% 
      pull(narrative) %>% 
      pluck(values$dat_index)
    
  })
  
  # output$narrative <- renderText(narrative_sample())
}

shinyApp(ui, server)