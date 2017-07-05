## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center')

## ------------------------------------------------------------------------
library(zFactor)
listStandingKatzCurves(pprRange = 'all')

## ------------------------------------------------------------------------
library(zFactor)
listStandingKatzCurves(pprRange = 'hp')

## ------------------------------------------------------------------------
library(zFactor)
listStandingKatzCurves(pprRange = 'lp')

## ----fig.width=5, fig.height=5-------------------------------------------
library(zFactor)
getStandingKatzCurve(tpr = 1.3, toView = FALSE, toSave = FALSE)

## ----fig.width=5, fig.height=5-------------------------------------------
library(zFactor)

getStandingKatzCurve(tpr = 1.3, pprRange = 'hp', toView = FALSE, toSave = FALSE)

## ------------------------------------------------------------------------
getStandingKatzCurve(tpr = 1.3, pprRange = 'hp', ylim = c(0.75, 1.75))

## ----fig.width=5, fig.height=5-------------------------------------------
library(zFactor)
getStandingKatzCurve(tpr = 1.05, pprRange = "lp", toView = FALSE, toSave = FALSE)

## ---- echo=FALSE, results='asis'-----------------------------------------
library(zFactor)

ds <- getStandingKatzCurve(tpr = 1.3, pprRange = 'hp', 
                           toView = FALSE, toSave = FALSE, toPlot = FALSE)
knitr::kable(head(ds, 10))

## ------------------------------------------------------------------------
library(zFactor)
library(tibble)

tpr <- c(1.05, 1.3, 1.5)
tpr_li <- lapply(tpr, getStandingKatzData, pprRange = 'lp')
names(tpr_li) <- tpr
tibble(tpr_li)

## ------------------------------------------------------------------------
as.tibble(tpr_li[["1.05"]])
as.tibble(tpr_li[["1.3"]])
as.tibble(tpr_li[["1.5"]])

## ------------------------------------------------------------------------
# show the first 10 rows
head(tpr_li[["1.3"]], 10)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.4, 1.5, 1.6, 1.7, 1.8, 1.9)
ppr_vec <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)

getStandingKatzMatrix(ppr_vector = ppr_vec, tpr_vector = tpr_vec)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.05, 1.1, 1.2, 1.3)
ppr_vec <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
getStandingKatzMatrix(ppr_vector = ppr_vec, tpr_vector = tpr_vec)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(2.0, 2.2, 2.4, 2.6, 2.8, 3.0)
ppr_vec <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.0)
getStandingKatzMatrix(ppr_vector = ppr_vec, tpr_vector = tpr_vec)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.1, 1.2)
ppr_vec <- c(1, 2, 3, 4, 5, 6)
getStandingKatzMatrix(ppr_vector = ppr_vec, tpr_vector = tpr_vec, 
                      pprRange = "lp")

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.2)
ppr_vec <- c(8.3, 10)
getStandingKatzMatrix(ppr_vector = ppr_vec, tpr_vector = tpr_vec, 
                      pprRange = "hp")

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.2)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "hp")

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.2)
ppr_vec <- c(8.6, 10.3, 15)
getStandingKatzMatrix(ppr_vector = ppr_vec, tpr_vector = tpr_vec, 
                      pprRange = "hp")

## ------------------------------------------------------------------------
library(zFactor)

asked_tpr <- 1.5
asked_ppr <- 2.5

tpr_vec <- c(asked_tpr)
res_li <- lapply(tpr_vec, getStandingKatzData, pprRange = 'lp')
names(res_li) <- tpr_vec

asked_tpr_str <- as.character(asked_tpr)
df <- res_li[[asked_tpr_str]]
df[which(res_li[[asked_tpr_str]]["Ppr_near"] == asked_ppr), "z"]

## ------------------------------------------------------------------------
library(zFactor)
library(data.table)

tpr <- c(1.05, 1.1, 1.2)

tpr_li <- lapply(tpr, getStandingKatzData, pprRange = 'lp')
names(tpr_li) <- tpr

common <- rbindlist(tpr_li, idcol = TRUE)
common

## ------------------------------------------------------------------------
library(zFactor)
getStandingKatzTpr(pprRange = "all")

## ------------------------------------------------------------------------
library(zFactor)
getStandingKatzTpr(pprRange = "lp")

## ------------------------------------------------------------------------
library(zFactor)
getStandingKatzTpr(pprRange = "hp")

