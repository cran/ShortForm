## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ShortForm)

## ----basic-example------------------------------------------------------------
set.seed(58310)

shortAntModel <- "
Ability =~ Item1 + Item2 + Item3 + Item4 + Item5 + Item6 + Item7 + Item8
Ability ~ Outcome
"

result <- tabuSearch(
  initialModel = shortAntModel,
  originalData = simulated_test_data,
  itemsPerFactor = 7,
  maxIterations = 3,
  tabu.size = 3,
  parallel = FALSE
)

result

## ----summary------------------------------------------------------------------
summary(result)

## ----plot, fig.width=6, fig.height=4------------------------------------------
plot(result)

## ----criterion-function-------------------------------------------------------
set.seed(58310)

tabuCriterion <- function(fit) {
  tryCatch(lavaan::fitmeasures(fit, "chisq"), error = function(e) Inf)
}

result_chisq <- tabuSearch(
  initialModel = shortAntModel,
  originalData = simulated_test_data,
  itemsPerFactor = 7,
  criterion = tabuCriterion,
  # smaller chisq is better, so this is minimized directly
  # (unlike the default cfi criterion, which is maximized)
  negateCriterion = FALSE,
  maxIterations = 3, tabu.size = 3, parallel = FALSE
)

result_chisq

## ----larger-example, eval=FALSE-----------------------------------------------
# # four correlated-ish factors, 12 candidate items each
# tabuModel <- "
# Trait1 =~ Item1 + Item2 + Item3 + Item4 + Item5 + Item6 +
# Item7 + Item8 + Item9 + Item10 + Item11 + Item12
# Trait2 =~ Item13 + Item14 + Item15 + Item16 + Item17 +
# Item18 + Item19 + Item20 + Item21 + Item22 + Item23 + Item24
# Trait3 =~ Item25 + Item26 + Item27 + Item28 + Item29 + Item30 +
# Item31 + Item32 + Item33 + Item34 + Item35 + Item36
# Trait4 =~ Item37 + Item38 + Item39 + Item40 + Item41 +
# Item42 + Item43 + Item44 + Item45 + Item46 + Item47 + Item48
# "
# # NOTE: each factor must be on a single line, or the algorithm
# # will not parse the model syntax correctly.
# 
# tabuShort <- tabuSearch(
#   initialModel = tabuModel, originalData = tabuData, # your data here
#   itemsPerFactor = c(3, 3, 3, 3),
#   criterion = tabuCriterion,
#   negateCriterion = FALSE,
#   maxIterations = 20, tabu.size = 10
# )

## ----bifactor-example, eval=FALSE---------------------------------------------
# bifactorModel <- "
# visual  =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
# textual =~ x4 + x5 + x6
# speed   =~ x7 + x8 + x9"
# 
# tabuSearch(
#   initialModel = bifactorModel,
#   originalData = lavaan::HolzingerSwineford1939,
#   itemsPerFactor = c(6, 3, 3),
#   bifactor = "visual",
#   maxIterations = 20, tabu.size = 5
# )

## ----tabu-sem-----------------------------------------------------------------
holzingerModel <- " visual  =~ x1 + x2 + x3
                     textual =~ x4 + x5 + x6
                     speed   =~ x7 + x8 + x9"

init.model <- lavaan::lavaan(
  model = holzingerModel, data = lavaan::HolzingerSwineford1939,
  auto.var = TRUE, auto.fix.first = TRUE, std.lv = FALSE, auto.cov.lv.x = TRUE
)
ptab <- search.prep(fitted.model = init.model, loadings = TRUE, fcov = TRUE, errors = FALSE)

trial <- suppressWarnings(
  tabu.sem(init.model = init.model, ptab = ptab, criterion = AIC, niter = 2, tabu.size = 5)
)

trial

