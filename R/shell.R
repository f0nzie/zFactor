#' Shell correlation
#'
#' @rdname Shell
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @param tolerance controls the iteration accuracy
#' @param verbose print internal
#' @export
z.Shell <- function(pres.pr, temp.pr, tolerance = 1E-13,
                             verbose = FALSE) {
    sh <- sapply(pres.pr, function(x)
        sapply(temp.pr, function(y) .z.Shell(pres.pr = x, temp.pr = y,
                                                      tolerance = tolerance,
                                                      verbose = verbose)))
    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        rownames(hy) <- temp.pr
        colnames(hy) <- pres.pr
    }
    return(sh)
}



.z.Shell <- function(pres.pr, temp.pr, tolerance = 1E-13,
                             verbose = FALSE) {
    tpr <- temp.pr
    ppr <- pres.pr

    A <- -0.101 - 0.36 * tpr + 1.3868 * sqrt(tpr - 0.919)
    B <- 0.021 + 0.04275 / (tpr -0.65)
    D <- 0.122 * exp(-11.3 *(tpr - 1))
    E <- 0.622 - 0.224 * tpr
    F <- 0.0657 / (tpr - 0.85) - 0.037
    G <- 0.32 * exp(-19.53 * (tpr - 1))
    C <- ppr * (E + F * ppr + G * ppr^4)

    z <- A + B * ppr + (1 - A) * exp(-C) - D * (ppr / 10)^4

    return(z)
}

