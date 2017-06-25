// package zFactor;

/**
 * This code calculates compressibility factor (z-factor) for natural hydrocarbon gases
 * with 3 different methods. It is the outcomes of the following paper:
 * <br>
 * Kamyab, M.; Sampaio Jr., J. H. B.; Qanbari, F. & Eustes III, A. W.
 * Using artificial neural networks to estimate the Z-Factor for natural hydrocarbon gases
 * Journal of Petroleum Science and Engineering, 2010, 73, 248-257
 * <br>
 * The original paper can be found <a href="http://www.sciencedirect.com/science/article/pii/S0920410510001427">here</a>.
 * <p>
 * Artificial Neural Network (ANN)has been applied and two accurate non-iterative methods are presented.
 * The Dranchuk and Abou-Kassem equation of state model, which is an iterative method, is
 * also presented here for comparison. All the methods are:
 * <ul>
 * 		<li> {@link ANN10}: this method is the most accurate ANN method that presented in the paper.
 * 		<li> {@link ANN5}: this method is the next accurate ANN method that presented in the paper.
 * 		<li> {@link DAK}: this is the Dranchuk and Abou-Kassem equation of state.
 * </ul>
 *
 * @author  <a href="mailto:m@kamyab.co">Mohammadreza Kamyab</a>
 * @author  <a href="mailto:jrgsampaio@gmail.com">Jorge H.B. Sampaio Jr.</a>
 */
class CalculateZFactor {
	//Minimum and Maximum values used in the neural network to normalize the input and output values.
	private final static double Ppr_min = 0;
	private final static double Ppr_max = 30;
	private final static double Tpr_min = 1;
	private final static double Tpr_max = 3;
	private final static double Z_min = 0.25194;
	private final static double Z_max = 2.66;

	/**
	 * The is the structural elements of the Network 2-5-5-1
	 */
	//Weights and Biases for the 1st layer of neurons
	private static double[][] wb1_5 =	{{-1.5949,	7.9284,		7.2925},
										{-1.7917,	1.2117,		2.221},
										{5.3547,	-4.5424,	-0.9846},
										{4.6209,	2.2228,		8.9966},
										{-2.3577,	-0.1499,	-1.5063}};


	//Weights and Biases for the 2nd layer of neurons
	private static double[][] wb2_5 =	{{2.3617,	-4.0858,	1.2062,		-1.1518,	-1.2915,	2.0626},
										{10.0141,	9.8649,		-11.4445,	-123.0698,	7.5898,	    95.1393},
										{10.4103,	14.1358,	-10.9061,	-125.5468,	6.3448,	    93.8916},
										{-1.7794,	14.0742,	-1.4195,	12.0894,	-15.4537,	-9.9439},
										{-0.5988,	-0.4354,	-0.336, 	9.9429,		-0.4029,	-8.3371}};


	//Weights and Biases for the 3rd layer of neurons
	private static double[] wb3_5 =	{1.4979,	-37.466,	37.7958,	-7.7463,	6.9079,		2.8462 };
	//-------------END OF NETWORK 2-5-5-1 STRUCTURE------------------------------------------------------------------------

	/**
	 * The is the structural elements of the Network 2-10-10-1
	 */
	//Weights and Biases for the 1st layer of neurons
	private static double[][] wb1_10 =	{{2.2458,	-2.2493,	-3.7801},
										{3.4663,	8.1167,		-14.9512},
										{5.0509,	-1.8244,	3.5017},
										{6.1185,	-0.2045,	0.3179},
										{1.3366,	4.9303,		2.2153},
										{-2.8652,	1.1679,		1.0218},
										{-6.5716,	-0.8414,	-8.1646},
										{-6.1061,	12.7945,	7.2201},
										{13.0884,	7.5387,		19.2231},
										{70.7187,	7.6138,		74.6949}};


