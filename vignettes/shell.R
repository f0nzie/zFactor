## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center', results="hold")

## ------------------------------------------------------------------------
# get a z value using HY
library(zFactor)

z.Shell(pres.pr = 1.5, temp.pr = 2.0)

## ------------------------------------------------------------------------
# get a z value from the SK chart at the same Ppr and Tpr
library(zFactor)

tpr_vec <- c(2.0)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "lp")[1, "1.5"]

## ------------------------------------------------------------------------
library(zFactor)


z.Shell(pres.pr = 1.5, temp.pr = 1.1)

## ------------------------------------------------------------------------
library(zFactor)

tpr_vec <- c(1.1)
getStandingKatzMatrix(tpr_vector = tpr_vec, 
                      pprRange = "lp")[1, "1.5"]

## ------------------------------------------------------------------------
library(zFactor)

ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.3, 1.5, 1.7, 2) 


z.Shell(ppr, tpr)

## ------------------------------------------------------------------------
# test HY with 1st-derivative using the values from paper 
 
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.3, 1.5, 1.7, 2) 
 
hy <- sapply(ppr, function(x)  
    sapply(tpr, function(y) zFactor:::.z.Shell(pres.pr = x, temp.pr = y))) 
 
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
# calculate z values at lower values of Tpr
library(zFactor)

tpr <- c(1.05, 1.1)
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5) 

corr2 <- z.Shell(pres.pr = ppr, temp.pr = tpr) 

print(corr2)

## ------------------------------------------------------------------------
err2 <- round((sk2 - corr2) / sk2 * 100, 2)
err2

## ------------------------------------------------------------------------
t_err2 <- t(err2)
t_err2

## ------------------------------------------------------------------------
sum_t_err2 <- summary(t_err2)
sum_t_err2

## ------------------------------------------------------------------------
library(zFactor)
library(tibble)

tpr2 <- c(1.05, 1.1, 1.2, 1.3) 
ppr2 <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5) 

sk_corr_2 <- createTidyFromMatrix(ppr2, tpr2, correlation = "SH")
as.tibble(sk_corr_2)

## ------------------------------------------------------------------------
library(ggplot2)

p <- ggplot(sk_corr_2, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
library(zFactor)
library(ggplot2)
library(tibble)

# get all `lp` Tpr curves
tpr_all <- getCurvesDigitized(pprRange = "lp")
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 

sk_corr_all <- createTidyFromMatrix(ppr, tpr_all, correlation = "SH")
as.tibble(sk_corr_all)

p <- ggplot(sk_corr_all, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
# MSE: Mean Squared Error
# RMSE: Root Mean Sqyared Error
# RSS: residual sum of square
# ARE:  Average Relative Error, %
# AARE: Average Absolute Relative Error, %
library(dplyr)
grouped <- group_by(sk_corr_all, Tpr, Ppr)
smry_tpr_ppr <- summarise(grouped, 
          RMSE= sqrt(mean((z.chart-z.calc)^2)), 
          MSE = sum((z.calc - z.chart)^2) / n(), 
          RSS = sum((z.calc - z.chart)^2),
          ARE = sum((z.calc - z.chart) / z.chart) * 100 / n(),
          AARE = sum( abs((z.calc - z.chart) / z.chart)) * 100 / n()
          )

ggplot(smry_tpr_ppr, aes(Ppr, Tpr)) + 
    geom_tile(data=smry_tpr_ppr, aes(fill=AARE), color="white") +
    scale_fill_gradient2(low="blue", high="red", mid="yellow", na.value = "pink",
                         midpoint=12.5, limit=c(0, 25), name="AARE") + 
    theme(axis.text.x = element_text(angle=45, vjust=1, size=11, hjust=1)) + 
    coord_equal() +
    ggtitle("Shell", subtitle = "SH")

## ------------------------------------------------------------------------
# get all `lp` Tpr curves
tpr <- getCurvesDigitized(pprRange = "lp")
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 

# calculate HY for the given Tpr
all_corr <- sapply(ppr, function(x)  
    sapply(tpr, function(y) z.Shell(pres.pr = x, temp.pr = y))) 

rownames(all_corr) <- tpr 
colnames(all_corr) <- ppr 
cat("Calculated correlation\n")
print(all_corr) 

cat("\nStanding-Katz chart\n")
all_sk <- getStandingKatzMatrix(ppr_vector = ppr, tpr_vector = tpr)
all_sk

# find the error
cat("\n Errors in percentage \n")
all_err <- round((all_sk - all_corr) / all_sk * 100, 2)  # in percentage
all_err

cat("\n Errors in Ppr\n")
summary(all_err)

# for the transposed matrix
cat("\n Errors for the transposed matrix: Tpr \n")
summary(t(all_err))

