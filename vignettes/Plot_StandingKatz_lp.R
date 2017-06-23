## ------------------------------------------------------------------------
library(zFactor)

getStandingKatzCurve(tpr = 1.05, toSave = FALSE, toView = FALSE)

## ------------------------------------------------------------------------
# view all the `Tpr` SK individual charts
tpr_vec <- getCurvesDigitized(pprRange = "lp")

invisible(sapply(tpr_vec, function(x) getStandingKatzCurve(tpr = x, 
                                                           toSave = FALSE, 
                                                           toView = FALSE)))

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.05, 1.3, 1.5)

all_tpr1 <- (lapply(tpr_vec, function(x) getStandingKatzCurve(tpr = x, 
                                                           toSave = FALSE, 
                                                           toView = FALSE,
                                                           toPlot = FALSE)))


## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.05, 1.3, 1.5)
all_tpr2 <- (lapply(tpr_vec, function(x) getStandingKatzData(tpr = x)))
names(all_tpr2) <- tpr_vec

## ------------------------------------------------------------------------
library(data.table)

all_tpr_df <- data.table::rbindlist(all_tpr2, idcol = TRUE)
colnames(all_tpr_df)[1] <- "Tpr"

## ------------------------------------------------------------------------
library(ggplot2)

ggplot(all_tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

## ------------------------------------------------------------------------
library(zFactor)
library(ggplot2)
library(data.table)

tpr_vec <- c(1.05, 1.1, 1.2, 1.3, 1.5, 1.6, 1.7, 1.9, 2.0, 2.4, 2.6, 2.8, 3.0)
all_tpr2 <- (lapply(tpr_vec, function(x) getStandingKatzData(tpr = x)))
names(all_tpr2) <- tpr_vec


all_tpr_df <- data.table::rbindlist(all_tpr2, idcol = TRUE)
colnames(all_tpr_df)[1] <- "Tpr"


ggplot(all_tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

## ------------------------------------------------------------------------
library(zFactor)
library(ggplot2)
library(data.table)

tpr_vec <- c(1.05, 1.1, 1.2, 1.3, 1.4)
all_tpr3 <- (lapply(tpr_vec, function(x) getStandingKatzData(tpr = x)))
names(all_tpr3) <- tpr_vec


all_tpr_df3 <- data.table::rbindlist(all_tpr3, idcol = TRUE)
colnames(all_tpr_df3)[1] <- "Tpr"


ggplot(all_tpr_df3, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

