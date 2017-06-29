library(testthat)
context("test z.DranchukAbuKassem")

test_that("DAK calculates z for only one point at Ppr=0.5 and Tpr=1.3", {
    expect_equal(z.DranchukAbuKassem(0.5, 1.3), 0.9203019)
})


test_that("DAK corr matches a single z value", {
    expect_equal(z.DranchukAbuKassem(pres.pr = 1.5, temp.pr = 1.1), 0.4463987,
                 tolerance = 1e-7)
})


test_that("DAK corr matches solution of 4x7 Ppr, Tpr matrix", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)
    # dak <- z.DranchukAbuKassem(ppr, tpr); save(dak, file = "dak_4x7.rda")
    load(file = "dak_4x7.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dak)
})


test_that("DAK works with 7 Ppr values and 4 Tpr using sapply", {
    # test using common values
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    tbl <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.DranchukAbuKassem(pres.pr = x, temp.pr = y)))

    rownames(tbl) <- tpr
    colnames(tbl) <- ppr
    load(file = "dak_4x7.rda");
    expect_equal(tbl, dak)
})


test_that("DAK corr matches solution of 2x6 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1)
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5)

    # dak <- z.DranchukAbuKassem(ppr, tpr); save(dak, file = "dak_2x6.rda")
    load(file = "dak_2x6.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dak)
})


test_that("DAK corr matches solution of 4x13 Ppr, Tpr matrix", {
    tpr <- c(1.05, 1.1, 1.2, 1.3)
    ppr <- c(0.5, 1.0, 1.5, 2, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5)
    # dak <- z.DranchukAbuKassem(ppr, tpr); save(dak, file = "dak_4x13.rda")
    load(file = "dak_4x13.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dak)
})

test_that("DAK corr matches solution of 16x7 Ppr, Tpr (all) matrix", {
    tpr <- getCurvesDigitized(pprRange = "lp")
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    # dak <- z.DranchukAbuKassem(ppr, tpr); save(dak, file = "dak_16x7.rda")
    load(file = "dak_16x7.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dak)
})

test_that("uni-element vectors of Ppr and Tpr work", {
    # print(z.DranchukAbuKassem(c(1.0), c(1.5)))
    expect_equal(z.DranchukAbuKassem(1.0, 1.5), 0.9034006, tolerance = 1e-7)
    expect_equal(z.DranchukAbuKassem(c(1.0), c(1.5)), 0.9034006, tolerance = 1e-7)
})

test_that("1x2 matrix of Ppr and Tpr work", {
    ppr <- c(1.0, 2.0)
    tpr <- 1.5
    # print(z.DranchukAbuKassem(ppr, tpr))
    expected <- matrix(c(0.9034006, 0.8214651), nrow=1, ncol=2)
    rownames(expected) <- tpr
    colnames(expected) <- ppr
    expect_equal(z.DranchukAbuKassem(ppr, tpr), expected, tolerance = 1e-7)
})