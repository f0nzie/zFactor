## ------------------------------------------------------------------------
library(zFactor)
zFactor:::z.plot.range("DAK", interval = "fine")

## ------------------------------------------------------------------------
library(tibble)
dak_tpr <- as.tibble(z.stats("DAK"))
dak_tpr

## ------------------------------------------------------------------------
# ggplot(dak_tpr, aes())

## ------------------------------------------------------------------------
library(dplyr)
library(tibble)

correlation <- "DAK"
# get all `lp` Tpr curves
tpr_all <- getStandingKatzTpr(pprRange = "lp")
# ppr <- c(0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0)
ppr <- zFactor:::getStandingKatzPpr(interval = "fine")
sk_corr_all <- createTidyFromMatrix(ppr, tpr_all, correlation)
grouped <- group_by(sk_corr_all, Tpr, Ppr)
smry_tpr_ppr <- summarise(grouped,  z.chart, z.calc,
                          RMSE = sqrt(mean((z.chart-z.calc)^2)),
                          MPE  = sum((z.calc - z.chart) / z.chart) * 100 / n(),
                          MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n(),
                          MSE  = sum((z.calc - z.chart)^2) / n(),
                          RSS  = sum((z.calc - z.chart)^2),
                          MAE  = sum(abs(z.calc - z.chart)) / n()
                         
)
as.tibble(smry_tpr_ppr)
# dak_tpr_ppr <- smry_tpr_ppr

## ------------------------------------------------------------------------
smry_tpr_105 <- smry_tpr_ppr[smry_tpr_ppr$Tpr=="1.05", ]
smry_tpr_105

## ----fig.asp=1-----------------------------------------------------------
# par(mfrow = c(2,1))
# hist(smry_tpr_105$z.chart - smry_tpr_105$z.calc)
# boxplot(smry_tpr_105$z.chart - smry_tpr_105$z.calc)

## ------------------------------------------------------------------------
# # RMSE Tpr=1.05
# dat = data.frame(residual = smry_tpr_105$z.chart - smry_tpr_105$z.calc, yhat=smry_tpr_105$z.calc)
# plt = ezplot::plt_dist(dat)
# plt("residual")

## ------------------------------------------------------------------------
plot(smry_tpr_105$Ppr, smry_tpr_105$RMSE)

## ------------------------------------------------------------------------
plot(smry_tpr_105$Ppr, smry_tpr_105$z.chart, type = "l")
points(smry_tpr_105$Ppr, smry_tpr_105$z.calc, cex = 1.25)
points(smry_tpr_105$Ppr, smry_tpr_105$RMSE)

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(smry_tpr_ppr, aes(x = Ppr, y = z.chart, group = Tpr, color = Tpr)) + 
    geom_line() + 
    geom_point(aes(y=z.calc), col = "blue") +
    geom_crossbar(aes(ymin=z.chart-RMSE, ymax=z.chart+RMSE), width = 0.25, col = "orange") +
    geom_linerange(aes(ymin = z.chart-RMSE, ymax = z.chart+RMSE), col = "orange")

ggplot(smry_tpr_ppr, aes(x=Ppr, y=RMSE)) +  geom_line() + geom_point()

## ------------------------------------------------------------------------
# MPE
library(ggplot2)
ggplot(smry_tpr_105, aes(x = Ppr, y = z.chart)) + 
    geom_line() + 
    geom_point(aes(y=z.calc), col = "blue") +
    geom_crossbar(aes(ymin=z.chart-MPE, ymax=z.chart+MPE), width = 0.25, col = "orange")
    #+ geom_linerange(aes(ymin = z.chart-MPE, ymax = z.chart+MPE), col = "orange")

ggplot(smry_tpr_105, aes(x=Ppr, y=MPE)) +  geom_line() + geom_point()

## ------------------------------------------------------------------------
# p <- ggplot(smry_tpr_105, aes(x = Ppr, y = z.chart))
# p <- p + geom_line()    
# p <- p + geom_line(aes(y=MPE))
# p <- p + scale_y_continuous(sec.axis = sec_axis(Ppr+ MPE. * .1))
# 
# p

## ------------------------------------------------------------------------
p <- ggplot(mtcars, aes(cyl, mpg)) +
  geom_point()

# Create a simple secondary axis
p + scale_y_continuous(sec.axis = sec_axis(~.+10))

# Inherit the name from the primary axis
p + scale_y_continuous("Miles/gallon", sec.axis = sec_axis(~.+10, name = derive()))

# Duplicate the primary axis
p + scale_y_continuous(sec.axis = dup_axis())

# You can pass in a formula as a shorthand
p + scale_y_continuous(sec.axis = ~.^2)

