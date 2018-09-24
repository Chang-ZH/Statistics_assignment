mycfint <- function(sample, alpha = 0.05, psigma = 0){
	#if(!alpha & !psigma){
	#	alpha <- 0.05
	#	psigma <- 0
	#}
	#if(!alpha & psigma){
	#	alpha <- 0.05
	#}
	#if(alpha & !psigma){
	#	psigma <- 0
	#}
	if((psigma < 0) | (alpha <= 0) | (alpha >= 1)){
		return(NULL)
	}else{
		n <- length(sample)
		mean_x <- mean(sample)
		if(psigma == 0){
			psigma <- sd(sample)
		}
		half_alpha_x <- qnorm(1 - (alpha / 2))

		lcl <- mean_x - (half_alpha_x * (psigma / sqrt(n)))
		ucl <- mean_x + (half_alpha_x * (psigma / sqrt(n)))
		cfint <- c(lcl, ucl)
		return(cfint)
	}
}

#test <- c(1:10)
#print(mycfint(test, 0.01, 5))

#x <- 80
#ten_ele <- rep(x, times = 25)
#print(mycfint(ten_ele, 0.05, 5))

#ten_twosev <- c(180, 130, 150, 165, 90, 130, 120, 60, 200, 180, 80, 240, 210, 150, 125)
#print(mean(ten_twosev))
#print(mycfint(ten_twosev, 0.05, 40))


