## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center', results = "hold")

## ------------------------------------------------------------------------
library(zFactor)
sk <- getStandingKatzCurve()

## ------------------------------------------------------------------------
library(zFactor)
getStandingKatzCurve(tpr = 1.05, toSave = FALSE, toView = FALSE)

## ------------------------------------------------------------------------
library(zFactor)
tpr_vec <- c(1.05, 1.1)
result <- getStandingKatzCurve(tpr = tpr_vec, toSave = FALSE, toView = FALSE)

## ------------------------------------------------------------------------
class(result)      # class of the object `result` is a list of dataframes
names(result)      # name of each dataframe within the list

## ------------------------------------------------------------------------
library(tibble)
as.tibble(result[["1.05"]])

## ------------------------------------------------------------------------
as_tibble(result[["1.1"]])

## ------------------------------------------------------------------------
# view all the `Tpr` SK individual charts
tpr_vec <- getStandingKatzTpr(pprRange = "lp")
result <- getStandingKatzCurve(tpr_vec, toSave = FALSE,  toView = FALSE)

## ------------------------------------------------------------------------
getStandingKatzCurve(tpr = 1.7, toSave = FALSE, toView = FALSE, 
                     ylim = c(0.8, 1.1))

## ------------------------------------------------------------------------
names(result)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.05, 1.3, 1.5)
all_tpr2 <- getStandingKatzData(tpr_vec)

names(all_tpr2)

## ------------------------------------------------------------------------
library(tibble)
as.tibble(all_tpr2[["1.5"]])

## ------------------------------------------------------------------------
library(data.table)
library(ggplot2)

# join the dataframes with rbindlist adding an identifier column
all_tpr_df <- data.table::rbindlist(all_tpr2, idcol = TRUE)
colnames(all_tpr_df)[1] <- "Tpr"    # name the identifier as Tpr

ggplot(all_tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

## ------------------------------------------------------------------------
tpr_vec <- c(1.05, 1.3, 1.5)
multiplotStandingKatz(tpr_vec)

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
tpr_vec <- getStandingKatzTpr(pprRange = "lp")
multiplotStandingKatz(tpr_vec)

## ------------------------------------------------------------------------
library(zFactor)
library(ggplot2)
library(data.table)

low_tpr_vec <- c(1.05, 1.1, 1.2, 1.3, 1.4)
low_tpr_li <- (lapply(low_tpr_vec, function(x) getStandingKatzData(tpr = x)))
names(low_tpr_li) <- low_tpr_vec

low_tpr_df <- data.table::rbindlist(low_tpr_li, idcol = TRUE)
colnames(low_tpr_df)[1] <- "Tpr"

ggplot(low_tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

## ------------------------------------------------------------------------
low_tpr_vec <- c(1.05, 1.1, 1.2, 1.3, 1.4)
multiplotStandingKatz(low_tpr_vec)

## ------------------------------------------------------------------------
library(zFactor)
library(ggplot2)
library(data.table)

med_tpr_vec <- c(1.5, 1.6, 1.7, 1.8, 1.9)
med_tpr_li <- (lapply(med_tpr_vec, function(x) getStandingKatzData(tpr = x)))
names(med_tpr_li) <- med_tpr_vec

med_tpr_df <- data.table::rbindlist(med_tpr_li, idcol = TRUE)
colnames(med_tpr_df)[1] <- "Tpr"

ggplot(med_tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

## ------------------------------------------------------------------------
med_tpr_vec <- c(1.5, 1.6, 1.7, 1.8, 1.9)
multiplotStandingKatz(low_tpr_vec)

## ------------------------------------------------------------------------
library(zFactor)
library(ggplot2)
library(data.table)

hi_tpr_vec <- c(2.0, 2.4, 2.6, 2.8, 3.0)
hi_tpr_li <- (lapply(hi_tpr_vec, function(x) getStandingKatzData(tpr = x)))
names(hi_tpr_li) <- hi_tpr_vec

hi_tpr_df <- data.table::rbindlist(hi_tpr_li, idcol = TRUE)
colnames(hi_tpr_df)[1] <- "Tpr"

ggplot(hi_tpr_df, aes(x=Ppr, y=z, group=Tpr, color=Tpr)) + 
    geom_line() +
    geom_point()

## ------------------------------------------------------------------------
hi_tpr_vec <- c(2.0, 2.4, 2.6, 2.8, 3.0)
multiplotStandingKatz(hi_tpr_vec)

## ------------------------------------------------------------------------
library(tibble)
as.tibble(hi_tpr_df)

## ------------------------------------------------------------------------
summary(hi_tpr_df)

