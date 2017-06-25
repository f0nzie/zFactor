
#' ANN correlation
#'
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @rdname ANN
#' @export
# #' @importFrom rJava .jnew .jcall .jinit .jaddClassPath .jclassPath
z.Ann10 <- function(pres.pr, temp.pr) {
    # # classFile <- paste(find.package("zFactor"), "./java/CalculateZFactor.class", sep="/");
    # classFile <- paste(system.file(package = "zFactor"), "java", sep = "/")
    # # start the Java Virtual Machine
    # rJava::.jinit()
    # # replace with the path to the folder containing your class
    # rJava::.jaddClassPath(classFile)
    # # show the Java class path
    # zFactor <- rJava::.jnew("CalculateZFactor")
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
    # classFile <- paste(find.package("zFactor"), "./java/CalculateZFactor.class", sep="/");
    classFile <- paste(system.file(package = "zFactor"), "java", sep = "/")
    # start the Java Virtual Machine
    rJava::.jinit()
    # replace with the path to the folder containing your class
    rJava::.jaddClassPath(classFile)
    # show the Java class path
    zFactor <- rJava::.jnew("CalculateZFactor")
    mx <-  rJava::.jcall(zFactor, "D", "ANN10", pres.pr, temp.pr)
    mx
}




