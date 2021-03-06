% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Algorithms.R
\name{Bisection}
\alias{Bisection}
\title{Bisection}
\usage{
Bisection(f = function(x) x^2 - 4 * x + 3, a = 0, b = 2)
}
\arguments{
\item{f}{mathematical function}

\item{a}{lower bound numeric value}

\item{b}{upper bound numeric value}
}
\description{
Finds roots for a given interval of values for a given function using bisection method

Algorithms
}
\examples{
\dontrun{
RemixAutoML::Bisection(f = function(x) x ^ 2 - 4 * x + 3, a = 0, b = 2)
# 1
}

}
\author{
Adrian Antico
}
