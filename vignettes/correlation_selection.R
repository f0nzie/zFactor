## ------------------------------------------------------------------------
library(zFactor)
library(tibble)

as.tibble(z.stats("HY"))

## ------------------------------------------------------------------------
stats_of_z.stats("MAPE")

## ------------------------------------------------------------------------
library(zFactor)
qcorrs <- z.stats_quantile("MPE")

# par(mfrow = c(1,3))
boxplot(qcorrs,  ylim= c(-600, 100), cex = 1.5, las=2, main = "MPE, y = (-4, 100)")
grid()
boxplot(qcorrs,  ylim= c(-4, 30), cex = 1.5, las=2, main = "MPE, y = (-4, 30)")
grid()
boxplot(qcorrs,  ylim= c(-4, 6), cex = 1.5, las=2, main = "MPE, y = (-4, 6)")
# grid()

## ------------------------------------------------------------------------
library(zFactor)

qcorrs <- z.stats_quantile("RMSE")
# op <- par(mfrow = c(1,4))
boxplot(qcorrs, log = "y", ylim =  c(1e-6, 1e3), las=2, main = "RMSE")
grid()

qcorrs <- z.stats_quantile("MAPE")
boxplot(qcorrs, log = "y", ylim =  c(1e-6, 1e3), las=2, main = "MAPE")
grid()

qcorrs <- z.stats_quantile("MSE")
boxplot(qcorrs, log = "y", ylim = c(1e-12, 1e3), las=2, main = "MSE")
grid()

qcorrs <- z.stats_quantile("RSS")
boxplot(qcorrs, log = "y", ylim = c(1e-12, 1e3), las=2, main = "RSS")
grid()
# par(op)

## ------------------------------------------------------------------------
library(zFactor)
qcorrs <- z.stats_quantile("MPE")

# par(mfrow = c(1,3))
boxplot(qcorrs,  ylim= c(-600, 100), cex = 1.5, las=2, main = "MPE, y = (-4, 100)")
grid()
boxplot(qcorrs,  ylim= c(-4, 30), cex = 1.5, las=2, main = "MPE, y = (-4, 30)")
grid()
boxplot(qcorrs,  ylim= c(-4, 6), cex = 1.5, las=2, main = "MPE, y = (-4, 6)")
# grid()

## ------------------------------------------------------------------------
library(zFactor)
qcorrs <- z.stats_quantile("MPE")
scorrs <- qcorrs[, c("HY", "DAK", "DPR", "N10")]

# par(mfrow = c(1,2))
boxplot(scorrs,  ylim= c(-2, 25), cex = 1.5, las=2, main = "MPE, y = (-2, 25)")
grid()

boxplot(scorrs,  ylim= c(-2, 2), cex = 1.5, las=2, main = "MPE, y = (-2, 2)")
# grid()

