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







