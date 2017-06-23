
#' split a long string to create a vector for testing
#'
#' @param str a contnuous long string to split as a vector
#' @export
convertStringToVector <- function(str) {
    vs <- unlist(strsplit(str, " "))
    vn <- as.numeric(vs)
    paste(vn, collapse = ", ")

}


matrixToDataframe <- function(mat) {
    # convert a Ppr/Tpr matrix do a dataframe
    mat <- cbind(as.double(rownames(mat)), mat)  # new column for Tpr
    rownames(mat) <- NULL           # reset row names
    df <- as.data.frame(mat)     # dataframe
    names(df)[1] <- "Tpr"
    df
}

matrixWithCorrelation <- function(ppr_vector, tpr_vector, corr.Function) {
    # create a matrix using a z-factor correlation function and sapply
    corr_matrix <- sapply(ppr_vector, function(x)
        sapply(tpr_vector, function(y) corr.Function(pres.pr = x, temp.pr = y)))

    rownames(corr_matrix) <- tpr_vector
    colnames(corr_matrix) <- ppr_vector
    corr_matrix
}

combineCorrWithSK <- function(sk_df, co_df) {
    # combine correlation tidy DF with Standing-Katz tidy DF
    sk_tidy <- tidyr::gather(sk_df, "ppr", "z.chart", 2:ncol(sk_df))
    co_tidy <- tidyr::gather(co_df, "ppr", "z.calcs", 2:ncol(co_df))

    sk_co_tidy <- cbind(sk_tidy, z.calc = co_tidy$z.calcs)
    sk_co_tidy$dif <- sk_co_tidy$z.chart  - sk_co_tidy$z.calc
    colnames(sk_co_tidy)[1:2] <- c("Tpr", "Ppr")
    sk_co_tidy
}


#' Create a tidy table from Ppr and Tpr vectors
#'
#' @param ppr_vector a pseudo-reduced pressure vector
#' @param tpr_vector a pseudo-reduced temperature vector
#' @param correlation a z-factor correlation
#' @export
createTidyFromMatrix <- function(ppr_vector, tpr_vector, correlation) {
    if (correlation == "HY")  zFunction <- z.HallYarborough
    if (correlation == "DAK") zFunction <- z.DranchukAbuKassem
    if (correlation == "DPR") zFunction <- z.DranchukPurvisRobinson

    sk_matrix <- getStandingKatzMatrix(ppr_vector, tpr_vector,
                                       pprRange = "lp")
    co_matrix <- matrixWithCorrelation(ppr_vector, tpr_vector,
                                       corr.Function = zFunction)

    sk_df <- matrixToDataframe(sk_matrix)
    co_df <- matrixToDataframe(co_matrix)

    sk_co_tidy <- combineCorrWithSK(sk_df, co_df)
    sk_co_tidy
}