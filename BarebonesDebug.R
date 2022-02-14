library(shiny)
library(audio)

ui <- fluidPage(
  mainPanel(
    width = 12, align = "center", actionButton(
      inputId = "Timer",
      label = "Start Timer"
    ))
)

server <- function(input, output, session) {
  observeEvent(input$Timer,{play(load.wave("Soulbound.wav"))})
}

shinyApp(ui, server)