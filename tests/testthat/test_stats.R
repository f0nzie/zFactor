
library(testthat)


context("z.stats")

test_that("z.stats matches dimension and mean of MAPE. default interval = coarse", {
    sh_corrs <- (zFactor:::z_correlations$short)
    sapply(sh_corrs, function(corr)
        expect_equal(dim(z.stats(corr)), c(112,8)))
    s.mean <- sapply(sh_corrs, function(corr) mean(z.stats(corr)$MAPE))
    expected <- c(13.8862628,  0.8186578,  0.7697211,  0.8123786,  4.1530402,  0.1635157,  2.0987294)
    names(expected) <- sh_corrs
    expect_equal(s.mean, expected)
})


test_that("z.stats matches dimension and mean of MAPE, interval = fine", {
    sh_corrs <- (zFactor:::z_correlations$short)
    sapply(sh_corrs, function(corr)
        expect_equal(dim(z.stats(corr)), c(112,8)))
    s.mean <- sapply(sh_corrs, function(corr) mean(z.stats(corr, interval = "fine")$MAPE))
    expected <- c(15.8031751, 0.7581761, 0.7500547, 0.7958098, 4.1555843, 0.1543264, 1.8543540)
    names(expected) <- sh_corrs
    expect_equal(s.mean, expected)
})


test_that("z.stats matches dimension and mean of MAPE, range = hp", {
    sh_corrs <- (zFactor:::z_correlations$short)
    sapply(sh_corrs, function(corr)
        expect_equal(dim(z.stats(corr)), c(112,8)))
    s.mean <- sapply(sh_corrs, function(corr) mean(z.stats(corr, pprRange = "hp")$MAPE))
    expected <- c(15.8345501,  1.0276664,  0.9324033,  0.9698105,  4.2518234,  0.1668054,  2.5638032 )
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




context("z.plot.range")

test_that("z.plot.range work for Hall-Yarborough", {
    expect_silent(z.plot.range("HY"))
    expect_silent(z.plot.range("HY", pprRange = "hp"))
    expect_silent(z.plot.range("HY", pprRange = "lp"))

    expect_silent(z.plot.range("DAK"))
    expect_silent(z.plot.range("DAK", pprRange = "hp"))
    expect_silent(z.plot.range("DAK", pprRange = "lp"))
})


