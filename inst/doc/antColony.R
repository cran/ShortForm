## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ShortForm)

## ----basic-example------------------------------------------------------------
set.seed(58310)

result <- antColony(
  data = lavaan::HolzingerSwineford1939,
  ants = 2, evaporation = 0.7,
  initialModel = " visual  =~ x1 + x2 + x3
                   textual =~ x4 + x5 + x6
                   speed   =~ x7 + x8 + x9 ",
  itemsPerFactor = c(3, 3, 3),
  steps = 2,
  fit.indices = c("cfi"),
  fit.statistics.test = "(cfi > 0.6)",
  maxIterations = 2,
  parallel = FALSE,
  verbose = FALSE
)

result

## ----summary------------------------------------------------------------------
summary(result)

## ----plot, fig.width=7, fig.height=6------------------------------------------
plot(result)

## ----plot-single, fig.width=6, fig.height=4-----------------------------------
plot(result, type = "pheromone")

## ----realistic-example, eval=FALSE--------------------------------------------
# data(exampleAntModel) # a character vector for a lavaan model
# data(simulated_test_data)
# 
# abilityShortForm <- antColony(
#   data = simulated_test_data,
#   ants = 5, evaporation = 0.7,
#   initialModel = exampleAntModel,
#   itemsPerFactor = 20,
#   steps = 3,
#   fit.indices = c("cfi", "rmsea"),
#   fit.statistics.test = "(cfi > 0.95)&(rmsea < 0.05)",
#   maxIterations = 500
# )
# 
# abilityShortForm

## ----ordered-example, eval=FALSE----------------------------------------------
# sim_model <- "
# f1 =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10
# f2 =~ x11 + x12 + x13 + x14 + x15 + x16 + x17 + x18 + x19 + x20
# f3 =~ x21 + x22 + x23 + x24 + x25 + x26 + x27 + x28 + x29 + x30"
# 
# sim_data <- cbind(
#   psych::sim.rasch(nvar = 10)$items,
#   psych::sim.rasch(nvar = 10)$items,
#   psych::sim.rasch(nvar = 10)$items
# )
# colnames(sim_data) <- paste0("x", 1:30)
# 
# # only estimator and ordered are changed -- every other lavaan.model.specs
# # element falls back to antColony()'s own default
# example <- antColony(
#   data = sim_data,
#   ants = 5, evaporation = 0.7,
#   initialModel = sim_model,
#   lavaan.model.specs = list(estimator = "wlsmv", ordered = TRUE),
#   itemsPerFactor = c(5, 5, 5),
#   steps = 20,
#   fit.indices = c("cfi.scaled"),
#   fit.statistics.test = "(cfi.scaled > 0.90)",
#   maxIterations = 500,
#   parallel = TRUE
# )

## ----bifactor-example, eval=FALSE---------------------------------------------
# bifactorModel <- "
# visual  =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
# textual =~ x4 + x5 + x6
# speed   =~ x7 + x8 + x9"
# 
# antColony(
#   data = lavaan::HolzingerSwineford1939,
#   ants = 5, evaporation = 0.7,
#   initialModel = bifactorModel,
#   itemsPerFactor = c(6, 3, 3),
#   bifactor = "visual",
#   steps = 5, fit.indices = c("cfi"), fit.statistics.test = "(cfi > 0.9)",
#   maxIterations = 100
# )

