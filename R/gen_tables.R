
#' Generate a dataset of z values read from Standing-Kats chart
#'
#' @export
SK.genDataset7p4t <- function(to_disk = FALSE) {
    # create table from values read from SK chart
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    # few data points from Standing-Katz chart
    z <- c(
        c(0.92, 0.76, 0.64, 0.63, 0.68, 0.76, 0.84),
        c(0.94, 0.86, 0.79, 0.77, 0.79, 0.84, 0.89),
        c(0.97, 0.92, 0.87, 0.86, 0.865, 0.895, 0.94),
        c(0.985, 0.957, 0.941, 0.938, 0.945, 0.97, 1.01)
    )

    # create a matrix of SK chart points
    sk_short <- matrix(z, nrow = 4, ncol = 7, byrow = TRUE)
    rownames(sk_short) <- tpr
    colnames(sk_short) <- ppr

    # 7 pressure and 4 temperatures
    if (to_disk) save(sk_short, file = "./data/z_sk_chart_7p4t.rda")
    invisible(sk_short)
}


#' Generate a dataset of z values read from Standing-Kats chart
#'
#' @export
HY.genDataset7p4t <- function(to_disk = FALSE) {
    # create table from values read from SK chart
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    hy_short <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.HallYarborough(pres.pr = x, temp.pr = y)))

    rownames(hy_short) <- tpr
    colnames(hy_short) <- ppr


    # 7 pressure and 4 temperatures
    if (to_disk) save(hy_short, file = "./data/z_hy_7p4t.rda")
    invisible(hy_short)
}



#' Generate a dataset of z values calculated by DAK
#'
#' @export
DAK.genDataset7p4t <- function(to_disk = FALSE) {
    # create table from values read from SK chart
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    dak_short <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.DranchukAbuKassem(pres.pr = x, temp.pr = y)))

    rownames(dak_short) <- tpr
    colnames(dak_short) <- ppr

    # 7 pressure and 4 temperatures
    if (to_disk) save(dak_short, file = "./data/z_dak_7p4t.rda")
    invisible(dak_short)
}



#' Generate a dataset of z values calculated by DPR
#'
#' @export
DPR.genDataset7p4t <- function(to_disk = FALSE) {
    # create table from values read from SK chart
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    dpr_short <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.DranchukPurvisRobinson(pres.pr = x, temp.pr = y)))

    rownames(dpr_short) <- tpr
    colnames(dpr_short) <- ppr

    # 7 pressure and 4 temperatures
    if (to_disk) save(dpr_short, file = "./data/z_dpvr_7p4t.rda")
    invisible(dpr_short)
}



HY.genDatasetDif <- function(to_disk = FALSE) {
    # convert to tidy table for z values calculated by HY and read from SK chart
    # library(tidyr)

    # load both tables (matrices)
    # load(file = "./data/z_sk_chart_7p4t.rda")
    load(file = "./data/z_hy_7p4t.rda")

    # create tidy data for z from SK chart
    sk_short <- cbind(as.double(rownames(sk_short)), sk_short)  # new column for Tpr
    rownames(sk_short) <- NULL           # reset row names
    # colnames(sk_short)[1] <- "Tpr"       # add column name
    .z_chart <- as.data.frame(sk_short)  # dataframe

    hy_short <- cbind(as.double(rownames(hy_short)), hy_short)
    rownames(hy_short) <- NULL
    # colnames(hy_short)[1] <- "Tpr"
    .z_calcs <- as.data.frame(hy_short)

    z_chart <- tidyr::gather(.z_chart, "ppr", "z.chart", 2:8)
    z_calcs <- tidyr::gather(.z_calcs, "ppr", "z.calcs", 2:8)

    hy_dif <- cbind(z_chart, z.calc = z_calcs$z.calcs)
    hy_dif$dif <- hy_dif$z.chart  - hy_dif$z.calc

    colnames(hy_dif)[1:2] <- c("Tpr", "Ppr")

    if (to_disk) save(hy_dif, file = "./data/hy_dif.rda")
    invisible(hy_dif)

}

genDatasetDif <- function(correlation = "HY") {
    # generic function
    # convert to tidy table for z values calculated by HY and read from SK chart
    pkg_data_path <- system.file("data", package = "zFactor")

    corr <- tolower(correlation)
    rda_name <- paste(paste("z", corr, "7p4t", sep = "_"), "rda", sep = ".")
    # ds_name <- paste(pkg_data_path, rda_name, sep = "/")
    corr_rda_file <- paste(pkg_data_path, rda_name, sep = "/")

    # load both tables (matrices)
    load(file = "./data/z_sk_chart_7p4t.rda")
    load(file = corr_rda_file)

    # create tidy data for z from SK chart
    sk_short <- cbind(as.double(rownames(sk_short)), sk_short)  # new column for Tpr
    rownames(sk_short) <- NULL           # reset row names
    .z_chart <- as.data.frame(sk_short)  # dataframe

    hy_short <- cbind(as.double(rownames(hy_short)), hy_short)
    rownames(hy_short) <- NULL
    .z_calcs <- as.data.frame(hy_short)

    z_chart <- tidyr::gather(.z_chart, "ppr", "z.chart", 2:8)
    z_calcs <- tidyr::gather(.z_calcs, "ppr", "z.calcs", 2:8)

    hy_dif <- cbind(z_chart, z.calc = z_calcs$z.calcs)
    hy_dif$dif <- hy_dif$z.chart  - hy_dif$z.calc

    colnames(hy_dif)[1:2] <- c("Tpr", "Ppr")

    dif_name <- paste(paste(corr, "dif", sep = "_"), "rda", sep = ".")
    dif_file <- paste(pkg_data_path, dif_name, sep = "/")
    save(hy_dif, file = dif_file)

}