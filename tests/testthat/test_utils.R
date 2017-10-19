library(testthat)

# context("utils")
#
# test_that("get_z_correlations return short", {
#     short = c("BB",  "HY",  "DAK", "DPR", "SH",  "N10", "PP")
#     expect_equal(get_z_correlations(how = "short"), short)
#     # test default
#     expect_equal(get_z_correlations(), short)
# })
#
#
# test_that("get_z_correlations return long", {
#     long <- c("Beggs-Brill", "Hall-Yarborough",  "Dranchuk-AbuKassem" ,
#               "Dranchuk-Purvis-Robinson", "Shell", "Ann10",  "Papp")
#     expect_equal(get_z_correlations(how = "long"), long)
#     # print(get_z_correlations(how = "long"))
# })
#
# test_that("get_z_correlations return function", {
#     function.names <- c("z.BeggsBrill", "z.HallYarborough", "z.DranchukAbuKassem",
#                         "z.DranchukPurvisRobinson", "z.Shell", "z.Ann10", "z.Papp")
#     expect_equal(get_z_correlations(how = "function"), function.names)
#     # print(get_z_correlations(how = "function"))
# })
#
# test_that("get_z_correlations return wrong parameter", {
#     expect_error(get_z_correlations("wrong"))
# })
#
#
#
# context("convertStringToVector")
#
# test_that("convertStringToVector with numeric string", {
#     str <- "1.2 1.3 1.4 1.5"
#     expected <- "c(1.2, 1.3, 1.4, 1.5)"
#     expect_equal(convertStringToVector(str), expected)
# })
#
# test_that("convertStringToVector with alphabetic string", {
#     str = c("BB HY DAK DPR  SH  N10   PP")
#     expected <- "c(BB, HY, DAK, DPR, SH, N10, PP)"
#     expect_equal(convertStringToVector(str), expected)
# })
#
# test_that("convertStringToVector with alphanumeric string", {
#     str = c("BB 1.2 1.0 DPR  SH  N10   PP")
#     expected <- "c(NA, 1.2, 1, NA, NA, NA, NA)"
#     expect_equal(convertStringToVector(str), expected)
# })




context("createTidyFromMatrix")

test_that("createTidyFromMatrix", {
    ppr <- c(0.5, 1.5, 2.5, 3.5)
    tpr <- c(1.05, 1.1, 1.2)
    result <- createTidyFromMatrix(ppr, tpr, "HY")
    expect_is(result, "data.frame")
    expect_equal(dim(result), c(12, 5))
    expect_equal(names(result), c("Tpr", "Ppr", "z.chart", "z.calc", "dif" ))

})

test_that("createTidyFromMatrix if ppr has one element", {
    ppr <- c(0.5)
    tpr <- c(1.05, 1.1, 1.2)
    result <- createTidyFromMatrix(ppr, tpr, "HY")
    expect_equal(dim(result), c(3, 5))

})

test_that("createTidyFromMatrix if tpr has one element", {
    ppr <- c(0.5, 1.5, 2.5, 3.5)
    tpr <- c(1.05)
    result <- createTidyFromMatrix(ppr, tpr, "HY")
    expect_equal(dim(result), c(4, 5))
})

test_that("createTidyFromMatrix if correlation not provided", {
    ppr <- c(0.5, 1.5, 2.5, 3.5)
    tpr <- c(1.05)
    # result <- createTidyFromMatrix(ppr, tpr)
    # expect_equal(dim(result), c(4, 5))
    # print(result)
    expected <- "You have to provide a z-factor correlation:  BB HY DAK DPR SH N10 PP"
    expect_error(createTidyFromMatrix(ppr, tpr), expected)
})

test_that("createTidyFromMatrix if correlation not provided", {
    ppr <- c(0.5, 1.5, 2.5, 3.5)
    tpr <- c(1.05)
    expected <- "Not a valid correlation."
    expect_error(createTidyFromMatrix(ppr, tpr, "XYZ"), expected)
})

