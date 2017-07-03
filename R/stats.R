#' Get error summary statistics for any given compressibility correlation
#'
#' A quick way to show an error summary between any of the indicated correlations and
#' the Standing-Katz chart
#' @param correlation identifier. Can be "HY", "DAK", "DPR" "N10", "SH"
#' @param pprRange low (lp) or high (hp) chart area of the Standing-Katz chart
#' @param interval quality of the Ppr scale. Coarse: every 1.0; Fine: every 0.5
#' @importFrom dplyr group_by summarise
#' @rdname z.stats
#' @export
#' @examples
#' # error statistics for the Dranchuk-AbouKassem correlation
#' z.stats("DAK")
#'
#' # error statistics for Hall-Yarborough correlation at steps of 0.5 in Ppr
#' z.stats("HY", interval = "fine")
z.stats <- function(correlation = "DAK", pprRange = "lp", interval = "coarse") {
    Ppr <- NULL; Tpr <- NULL; z.calc <- NULL; z.chart <- NULL; n <- NULL
    # get all `lp` Tpr curves
    tpr_all <- getStandingKatzTpr(pprRange)
    # ppr <- c(0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0)
    ppr <- getStandingKatzPpr(interval)
    sk_corr_all <- createTidyFromMatrix(ppr, tpr_all, correlation)

    grouped <- group_by(sk_corr_all, Tpr, Ppr)
    smry_tpr_ppr <- summarise(grouped,
                              RMSE= sqrt(mean((z.chart-z.calc)^2)),
                              MPE = sum((z.calc - z.chart) / z.chart) * 100 / n(),
                              MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n(),
                              MSE = sum((z.calc - z.chart)^2) / n(),
                              RSS = sum((z.calc - z.chart)^2),
                              MAE = sum(abs(z.calc - z.chart)) / n()
    )
    smry_tpr_ppr
}


#' Tile plot of best fit area for indicated correlation
#'
#' Plot will show blue areas with the lowest errors and redish with very high error
#' or close to MAPE=25. Pink is much greater than 25.
#' @param correlation identifier. Can be "HY", "DAK", "DPR" "N10", "SH"
#' @param pprRange low (lp) or high (hp) chart area of the Standing-Katz chart
#' @param ... any other parameter
#' @import ggplot2
#' @export
#' @examples
#' # plot Dranchuk-AbouKassem
#' z.plot.range("DAK")
#'
#' # plot Beggs-Brill correlation with fine grid on Ppr
#' z.plot.range("BB", interval = "fine")
z.plot.range <- function(correlation = "DAK", pprRange = "lp", ...) {
    Ppr <- NULL; Tpr <- NULL; MAPE <- NULL; z.calc <- NULL; z.chart <- NULL
    isMissing_correlation(correlation)
    if (!isValid_correlation(correlation)) stop("Not a valid correlation.")

    corr_name <- z_correlations[which(z_correlations["short"] == correlation),
                                                     "long"]

    smry_tpr_ppr <- z.stats(correlation, pprRange, ...)
    g <- ggplot(smry_tpr_ppr, aes(Ppr, Tpr))
    g <- g + geom_tile(data=smry_tpr_ppr, aes(fill=MAPE), color="white") +
        scale_fill_gradient2(low="blue", high="red", mid="yellow", na.value = "pink",
                             midpoint=12.5, limit=c(0, 25), name="MAPE") +
        theme(axis.text.x = element_text(angle=45, vjust=1, size=11, hjust=1)) +
        coord_equal() +
        ggtitle(corr_name, subtitle = correlation)
    print(g)
}
