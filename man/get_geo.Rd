% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_geo.R
\name{get_geo}
\alias{get_geo}
\title{Get a GEO object from GEO FTP site}
\usage{
get_geo(
  ids,
  dest_dir = getwd(),
  gse_matrix = TRUE,
  pdata_from_soft = TRUE,
  add_gpl = NULL,
  ftp_over_https = TRUE,
  handle_opts = list(connecttimeout = 60L)
)
}
\arguments{
\item{ids}{A character vector representing the GEO entity for downloading and
parsing. All ids must in the same GEO identity (\code{c("GDS505", "GDS606")} are
all GEO DataSets, \code{c("GSE2", "GSE22")} are all GEO series eg.).}

\item{dest_dir}{The destination directory for any downloads. Defaults to
current working dir.}

\item{gse_matrix}{A logical value indicates whether to retrieve Series Matrix
files when handling a \code{GSE} GEO entity. When set to \code{TRUE}, an
\link[Biobase:class.ExpressionSet]{ExpressionSet} Object will be returned.}

\item{pdata_from_soft}{A logical value indicates whether derive \code{phenoData}
from GSE series soft file when parsing
\link[Biobase:class.ExpressionSet]{ExpressionSet} Object. Defaults to \code{TRUE}.
Sometimes soft file can be in large size, you can disable the downloading of
soft file by setting pdata_from_soft into \code{FALSE}. if \code{FALSE}, \code{phenoData}
will be parsed directly from GEO series matrix file, which is what
\code{GEOquery} do, in this way, \verb{characteristics_ch*} column sometimes cannot be
parsed correctly.}

\item{add_gpl}{A logical value indicates whether to add \strong{platform} (namely
the \link[Biobase:featureData]{featureData} slot in the
\link[Biobase:class.ExpressionSet]{ExpressionSet} Object) information when handling a
\code{GSE} GEO entity with \code{gse_matrix} option \code{TRUE}. \code{add_gpl} is set to \code{NULL}
by default, which means the internal will try to map the GPL accession ID
into a Bioconductor annotation package firstly, if it succeed, the
\link[Biobase:class.eSet]{annotation} slot in the returned
\link[Biobase:class.ExpressionSet]{ExpressionSet} object will be set to the found
Bioconductor annotation package and the \code{add_gpl} will be set to \code{FALSE},
otherwise, \code{add_gpl} will be set to \code{TRUE}.}

\item{ftp_over_https}{A scalar logical value indicates whether to connect GEO
FTP site with https traffic. If \code{TRUE}, will download FTP files from
\url{https://ftp.ncbi.nlm.nih.gov/geo}, which is used by GEOquery, otherwise,
will use \url{ftp://ftp.ncbi.nlm.nih.gov/geo} directly.}

\item{handle_opts}{A list of named options / headers to be set in the
\link[curl:handle]{handle}.}
}
\value{
An object of the appropriate class (GDS, GPL, GSM, or GSE) is
returned. For \code{GSE} entity, if \code{gse_matrix} parameter is \code{FALSE}, an
\linkS4class{GEOSeries} object is returned and if \code{gse_matrix} parameter is
\code{TRUE}, a \link[Biobase:class.ExpressionSet]{ExpressionSet} Object or a list of
\link[Biobase:class.ExpressionSet]{ExpressionSet} Objects is returned with every
element correspongding to each Series Matrix file associated with the GSE
accesion. And for other GEO entity, a \linkS4class{GEOSoft} object is returned.
}
\description{
This function is the main user-level function in the \code{rgeo} package. It
implements the downloading and parsing of GEO files.
}
\details{
Use \code{get_geo} functions to download and parse information available from
\href{http://www.ncbi.nlm.nih.gov/geo}{NCBI GEO}. Here are some details about what
is avaible from GEO. All entity types are handled by \code{get_geo} and
essentially any information in the GEO SOFT format is reflected in the
resulting data structure.

From the GEO website:

The Gene Expression Omnibus (GEO) from NCBI serves as a public repository
for a wide range of high-throughput experimental data. These data include
single and dual channel microarray-based experiments measuring mRNA, genomic
DNA, and protein abundance, as well as non-array techniques such as serial
analysis of gene expression (SAGE), and mass spectrometry proteomic data. At
the most basic level of organization of GEO, there are three entity types
that may be supplied by users: Platforms, Samples, and Series.
Additionally, there is a curated entity called a GEO dataset.

A Platform record describes the list of elements on the array (e.g., cDNAs,
oligonucleotide probesets, ORFs, antibodies) or the list of elements that
may be detected and quantified in that experiment (e.g., SAGE tags,
peptides). Each Platform record is assigned a unique and stable GEO
accession number (GPLxxx). A Platform may reference many Samples that have
been submitted by multiple submitters.

A Sample record describes the conditions under which an individual Sample
was handled, the manipulations it underwent, and the abundance measurement
of each element derived from it. Each Sample record is assigned a unique and
stable GEO accession number (GSMxxx). A Sample entity must reference only
one Platform and may be included in multiple Series.

A Series record defines a set of related Samples considered to be part of a
group, how the Samples are related, and if and how they are ordered. A
Series provides a focal point and description of the experiment as a whole.
Series records may also contain tables describing extracted data, summary
conclusions, or analyses. Each Series record is assigned a unique and stable
GEO accession number (GSExxx).

GEO DataSets (GDSxxx) are curated sets of GEO Sample data. A GDS record
represents a collection of biologically and statistically comparable GEO
Samples and forms the basis of GEO's suite of data display and analysis
tools. Samples within a GDS refer to the same Platform, that is, they share
a common set of probe elements. Value measurements for each Sample within a
GDS are assumed to be calculated in an equivalent manner, that is,
considerations such as background processing and normalization are
consistent across the dataset. Information reflecting experimental design is
provided through GDS subsets.
}
\examples{
gse_matix <- get_geo("GSE10", tempdir())
gse <- get_geo("GSE10", tempdir(), gse_matrix = FALSE)
gpl <- get_geo("gpl98", tempdir())
gsm <- get_geo("GSM1", tempdir())
gds <- get_geo("GDS10", tempdir())

}
\references{
\itemize{
\item \url{https://www.ncbi.nlm.nih.gov/geo/info/download.html}
\item \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi}
\item \url{https://www.ncbi.nlm.nih.gov/geo/info/soft.html#format}
\item \href{https://ftp.ncbi.nlm.nih.gov/geo/README.txt}{Programmatic access to GEO FTP site}
}
}
\keyword{IO}
\keyword{database}
