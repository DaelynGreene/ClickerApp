library(shiny)
library(shinyWidgets)


ui <- fluidPage(
    mainPanel(
      align = "center",
      width = 12,
      setBackgroundColor(
        color = VOLS_PALETTE,
        gradient = "radial",
        direction = "top"
      )
    ),
    titlePanel(title = h3("How many clicks in 5 seconds!!!", align = "center"), windowTitle = "Clicker Challenge"),
    br(),
    br(),
    mainPanel(
      width = 12, align = "center", actionButton(
        inputId = "Timer",
        label = "Start Timer"
      ),
      actionButton(
        inputId = "Clicks",
        label = "Click Me"
      ),
      actionButton(
        inputId = "DisplayClicks",
        label = "How Many Times Did I Click?"
      )
    ),
    br(),
    br(),
    h3(textOutput("currentTime"), align = "center"),
    mainPanel(width = 12, align = "center", a(
      href = "https://haslam.utk.edu/experts/brian-stevens",
      "Learn more about the creator", align = "center"
    )),
    uiOutput("Eggs"),
    br(),
    h3(textOutput("DisplayingClicks"), align = "center")
  )
