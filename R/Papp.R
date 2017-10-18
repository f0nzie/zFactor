
#' Papp correlation
#'
#' Calculate the Z factor with the Papp correlation
#'
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @param tolerance rounding tolerance to avoid rounding readings that are in
#' the middle of the grid. "tolerance" adds flexibility in deciding point closeness.
#' @param verbose print internal
#' @rdname Papp
#' @export
#' @examples
#' # Example 1
#' ## one single z calculation
#' z.Papp(pres.pr = 1.5, temp.pr = 2.0)
#' # Example 2
#' ## calculate z for multiple values of Tpr and Ppr
#' ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
#' tpr <- c(1.3, 1.5, 1.7, 2)
#' z.Papay(pres.pr = ppr, temp.pr = tpr)
z.Papp <- function(pres.pr, temp.pr,
                         tolerance = 1e-13, verbose = FALSE) {
    # calls the core function.
    # this function converts the results to a matrix
    co <- sapply(pres.pr, function(x)
        sapply(temp.pr, function(y)
            .z.Papp(pres.pr = x, temp.pr = y,
                                      tolerance = tolerance, verbose = verbose)))
    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        co <- matrix(co, nrow = length(temp.pr), ncol = length(pres.pr))
        rownames(co) <- temp.pr
        colnames(co) <- pres.pr
    }
    return(co)
}


.z.Papp <- function(pres.pr, temp.pr,
                          tolerance = 1e-13, verbose = FALSE) {
    # core function
    # Papay compressibility factor

    x <- pres.pr / temp.pr^2
    a <- 0.1219 * temp.pr^0.638
    b <- temp.pr - 7.76 + 14.75 / temp.pr
    c <- 0.3 * x + 0.441 * x^2

    z <- 1 + a * (x - b) * (1 - exp(-c))

    return(z)
}
