library(testthat)

# function is using suppressWarnings() to
# prevent warning message:  introducing NAs by coercion. See:
# https://stackoverflow.com/a/14985152/5270873

context("utils.R - convertStringToVector")

test_that("convertStringToVector with numeric string", {
    str <- "1.2 1.3 1.4 1.5"
    expected <- "c(1.2, 1.3, 1.4, 1.5)"
    expect_equal(convertStringToVector(str), expected)
})

test_that("convertStringToVector with alphabetic string", {
    str = c("BB HY DAK DPR  SH  N10   PP")
    expected <- "c(BB, HY, DAK, DPR, SH, N10, PP)"
    expect_equal(convertStringToVector(str), expected)
})

test_that("convertStringToVector with alphanumeric string", {
    str = c("BB 1.2 1.0 DPR  SH  N10   PP")
    expected <- "c(NA, 1.2, 1, NA, NA, NA, NA)"
    expect_equal(convertStringToVector(str), expected)
})
