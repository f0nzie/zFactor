
#' split a long string to create a vector for testing
#'
#' @param str a contnuous long string to split as a vector
#' @export
#' @examples
#' convertStringToVector("1.05 1.10 1.20")
#' # result: "c(1.05, 1.1, 1.2)"
#' # now, you can paste the vector in your test
convertStringToVector <- function(str) {
    vs <- unlist(strsplit(str, " "))
    vn <- as.numeric(vs)
    vt <- paste(vn, collapse = ", ")
    paste0('c(', vt, ')')
}


matrixToDataframe <- function(mat) {
    # convert a Ppr/Tpr matrix do a dataframe
    mat <- cbind(as.double(rownames(mat)), mat)  # new column for Tpr
    rownames(mat) <- NULL           # reset row names
    df <- as.data.frame(mat)        # dataframe
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
    sk_co_tidy$Tpr <- as.character(sk_co_tidy$Tpr)
    sk_co_tidy$Ppr <- as.numeric(sk_co_tidy$Ppr)
    sk_co_tidy
}


#' Create a tidy table from Ppr and Tpr vectors
#'
#' @param ppr_vector a pseudo-reduced pressure vector
#' @param tpr_vector a pseudo-reduced temperature vector
#' @param correlation a z-factor correlation
#' @export
#' @examples
#' ppr <- c(0.5, 1.5, 2.5, 3.5)
#' tpr <- c(1.05, 1.1, 1.2)
#' createTidyFromMatrix(ppr, tpr, correlation = "DAK")
createTidyFromMatrix <- function(ppr_vector, tpr_vector, correlation) {
    valid_choices <- c("BB", "HY", "DAK", "DPR", "SH", "N10")
    msg_missing <- "You have to provide a z-factor correlation: 'BB' or
    'HY' or 'DAK' or 'DPR'."
    if (missing(correlation)) stop(msg_missing)
    if (!correlation %in% valid_choices) stop("Not a valid correlation.")

    if (correlation == "BB")  zFunction <- z.BeggsBrill
    if (correlation == "HY")  zFunction <- z.HallYarborough
    if (correlation == "DAK") zFunction <- z.DranchukAbuKassem
    if (correlation == "DPR") zFunction <- z.DranchukPurvisRobinson
    if (correlation == "SH")  zFunction <- z.Shell
    if (correlation == "N10") zFunction <- z.Ann10

    sk_matrix <- getStandingKatzMatrix(ppr_vector, tpr_vector,
                                       pprRange = "lp")
    co_matrix <- matrixWithCorrelation(ppr_vector, tpr_vector,
                                       corr.Function = zFunction)

    sk_df <- matrixToDataframe(sk_matrix)
    co_df <- matrixToDataframe(co_matrix)

    sk_co_tidy <- combineCorrWithSK(sk_df, co_df)
    sk_co_tidy
}


#' Plot multiple Tpr curves in one figure
#'
#' @param tpr Pseudo-reduced temperature curve in SK chart
#' @param pprRange Takes one of two values: "lp": low pressure, or "hp" for
#' @param ... additional parameters
#' @importFrom ggplot2 ggplot aes geom_line geom_point
#' @export
multiplotStandingKatz <- function(tpr, pprRange = "lp", ...) {
    Ppr <- NULL; z <- NULL; Tpr <- NULL
    tpr_li <- getStandingKatzData(tpr, pprRange = pprRange)

    # join the dataframes with rbindlist adding an identifier column
    tpr_df <- data.table::rbindlist(tpr_li, idcol = TRUE)
    colnames(tpr_df)[1] <- "Tpr"    # name the identifier as Tpr

    g <- ggplot(tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) +
        geom_line() +
        geom_point()
    print(g)
}