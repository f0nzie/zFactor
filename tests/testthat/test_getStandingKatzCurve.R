library(testthat)


context("getStandingKatzCurve()")

test_that("Tpr=2.4 matches values in file", {
expect_equal(getStandingKatzCurve(tpr = 2.4, pprRange = "lp",
                     toView = FALSE,
                     toPlot = FALSE,
                     toSave = FALSE), get(load("sk_lp_tpr_240.rda")))
})

test_that("Tpr=1.05 matches values in file", {
expect_equal(getStandingKatzCurve(tpr = 1.05, pprRange = "lp",
                                  toView = FALSE,
                                  toPlot = FALSE,
                                  toSave = FALSE), get(load("sk_lp_tpr_105.rda")))
})

test_that("Tpr=1.5 matches values in file", {
    expect_equal(getStandingKatzCurve(tpr = 1.5, pprRange = "hp",
                                      toView = FALSE,
                                      toPlot = FALSE,
                                      toSave = FALSE), get(load("sk_hp_tpr_150.rda")))
})

test_that("Tpr=3.0 matches values in file", {
    expect_equal(getStandingKatzCurve(tpr = 3, pprRange = "hp",
                                      toView = FALSE,
                                      toPlot = FALSE,
                                      toSave = FALSE), get(load("sk_hp_tpr_300.rda")))
})




context("listStandingKatzCurves()")

test_that("listStandingKatzCurves() matches files 'lp", {
    expected <- c('sk_lp_tpr_105.txt', 'sk_lp_tpr_110.txt', 'sk_lp_tpr_120.txt',
                  'sk_lp_tpr_130.txt', 'sk_lp_tpr_140.txt', 'sk_lp_tpr_150.txt',
                  'sk_lp_tpr_160.txt', 'sk_lp_tpr_170.txt', 'sk_lp_tpr_180.txt',
                  'sk_lp_tpr_190.txt', 'sk_lp_tpr_200.txt', 'sk_lp_tpr_220.txt',
                  'sk_lp_tpr_240.txt', 'sk_lp_tpr_260.txt', 'sk_lp_tpr_280.txt',
                  'sk_lp_tpr_300.txt'
                  )

    expect_equal(listStandingKatzCurves("lp"), expected)
})

test_that("listStandingKatzCurves() matches files 'hp", {
    expected <- c('sk_hp_tpr_105.txt', 'sk_hp_tpr_110.txt', 'sk_hp_tpr_120.txt',
                  'sk_hp_tpr_130.txt', 'sk_hp_tpr_140.txt', 'sk_hp_tpr_150.txt',
                  'sk_hp_tpr_170.txt', 'sk_hp_tpr_200.txt', 'sk_hp_tpr_220.txt',
                  'sk_hp_tpr_240.txt', 'sk_hp_tpr_260.txt', 'sk_hp_tpr_300.txt')

    expect_equal(listStandingKatzCurves("hp"), expected)
})

test_that("listStandingKatzCurves() matches files 'all", {
    expected <- c('sk_hp_tpr_105.txt', 'sk_hp_tpr_110.txt', 'sk_hp_tpr_120.txt',
                  'sk_hp_tpr_130.txt', 'sk_hp_tpr_140.txt', 'sk_hp_tpr_150.txt',
                  'sk_hp_tpr_170.txt', 'sk_hp_tpr_200.txt', 'sk_hp_tpr_220.txt',
                  'sk_hp_tpr_240.txt', 'sk_hp_tpr_260.txt', 'sk_hp_tpr_300.txt',
                  'sk_lp_tpr_105.txt', 'sk_lp_tpr_110.txt', 'sk_lp_tpr_120.txt',
                  'sk_lp_tpr_130.txt', 'sk_lp_tpr_140.txt', 'sk_lp_tpr_150.txt',
                  'sk_lp_tpr_160.txt', 'sk_lp_tpr_170.txt', 'sk_lp_tpr_180.txt',
                  'sk_lp_tpr_190.txt', 'sk_lp_tpr_200.txt', 'sk_lp_tpr_220.txt',
                  'sk_lp_tpr_240.txt', 'sk_lp_tpr_260.txt', 'sk_lp_tpr_280.txt',
                  'sk_lp_tpr_300.txt'
                  )

    expect_equal(listStandingKatzCurves("all"), expected)
})




