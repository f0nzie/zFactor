## ------------------------------------------------------------------------
library(zFactor)
library(tibble)
library(ggplot2)

zFactor:::z.plot.range("HY", interval = "fine")

## ----eval=FALSE----------------------------------------------------------
#  RMSE = sqrt(mean((z.chart - z.calc)^2))

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Root Mean Squared Error")
hy

## ----eval=FALSE----------------------------------------------------------
#  MPE  = sum((z.calc - z.chart) / z.chart) * 100 / n(),

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = MPE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY  - Mean Percentage error")
hy

## ----eval=FALSE----------------------------------------------------------
#  MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n()

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = MAPE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Absolute Percentage Error")
hy

## ----eval=FALSE----------------------------------------------------------
#  MSE  = sum((z.calc - z.chart)^2) / n()

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = MSE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Squared Error")
hy

## ----eval=FALSE----------------------------------------------------------
#  RSS  = sum((z.calc - z.chart)^2)

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = RSS, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Residual sum of Squares")
hy

## ----eval=FALSE----------------------------------------------------------
#  MAE  = sum(abs(z.calc - z.chart)) / n()

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("HY"))
hy <- ggplot(sum_tpr, aes(x = Tpr, y = MAE, col = Tpr)) +
           geom_point()  + theme(legend.position="none") + 
    ggtitle("HY - Mean Absolute Error")
hy

## ------------------------------------------------------------------------
sum_tpr <- as.tibble(z.stats("BB"))
bb <- ggplot(sum_tpr, aes(x = Tpr, y = RMSE, color = Tpr)) +
           geom_point() + ylim(0, 0.4) + theme(legend.position="none") +
    ggtitle("Beggs-Brill")
bb

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
# Ppr  <- as.numeric(sum_tpr$Ppr)
# Tpr  <- as.numeric(sum_tpr$Tpr)
# RMSE <- sum_tpr$RMSE

sum_tpr <- as.tibble(z.stats("N10"))

sum_tpr$Tpr <- as.numeric(sum_tpr$Tpr)
sum_tpr$Ppr <- as.numeric(sum_tpr$Ppr)


data.loess <- loess(RMSE ~ Ppr * Tpr, data = sum_tpr)

xgrid <- seq(min(sum_tpr$Ppr), max(sum_tpr$Ppr), 0.1)
ygrid <- seq(min(sum_tpr$Tpr), max(sum_tpr$Tpr), 0.2)

data.fit <- expand.grid(Ppr = xgrid, Tpr = ygrid)
mtrx3d <-  predict(data.loess, newdata = data.fit)

contour(x = xgrid, y = ygrid, z = mtrx3d, nlev = 10, method = "edge")

## ------------------------------------------------------------------------
contour(x = xgrid, y = ygrid, z = mtrx3d)

## ------------------------------------------------------------------------
library(zFactor)
correlation = "PP"
pprRange <- "lp"
stat <- "MAPE"
interval <-  "fine"

if (stat == "MAPE") {
    midpoint <-  12.5
    limit <- c(0, 25)
} else if (stat == "RMSE") {
    midpoint <-   0.015
    limit <- c(0, 0.030)
}

# Ppr <- NULL; Tpr <- NULL; MAPE <- NULL; z.calc <- NULL; z.chart <- NULL
# sum_tpr <- as.tibble(z.stats(correlation))
# isMissing_correlation(correlation)
msg <- "You have to provide a z-factor correlation: "
msg_missing <- paste(msg, paste(get_z_correlations(), collapse = " "))
if (missing(correlation)) stop(msg_missing)
if (!isValid_correlation(correlation)) stop("Not a valid correlation.")

corr_name <- zFactor:::z_correlations[which(zFactor:::z_correlations["short"] == correlation),
                                                 "long"]

smry_tpr_ppr <- z.stats(correlation, pprRange, interval = interval)
g <- ggplot(smry_tpr_ppr, aes(Ppr, Tpr))
g <- g + geom_tile(data=smry_tpr_ppr, aes(fill=get(stat)), color="white") +
    scale_fill_gradient2(low="blue", high="red", mid="yellow", na.value = "pink",
                         midpoint = midpoint, limit = limit, name = stat) +
    theme(axis.text.x = element_text(angle=45, vjust=1, size=11, hjust=1)) +
    coord_equal() +
    ggtitle(corr_name, subtitle = correlation) +
    guides(fill = guide_colorbar(barwidth = 0.6, barheight = 5, 
                                 label.vjust = 0.9))
print(g)

