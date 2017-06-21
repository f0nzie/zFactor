
#' split a long string to create a vector for testing
#'
#' @param str a contnuous long string to split as a vector
#' @export
convertStringToVector <- function(str) {
    vs <- unlist(strsplit(str, " "))
    vn <- as.numeric(vs)
    paste(vn, collapse = ", ")

}