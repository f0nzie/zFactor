library(testthat)
context("test z.DranchukAbuKassem")

test_that("only one point at Ppr=0.5 and Tpr = 1.3 matches", {
    expect_equal(z.DranchukAbuKassem(0.5, 1.3), 0.9203019)
})



# test using common values
ppr <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5)
tpr <- c(1.3, 1.5, 1.7, 2)

test_that("test DAK between 7 Ppr values and 4 Tpr", {
    tbl <- sapply(ppr, function(x)
        sapply(tpr, function(y) z.DranchukAbuKassem(pres.pr = x, temp.pr = y)))

    rownames(tbl) <- tpr
    colnames(tbl) <- ppr
    # print(tbl)
    # DAK74 <- tbl
    # save(DAK74, file = "dak74.rda")
    load(file = "dak74.rda")
    expect_equal(tbl, DAK74)
})

