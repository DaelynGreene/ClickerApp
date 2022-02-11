library(shiny)
library(lubridate)
library(audio)



server <- function(input, output, session) {
  timer <- reactiveVal(6)
  active <- reactiveVal(FALSE)
  ClickCounter <- reactiveValues(NumberClicks = 0)

  observeEvent(input$Timer, {
    ClickCounter$NumberClicks <- 0
  })

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
        output$Eggs <- renderUI({
          isolate({
            if (2 == 2) {
              mainPanel(
                align = "center",
                width = 12,
                setBackgroundColor(
                  color = GEN_PALETTE(),
                  gradient = "radial",
                  direction = "bottom"
                )
              )
            }
          })
        })
        if (timer() < 1) {
          active(FALSE)
          showModal(modalDialog(
            title = "Important Message",
            div(
              "Countdown completed! You clicked the button",
              paste(ClickCounter$NumberClicks), "times!"
            )
          ))
          if (ClickCounter$NumberClicks <= 5000) {
            play(load.wave("Borat.wav"))
          }
        }
      }
    })
  })

  # observers for actionbuttons
  observeEvent(input$Timer, {
    # play(load.wave("FCW.wav"))
    active(TRUE)
    timer(5)
    output$DisplayingClicks <- renderText("")
  })

  output$currentTime <- renderText({
    invalidateLater(1000, session)
    if (as.numeric(seconds_to_period(timer())) >= 5) {
      paste("It's the final countdown!")
    } else {
      paste(
        "Hurry! You've only got",
        as.numeric(seconds_to_period(timer())),
        "seconds left!"
      )
    }
  })
}
