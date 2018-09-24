mysample <- function(n, size){
	if(size > n){
		size <- n
	}

	num <- c(1:n)
	random_uni_num <- runif(n)

	ordered_num <- data.frame(
		num <- num,
		random_uni_num <- random_uni_num
	)

	# sort by the col of random values
	random_num <- ordered_num[order(random_uni_num),]
	random_num #test
	random_sample <- random_num$num[1:size]
	random_sample
}

#mysample(10, 12) ##test

