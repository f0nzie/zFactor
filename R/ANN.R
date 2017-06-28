
# Minimum and Maximum values used in the neural network to normalize the input and output values.
Ppr_min = 0;
Ppr_max = 30;
Tpr_min = 1;
Tpr_max = 3;
Z_min = 0.25194;
Z_max = 2.66;


# Weights and Biases for the 1st layer of neurons
wb1_10 =	rbind(
                    c(2.2458,	-2.2493,	-3.7801),
                    c(3.4663,	8.1167,		-14.9512),
                    c(5.0509,	-1.8244,	3.5017),
                    c(6.1185,	-0.2045,	0.3179),
                    c(1.3366,	4.9303,		2.2153),
                    c(-2.8652,	1.1679,		1.0218),
                    c(-6.5716,	-0.8414,	-8.1646),
                    c(-6.1061,	12.7945,	7.2201),
                    c(13.0884,	7.5387,		19.2231),
                    c(70.7187,	7.6138,		74.6949)
                    )

# Weights and Biases for the 2nd layer of neurons
wb2_10 <-	rbind(
    c(4.674,	1.4481,		-1.5131,	0.0461,		-0.1427,	2.5454,		-6.7991,	-0.5948,	-1.6361,	0.5801,		-3.0336),
    c(-6.7171,	-0.7737,	-5.6596,	2.975,	    14.6248,	2.7266,	    5.5043,	    -13.2659,	-0.7158,	3.076,	    15.9058),
    c(7.0753,	-3.0128,	-1.1779,	-6.445,	    -1.1517,	7.3248,	    24.7022,	-0.373,	    4.2665,	    -7.8302,	-3.1938),
    c(2.5847,	-12.1313,	21.3347,	1.2881,	    -0.2724,	-1.0393,	-19.1914,	-0.263,	    -3.2677,	-12.4085,	-10.2058),
    c(-19.8404,	4.8606,	    0.3891,	    -4.5608,	-0.9258,	-7.3852,	18.6507,	0.0403,	    -6.3956,	-0.9853,	13.5862),
    c(16.7482,	-3.8389,	-1.2688,	1.9843,	    -0.1401,	-8.9383,	-30.8856,	-1.5505,	-4.7172,	10.5566,	8.2966),
    c(2.4256,	2.1989,	    18.8572,	-14.5366,	11.64,	    -19.3502,	26.6786,	-8.9867,	-13.9055,	5.195,	    9.7723),
    c(-16.388,	12.1992,	-2.2401,	-4.0366,	-0.368,	    -6.9203,	-17.8283,	-0.0244,	9.3962,	    -1.7107,	-1.0572),
    c(14.6257,	7.5518,	    12.6715,	-12.7354,	10.6586,	-43.1601,	1.3387,	    -16.3876,	8.5277,	    45.9331,	-6.6981),
    c(-6.9243,	0.6229,	    1.6542,	    -0.6833,	1.3122,	    -5.588,	    -23.4508,	0.5679,	    1.7561,	    -3.1352,	5.8675)
    )


# Weights and Biases for the 3rd layer of neurons
wb3_10 <- c(-30.1311, 2.0902, -3.5296,	18.1108, -2.528, -0.7228, 0.0186, 5.3507, -0.1476, -5.0827, 3.9767)

n1_10 <- matrix(0, nrow = 11, ncol= 3) # input and output of the 1st layer in 2-10-10-1 network.	[,0] ==> inputs, [,1] ==> outputs
n2_10 <- matrix(0, nrow = 11, ncol= 3) # input and output of the 2nd layer in 2-10-10-1 network.	[,0] ==> inputs, [,1] ==> outputs

#' Artificial Neural Network correlation
#'
#' @param pres.pr pseudo-reduced pressure
#' @param temp.pr pseudo-reduced temperature
#' @rdname ANN
#' @export
# #' @importFrom rJava .jnew .jcall .jinit .jaddClassPath .jclassPath
z.Ann10 <- function(pres.pr, temp.pr, tolerance, verbose) {
    z.Ann10.r(pres.pr, temp.pr)
}



z.Ann10.r <- function(pres.pr, temp.pr) {
    mx <- sapply(pres.pr, function(x) sapply(temp.pr, function(y)
        .z.Ann10.r(x, y) ))

    if (length(pres.pr) > 1 || length(temp.pr) > 1) {
        colnames(mx) <- pres.pr
        rownames(mx) <- temp.pr
    }
    mx
}



.z.Ann10.r <- function(pres.pr, temp.pr) {

    Ppr <- pres.pr; Tpr <- temp.pr
    Ppr_n = 2.0 / (Ppr_max - Ppr_min) * (Ppr - Ppr_min) - 1.0
    Tpr_n = 2.0 / (Tpr_max - Tpr_min) * (Tpr - Tpr_min) - 1.0

    for (i in 1:10)  {
        n1_10[i, 1] <-  Ppr_n * wb1_10[i, 1] + Tpr_n * wb1_10[i, 2] + wb1_10[i, 3]
        n1_10[i, 2] <-  logSig(n1_10[i, 1]);
    }
    for (i in 1:10)  {
        n2_10[i, 1]  <-  0;
        for (j  in 1:nrow(n2_10)) {
            # cat(i, j, n2_10[i,j], "\n")
            n2_10[i, 1]  <-  n2_10[i, 1] + n1_10[j, 2] * wb2_10[i, j]
        }
        n2_10[i, 1] <-  n2_10[i, 1] + wb2_10[i, 11];	#  //adding the bias value
        n2_10[i, 2] <- logSig(n2_10[i, 1])
    }
    z_n = 0;
    for (j in 1:nrow(n2_10))
        z_n <-  z_n + n2_10[j, 2] * wb3_10[j]
    z_n  <-  z_n + wb3_10[11]	# adding the bias value

    zAnn10 <-  (z_n + 1) * (Z_max - Z_min) / 2 + Z_min; # reverse normalization of normalized z factor.
    return(zAnn10)

}


logSig <- function(x) {
    return(1 / (1 + exp(-1 * x)))
}












