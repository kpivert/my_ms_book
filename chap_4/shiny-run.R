# This script is used to run the application defined in app.R in the background

# rstudioapi::viewer("URL from console") 
options(shiny.autoreload = TRUE)
shiny::runApp()

