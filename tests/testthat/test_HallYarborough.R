library(testthat)
context("test z.HallYarborough")
# test only one point at Ppr=0.5 and Tpr = 1.3

expect_equal(z.HallYarborough(0.5, 1.3), 0.9176300, tolerance = 1E-7)


# test DAK with  using the values from paper
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
tpr <- c(1.3, 1.5, 1.7, 2)

test_that("test DAK with  using the values from paper", {
    tbl <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.HallYarborough(pres.pr = x, temp.pr = y)))

    rownames(tbl) <- tpr
    colnames(tbl) <- ppr
    # print(tbl)
    # HY74 <- tbl; save(HY74, file = "hy74.rda")
    load(file = "hy74.rda");     expect_equal(tbl, HY74)
})

