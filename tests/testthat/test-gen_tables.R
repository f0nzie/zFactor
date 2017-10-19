context("gen_tables")

test_that("SK.genDataset7p4t dimension correct", {
    result <- SK.genDataset7p4t()
    expect_equal(dim(result), c(4, 7))
})
