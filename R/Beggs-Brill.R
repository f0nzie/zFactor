# Beggs and Brill

#' Beggs and Brill correlation
#'
#' Calculate the Z factor with the Brill-Beggs correlation
#'
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @param tolerance rounding tolerance to avoid rounding readings that are in
#' the middle of the grid. "tolerance" adds flexibility in deciding point closeness.
#' @param verbose print internal
#' @rdname Beggs-Brill
#' @export
#' @export
z.BeggsBrill <- function(pres.pr, temp.pr,
                         tolerance = 1e-13, verbose = FALSE) {

    co <- sapply(pres.pr, function(x)
        sapply(temp.pr, function(y)
            .z.BeggsBrill(pres.pr = x, temp.pr = y,
                                      tolerance = tolerance, verbose = verbose)))
    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        co <- matrix(co, nrow = length(temp.pr), ncol = length(pres.pr))
        rownames(co) <- temp.pr
        colnames(co) <- pres.pr
    }
    return(co)
}


.z.BeggsBrill <- function(pres.pr, temp.pr, tolerance = 1e-13, verbose = FALSE) {
    # Brill and Beggs compressibility factor (1973)

    A <- 1.39 *(temp.pr - 0.92)^0.5 - 0.36 * temp.pr - 0.101

    zF <-(0.3016 - 0.49 * temp.pr + 0.1824 * temp.pr^2)
    B <- (0.62 - 0.23 * temp.pr) * pres.pr +
        (0.066 / (temp.pr - 0.86) - 0.037) * pres.pr^2 +
        0.32 * pres.pr^6 / 10^(9 * (temp.pr - 1))
    C <- 0.132 - 0.32 * log10(temp.pr)
    D <- 10^(0.3106 - 0.49 * temp.pr + 0.1824 * temp.pr^2)

    z <- A + (1 - A) / exp(B) + C * pres.pr^D

    return(z)
}


# .z.BeggsBrill <- function(pres.pr, temp.pr, tolerance = 1e-13, verbose = FALSE) {
#     # Brill and Beggs compressibility factor (1973)
#
#     # pres.pc <- 678 - 50*(gas.sg - 0.5) - 206.7 * n2.frac + 440 * co2.frac +
#     #     606.7 * h2s.frac
#     # temp.pc <- 326+315.7 * (gas.sg - 0.5) - 240 * n2.frac - 83.3 * co2.frac +
#     #     133.3 * h2s.frac
#     # pres.pr <- pres.a / pres.pc
#
#     # worksheet has a bug in the Farenheit add formula in the book
#     # temp.pr <- (temp.f + 460) / temp.pc
#
#     A <- 1.39 *(temp.pr - 0.92)^0.5 - 0.36 * temp.pr - 0.101
#     E <- 9 * (temp.pr - 1)
#     F <- 0.3106 - 0.49 * temp.pr + 0.1824 * temp.pr^2
#     B <- (0.62 - 0.23 * temp.pr) * pres.pr +
#         (0.066 / (temp.pr - 0.86) - 0.037) * pres.pr^2 +
#         0.32 * pres.pr^2 / 10^E
#     C <- 0.132 - 0.32 * log10(temp.pr)
#     # D <- 10^(0.3106 - 0.49 * temp.pr+0.1824*temp.pr^2)
#     D <- 10^F
#
#     z <- A + (1 - A) / exp(B) + C * pres.pr^D
#
#     return(z)
# }