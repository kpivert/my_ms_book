library(shiny)

ui <- fluidPage(
  actionButton("delete", "Delete all files?")
)

server <- function(input, output, session) {
  
  modal_confirm <- modalDialog(
    "Are you sure you want to continue?",
    title = "Deleting all files",
    footer = tagList(
      actionButton("cancel", "Cancel"),
      actionButton("ok", "Delete", class = "btn btn-danger")
    )
  )
  
  observeEvent(input$delete, {
    showModal(modal_confirm)
  })
  
  observeEvent(input$ok, {
    showNotification("Files deleted")
    removeModal()
  })
  
  observeEvent(input$cancel, {
    removeModal()
  })
}

shinyApp(ui, server)