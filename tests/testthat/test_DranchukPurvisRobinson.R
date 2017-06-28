library(testthat)
context("test z.DranchukPurvisRobinson")

# test only one point at Ppr=0.5 and Tpr = 1.3
# print(z.DranchukPurvisRobinson(0.5, 1.3))
expect_equal(z.DranchukPurvisRobinson(0.5, 1.3), 0.9197157, tolerance = 1E-7)



test_that("DPR corr matches solution of 4x7 Ppr, Tpr matrix", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    # dpr <- z.DranchukAbuKassem(ppr, tpr); save(dpr, file = "dpr_4x7.rda")
    load(file = "dpr_4x7.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dpr)
})


test_that("DPR corr matches solution of 2x6 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1)
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5)

    # dpr <- z.DranchukAbuKassem(ppr, tpr); save(dpr, file = "dpr_2x6.rda")
    load(file = "dpr_2x6.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dpr)
})


test_that("DPR corr matches solution of 4x13 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1, 1.2, 1.3)
    ppr <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)

    # dpr <- z.DranchukAbuKassem(ppr, tpr); save(dpr, file = "dpr_4x13.rda")
    load(file = "dpr_4x13.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dpr)
})

test_that("DPR corr matches solution of 16x7 Ppr, Tpr (all) matrix", {
    tpr <- getCurvesDigitized(pprRange = "lp")
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)

    # dpr <- z.DranchukAbuKassem(ppr, tpr); save(dpr, file = "dpr_16x7.rda")
    load(file = "dpr_16x7.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dpr)
})