% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Tabu_sem.R
\name{tabu.sem}
\alias{tabu.sem}
\title{Given a fitted lavaan model, a search table, and an objective criterion,
performs a Tabu model specification search. Currently only supports
neighbors that are 1 move away from the current model.}
\usage{
tabu.sem(init.model, ptab, obj, niter = 30, tabu.size = 5)
}
\arguments{
\item{init.model}{initial fitted model of class lavaan}

\item{ptab}{search table (e.g., created by search.prep) that lists candidate
parameters that can be modified as part of the search and how the parameters
can be modified (fixed to what values)}

\item{obj}{objective function to be MINIMIZED. Any function that takes a
lavaan object as the sole argument and returns a numeric value can be used.}

\item{niter}{number of Tabu iterations to perform}

\item{tabu.size}{size of Tabu list}
}
\value{
A list with three elements: best.obj, the numerical value of the best (minimal) objective function achieved; best.mod, the final lavaan model, and best.binvec, a data.frame of the lavaan-formatted parameter table for the final model.
}
\description{
Given a fitted lavaan model, a search table, and an objective criterion,
performs a Tabu model specification search. Currently only supports
neighbors that are 1 move away from the current model.
}
\examples{
# load simulation data and select columns used in this example
data(simulated_test_data)
tabuData <- simulated_test_data[, c(1:10)]

# specify an improper model (improper because data is unidimensional)
tabuModel <- "
Ability =~ Item1 + Item2 + Item3 + Item4
FakeAbility =~ Item5 + Item6 + Item7 + Item8
Ability ~ Outcome
FakeAbility ~ 0*Outcome"

# run the initial misspecified model for Tabu

init.model <- lavaan::lavaan(
  model = tabuModel, data = tabuData,
  auto.var = TRUE, auto.fix.first = FALSE, std.lv = TRUE, auto.cov.lv.x = TRUE
)

# Use search.prep to prepare for the Tabu search
ptab <- search.prep(fitted.model = init.model, loadings = TRUE, fcov = TRUE, errors = FALSE)

# Perform Tabu Search
trial <- tabu.sem(init.model = init.model, ptab = ptab, obj = AIC, niter = 2, tabu.size = 5)
}
\references{
\doi{10.1080/10705511.2017.1409074}
}
\author{
Carl F. Falk
}
