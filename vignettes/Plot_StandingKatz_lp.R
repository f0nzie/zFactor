## ------------------------------------------------------------------------
library(zFactor)

getStandingKatzCurve(tpr = 1.05, toSave = FALSE, toView = FALSE)

## ------------------------------------------------------------------------
tpr_vec <- getCurvesDigitized(pprRange = "lp")
invisible(sapply(tpr_vec, function(x) getStandingKatzCurve(tpr = x, toSave = FALSE, toView = FALSE)))

