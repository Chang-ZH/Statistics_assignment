library(XLConnect)

anova.1w <- function(x1, x2, ...){
	z <- list(x1, x2, ...)
	n_total <- length(z)
	for(i in 1:n_total){
		z[[i]] <- z[[i]][!is.na(z[[i]])]
	}
	df_t <- n_total - 1

	df_e <- 0
	for(i in 1:n_total){
		v <- z[[i]]
		temp <- length(v)
		df_e <- df_e + temp
	}
	df_e <- df_e - n_total

	sum_total <- 0
	for(i in 1:length(z)){
		v <- z[[i]]
		temp <- sum(v)
		sum_total <- sum_total + temp 
	}

	grand_mean <- sum_total / (df_e + n_total)

	treatment_mean <- vector("numeric", n_total)
	for(i in 1:n_total){
		treatment_mean[i] <- mean(z[[i]])
	}

	treatment_n <- vector("numeric", n_total)
	for(i in 1:n_total){
		treatment_n[i] <- length(z[[i]])
	}
	sst <- 0
	for(i in 1:n_total){
		#use each z[[i]][j] fail
		temp <- treatment_n[i] * (treatment_mean[i] - grand_mean)^2
		sst <- sst + temp
	}
	mst <- sst / df_t

	sse <- 0
	for(i in 1:n_total){
		var <- var(z[[i]])
		temp <- (treatment_n[i] - 1) * var
		sse <- sse + temp
	}
	mse <- sse / df_e

	fvalue <- mst / mse
	pvalue <- 1 - pf(fvalue, df_t, df_e) 

	ans <- list(sst = sst, df_t = df_t, mst = mst, sse = sse, df_e = df_e, mse = mse, fvalue = fvalue, pvalue = pvalue)
	#return(ans)

	#14.47
	t <- qt(1 - 0.083, 77)
	# why can't i use "nrow"?
	n1 <- length(z[[1]])
	n2 <- length(z[[2]])
	n3 <- length(z[[3]])
	n4 <- length(z[[4]])
	#print(n1)
	#print(n2)
	print(treatment_mean[3] - treatment_mean[4])
	#a
	LSD <- t * (mse * ((1/n3) + (1/n4)))^0.5
	#b
	#print(length(z))
	#ng <- length(z) / (1/n1 + 1/n2 + 1/n3 + 1/n4)
	#print(ng)
	#qcv <- qtukey(1 - 0.05, 4, 77)
	#print(qcv)
	#omega <- qcv * sqrt(mse / ng)^0.5

	return(LSD)
}

#fileXls = "Xr14-09.xlsx"
#exc <- loadWorkbook(fileXls)
#df1 <- readWorksheet(exc, 1)
#head(df1)
#a <- anova.1w(df1[,1], df1[,2], df1[,3], df1[,4])
#print(a)

#fileXls = "Xr14-17.xlsx"
#exc <- loadWorkbook(fileXls)
#df1 <- readWorksheet(exc, 1)
#head(df1)
#b <- anova.1w(df1[,1], df1[,2], df1[,3])
#print(b)
#c <- anova.1w(df1[,4], df1[,5], df1[,6])
#print(c)


