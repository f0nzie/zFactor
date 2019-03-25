library(testthat)

context("SK.genDataset7p4t")

test_that("SK.genDataset7p4t dimension correct", {
    result <- SK.genDataset7p4t()
    expect_equal(dim(result), c(4, 7))
})




context("HY.genDataset7p4t")

test_that("HY.genDataset7p4t dimension correct", {
    result <- HY.genDataset7p4t()
    expect_equal(dim(result), c(4, 7))
})




context("DAK.genDataset7p4t ")

test_that("DAK.genDataset7p4t  dimension correct", {
    result <- DAK.genDataset7p4t ()
    expect_equal(dim(result), c(4, 7))
})



context("DPR.genDataset7p4t ")

test_that("DPR.genDataset7p4t  dimension correct", {
    result <- DPR.genDataset7p4t ()
    expect_equal(dim(result), c(4, 7))
})



context("DPR.genDataset7p4t ")

test_that("DPR.genDataset7p4t  dimension correct", {
    result <- DPR.genDataset7p4t ()
    expect_equal(dim(result), c(4, 7))
})



context("HY.genDatasetDif ")

test_that("HY.genDatasetDif  dimension correct", {
    result <- zFactor:::HY.genDatasetDif()
    expect_equal(dim(result), c(28, 5))
})



context("genDatasetDif ")
# correlations not implemented: BB, N10, SH, PP

test_that("genDatasetDif  dimension correct, default corr = HY", {
    result <- zFactor:::genDatasetDif()
    expect_equal(dim(result), c(28, 5))
})

test_that("genDatasetDif  dimension correct, default corr = DAK", {
    result <- zFactor:::genDatasetDif(correlation = "DAK")
    expect_equal(dim(result), c(28, 5))
})

test_that("genDatasetDif  dimension correct, default corr = DPR", {
    result <- zFactor:::genDatasetDif(correlation = "DPR")
    expect_equal(dim(result), c(28, 5))
})

test_that("genDatasetDif  dimension correct, default corr = HY", {
    result <- zFactor:::genDatasetDif(correlation = "HY")
    expect_equal(dim(result), c(28, 5))
})



