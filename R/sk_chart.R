

# add modification "assign(.tpr, tpr)" to store modified dataframe
# add parameter "tolerance" to allow flexibility in deciding point closeness
getZcurve2 <- function(dfile, tolerance = 0.01, save = TRUE) {
    # Read digitized data from Standing-Katz chart, plot it
    # and put it in a .rda file
    # x: Ppr
    # y: z
    isNear <- function(n) abs(n - round(n, 1)) <= tolerance

    .tpr <- tools::file_path_sans_ext(dfile)
    data_file <- paste("../inst/extdata", dfile, sep = "/")
    assign(.tpr, read.table(data_file, header = TRUE))  # name same as file name
    tpr <- get(.tpr)               # get the object
    colnames(tpr)<- c("Ppr", "z")
    tpr <- tpr[order(tpr$Ppr),]            # sort Ppr
    tpr$isNear <- isNear(tpr$Ppr)# round to nearest Ppr
    tpr$Ppr_near <- ifelse(tpr$isNear, round(tpr$Ppr/.1)*.1, tpr$Ppr)
    tpr$diff <- tpr$Ppr - tpr$Ppr_near     # find the difference to nearest
    assign(.tpr, tpr)
    if (save) {
        rda_file <- paste(tools::file_path_sans_ext(dfile), "rda", sep = ".")
        rda_file <- paste("../data", rda_file, sep = "/")
        save(list = .tpr, file = rda_file)     # save with same name as string
    }
    plot(x = tpr$Ppr, y = tpr$z)                      # as rad from SK chart
    lines(x = tpr$Ppr_near, y = tpr$z, col = "blue")  # nearest rounded points
}