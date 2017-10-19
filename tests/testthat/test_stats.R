
library(testthat)


context("z.stats")

test_that("z.stats matches dimension and mean of MAPE", {
    sh_corrs <- (zFactor:::z_correlations$short)
    sapply(sh_corrs, function(corr)
        expect_equal(dim(z.stats(corr)), c(112,8)))
    s.mean <- sapply(sh_corrs, function(corr) mean(z.stats(corr)$MAPE))
    expected <- c(13.8862628,  0.8186578,  0.7697211,  0.8123786,  4.1530402,  0.1635157,  2.0987294)
    names(expected) <- sh_corrs
    expect_equal(s.mean, expected)
})




context("z_correlations")

test_that("z_correlations matches the short names of the correlations", {
    sh_corrs <- (zFactor:::z_correlations$long)
    for (corr in sh_corrs) {
        expect_true(corr %in% c("Beggs-Brill", "Hall-Yarborough", "Dranchuk-AbuKassem",
                                "Dranchuk-Purvis-Robinson", "Shell", "Ann10", "Papp"))
    }
})

test_that("z_correlations matches the short names of the correlations", {
    sh_corrs <- (zFactor:::z_correlations$short)
    for (corr in sh_corrs) {
        expect_true(corr %in% c("BB", "HY", "DAK", "DPR", "SH", "N10", "PP"))
    }
})
