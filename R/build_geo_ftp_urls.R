# Programmatic access to GEO-[help](https://ftp.ncbi.nlm.nih.gov/geo/README.txt)
geo_ftp <- "ftp://ftp.ncbi.nlm.nih.gov/geo/"

parse_geo_type <- function(x) {
    switch(x,
        GSE = "series",
        GPL = "platforms",
        GSM = "samples",
        GDS = "datasets"
    )
}

#' |            type            | GDS | GSE | GPL | GSM |
#' | :------------------------: | :-: | :-: | :-: | :-: |
#' |        SOFT (soft)         |  o  |  o  |  o  |  x  |
#' |    SOFTFULL (soft_full)    |  o  |  x  |  x  |  x  |
#' |      MINiML (miniml)       |  x  |  o  |  o  |  x  |
#' |      Matrix (matrix)       |  x  |  o  |  x  |  x  |
#' |     Annotation (annot)     |  x  |  x  |  o  |  x  |
#' | Supplementaryfiles (suppl) |  x  |  o  |  o  |  o  |

# parse_file_switch_helper <- list(
#     GDS = c(soft = ".soft.gz", soft_full = "_full.soft.gz"),
#     GSE = c(
#         soft = "_family.soft.gz", miniml = "_family.xml.tgz",
#         matrix = "_series_matrx.txt.gz", suppl = ""
#     ),
#     GPL = c(
#         annot = ".annot.gz",
#         miniml = "_family.xml.tgz",
#         soft = "_family.soft.gz",
#         suppl = ""
#     ),
#     GSM = c(suppl = "")
# )
# parse_file <- function(ids, file_type, geo_type) {
#     file_suffix <- parse_file_switch_helper[[geo_type]][[file_type]]
#     if (is.na(file_suffix)) {
#         rlang::abort(
#             "{parse_geo_type(geo_type)} never own {file_type} file"
#         )
#     }
#     if (nchar(file_suffix)) {
#         file_ids <- paste0(ids, file_suffix)
#     } else {
#         file_ids <- file_suffix
#     }
#     paste0(file_type, "/", file_ids)
# }

parse_file_names <- function(ids, file_type, geo_type) {
    file_suffix <-
        switch(geo_type,
            GDS = switch(file_type,
                soft = ".soft.gz",
                soft_full = "_full.soft.gz"
            ),
            GSE = switch(file_type,
                soft = "_family.soft.gz",
                miniml = "_family.xml.tgz",
                matrix = "/",
                suppl = "/"
            ),
            GPL = switch(file_type,
                annot = ".annot.gz",
                miniml = "_family.xml.tgz",
                soft = "_family.soft.gz",
                suppl = "/"
            ),
            GSM = if (identical(file_type, "suppl")) "/" else NULL
        )
    if (is.null(file_suffix)) {
        rlang::abort(
            paste0(parse_geo_type(geo_type), " never own ", file_type, " file")
        )
    }
    if (!identical(file_suffix, "/")) {
        paste0(ids, file_suffix)
    } else {
        file_suffix
    }
}

build_geo_ftp_urls <- function(ids, file_type) {
    geo_type <- substr(ids, 1, 3)
    super_ids <- sub("\\d{1,3}$", "nnn", ids, perl = TRUE)
    file.path(
        geo_ftp,
        parse_geo_type(geo_type),
        super_ids, ids, file_type,
        parse_file_names(ids, file_type, geo_type)
    )
}