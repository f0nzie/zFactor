library(testthat)


context("z.Shell")

# test only one point at Ppr=0.5 and Tpr = 1.3
test_that("SH matches z at Ppr=0.5 and Tpr=1.3", {
    # print(z.Shell(0.5, 1.3))

    expect_equal(z.Shell(0.5, 1.3), 0.9183713, tolerance = 1E-7)
})

test_that("SH corr matches solution of 4x7 Ppr, Tpr matrix", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    # dpr <- z.Shell(ppr, tpr); save(dpr, file = "sh_4x7.rda")
    load(file = "sh_4x7.rda");
    expect_equal(z.Shell(ppr, tpr), dpr)
})


test_that("SH corr matches solution of 2x6 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1)
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5)

    # dpr <- z.Shell(ppr, tpr); save(dpr, file = "sh_2x6.rda")
    load(file = "sh_2x6.rda");
    expect_equal(z.Shell(ppr, tpr), dpr)
})


test_that("SH corr matches solution of 4x13 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1, 1.2, 1.3)
    ppr <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)

    # dpr <- z.Shell(ppr, tpr); save(dpr, file = "sh_4x13.rda")
    load(file = "sh_4x13.rda");
    expect_equal(z.Shell(ppr, tpr), dpr)
})


test_that("SH corr matches solution of 16x7 Ppr, Tpr (all) matrix", {
    tpr <- getStandingKatzTpr(pprRange = "lp")
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)

    # dpr <- z.Shell(ppr, tpr); save(dpr, file = "sh_16x7.rda")
    load(file = "sh_16x7.rda");
    expect_equal(z.Shell(ppr, tpr), dpr)
})

test_that("uni-element vectors of Ppr and Tpr work", {
    # print(z.Shell(c(1.0), c(1.5)))

    expect_equal(z.Shell(1.0, 1.5), 0.8987298, tolerance = 1e-7)
    expect_equal(z.Shell(c(1.0), c(1.5)), 0.8987298, tolerance = 1e-7)
})

test_that("1x2 matrix of Ppr and Tpr work", {
    ppr <- c(1.0, 2.0)
    tpr <- 1.5
    # print(z.Shell(ppr, tpr))
    expected <- matrix(c(0.8987298, 0.8134567), nrow=1, ncol=2)
    rownames(expected) <- tpr
    colnames(expected) <- ppr
    expect_equal(z.Shell(ppr, tpr), expected, tolerance = 1e-7)
})