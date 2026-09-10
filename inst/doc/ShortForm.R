## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ShortForm)

## ----quick-example-ACO--------------------------------------------------------
set.seed(58310)

result_ACO <- antColony(
  data = lavaan::HolzingerSwineford1939,
  ants = 2, evaporation = 0.7,
  initialModel = " visual  =~ x1 + x2 + x3
                   textual =~ x4 + x5 + x6
                   speed   =~ x7 + x8 + x9 ",
  itemsPerFactor = c(3, 3, 3),
  steps = 2, fit.indices = c("cfi"), fit.statistics.test = "(cfi > 0.6)",
  maxIterations = 2, parallel = FALSE, verbose = FALSE
)

result_ACO

## ----quick-example-SA---------------------------------------------------------
set.seed(58310)

result_SA <- suppressWarnings(simulatedAnnealing(
  initialModel = " visual  =~ x1 + x2 + x3
                   textual =~ x4 + x5 + x6
                   speed   =~ x7 + x8 + x9 ",
  originalData = lavaan::HolzingerSwineford1939,
  maxIterations = 3,
  criterion = "cfi", negateCriterion = TRUE,
  itemsPerFactor = c(2, 2, 2),
  items = paste0("x", 1:9)
))

result_SA

## ----quick-example-TS---------------------------------------------------------
set.seed(58310)

shortAntModel <- "
Ability =~ Item1 + Item2 + Item3 + Item4 + Item5 + Item6 + Item7 + Item8
Ability ~ Outcome
"

result_TS <- tabuSearch(
  initialModel = shortAntModel,
  originalData = simulated_test_data, itemsPerFactor = 7,
  maxIterations = 3, tabu.size = 3, parallel = FALSE
)

result_TS

## ----outputs------------------------------------------------------------------
plot(result_TS)