	//Weights and Biases for the 2nd layer of neurons
	private static double[][] wb2_10 =		{{4.674,	1.4481,		-1.5131,	0.0461,		-0.1427,	2.5454,		-6.7991,	-0.5948,	-1.6361,	0.5801,		-3.0336},
											{-6.7171,	-0.7737,	-5.6596,	2.975,	    14.6248,	2.7266,	    5.5043,	    -13.2659,	-0.7158,	3.076,	    15.9058},
											{7.0753,	-3.0128,	-1.1779,	-6.445,	    -1.1517,	7.3248,	    24.7022,	-0.373,	    4.2665,	    -7.8302,	-3.1938},
											{2.5847,	-12.1313,	21.3347,	1.2881,	    -0.2724,	-1.0393,	-19.1914,	-0.263,	    -3.2677,	-12.4085,	-10.2058},
											{-19.8404,	4.8606,	    0.3891,	    -4.5608,	-0.9258,	-7.3852,	18.6507,	0.0403,	    -6.3956,	-0.9853,	13.5862},
											{16.7482,	-3.8389,	-1.2688,	1.9843,	    -0.1401,	-8.9383,	-30.8856,	-1.5505,	-4.7172,	10.5566,	8.2966},
											{2.4256,	2.1989,	    18.8572,	-14.5366,	11.64,	    -19.3502,	26.6786,	-8.9867,	-13.9055,	5.195,	    9.7723},
											{-16.388,	12.1992,	-2.2401,	-4.0366,	-0.368,	    -6.9203,	-17.8283,	-0.0244,	9.3962,	    -1.7107,	-1.0572},
											{14.6257,	7.5518,	    12.6715,	-12.7354,	10.6586,	-43.1601,	1.3387,	    -16.3876,	8.5277,	    45.9331,	-6.6981},
											{-6.9243,	0.6229,	    1.6542,	    -0.6833,	1.3122,	    -5.588,	    -23.4508,	0.5679,	    1.7561,	    -3.1352,	5.8675}};


	//Weights and Biases for the 3rd layer of neurons
	private static double[] wb3_10 =		{-30.1311, 2.0902,		-3.5296,	18.1108,	-2.528,		-0.7228,	0.0186,		5.3507,		-0.1476,	-5.0827,	3.9767 };
	//-------------END OF NETWORK 2-10-10-1 STRUCTURE------------------------------------------------------------------------

	private static double[][] n1_5 = new double[5][2];      //input and output of the 1st layer in 2-5-5-1 network.	[,0] ==> inputs, [,1] ==> outputs
	private static double[][] n2_5 = new double[5][2];      //input and output of the 2nd layer in 2-5-5-1 network.	[,0] ==> inputs, [,1] ==> outputs
	private static double[][] n1_10 = new double[10][2];    //input and output of the 1st layer in 2-10-10-1 network.	[,0] ==> inputs, [,1] ==> outputs
	private static double[][] n2_10 = new double[10][2];    //input and output of the 2nd layer in 2-10-10-1 network.	[,0] ==> inputs, [,1] ==> outputs

	private final static double TOLERANCE = 0.0001;     //tolerance of DAK
	private final static int MAX_NO_Iterations = 20;    //Max number of iterations for DAK

	private static double Ppr_n;   //normalized Ppr - is used in ANN
	private static double Tpr_n;   //normalized Tpr - is used in ANN
	private static double z_n;     //normalized z   - is used in ANN
	//-------------------------------------------------------------------------------------------------------------------------


	/**
	 * This method calculates the z-factor using a 2x10x10x1 Artificial Neural Network
	 * based on training data obtained from Standing-Katz and Katz charts.
	 * It always produces a result, but accuracy is controlled for {@code 0<Ppr<30} and {@code 1<Tpr<3}
	 *
	 * @param Ppr pseudo-reduced pressure
	 * @param Tpr pseudo-reduced temperature
	 * @return z factor
	 */
	public static double ANN10(double Ppr, double Tpr)
	{
        Ppr_n = 2.0 / (Ppr_max - Ppr_min) * (Ppr - Ppr_min) - 1.0;
        Tpr_n = 2.0 / (Tpr_max - Tpr_min) * (Tpr - Tpr_min) - 1.0;

        for (int i = 0; i < 10; i++)
        {
            n1_10[i][0] = Ppr_n * wb1_10[i][0] + Tpr_n * wb1_10[i][1] + wb1_10[i][2];
            n1_10[i][1] = logSig(n1_10[i][0]);
        }

        for (int i = 0; i < 10; i++)
        {
        	n2_10[i][0] = 0;
        	for (int j = 0; j < n2_10.length; j++)
        		n2_10[i][0] += n1_10[j][1] * wb2_10[i][j];
        	n2_10[i][0] += wb2_10[i][10];	//adding the bias value

        	n2_10[i][1] = logSig(n2_10[i][0]);
        }

        z_n = 0;
        for (int j = 0; j < n2_10.length; j++)
        	z_n += n2_10[j][1] * wb3_10[j];
        z_n += wb3_10[10];	//adding the bias value

        double zAnn10 = (z_n + 1) * (Z_max - Z_min) / 2 + Z_min;  //reverse normalization of normalized z factor.

        return zAnn10;
	}

