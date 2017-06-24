## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center', results="hold")

## ------------------------------------------------------------------------
# get a z value using DPR correlation
library(zFactor)

z.DranchukPurvisRobinson(pres.pr = 1.5, temp.pr = 2.0)
# HY = 0.9580002

## ------------------------------------------------------------------------
# get a z value from the SK chart at the same Ppr and Tpr
library(zFactor)

tpr_vec <- c(2.0)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "lp")[1, "1.5"]

## ------------------------------------------------------------------------
library(zFactor)

z.DranchukPurvisRobinson(pres.pr = 1.5, temp.pr = 1.1)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.1)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "lp")[1, "1.5"]

## ------------------------------------------------------------------------
# test HY with 1st-derivative using the values from paper 
 
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.3, 1.5, 1.7, 2) 
 
dpr <- z.DranchukPurvisRobinson(pres.pr = ppr, temp.pr = tpr)
print(dpr)

# Hall-Yarborough
#    0.5       1.5       2.5       3.5       4.5       5.5       6.5
# 1.3 0.9176300 0.7534433 0.6399020 0.6323003 0.6881127 0.7651710 0.8493794
# 1.5 0.9496855 0.8581232 0.7924067 0.7687902 0.7868071 0.8316848 0.8906351
# 1.7 0.9682547 0.9134862 0.8756412 0.8605668 0.8694525 0.8978885 0.9396353
# 2   0.9838234 0.9580002 0.9426939 0.9396286 0.9490995 0.9697839 0.9994317

## ------------------------------------------------------------------------
library(zFactor)

sk <- getStandingKatzMatrix(ppr_vector = ppr, tpr_vector = tpr)
print(sk)

## ------------------------------------------------------------------------
err <- round((sk - dpr) / sk * 100, 2)
err

# DAK
# 0.5   1.5  2.5   3.5   4.5   5.5   6.5
# 1.30 -0.47  0.22 0.03 -0.15 -0.85 -0.97 -0.71
# 1.50 -0.31 -0.04 0.13 -0.14  0.05  0.34  0.18
# 1.70 -0.01  0.13 0.07 -0.58 -0.94 -0.38  0.11
# 2.00 -0.05  0.09 0.10 -0.16 -0.50 -0.26  0.14

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
# calculate z values at lower values of Tpr
library(zFactor)

dpr2 <- z.DranchukPurvisRobinson(pres.pr = ppr2, temp.pr = tpr2)
print(dpr2)

## ------------------------------------------------------------------------
err2 <- round((sk2 - dpr2) / sk2 * 100, 2)
err2

# DAK
# 0.5    1.5    2.5   3.5   4.5   5.5
# 1.05 -0.13 -12.15 -12.78 -7.49 -4.34 -1.68
# 1.10 -0.36  -4.79  -4.97 -3.56 -2.14 -1.21

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

sk_dpr_2 <- createTidyFromMatrix(ppr2, tpr2, correlation = "DPR")
sk_dpr_2

## ------------------------------------------------------------------------
library(ggplot2)

p <- ggplot(sk_dpr_2, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
sk_dpr_3 <- sk_dpr_2[sk_dpr_2$Tpr==1.05,]
sk_dpr_3

## ------------------------------------------------------------------------

p <- ggplot(sk_dpr_3, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
summary(sk_dpr_3)

 # dif     DAK      
 # Min.   :-0.048404  
 # 1st Qu.:-0.035300  
 # Median :-0.025978  
 # Mean   :-0.023178  
 # 3rd Qu.:-0.009960  
 # Max.   : 0.002325

## ------------------------------------------------------------------------
library(ggplot2)

# get all `lp` Tpr curves
tpr_all <- getCurvesDigitized(pprRange = "lp")
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
sk_dpr_all <- createTidyFromMatrix(ppr, tpr_all, correlation = "DPR")
sk_dpr_all


p <- ggplot(sk_dpr_all, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ----results="hold"------------------------------------------------------
# get all `lp` Tpr curves
tpr <- getCurvesDigitized(pprRange = "lp")
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 

# calculate HY for the given Tpr
all_dak <- z.DranchukPurvisRobinson(pres.pr = ppr, temp.pr = tpr)
cat("Calculated from the correlation \n")
print(all_dak) 

cat("\nStanding-Katz chart\n")
all_sk <- getStandingKatzMatrix(ppr_vector = ppr, tpr_vector = tpr)
all_sk

# find the error
cat("\n Errors in percentage \n")
all_err <- round((all_sk - all_dak) / all_sk * 100, 2)  # in percentage
all_err

cat("\n Errors in Ppr\n")
summary(all_err)

# for the transposed matrix
cat("\n Errors for the transposed matrix: Tpr \n")
summary(t(all_err))

