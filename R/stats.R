#' @importFrom dplyr group_by summarise
z.stats <- function(correlation = "DAK", pprRange = "lp") {
    Ppr <- NULL; Tpr <- NULL; z.calc <- NULL; z.chart <- NULL; n <- NULL
    # get all `lp` Tpr curves
    tpr_all <- getStandingKatzTpr(pprRange)
    # ppr <- c(0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0)
    ppr <- getStandingKatzPpr(interval = "fine")
    sk_corr_all <- createTidyFromMatrix(ppr, tpr_all, correlation)

    grouped <- group_by(sk_corr_all, Tpr, Ppr)
    smry_tpr_ppr <- summarise(grouped,
                              RMSE= sqrt(mean((z.chart-z.calc)^2)),
                              MPE = sum((z.calc - z.chart) / z.chart) * 100 / n(),
                              MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n(),
                              MSE = sum((z.calc - z.chart)^2) / n(),
                              RSS = sum((z.calc - z.chart)^2),
                              MAE = sum(abs(z.calc - z.chart)) / n(),
                              RMLSE = sqrt(1/n()*sum((log(z.calc +1)-log(z.chart +1))^2))
    )
    smry_tpr_ppr
}

#' @import ggplot2
z.plot.range <- function(correlation = "DAK", pprRange = "lp") {
    Ppr <- NULL; Tpr <- NULL; MAPE <- NULL; z.calc <- NULL; z.chart <- NULL
    smry_tpr_ppr <- z.stats(correlation, pprRange)
    g <- ggplot(smry_tpr_ppr, aes(Ppr, Tpr))
    g <- g + geom_tile(data=smry_tpr_ppr, aes(fill=MAPE), color="white") +
        scale_fill_gradient2(low="blue", high="red", mid="yellow", na.value = "pink",
                             midpoint=12.5, limit=c(0, 25), name="MAPE") +
        theme(axis.text.x = element_text(angle=45, vjust=1, size=11, hjust=1)) +
        coord_equal() +
        ggtitle("Hall-Yarborough", subtitle = "HY")
    print(g)
}
