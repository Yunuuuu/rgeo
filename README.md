
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rgeo

<!-- badges: start -->

[![R-CMD-check](https://github.com/Yunuuuu/rgeo/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Yunuuuu/rgeo/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Yunuuuu/rgeo/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Yunuuuu/rgeo?branch=main)
<!-- badges: end -->

The goal of `rgeo` is to reduce the dependencies of
[`GEOquery`](https://github.com/seandavi/GEOquery) and provide a unified
R interface for most operation including both searching and downloading
in [GEO database](https://www.ncbi.nlm.nih.gov/geo/).

## Installation

You can install the development version of rgeo from
[GitHub](https://github.com/) with:

``` r
pak::pkg_install("Yunuuuu/rgeo")
```

## Features

-   Low dependency, using
    [`data.table`](https://github.com/Rdatatable/data.table) to
    implement all reading and preprocessing process. Reducing
    dependencies is the main purpose of this package since I have
    experienced several times of code failure after updating packages
    when using [`GEOquery`](https://github.com/seandavi/GEOquery).
-   Provide a searching interface of [GEO
    database](https://www.ncbi.nlm.nih.gov/geo/), in this way, we can
    filter the searching results using `R function`.
-   Provide some useful utils function to deal with GEO datasets like
    `parse_pdata`, `set_pdata`, `log_trans` and `show_geo`.

## Vignettes

``` r
library(rgeo)
```

### Search GEO database - `search_geo`

The NCBI uses a search term syntax which can be associated with a
specific search field with square brackets. So, for instance “Homo
sapiens\[ORGN\]” denotes a search for `Homo sapiens` in the “Organism”
field. Details see
<https://www.ncbi.nlm.nih.gov/geo/info/qqtutorial.html>. We can use the
same term to query our desirable results in `search_geo`. `search_geo`
will parse the searching results and return a data.frame containing all
the records based on the search term. The internal of `search_geo` is
based on [`rentrez`](https://github.com/ropensci/rentrez) package, which
provides functions that work with the [NCBI
Eutils](http://www.ncbi.nlm.nih.gov/books/NBK25500/) API, so we can
utilize `NCBI API key` to increase the downloading speed, details see
<https://docs.ropensci.org/rentrez/articles/rentrez_tutorial.html#rate-limiting-and-api-keys>.

Providing we want ***GSE*** GEO records related to ***human diabetes***,
we can get these records by this:

``` r
diabetes_gse_records <- search_geo(
    "diabetes[ALL] AND Homo sapiens[ORGN] AND GSE[ETYP]"
)
diabetes_gse_records
```

### download data from GEO database - `get_geo`
