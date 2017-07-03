#' Shell correlation from Kumar thesis (2005)
#'
#' @rdname Shell
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @param tolerance controls the iteration accuracy
#' @param verbose print internal
#' @export
#' @examples
#' # single z point and create a dataframe with info
#' ppr <- 1.5
#' tpr <- 1.1
#' z.calc <- z.Shell(pres.pr = ppr, temp.pr = tpr)
#' # From the Standing-Katz chart we obtain a digitized point:
#' z.chart <- getStandingKatzMatrix(tpr_vector = tpr,
#'                                  pprRange = "lp")[1, as.character(ppr)]
#' ape <- abs((z.calc - z.chart) / z.chart) * 100
#' df <- as.data.frame(list(Ppr = ppr,  z.calc =z.calc, z.chart = z.chart, ape=ape))
#' rownames(df) <- tpr
#' df
z.Shell <- function(pres.pr, temp.pr, tolerance = 1E-13,
                             verbose = FALSE) {
    co <- sapply(pres.pr, function(x)
        sapply(temp.pr, function(y) .z.Shell(pres.pr = x, temp.pr = y,
                                                      tolerance = tolerance,
                                                      verbose = verbose)))
    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        co <- matrix(co, nrow = length(temp.pr), ncol = length(pres.pr))
        rownames(co) <- temp.pr
        colnames(co) <- pres.pr
    }
    return(co)
}



.z.Shell <- function(pres.pr, temp.pr, tolerance = 1E-13,
                             verbose = FALSE) {
    # As per paper: "Prediction of gas compressibility factor using intelligent
    # models". DOI: doi.org/10.1016/j.ngib.2015.09.001
    tpr <- temp.pr
    ppr <- pres.pr

    A <- -0.101 - 0.36 * tpr + 1.3868 * sqrt(tpr - 0.919)
    B <- 0.021 + 0.04275 / (tpr - 0.65)
    D <- 0.122 * exp(-11.3 *(tpr - 1))
    E <- -0.6222 - 0.224 * tpr  # there is an error in the paper
                                # -0.6222 should be +0.6222

    E <- 0.6222 - 0.224 * tpr   # <- this is correct

    zF <- 0.0657 / (tpr - 0.85) - 0.037
    G <- 0.32 * exp(-19.53 * (tpr - 1))
    C <- ppr * (E + zF * ppr + G * ppr^4)

    z <- A + B * ppr + (1 - A) * exp(-C) - D * (ppr / 10)^4

    return(z)
}



# .z.Shell <- function(pres.pr, temp.pr, tolerance = 1E-13,
#                      verbose = FALSE) {
#     # checked against three sources: two books and one paper
#     # as per thesis by Neeraj Kumar, "Compressibility Factors for natural
#     # and sour gases by correlations and EOS". 2004. Texas Tech University
#
#     tpr <- temp.pr
#     ppr <- pres.pr
#
#     A <- -0.101 - 0.36 * tpr + 1.3868 * sqrt(tpr - 0.919)
#     B <- 0.021 + 0.04275 / (tpr - 0.65)
#     C <- 0.6222 - 0.224 * tpr     # 0.224 # -0.622
#     D <- 0.0657 / (tpr - 0.86) - 0.037
#     E <- 0.320 * exp(-19.53 * (tpr - 1))
#     zF <- 0.122 * exp(-11.30 * (tpr - 1))
#     G <- ppr * (C + D * ppr + E * ppr^4)
#
#     z <- A + B * ppr + (1 - A) * exp(-G) - zF * (ppr / 10)^4
#
#     return(z)
# }
