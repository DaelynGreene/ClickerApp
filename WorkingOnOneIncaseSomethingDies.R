library(lubridate)
library(shiny)
library(shinyWidgets)
library(audio)
palette1 <- rainbow(50)
OrangeAndWhite <- rep(c("#ff8200", "#ffffff"), 10)
InitialBackground <- setBackgroundColor(color = OrangeAndWhite, gradient = "radial", direction = "top")

ui <-
  fluidPage(
    
    mainPanel(
      align = "center",
      width = 12,
      InitialBackground
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



##############################################################################################################################
##############################################################################################################################



server <- function(input, output, session) {
  timer <- reactiveVal(6)
  active <- reactiveVal(FALSE)




  ClickCounter <- reactiveValues(NumberClicks = 0)
  


  observeEvent(input$Clicks, {
    ClickCounter$NumberClicks <- ClickCounter$NumberClicks + 1
  })



  observeEvent(input$DisplayClicks, {
    output$DisplayingClicks <- renderText({
      ClickCounter$NumberClicks
    })
  })



  observe({
    invalidateLater(1000, session)
    isolate({
      if (active()) {
        timer(timer() - 1)
        # output$Eggs <- renderUI({
        #   mainPanel(
        #     align = "center",
        #     width = 12,
        #     setBackgroundColor(color=sample(rainbow(50),16), gradient="radial", direction="bottom")
        #   )
        # })
        if (timer() < 1) {
          active(FALSE)
          showModal(modalDialog(
            title = "Important Message",
            div(
              "Countdown completed! You clicked the button",
              paste(ClickCounter$NumberClicks), "times!"
            )
          ))
          # if (ClickCounter$NumberClicks <= 5000) {
          #   play(load.wave("Borat.wav"))
          # }
        }
      }
    })
  })



  # observers for actionbuttons



  observeEvent(input$Timer, {
    ClickCounter$NumberClicks <- 0
    play(load.wave("FCShorter.wav"))
    active(TRUE)
    timer(5)
    output$DisplayingClicks <- renderText("")
  })



  output$currentTime <- renderText({
    invalidateLater(1000, session)
    if (as.numeric(seconds_to_period(timer())) >= 5) {
      paste("It's the final countdown!")
    } else {
      if (timer() == 1) {
        paste(
          "Hurry! You've only got",
          as.numeric(seconds_to_period(timer())),
          "second left!"
        )
      } else {
        paste(
          "Hurry! You've only got",
          as.numeric(seconds_to_period(timer())),
          "seconds left!"
        )
      }
    }
  })
}



shinyApp(ui = ui, server = server)
