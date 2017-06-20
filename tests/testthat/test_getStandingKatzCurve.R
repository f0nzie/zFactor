library(testthat)

context("test getStandingKatzCurve()")

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