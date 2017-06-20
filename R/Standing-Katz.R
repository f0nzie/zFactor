
#' Read file with readings from Standing-Katz chart, create data file and plot
#'
#' Read a .txt file that was created from readings of the Standing-Katz chart,
#' then convert it to a .rda file and plot the curve for given Tpr
#' @param tpr Pseudo-reduced temperature curve in SK chart
#' @param pprRange Takes one of two values: "lp": low pressure, or "hp" for
#' high pressure
#' @param tolerance rounding tolerance to avoid rounding readings that are in
#' the middle of the grid. "tolerance" adds flexibility in deciding point closeness.
#' @param save flag to indicate if the .rda file will be saved to disk
#' @importFrom graphics lines plot mtext
#' @export
getStandingKatzCurve <- function(tpr = 1.3, pprRange = "lp", tolerance = 0.01,
                                 toView = TRUE, toSave = TRUE, toPlot = TRUE) {
    # Read digitized data from Standing-Katz chart, plot it
    # and put it in a .rda file
    # x: Ppr
    # y: z
    isNear <- function(n) abs(n - round(n, 1)) <= tolerance

    # stop if Tpr curve has not been recorded
    if (!tpr %in% c(1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.7, 2.0, 2.2, 2.4, 2.6, 3.0))
        stop(sprintf("Curve not available at Tpr =%5.2f", tpr))

    # stop if it is not lp or hp PPr
    if (!pprRange %in% c("lp", "hp"))
        stop("Range unknown. It can be 'lp' or 'hp'")

    extdata <- system.file("extdata", package = "zFactor")  # files are in extdata
    this_tpr <- tpr
    tpr_str <- format(round(tpr*100, 2), nsmall = 0)    # two decimals as string
    dfile <- paste(paste("sk", pprRange, "tpr", tpr_str, sep = "_"),
                   "txt", sep = ".")

    ds_name <- tools::file_path_sans_ext(dfile)
    ds_file <- paste(ds_name, "rda", sep = ".")

    .tpr <- tools::file_path_sans_ext(dfile)            # remove the extension

    # stop if no file is found
    data_file <- paste(extdata, dfile, sep = "/")
    if (!file.exists(data_file)) stop(sprintf("File %s does not exist", data_file))

    # add modification "assign(.tpr, tpr)" to store modified dataframe
    assign(.tpr, utils::read.table(data_file, header = TRUE))  # name same as file name
    tpr <- get(.tpr)               # get the object
    colnames(tpr)<- c("Ppr", "z")
    tpr <- tpr[order(tpr$Ppr),]            # sort Ppr
    tpr$isNear <- isNear(tpr$Ppr)          # round to nearest Ppr
    tpr$Ppr_near <- ifelse(tpr$isNear, round(tpr$Ppr/.1)*.1, tpr$Ppr)
    tpr$diff <- tpr$Ppr - tpr$Ppr_near     # find the difference to nearest
    assign(.tpr, tpr)

    if (toSave) {
        save(list = .tpr, file = ds_file)     # save with same name as input
    }
    # # as read from SK chart
    if (toPlot) {
        title <- paste0("Tpr = ", as.character(this_tpr))
        plot(x = tpr$Ppr, y = tpr$z,
             main = title, xlab = "Ppr", ylab = "z")
        lines(x = tpr$Ppr_near, y = tpr$z, col = "blue")  # nearest rounded points
        mtext("z vs Ppr from Standing-Katz chart")        # subtitle
    }
    # assign(ds_name, get(load(ds_file)), envir = .GlobalEnv)
    # ds_obj <- get(ds_name)
    # View(ds_obj, title = ds_name)
    # invisible(ds_obj)
    if (toView) utils::View(tpr, title = .tpr)
    invisible(tpr)
}



#' List all Standing-Katz curves available at Low and High pressures
#'
#' @param pprRange Takes one of three values: "lp": low pressure, or "hp" for
#' high pressure, or 'all' for all the curve files
#' @export
listStandingKatzCurves <- function(pprRange = "lp") {
    # stop if it is not 'lp' or 'hp' or 'all'
    if (!pprRange %in% c("lp", "hp", "all"))
        stop("Ppr range unknown. It can be 'lp' or 'hp' or 'all'")

    extdata <- system.file("extdata", package = "zFactor")  # files are in extdata
    if (pprRange == "lp") pat  <- "sk_[l]p_tpr_[1,2,3][0-7][0,5].*\\.txt"
    if (pprRange == "hp") pat  <- "sk_[h]p_tpr_[1,2,3][0-7][0,5].*\\.txt"
    if (pprRange == "all") pat <- "sk_[lh]p_tpr_[1,2,3][0-7][0,5].*\\.txt"

    list.files(path = extdata, pattern = pat)
}