## ------------------------------------------------------------------------
library(zFactor)
library(tibble)
library(ggplot2)

zFactor:::z.plot.range("HY", interval = "fine")

## ----eval=FALSE----------------------------------------------------------
#  RMSE = sqrt(mean((z.chart - z.calc)^2))

## ------------------------------------------------------------------------
z_hy  <- z.stats("HY")
sum_tpr <- as.tibble(z.stats("HY"))

hy <- ggplot(z_hy, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Root Mean Squared Error")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$RMSE,  horizontal = TRUE, main = "HY", xlab = "RMSE")

## ----eval=FALSE----------------------------------------------------------
#  MPE  = sum((z.calc - z.chart) / z.chart) * 100 / n(),

## ------------------------------------------------------------------------
# sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(z_hy, aes(x = Tpr, y = MPE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY  - Mean Percentage error")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$MPE,  horizontal = TRUE, main = "HY", xlab = "MPE")

## ----eval=FALSE----------------------------------------------------------
#  MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n()

## ------------------------------------------------------------------------
# sum_tpr <- as.tibble(z.stats("HY"))

hy <- ggplot(z_hy, aes(x = Tpr, y = MAPE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Absolute Percentage Error")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$MAPE,  horizontal = TRUE, main = "HY", xlab = "MAPE")

## ----eval=FALSE----------------------------------------------------------
#  MSE  = sum((z.calc - z.chart)^2) / n()

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = MSE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Squared Error")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$MSE,  horizontal = TRUE, main = "HY", xlab = "MSE")

## ----eval=FALSE----------------------------------------------------------
#  RSS  = sum((z.calc - z.chart)^2)

## ------------------------------------------------------------------------
# sum_tpr <- as.tibble(z.stats("HY"))

hy <- ggplot(z_hy, aes(x = Tpr, y = RSS, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Residual Sum of Squares")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$RSS,  horizontal = TRUE, main = "HY", xlab = "RSS")

## ----eval=FALSE----------------------------------------------------------
#  MAE  = sum(abs(z.calc - z.chart)) / n()

## ------------------------------------------------------------------------
# sum_tpr <- as.tibble(z.stats("HY"))

hy <- ggplot(z_hy, aes(x = Tpr, y = MAE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Absolute Error")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$MAE,  horizontal = TRUE, main = "HY", xlab = "MAE")

## ----eval=FALSE----------------------------------------------------------
#  MAE  = sum(atan(abs(z.calc - z.chart))) / n()

## ------------------------------------------------------------------------
hy <- ggplot(z_hy, aes(x = Tpr, y = MAAPE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Arc-tangent Absolute Error")
hy

## ------------------------------------------------------------------------
boxplot(z_hy$MAAPE,  horizontal = TRUE, main = "HY", xlab = "MAAPE")

## ------------------------------------------------------------------------
z_bb <- z.stats("BB")
bb <- ggplot(z_bb, aes(x = Tpr, y = RMSE, color = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") +
    ggtitle("Beggs-Brill")
bb

## ------------------------------------------------------------------------
boxplot(z_bb$RMSE,  horizontal = TRUE, main = "BB", xlab = "RMSE")

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") + 
    ggtitle("Hall-Yarborough")
hy

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("DAK"))
dak <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") +
    ggtitle("Dranchuk-AbouKassem")
dak

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("SH"))
sh <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") +
    ggtitle("Shell")
sh

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("N10"))
n10 <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") +
    ggtitle("Neural-Network-10")
n10

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("PP"))
pp <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") +
    ggtitle("Papp")
pp


## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
sum_tpr

## ------------------------------------------------------------------------
z.plot.range(correlation = "BB", stat = "MAPE", interval = "fine")
z.plot.range(correlation = "BB", stat = "RMSE", interval = "fine")

## ------------------------------------------------------------------------
z.plot.range(correlation = "HY", stat = "MAPE", interval = "fine")
z.plot.range(correlation = "HY", stat = "RMSE", interval = "fine")

## ------------------------------------------------------------------------
z.plot.range(correlation = "DAK", stat = "MAPE", interval = "fine")
z.plot.range(correlation = "DAK", stat = "RMSE", interval = "fine")

## ------------------------------------------------------------------------
z.plot.range(correlation = "SH", stat = "MAPE", interval = "fine")
z.plot.range(correlation = "SH", stat = "RMSE", interval = "fine")

## ------------------------------------------------------------------------
z.plot.range(correlation = "N10", stat = "MAPE", interval = "fine")
z.plot.range(correlation = "N10", stat = "RMSE", interval = "fine")

## ------------------------------------------------------------------------
z.plot.range(correlation = "PP", stat = "MAPE", interval = "fine")
z.plot.range(correlation = "PP", stat = "RMSE", interval = "fine")

