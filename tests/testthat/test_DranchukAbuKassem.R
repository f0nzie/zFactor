library(testthat)
context("test z.DranchukAbuKassem")

test_that("only one point at Ppr=0.5 and Tpr = 1.3 matches", {
    expect_equal(z.DranchukAbuKassem(0.5, 1.3), 0.9203019)
    # print(z.DranchukAbuKassem(0.5, 1.3))
})

test_that("DAK corr matches a single z value", {
    # print(z.DranchukAbuKassem(pres.pr = 1.5, temp.pr = 1.1))
    expect_equal(z.DranchukAbuKassem(pres.pr = 1.5, temp.pr = 1.1), 0.4463987,
                 tolerance = 1e-7)
})


test_that("test DAK between 7 Ppr values and 4 Tpr", {
    # test using common values
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)

    tbl <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.DranchukAbuKassem(pres.pr = x, temp.pr = y)))

    rownames(tbl) <- tpr
    colnames(tbl) <- ppr
    # print(tbl)
    # DAK74 <- tbl
    # save(DAK74, file = "dak74.rda")
    # load(file = "dak74.rda")
    load(file = "dak_4x7.rda");
    expect_equal(tbl, dak)
})




test_that("DAK corr matches solution of 4x7 Ppr, Tpr matrix", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)
    # dak <- z.DranchukAbuKassem(ppr, tpr); save(dak, file = "dak_4x7.rda")
    load(file = "dak_4x7.rda");
    expect_equal(z.DranchukAbuKassem(ppr, tpr), dak)
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