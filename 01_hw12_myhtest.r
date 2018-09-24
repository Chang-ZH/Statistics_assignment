#set.seed(102)
#data1 <- rnorm(100)

myhtest <- function(sample, h0mean, htype, alpha = 0.05, psigma = 0){
    if((psigma < 0) | (alpha <= 0) | (alpha >= 1) | ((htype != "twotail") & htype != "lefttail") & (htype != "righttail")){
	return(NULL)
	}
	else{
		n <- length(sample)
		samp_mean <- mean(sample)
		test_result <- TRUE

		if(psigma == 0){
			psigma <- sd(sample)
		}

		z_value <- (samp_mean - h0mean) / (psigma / sqrt(n))
		if(htype == "twotail"){
			alpha_x <- qnorm(1 - (alpha / 2))
			lcl <- h0mean - (alpha_x * (psigma / sqrt(n)))
			ucl <- h0mean + (alpha_x * (psigma / sqrt(n)))
			if((samp_mean < ucl) & (samp_mean > lcl)){
				test_result <- FALSE
			}

			if(z_value < 0)
				p_value <- 2 * pnorm(z_value)
			else
				p_value <- 2 * (1 - pnorm(z_value))
		}

		else if(htype == "lefttail"){
			alpha_x <- qnorm(1 - alpha)
			lcl <- h0mean - (alpha_x * (psigma / sqrt(n)))
			if(samp_mean > lcl){
				test_result <- FALSE
			}
			p_value <- pnorm(z_value)
		}

		else if(htype == "righttail"){
			alpha_x <- qnorm(1 - alpha)
			ucl <- h0mean + (alpha_x * (psigma / sqrt(n)))
			if(samp_mean < ucl){
				test_result <- FALSE
			}
			p_value <- 1 - pnorm(z_value)
		}
	}

	htest <- c(p_value, z_value, test_result)
	return(htest)
}

#ret1 <- myhtest(data1, 0.3, "twotail")
#print(ret1)
#ret2 <- myhtest(data1, 0.3, "lefttail")
#print(ret2)
#ret3 <- myhtest(data1, 0.3, "righttail")
#print(ret3)
#ret4 <- myhtest(data1, 0.3, "tail")
#print(ret4)
##11.11
data2 <- rep(80, 100)
ret11_11 <- myhtest(data2,70, "righttail", 0.01, 20)
print(ret11_11)


