

#' ANN correlation
#'
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @rdname ANN
#' @export
# #' @importFrom rJava .jnew .jcall .jinit .jaddClassPath .jclassPath
z.Ann10 <- function(pres.pr, temp.pr) {
    # jinit and add classpath here because it doesn't work from .onLoad
    jarFile <- paste(system.file(package = "zFactor"), "java", sep = "/")
    rJava::.jinit()
    rJava::.jaddClassPath(jarFile)
    # print(rJava::.jclassPath())
    zFactor <- rJava::.jnew("CalculateZFactor")

    mx <- sapply(pres.pr, function(x) sapply(temp.pr, function(y)
        rJava::.jcall(zFactor, "D", "ANN10", x, y)) )

    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        colnames(mx) <- pres.pr
        rownames(mx) <- temp.pr
        # mx
    }
    # else         # z.Ann10_1p(pres.pr, temp.pr)
    mx
}






