## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ShortForm)

## ----basic-example------------------------------------------------------------
set.seed(58310)

result <- suppressWarnings(simulatedAnnealing(
  initialModel = " visual  =~ x1 + x2 + x3
                   textual =~ x4 + x5 + x6
                   speed   =~ x7 + x8 + x9 ",
  originalData = lavaan::HolzingerSwineford1939,
  maxIterations = 3,
  criterion = "cfi",
  negateCriterion = TRUE,
  itemsPerFactor = c(2, 2, 2),
  items = paste0("x", 1:9)
))

result

## ----summary------------------------------------------------------------------
summary(result)

## ----plot, fig.width=6, fig.height=4------------------------------------------
plot(result)

## ----plot-burnin, fig.width=6, fig.height=4-----------------------------------
plot(result, burn_in = 1)

## ----criterion-function, eval=FALSE-------------------------------------------
# simulatedAnnealing(
#   initialModel = "...",
#   originalData = myData,
#   maxIterations = 20,
#   criterion = function(fit) AIC(fit),
#   negateCriterion = FALSE, # smaller AIC is better
#   itemsPerFactor = c(6, 6, 6)
# )

## ----full-model-example, eval=FALSE-------------------------------------------
# fittedModel <- lavaan::cfa(
#   model = " visual  =~ x1 + x2 + x3
#             textual =~ x4 + x5 + x6
#             speed   =~ x7 + x8 + x9",
#   data = lavaan::HolzingerSwineford1939
# )
# 
# simulatedAnnealing(
#   initialModel = fittedModel,
#   originalData = lavaan::HolzingerSwineford1939,
#   maxIterations = 20,
#   criterion = "cfi",
#   negateCriterion = TRUE
# )

## ----bifactor-example, eval=FALSE---------------------------------------------
# bifactorModel <- "
# visual  =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
# textual =~ x4 + x5 + x6
# speed   =~ x7 + x8 + x9"
# 
# simulatedAnnealing(
#   initialModel = bifactorModel,
#   originalData = lavaan::HolzingerSwineford1939,
#   maxIterations = 20,
#   criterion = "cfi", negateCriterion = TRUE,
#   itemsPerFactor = c(6, 3, 3),
#   items = paste0("x", 1:9),
#   bifactor = "visual"
# )

## ----parallel-chains, eval=FALSE----------------------------------------------
# simulatedAnnealing(
#   initialModel = "...",
#   originalData = myData,
#   maxIterations = 100,
#   criterion = "cfi", negateCriterion = TRUE,
#   itemsPerFactor = c(6, 6, 6),
#   setChains = 4
# )

