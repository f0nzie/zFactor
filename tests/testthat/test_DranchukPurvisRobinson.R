library(testthat)
context("test z.DranchukPurvisRobinson")

# test only one point at Ppr=0.5 and Tpr = 1.3
# print(z.DranchukPurvisRobinson(0.5, 1.3))
expect_equal(z.DranchukPurvisRobinson(0.5, 1.3), 0.9197157, tolerance = 1E-7)



# test DAK with  using the values from paper
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
tpr <- c(1.3, 1.5, 1.7, 2)

test_that("test DAK with  using the values from paper", {
    tbl <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.DranchukPurvisRobinson(pres.pr = x, temp.pr = y)))

    rownames(tbl) <- tpr
    colnames(tbl) <- ppr
    # print(tbl)
    # DPR74 <- tbl; save(DPR74, file = "dpr74.rda")
    load(file = "dpr74.rda")
    expect_equal(tbl, DPR74)
})

