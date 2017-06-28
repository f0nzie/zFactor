library(testthat)
context("test z.HallYarborough")
# test only one point at Ppr=0.5 and Tpr = 1.3

test_that("HY corr matches a single z value at Ppr=0.5 and Tpr=1.3", {
    expect_equal(z.HallYarborough(0.5, 1.3), 0.9176300, tolerance = 1E-7)
})

test_that("HY corr matches a single z value at Ppr=1.5 and Tpr=1.1", {
    expect_equal(z.HallYarborough(pres.pr = 1.5, temp.pr = 1.1), 0.4732393,
                 tolerance = 1e-7)
})

test_that("HY corr matches solution of 4x7 Ppr, Tpr matrix", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    # hy_4x7 <- z.HallYarborough(ppr, tpr); save(hy_4x7, file = "hy_4x7.rda")
    load(file = "hy_4x7.rda"); expect_equal(z.HallYarborough(ppr, tpr), hy_4x7)
})


test_that("test HY with 4x7 Ppr x Tpr using sapply", {
    # test DAK with  using the values from paper
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    tbl <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.HallYarborough(pres.pr = x, temp.pr = y)))

    rownames(tbl) <- tpr
    colnames(tbl) <- ppr
    load(file = "hy_4x7.rda"); expect_equal(z.HallYarborough(ppr, tpr), hy_4x7)
})


test_that("HY corr matches solution of 2x6 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1)
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5)

    # hy <- z.HallYarborough(ppr, tpr); save(hy, file = "hy_2x6.rda")
    load(file = "hy_2x6.rda");
    expect_equal(z.HallYarborough(ppr, tpr), hy)
})


test_that("HY corr matches solution of 4x13 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1, 1.2, 1.3)
    ppr <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)

    # hy <- z.HallYarborough(ppr, tpr); save(hy, file = "hy_4x13.rda")
    load(file = "hy_4x13.rda");
    expect_equal(z.HallYarborough(ppr, tpr), hy)
})


test_that("HY corr matches solution of 16x7 Ppr, Tpr (all) matrix", {
    tpr <- getCurvesDigitized(pprRange = "lp")
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)

    # hy <- z.HallYarborough(ppr, tpr); save(hy, file = "hy_16x7.rda")
    load(file = "hy_16x7.rda");
    expect_equal(z.HallYarborough(ppr, tpr), hy)
})
