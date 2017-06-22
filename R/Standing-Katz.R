
#' Read file with readings from Standing-Katz chart, create data file and plot
#'
#' Read a .txt file that was created from readings of the Standing-Katz chart,
#' then convert it to a .rda file and plot the curve for given Tpr
#' @param tpr Pseudo-reduced temperature curve in SK chart
#' @param pprRange Takes one of two values: "lp": low pressure, or "hp" for
#' high pressure
#' @param tolerance rounding tolerance to avoid rounding readings that are in
#' the middle of the grid. "tolerance" adds flexibility in deciding point closeness.
#' @param toSave set to FALSE to indicate if the .rda file will not be saved to disk
#' @param toPlot set to FALSE to indicate the dataset will not be plotted
#' @param toView set to FALSE to prevent visualizing the dataframe
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
    # if (!tpr %in% c(1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.7, 2.0, 2.2, 2.4, 2.6, 3.0))
    if (!tpr %in% getCurvesDigitized(pprRange = "all"))
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


#' Read file with readings from Standing-Katz chart. Get only the data
#'
#' Read a .txt file that was created from readings of the Standing-Katz chart
#' and retrieve the points
#' @param tpr Pseudo-reduced temperature curve in SK chart
#' @param pprRange Takes one of two values: "lp": low pressure, or "hp" for
#' high pressure
#' @export
getStandingKatzData <- function(tpr = 1.3, pprRange = "lp") {
    getStandingKatzCurve(tpr = tpr, pprRange = pprRange,
                         toView = FALSE, toSave = FALSE, toPlot = FALSE)

}


#' List all Standing-Katz curves available at Low and High pressures
#'
#' @param pprRange Takes one of three values: "lp": low pressure, or "hp" for
#' high pressure, or 'all' for all the curve files
#' @export
listStandingKatzCurves <- function(pprRange = "lp") {
    range_valid <- c("lp", "hp", "all")
    # stop if it is not 'lp' or 'hp' or 'all'
    if (!pprRange %in% range_valid)
        stop("Ppr range unknown. It can be 'lp' or 'hp' or 'all'")

    extdata <- system.file("extdata", package = "zFactor")  # files are in extdata
    if (pprRange == "lp") pat  <- "sk_[l]p_tpr_[1,2,3][0-7][0,5].*\\.txt"
    if (pprRange == "hp") pat  <- "sk_[h]p_tpr_[1,2,3][0-7][0,5].*\\.txt"
    if (pprRange == "all") pat <- "sk_[lh]p_tpr_[1,2,3][0-7][0,5].*\\.txt"

    list.files(path = extdata, pattern = pat)
}


#' Generate a matrix of Standing-Katz pseudo-reduced pressure and tenperarture
#'
#' @param ppr_vector a vector of pseudo-reduced pressure
#' @param tpr_vector a vector of pseudo-reduced temperatures
#' @param pprRange Takes one of two values: "lp": low pressure, or "hp" for
#' high pressure
#' @export
getStandingKatzMatrix <- function(ppr_vector, tpr_vector, pprRange = "lp") {
    # create a `z` table (matrix) for a set of Tpr and Ppr
    range_valid <- c("lp", "hp")
    if (!pprRange %in% range_valid)
        stop("Ppr range keyword not valid")
    if (!all(tpr_vector %in% getCurvesDigitized(pprRange)))
        stop("One of the Tpr curves is not available")
    # if (missing(ppr_vector) || missing(tpr_vector))
    #     stop("You must supply vectors for PPr and Tpr")
    # if (length(ppr_vector) == 0 || length(tpr_vector) == 0) {
    #     stop("Ppr or Tpr vectors must have at least one element")}

    # get a list of dataframes at all given Tpr
    res_li <- lapply(tpr_vector, getStandingKatzData, pprRange)
    tpr_vec_str <- format(round(tpr_vector, 2), nsmall = 2)   # all Tpr with 2 decimals
    # add Tpr names to the dataframes in the list
    names(res_li) <- tpr_vec_str

    # initialize matrix with `Tpr` rows and 0 columns
    tbl_mx <- matrix(nrow = length(tpr_vector), ncol = 0)

    if (missing(ppr_vector)) {
        tbl <- data.frame()
        z_vec <- vector("numeric")     # initialize `z` vector
        for (tpr_str in tpr_vec_str) {   # iterate through Tpr string vector
            df <- res_li[[tpr_str]]      # extract a dataframe from the Tpr list
            cols2 <- df[c("z", "Ppr_near")]
            cols2$Tpr <- tpr_str
            tbl <- rbind(tbl, cols2) # add the Ppr column-vector to the matrix
        }
        sp <- tidyr::spread(tbl, key = "Tpr", value = z)
        am <- as.matrix(sp)
        rownames(am) <- am[, "Ppr_near"]
        am <- am[, c(2:ncol(am))]
        t(am)
    } else {
        for (ppr in ppr_vector) {          # iterate through Ppr numeric vector
            z_vec <- vector("numeric")     # initialize `z` vector
            for (tpr_str in tpr_vec_str) {   # iterate through Tpr string vector
                df <- res_li[[tpr_str]]      # extract a dataframe from the Tpr list
                z <- df[which(df["Ppr_near"] == ppr), "z"] # get `z` value for the Ppr
                z_vec <- c(z_vec, z)     # add a new `z` row to the bottom of vector `z_vec`
                z_mx <- matrix(z_vec)    # convert the vector to a matrix
            }
            colnames(z_mx) <- ppr           # add the column name to the column-vector Ppr
            if (dim(z_mx) == c(0, 1)) stop("Ppr values may not be digitized at this Tpr")
            tbl_mx <- cbind(tbl_mx, z_mx) # add the Ppr column-vector to the matrix
        }
        rownames(tbl_mx) <- tpr_vec_str   # add Tpr names to the matrix
        tbl_mx
    }
}


# extract the curve number from a digitized file
extractCurveNumber <- function(str) {
    # numbers WITHOUT including the dot and comma
    ul <- unlist(regmatches(str, gregexpr('\\(?[0-9]+', str)))
    curv_num <- as.numeric(ul) / 100
    curv_num
}


#' Get a numeric vector of digitized curves available by Tpr
#'
#' @param pprRange Takes one of 4 values: "lp": low pressure, or "hp" for
#' high pressure; "all": all curves; "common": only curves that are common to hp
#' and lp
#' @export
getCurvesDigitized <- function(pprRange) {
    range_valid <- c("lp", "hp", "all", "common")
    if (!pprRange %in% range_valid) stop("Ppr range keyword not valid")

    if (pprRange == "common") {
        lp_digit <- listStandingKatzCurves(pprRange = "lp")
        hp_digit <- listStandingKatzCurves(pprRange = "hp")
        lp_vec <- sapply(lp_digit, extractCurveNumber)
        hp_vec <- sapply(hp_digit, extractCurveNumber)
        intersect(lp_vec, hp_vec)
    } else {
        curves_digitized <- listStandingKatzCurves(pprRange = pprRange)
        curves_vec <- sapply(curves_digitized, extractCurveNumber)
        names(curves_vec) <- NULL
        unique(curves_vec)   # only unique values if `all`. intersection of lp and hp
    }

}