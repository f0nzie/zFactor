#' Hall-Yarborough correlation
#'
#' @rdname Hall-Yarborough
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @param tolerance controls the iteration accuracy
#' @param verbose print internal
z.HallYarborough <- function(pres.pr, temp.pr, tolerance = 1E-13,
                             verbose = FALSE) {
    # Hall-Yarborough correlation modified to use the Newton-Raphson method


    f <- function(y) {
        - A * pres.pr + (y + y^2 + y^3 - y^4) / (1 - y)^3  - B * y^2 + C * y^D
    }

    fdot <- function(y) {
        (1 + 4 * y + 4 * y^2 - 4 * y^3 + y^4 ) / (1 - y)^4 - 2 * B * y + C * D * y^(D-1)
    }

    t <- 1 / temp.pr
    A <- 0.06125 * t * exp(-1.2 * (1 - t)^2)
    B <- t * (14.76 - 9.76 * t + 4.58 * t^2)
    C <- t * (90.7 - 242.2 * t + 42.4 * t^2)
    D <- 2.18 + 2.82 * t

    # first guess for y
    yk <- 0.0125 * pres.pr * t * exp(-1.2 * (1 - t)^2)
    delta <- 1
    i <- 1    # itertations
    while (delta >= tolerance) {
        fyk <- f(yk)
        if (abs(fyk) < tolerance) break
        yk1 <- yk - f(yk) / fdot(yk)
        delta <- abs(yk - yk1)
        if (verbose) cat(sprintf("%3d %10f %10f %10f \n", i, delta, yk, fyk))
        yk <- yk1
        i <- i + 1
    }
    if (verbose) cat("\n")
    y <- yk
    z <- A * pres.pr / y
    if (verbose) print(z)
    return(z)
}