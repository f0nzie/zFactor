library(testthat)
library(zFactor)

context("test Artificial Neural Networks ANN10")

test_that("Tpr=2 and Ppr=1.5 matches z value", {
    expect_equal(z.Ann10(pres.pr = 1.5, temp.pr = 2.0), 0.9572277, tolerance = 1e-7)
})


test_that("Tpr=1.1 and Ppr=1.5 matches z value", {
    expect_equal(z.Ann10(pres.pr = 1.5, temp.pr = 1.1), 0.4309125, tolerance = 1e-7)
})


test_that("4x7 matrix stored matches Ann10 for two Ppr and Tpr vectors", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    # ann10 <- z.Ann10(ppr, tpr);  save(ann10, file = "ann10_4x7.rda")
    load(file = "ann10_4x7.rda")
    expect_equal(z.Ann10(ppr, tpr), ann10)

})


test_that("2x6 matrix stored matches Ann10 for two Ppr and Tpr vectors", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5)
    tpr <- c(1.05, 1.1)
    # ann10 <- z.Ann10(ppr, tpr);  save(ann10, file = "ann10_2x6.rda")
    load(file = "ann10_2x6.rda")
    expect_equal(z.Ann10(ppr, tpr), ann10)
})


test_that("4x13 matrix stored matches Ann10 for two Ppr and Tpr vectors", {
    ppr <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)
    tpr <- c(1.05, 1.1, 1.2, 1.3)
    # ann10 <- z.Ann10(ppr, tpr);  save(ann10, file = "ann10_4x13.rda")
    load(file = "ann10_4x13.rda")
    expect_equal(z.Ann10(ppr, tpr), ann10)
})

# get all `lp` Tpr curves

test_that("16x13 matrix stored matches Ann10 for two Ppr and Tpr vectors", {
    ppr <- c(0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)
    tpr <- getCurvesDigitized(pprRange = "lp")
    # ann10 <- z.Ann10(ppr, tpr);  save(ann10, file = "ann10_16x13.rda")
    load(file = "ann10_16x13.rda")
    expect_equal(z.Ann10(ppr, tpr), ann10)
})


test_that("uni-element vectors of Ppr and Tpr work", {
    # print(z.Ann10(c(1.0), c(1.5)))

    expect_equal(z.Ann10(1.0, 1.5), 0.9033904, tolerance = 1e-7)
    expect_equal(z.Ann10(c(1.0), c(1.5)), 0.9033904, tolerance = 1e-7)
})

test_that("1x2 matrix of Ppr and Tpr work", {
    ppr <- c(1.0, 2.0)
    tpr <- 1.5
    # print(z.Ann10(ppr, tpr))
    expected <- matrix(c(0.9033904, 0.8230262), nrow=1, ncol=2)
    rownames(expected) <- tpr
    colnames(expected) <- ppr
    expect_equal(z.Ann10(ppr, tpr), expected, tolerance = 1e-7)
})