## ------------------------------------------------------------------------
# MPE
library(ggplot2)
ggplot(smry_tpr_105, aes(x = Ppr, y = z.chart)) +
    geom_line() 
    # geom_line(aes(y=MPE)) #+
    #geom_point(aes(y=z.calc), col = "blue") +
    # geom_hline(aes(x=Ppr, y = MPE, yintercept=0))  +
    # scale_y_continuous(sec.axis = sec_axis(~.*2 ))
    

## ------------------------------------------------------------------------
# MAPE

library(ggplot2)
ggplot(smry_tpr_105, aes(x = Ppr, y = z.chart)) + 
    geom_line() + 
    geom_point(aes(y=z.calc), col = "blue") +
    geom_crossbar(aes(ymin=z.chart-MAPE, ymax=z.chart+MAPE), width = 0.25, col = "orange")
    #+ geom_linerange(aes(ymin = z.chart-MPE, ymax = z.chart+MPE), col = "orange")

ggplot(smry_tpr_105, aes(x=Ppr, y=MAPE)) +  geom_line() + geom_point()

## ------------------------------------------------------------------------
# MSE

library(ggplot2)
ggplot(smry_tpr_105, aes(x = Ppr, y = z.chart)) + 
    geom_line() + 
    geom_point(aes(y=z.calc), col = "blue") +
    geom_crossbar(aes(ymin=z.chart-MSE, ymax=z.chart+MSE), width = 0.25, col = "orange")
    #+ geom_linerange(aes(ymin = z.chart-MPE, ymax = z.chart+MPE), col = "orange")

ggplot(smry_tpr_105, aes(x=Ppr, y=MSE)) +  geom_line() + geom_point()

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(smry_tpr_105, aes(x=Ppr, y=RSS)) +  geom_line() + geom_point()
    #geom_point(aes(y=z.calc), col = "blue") +
    #geom_crossbar(aes(ymin=z.chart-RSS, ymax=z.chart+RSS), width = 0.25, col = "orange")

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(smry_tpr_105, aes(x=Ppr, y=MAE)) + 
    geom_line() + geom_point()
    #geom_point(aes(y=z.calc), col = "blue") +
    #geom_crossbar(aes(ymin=z.chart-RSS, ymax=z.chart+RSS), width = 0.25, col = "orange")

## ------------------------------------------------------------------------
# RSS

library(ggplot2)
ggplot(smry_tpr_105, aes(x = Ppr, y = z.chart)) + 
    #geom_line() + 
    #geom_point(aes(y=z.calc), col = "blue") +
    geom_crossbar(aes(ymin=z.chart-RSS, ymax=z.chart+RSS), width = 0.25, col = "orange")
    #+ geom_linerange(aes(ymin = z.chart-MPE, ymax = z.chart+MPE), col = "orange")

ggplot(smry_tpr_105, aes(x=Ppr, y=RSS)) +  geom_line() + geom_point()

## ------------------------------------------------------------------------
library(zFactor)
library(tibble)

dak <- z.stats("DAK")
dak
dak_105 <- dak[dak$Tpr=="1.05", ]
dak_105

## ----eval=FALSE----------------------------------------------------------
#  RMSE = sqrt(mean((z.chart - z.calc)^2))

## ----eval=FALSE----------------------------------------------------------
#  MPE  = sum((z.calc - z.chart) / z.chart) * 100 / n(),

## ----eval=FALSE----------------------------------------------------------
#  MAPE = sum(abs((z.calc - z.chart) / z.chart)) * 100 / n()

## ----eval=FALSE----------------------------------------------------------
#  MSE  = sum((z.calc - z.chart)^2) / n()

## ----eval=FALSE----------------------------------------------------------
#  RSS  = sum((z.calc - z.chart)^2)

## ----eval=FALSE----------------------------------------------------------
#  MAE  = sum(abs(z.calc - z.chart)) / n()

## ------------------------------------------------------------------------
d = data.frame(
  x  = c(1:5)
  , y  = c(1.1, 1.5, 2.9, 3.8, 5.2)
  , sd = c(0.2, 0.3, 0.2, 0.0, 0.4)
)

##install.packages("Hmisc", dependencies=T)
library("Hmisc")

# add error bars (without adjusting yrange)
plot(d$x, d$y, type="n")
with (
  data = d
  , expr = errbar(x, y, y+sd, y-sd, add=T, pch=1, cap=.1)
)

# new plot (adjusts Yrange automatically)
with (
  data = d
  , expr = errbar(x, y, y+sd, y-sd, add=F, pch=1, cap=.015, log="x")
)

## ------------------------------------------------------------------------
with (
  data = d,
qplot(x,y)+geom_errorbar(aes(x=x, ymin=y-sd, ymax=y+sd), width=0.25)
)