	/**
	 * This method calculates the z-factor using a 2x5x5x1 Artificial Neural Network
	 * based on training data obtained from Standing-Katz and Katz charts.
	 * It always produces a result, but accuracy is controlled for {@code 0<Ppr<30} and {@code 1<Tpr<3}
	 *
	 * @param Ppr pseudo-reduced pressure
	 * @param Tpr pseudo-reduced temperature
	 * @return z factor
	 */
	public static double ANN5(double Ppr, double Tpr)
	{
        Ppr_n = 2.0 / (Ppr_max - Ppr_min) * (Ppr - Ppr_min) - 1.0;
        Tpr_n = 2.0 / (Tpr_max - Tpr_min) * (Tpr - Tpr_min) - 1.0;

        for (int i = 0; i < 5; i++)
        {
            n1_5[i][0] = Ppr_n * wb1_5[i][0] + Tpr_n * wb1_5[i][1] + wb1_5[i][2];
            n1_5[i][1] = logSig(n1_5[i][0]);
        }

        for (int i = 0; i < 5; i++)
        {
        	n2_5[i][0] = 0;
        	for (int j = 0; j < n2_5.length; j++)
        		n2_5[i][0] += n1_5[j][1] * wb2_5[i][j];
        	n2_5[i][0] += wb2_5[i][5];	//adding the bias value

        	n2_5[i][1] = logSig(n2_5[i][0]);
        }

        z_n = 0;
        for (int j = 0; j < n2_5.length; j++)
        	z_n += n2_5[j][1] * wb3_5[j];
        z_n += wb3_5[5];	//adding the bias value

        double zAnn5 = (z_n + 1) * (Z_max - Z_min) / 2 + Z_min;  //reverse normalization of normalized z factor.

        return zAnn5;
	}

	/**
	 * This method calculates the z-factor using Dranchuk and Abou-Kassem (DAK) method.
	 *
	 * @param Ppr	pseudo-reduced pressure
	 * @param Tpr	pseudo-reduced temperature
	 * @return		z factor
	 */
	public static double DAK(double Ppr, double Tpr)
	{
		double zDAK, z_old, z_new;
		double den;

	    double A1 = 0.3265,
	    	   A2 = -1.07,
	    	   A3 = -0.5339,
	    	   A4 = 0.01569,
	    	   A5 = -0.05165,
	    	   A6 = 0.5475,
	    	   A7 = -0.7361,
	    	   A8 = 0.1844,
	    	   A9 = 0.1056,
	    	   A10 = 0.6134,
	    	   A11 = 0.721;

	    z_new = z_old = 1.0;
	    den = calculateDensity(Ppr, Tpr, z_old);

	    for (int i = 1; i <= MAX_NO_Iterations; i++){
	    	z_old = z_new;

	        z_new = 1 +
	                (A1 + A2 / Tpr + A3 / Math.pow(Tpr, 3) + A4 / Math.pow(Tpr, 4) + A5 / Math.pow(Tpr, 5)) * den +
	                (A6 + A7 / Tpr + A8 / Math.pow(Tpr, 2)) * Math.pow(den, 2) -
	                A9 * (A7 / Tpr + A8 / Math.pow(Tpr, 2)) * Math.pow(den, 5) +
	                A10 * (1 + A11 * Math.pow(den, 2)) * Math.pow(den, 2) / Math.pow(Tpr, 3) * Math.exp(-1 * A11 * Math.pow(den, 2));

	        den = calculateDensity(Ppr, Tpr, z_new);

	        if (Math.abs(z_new - z_old) < TOLERANCE){
	        	break;
	        }
	    }

	    zDAK = z_new;

		return zDAK;
	}


	private static double logSig(double x) {
		return 1 / (1 + Math.exp(-1 * x));
	}

	private static double calculateDensity(double pr, double tr, double z){
		return 0.27 * pr / tr / z;
	}
}