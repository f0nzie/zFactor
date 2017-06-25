library(testthat)
library(zFactor)

context("test Artificial Neural Networks ANN10")

expect_equal(z.Ann10(pres.pr = 1.5, temp.pr = 2.0), 0.9572277, tolerance = 1e-7)
