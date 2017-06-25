
#' ANN correlation
#'
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @rdname ANN
#' @export
# #' @importFrom rJava .jnew .jcall .jinit .jaddClassPath .jclassPath
z.Ann10 <- function(pres.pr, temp.pr) {
    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        mx <- sapply(pres.pr, function(x) sapply(temp.pr, function(y)
            z.Ann10_1p(x, y)) )
        colnames(mx) <- pres.pr
        rownames(mx) <- temp.pr
        mx
    } else {
        z.Ann10_1p(pres.pr, temp.pr)
    }
}


z.Ann10_1p <- function(pres.pr, temp.pr) {
    classFile <- paste(system.file(package = "zFactor"), "java", sep = "/")
    rJava::.jinit()    # start the Java Virtual Machine
    rJava::.jaddClassPath(classFile)  # path to folder containing Java class
    zFactor <- rJava::.jnew("CalculateZFactor")
    mx <-  rJava::.jcall(zFactor, "D", "ANN10", pres.pr, temp.pr)
    mx
}




