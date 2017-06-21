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


context("test listStandingKatzCurves()")

test_that("listStandingKatzCurves() matches files 'lp", {
    expected <- c('sk_lp_tpr_105.txt', 'sk_lp_tpr_110.txt', 'sk_lp_tpr_120.txt',
                  'sk_lp_tpr_130.txt', 'sk_lp_tpr_140.txt', 'sk_lp_tpr_150.txt',
                  'sk_lp_tpr_170.txt', 'sk_lp_tpr_200.txt', 'sk_lp_tpr_240.txt')

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
                  'sk_lp_tpr_170.txt', 'sk_lp_tpr_200.txt', 'sk_lp_tpr_240.txt')

    expect_equal(listStandingKatzCurves("all"), expected)
})