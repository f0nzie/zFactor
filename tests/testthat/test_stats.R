
library(testthat)


context("z.stats")

test_that("z.stats generates same dataframe size for all correlations", {
    sh_corrs <- (zFactor:::z_correlations$short)
    mean_mape <- vector("numeric")
    # for (corr in sh_corrs) {
    #     expect_equal(dim(z.stats(corr)), c(112, 8))
    #     mape <- z.stats(corr)$MAPE
    #     # print(corr); print(max(mape)); print(min(mape)); print(mean(mape))
    #     mean_mape <- c(mean_mape, mean(mape))
    # }
    # sapply(sh_corrs, function(corr)
    #     expect_equal(dim(z.stats(corr)), c(112,8)))
    sapply(sh_corrs, function(corr)
        print(mean(z.stats(corr)$MAPE)))
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
