library(audio)

VOLS_PALETTE <- rep(c("#ff8200", "#ffffff"), times = 10)

GEN_PALETTE <- function(n) {
  sample(rainbow(50), 15)
}

FINAL_COUNTDOWN_SOUND <- load.wave("FCW.wav")
BORAT_SOUND <- load.wave("Borat.wav")
