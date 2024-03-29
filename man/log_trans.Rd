% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/log_transformation.R
\name{log_trans}
\alias{log_trans}
\title{Apply log2 transformation for matrix data if not.}
\usage{
log_trans(data, pseudo = 1)
}
\arguments{
\item{data}{A matrix-like data object.}

\item{pseudo}{Since expression values for a gene can be zero in some
conditions (and non-zero in others), some advocate the use of
pseudo-expression values, i.e. transformations of the form: log2(exprs +
pseudo)}
}
\value{
A \code{matrix} or an \link[Biobase:class.ExpressionSet]{ExpressionSet} object
}
\description{
Apply log2 transformation for matrix data if not.
}
\details{
Automatically check whether \code{data} has been logarithmically
transformed, if not, applying a log2 transformation. The test methodology for
logarithm transformation is based on
\href{https://www.ncbi.nlm.nih.gov/geo/geo2r/}{GEO2R}
}
\references{
\href{https://www.ncbi.nlm.nih.gov/geo/geo2r/?acc=GSE1122}{geo2r analysis}
}
