## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center', results="hold")

## ------------------------------------------------------------------------
# get a z value using HY
library(zFactor)

ppr <- 1.5
tpr <- 2.0

z.calc <- z.HallYarborough(pres.pr = ppr, temp.pr = tpr)

# get a z value from the SK chart at the same Ppr and Tpr
z.chart <- getStandingKatzMatrix(tpr_vector = tpr, 
                      pprRange = "lp")[1, as.character(ppr)]

# calculate the APE (Average Percentage Error)
ape <- abs((z.calc - z.chart) / z.chart) * 100

df <- as.data.frame(list(Ppr = ppr,  z.calc =z.calc, z.chart = z.chart, ape=ape))
rownames(df) <- tpr
df

## ------------------------------------------------------------------------
library(zFactor)
ppr <- 1.5
tpr <- 1.1

z.calc <- z.HallYarborough(pres.pr = ppr, temp.pr = tpr)

# From the Standing-Katz chart we obtain a digitized point:
z.chart <- getStandingKatzMatrix(tpr_vector = tpr, 
                      pprRange = "lp")[1, as.character(ppr)]

# calculate the APE
ape <- abs((z.calc - z.chart) / z.chart) * 100

df <- as.data.frame(list(Ppr = ppr,  z.calc =z.calc, z.chart = z.chart, ape=ape))
rownames(df) <- tpr
df

## ------------------------------------------------------------------------
library(zFactor)

ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.05, 1.1, 1.7, 2) 

# calculate using the correlation
z.calc <- z.HallYarborough(ppr, tpr)

# With the same ppr and tpr vector, we do the same for the Standing-Katz chart
z.chart <- getStandingKatzMatrix(ppr_vector = ppr, tpr_vector = tpr)
ape <- abs((z.calc - z.chart) / z.chart) * 100

# calculate the APE
cat("z.correlation \n"); print(z.calc)
cat("\n z.chart \n"); print(z.chart)
cat("\n APE \n"); print(ape)

## ------------------------------------------------------------------------
sum_t_ape <- summary(t(ape))
sum_t_ape

## ------------------------------------------------------------------------
library(zFactor)
# enter vectors for Tpr and Ppr
tpr2 <- c(1.2, 1.3, 1.5, 2.0, 3.0) 
ppr2 <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5) 
# get z values from the SK chart
z.chart <- getStandingKatzMatrix(ppr_vector = ppr2, tpr_vector = tpr2, pprRange = "lp")

# We do the same with the HY correlation:
# calculate z values at lower values of Tpr
z.calc <- z.HallYarborough(pres.pr = ppr2, temp.pr = tpr2) 
ape <- abs((z.calc - z.chart) / z.chart) * 100

# calculate the APE
cat("z.correlation \n"); print(z.calc)
cat("\n z.chart \n"); print(z.chart)
cat("\n APE \n"); print(ape)

## ------------------------------------------------------------------------
sum_t_ape <- summary(t(ape))
sum_t_ape

## ------------------------------------------------------------------------
library(zFactor)
library(tibble)
library(ggplot2)

tpr2 <- c(1.05, 1.1, 1.2, 1.3)
ppr2 <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)

sk_corr_2 <- createTidyFromMatrix(ppr2, tpr2, correlation = "HY")
as.tibble(sk_corr_2)

p <- ggplot(sk_corr_2, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-abs(dif), ymax=z.calc+abs(dif)), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
library(ggplot2)
library(tibble)

# get all `lp` Tpr curves
tpr_all <- getStandingKatzTpr(pprRange = "lp")
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
sk_corr_all <- createTidyFromMatrix(ppr, tpr_all, correlation = "HY")
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
# RMSLE: Root Mean Squared Logarithmic Error. Penalizes understimation.
# MAPE: Mean Absolute Percentage Error = AARE
# MPE: Mean Percentage error = ARE
# MAE: Mean Absolute Error
library(dplyr)
grouped <- group_by(sk_corr_all, Tpr, Ppr)
smry_tpr_ppr <- summarise(grouped, 
          RMSE= sqrt(mean((z.chart-z.calc)^2)), 
          MPE = sum((z.calc - z.chart) / z.chart) * 100 / n(),
          MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n(), 
          MSE = sum((z.calc - z.chart)^2) / n(), 
          RSS = sum((z.calc - z.chart)^2),
          MAE = sum(abs(z.calc - z.chart)) / n(),
          RMLSE = sqrt(1/n()*sum((log(z.calc +1)-log(z.chart +1))^2))
          )

ggplot(smry_tpr_ppr, aes(Ppr, Tpr)) + 
    geom_tile(data=smry_tpr_ppr, aes(fill=MAPE), color="white") +
    scale_fill_gradient2(low="blue", high="red", mid="yellow", na.value = "pink",
                         midpoint=12.5, limit=c(0, 25), name="MAPE") + 
    theme(axis.text.x = element_text(angle=45, vjust=1, size=11, hjust=1)) + 
    coord_equal() +
    ggtitle("Hall-Yarborough", subtitle = "HY")

## ------------------------------------------------------------------------
library(dplyr)

sk_corr_all %>%
    filter(Tpr %in% c("1.05", "1.1")) %>%
    ggplot(aes(x = z.chart, y=z.calc, group = Tpr, color = Tpr)) +
    geom_point(size = 3) +
    geom_line(aes(x = z.chart, y = z.chart), color = "black") +
    facet_grid(. ~ Tpr) +
    geom_errorbar(aes(ymin=z.calc-abs(dif), ymax=z.calc+abs(dif)),
                  position=position_dodge(0.05))

## ------------------------------------------------------------------------
as.tibble(smry_tpr_ppr)

## ------------------------------------------------------------------------
# test HY with 1st-derivative using the values from the paper 
 
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.3, 1.5, 1.7, 2) 
 
hy <- sapply(ppr, function(x)  
    sapply(tpr, function(y) zFactor:::.z.HallYarborough(pres.pr = x, temp.pr = y))) 
 
rownames(hy) <- tpr 
colnames(hy) <- ppr 
print(hy) 

