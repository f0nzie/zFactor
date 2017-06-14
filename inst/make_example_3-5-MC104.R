# make data table for Example 3-4
ex34 <- data.frame(component = c("N2", "O2", "Ar"),
                   component_name = c("Nitrogen", "Oxygen", "Argon"),
                   mole_fraction = c(0.78, 0.21, 0.01),
                   molecular_weight = c(28.01, 32.0, 39.94)
)


# make data table for Example 3-5
ex35 <- data.frame(component = c("C1", "C2", "C3", "n-C4"),
                   component_name = c("Methane", "Ethane", "Propane", "n-Butane"),
                 mole_fraction = c(0.85, 0.090, 0.040, 0.020),
                 molecular_weight = c(16.04, 30.07, 44.10, 58.12))
ex35

# McCain Chapter 3
save(ex34, ex35, file = "./data/mc-ch3.rda")

