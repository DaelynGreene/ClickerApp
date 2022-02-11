library(shiny)
library(lubridate)
library(audio)

server <- function(input, output, session) {
  rvs <- reactiveValues(
    n_clicks = 0,
    timer = 6,
    active = FALSE
  )

  observeEvent(input$Timer, {
    play(FINAL_COUNTDOWN_SOUND)

    rvs$active <- TRUE
    rvs$timer <- 5
    rvs$n_clicks <- 0

    output$DisplayingClicks <- renderText("")
  })

  observeEvent(input$Clicks, {
    rvs$n_clicks <- rvs$n_clicks + 1
  })

  observeEvent(input$DisplayClicks, {
    output$DisplayingClicks <- renderText({
      rvs$n_clicks
    })
  })

  observe({
    invalidateLater(1000, session)
    isolate({
      if (rvs$active) {
        rvs$timer <- rvs$timer - 1
        output$Eggs <- renderUI({
          mainPanel(
            align = "center",
            width = 12,
            setBackgroundColor(
              color = GEN_PALETTE(),
              gradient = "radial",
              direction = "bottom"
            )
          ) # mainPanel
        }) # renderUI

        if (rvs$timer < 1) {
          rvs$active <- FALSE
          showModal(
            modalDialog(
              title = "Important Message",
              div(
                "Countdown completed! You clicked the button",
                rvs$n_clicks,
                "times!"
              )
            ) # modalDialog
          ) # showModal
          if (rvs$n_clicks <= 5000) {
            play(BORAT_SOUND)
          }
        } # if (rvs$timer < 1)
      } # if (rvs$active)
    }) # isolate
  })

  output$currentTime <- renderText({
    if (as.numeric(seconds_to_period(rvs$timer) >= 5)) {
      "It's the final countdown!"
    } else {
      paste(
        "Hurry! You've only got",
        as.numeric(seconds_to_period(rvs$timer)),
        "seconds left!"
      )
    }
  }) # renderText
} # server
