## ----setup, include=F, error=T, message=F, warning=F---------------------
knitr::opts_chunk$set(echo=T, comment=NA, error=T, warning=F, message = F, fig.align = 'center', results="hold")

## ----echo=FALSE, warning=FALSE-------------------------------------------
#suppressPackageStartupMessages(library(knitcitations))
#knitcitations::cleanbib()
#bib_file <- system.file("doc", "bibliography.bib", package = "zFactor")
#bib <- read.bibtex(bib_file)
# library(knitcitations)
# bib_file <- system.file("doc", "bibliography.bib", package = "zFactor")
# bib <- read.bibtex(bib_file)

## ------------------------------------------------------------------------
# get a z value
library(zFactor)
ppr <- 1.5
tpr <- 2.0

z.calc <- z.Papp(pres.pr = ppr, temp.pr = tpr)

# get a z value from the SK chart at the same Ppr and Tpr
z.chart <- getStandingKatzMatrix(tpr_vector = tpr, 
                      pprRange = "lp")[1, as.character(ppr)]

# calculate the APE
ape <- abs((z.calc - z.chart) / z.chart) * 100

df <- as.data.frame(list(Ppr = ppr,  z.calc =z.calc, z.chart = z.chart, ape=ape))
rownames(df) <- tpr
df
# HY = 0.9580002; # DAK = 0.9551087

## ------------------------------------------------------------------------
library(zFactor)
ppr <- 1.5
tpr <- 1.1

z.calc <- z.Papp(pres.pr = ppr, temp.pr = tpr)

# From the Standing-Katz chart we obtain a digitized point:
z.chart <- getStandingKatzMatrix(tpr_vector = tpr, 
                      pprRange = "lp")[1, as.character(ppr)]

# calculate the APE (Average Percentage Error)
ape <- abs((z.calc - z.chart) / z.chart) * 100

df <- as.data.frame(list(Ppr = ppr,  z.calc =z.calc, z.chart = z.chart, ape=ape))
rownames(df) <- tpr
df
# HY = 0.4732393  APE = 11.08903

## ------------------------------------------------------------------------
# test with vector extracted from paper
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
tpr <- c(1.05, 1.1, 1.7, 2) 

# calculate using the correlation
z.calc <- z.Papp(ppr, tpr)

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
z.calc <- z.Papp(pres.pr = ppr2, temp.pr = tpr2) 
ape <- abs((z.calc - z.chart) / z.chart) * 100

# calculate the APE
cat("z.correlation \n"); print(z.calc)
cat("\n z.chart \n"); print(z.chart)
cat("\n APE \n"); print(ape)

## ------------------------------------------------------------------------
sum_t_ape <- summary(t(ape))
sum_t_ape
 # Hall-Yarborough
 #      1.2               1.3              1.5               2         
 # Min.   :0.05224   Min.   :0.1105   Min.   :0.1021   Min.   :0.0809  
 # 1st Qu.:0.09039   1st Qu.:0.2080   1st Qu.:0.1623   1st Qu.:0.1814  
 # Median :0.28057   Median :0.3181   Median :0.1892   Median :0.1975  
 # Mean   :0.30122   Mean   :0.3899   Mean   :0.2597   Mean   :0.2284  
 # 3rd Qu.:0.51710   3rd Qu.:0.5355   3rd Qu.:0.3533   3rd Qu.:0.2627  
 # Max.   :0.57098   Max.   :0.8131   Max.   :0.5162   Max.   :0.4338  
 #       3          
 # Min.   :0.09128  
 # 1st Qu.:0.17466  
 # Median :0.35252  
 # Mean   :0.34820  
 # 3rd Qu.:0.52184  
 # Max.   :0.59923  

## ------------------------------------------------------------------------
library(zFactor)
library(tibble)
library(ggplot2)

tpr2 <- c(1.05, 1.1, 1.2, 1.3) 
ppr2 <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5) 

sk_dak_2 <- createTidyFromMatrix(ppr2, tpr2, correlation = "PP")
as.tibble(sk_dak_2)

p <- ggplot(sk_dak_2, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
library(zFactor)

sk_dak_3 <- sk_dak_2[sk_dak_2$Tpr==1.05,]
sk_dak_3

p <- ggplot(sk_dak_3, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.2,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
library(ggplot2)
library(tibble)

# get all `lp` Tpr curves
tpr_all <- getStandingKatzTpr(pprRange = "lp")
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5) 
sk_corr_all <- createTidyFromMatrix(ppr, tpr_all, correlation = "PP")
as.tibble(sk_corr_all)

p <- ggplot(sk_corr_all, aes(x=Ppr, y=z.calc, group=Tpr, color=Tpr)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=z.calc-dif, ymax=z.calc+dif), width=.4,
                  position=position_dodge(0.05))
print(p)

## ------------------------------------------------------------------------
# MSE: Mean Squared Error
# RMSE: Root Mean Squared Error
# RSS: residual sum of square
# ARE:  Average Relative Error, %
# AARE: Average Absolute Relative Error, %
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
    ggtitle("Papp", subtitle = "PP")

## ------------------------------------------------------------------------
library(dplyr)

sk_corr_all %>%
    filter(Tpr %in% c("1.05", "1.1", "1.2", "2.6", "2.8", "3")) %>%
    ggplot(aes(x = z.chart, y=z.calc, group = Tpr, color = Tpr)) +
    geom_point(size = 3) +
    geom_line(aes(x = z.chart, y = z.chart), color = "black") +
    facet_grid(. ~ Tpr, scales = "free") +
    geom_errorbar(aes(ymin=z.calc-abs(dif), ymax=z.calc+abs(dif)), 
                  position=position_dodge(0.5))

## ------------------------------------------------------------------------
as_tibble(smry_tpr_ppr)

## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = ""
)

## ----results="asis", echo=FALSE------------------------------------------
# bibliography(style="citation")