context("getCurvesDigitized()")

test_that("match digitized curves for `hp`", {
    expected <- c(1.05, 1.10, 1.20, 1.30, 1.40, 1.50, 1.70,
                  2.00, 2.20, 2.40, 2.60, 3.00)
    expect_equal(getStandingKatzTpr(pprRange = "hp"), expected)
})

test_that("match digitized curves for `lp`", {
    expected <- c(1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
                  2.0, 2.2, 2.4, 2.6, 2.8, 3.0)
    expect_equal(getStandingKatzTpr(pprRange = "lp"), expected)
})

test_that("match digitized curves for `common`", {
    expected <- c(1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.7, 2.0, 2.2, 2.4, 2.6, 3.0)
    expect_equal(getStandingKatzTpr(pprRange = "common"), expected)
})

test_that("match digitized curves for `all`", {
    expected <- c(1.05, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
                  2.0, 2.2, 2.4, 2.6, 2.8, 3.0)
    expect_equivalent(getStandingKatzTpr(pprRange = "all"), expected)
})





context("getStandingKatzPpr")

test_that("getStandingKatzPpr interval is `coarse`", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    expect_equal(getStandingKatzPpr(), ppr)          # default
    expect_equal(getStandingKatzPpr("coarse"), ppr)  # explicit
})

test_that("getStandingKatzPpr interval is `fine`", {
    ppr <- c(0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0)
    expect_equal(getStandingKatzPpr("fine"), ppr)  # explicit
})

test_that("getStandingKatzPpr interval is yields error", {
    expect_error(getStandingKatzPpr("any"), "wrong `interval` specified")
})



context("getStandingKatzTpr")

test_that("getStandingKatzTpr is not supplied a range for Ppr", {
    msg <- "one of these values must be supplied:"
    expect_error(getStandingKatzTpr(), msg)
})

test_that("getStandingKatzTpr, range for Ppr is low pressure", {
    msg <- "one of these values must be supplied:"
    expected <- c(1.05 ,1.10, 1.20, 1.30, 1.40, 1.50, 1.60, 1.70, 1.80, 1.90, 2.00, 2.20, 2.40, 2.60, 2.80, 3.00)
    expect_equal(getStandingKatzTpr("lp"), expected)
})


test_that("getStandingKatzTpr, range for Ppr is high pressure", {
    msg <- "one of these values must be supplied:"
    expected <- c(1.05 ,1.10, 1.20, 1.30, 1.40, 1.50, 1.70, 2.00, 2.20, 2.40, 2.60, 3.00)
    expect_equal(getStandingKatzTpr("hp"), expected)
})



context("getStandingKatzMatrix")

test_that("getStandingKatzMatrix, 4 Ppr x 7 Tpr", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
    tpr <- c(1.3, 1.5, 1.7, 2)
    expect_equal(dim(getStandingKatzMatrix(ppr, tpr)), c(4, 7))
})

test_that("getStandingKatzMatrix, 6 Ppr x 8 Tpr", {
    ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.0)
    tpr <- c(1.3, 1.5, 1.7, 2, 2.2, 2.4)
    expect_equal(dim(getStandingKatzMatrix(ppr, tpr)), c(6, 8))
})

test_that("getStandingKatzMatrix ppr, tpr", {
    ppr <- c(7.0, 7.5)
    tpr <- c(2.6, 2.4)
    # print(getStandingKatzMatrix(ppr, tpr, "hp"))
    expect_equal(dim(getStandingKatzMatrix(ppr, tpr)), c(2, 2))
})



context("getStandingKatzData")

test_that("getStandingKatzData, default", {
    expect_equal(dim(getStandingKatzData()), c(36, 5))
})

test_that("getStandingKatzData, default", {
    expect_equal(dim(getStandingKatzData(pprRange = "lp")), c(36, 5))
})


test_that("getStandingKatzData, default", {
    expect_equal(dim(getStandingKatzData(pprRange = "hp")), c(5, 5))
})


