## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center')

## ------------------------------------------------------------------------
# get a z value using HY
library(zFactor)

z.HallYarborough(pres.pr = 1.5, temp.pr = 2.0)

## ------------------------------------------------------------------------
# get a z value from the SK chart at the same Ppr and Tpr
library(zFactor)

tpr_vec <- c(2.0)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "lp")[1, "1.5"]

## ------------------------------------------------------------------------
library(zFactor)

z.HallYarborough(pres.pr = 1.5, temp.pr = 1.1)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.1)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "lp")[1, "1.5"]

## ------------------------------------------------------------------------
# test HY with 1st-derivative using the values from paper 
 
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.3, 1.5, 1.7, 2) 
 
hy <- sapply(ppr, function(x)  
    sapply(tpr, function(y) z.HallYarborough(pres.pr = x, temp.pr = y))) 
 
rownames(hy) <- tpr 
colnames(hy) <- ppr 
print(hy) 

## ------------------------------------------------------------------------
library(zFactor)

sk <- getStandingKatzMatrix(ppr_vector = ppr, tpr_vector = tpr)
sk

## ------------------------------------------------------------------------
err <- round((sk - hy) / sk * 100, 2)
err

## ------------------------------------------------------------------------
print(colSums(err))

## ------------------------------------------------------------------------
print(rowSums(err))

## ------------------------------------------------------------------------
library(zFactor)

tpr2 <- c(1.05, 1.1) 
ppr2 <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5) 


sk2 <- getStandingKatzMatrix(ppr_vector = ppr2, tpr_vector = tpr2, pprRange = "lp")
sk2

## ------------------------------------------------------------------------
# find what common values of PPr are available in the chart
getStandingKatzMatrix(tpr_vector = c(1.05))

## ------------------------------------------------------------------------
# calculate z values at lower values of Tpr
library(zFactor)

hy2 <- sapply(ppr2, function(x)  
    sapply(tpr2, function(y) z.HallYarborough(pres.pr = x, temp.pr = y))) 
 
rownames(hy2) <- tpr2
colnames(hy2) <- ppr2
print(hy2)

## ------------------------------------------------------------------------
err2 <- round((sk2 - hy2) / sk2 * 100, 2)
err2

## ------------------------------------------------------------------------
t_err2 <- t(err2)
t_err2

## ------------------------------------------------------------------------
sum_t_err2 <- summary(t_err2)
sum_t_err2

## ------------------------------------------------------------------------
library(zFactor)

tpr2 <- c(1.05, 1.1, 1.2, 1.3) 
ppr2 <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5) 

sk_hy_2 <- createTidyFromMatrix(ppr2, tpr2)
sk_hy_2

## ------------------------------------------------------------------------
# library(ggplot2)

p <- ggplot(sk_hy_2, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

