#library(XLConnect)
#fileXls = "Xr14-81_adjust.xlsx"
#exc <- loadWorkbook(fileXls)
#df1 <- readWorksheet(exc, 1)
#head(df1)

anova.2w <- function(df1, a = 0.05){
	alpha <- a

	df_t <- ncol(df1) - 1
	df_b <- nrow(df1) - 1
	df_e <- (ncol(df1) - 1) * (nrow(df1) - 1)
	
	n_total <- ncol(df1) * nrow(df1)
	sum_total <- 0
	for(i in 1:ncol(df1)){
		temp <- sum(df1[[i]])
		sum_total <- sum_total + temp 
	}
	grand_mean <- sum_total / n_total

	treatment_mean <- vector("numeric", ncol(df1))
	for(i in 1:ncol(df1)){
		treatment_mean[i] <- mean(df1[[i]])
	}
	treatment_n <- nrow(df1)
	sst <- 0
	for(i in 1:ncol(df1)){
		temp <- treatment_n * (treatment_mean[i] - grand_mean)^2
		sst <- sst + temp
	}
	mst <- sst / df_t

	block_mean <- vector("numeric", nrow(df1))
	for(i in 1:nrow(df1)){
		# if it is a rows, must transfer to vector by "as.numeric"
		v <- as.numeric(df1[i,])
		block_mean[i] <- mean(v)
	}
	block_n <- ncol(df1)
	ssb <- 0
	for(i in 1:nrow(df1)){
		temp <- block_n * (block_mean[i] - grand_mean)^2
		ssb <- ssb + temp
	}
	msb <- ssb / df_b

	sse <- 0
	for(i in 1:nrow(df1)){
		for(j in 1:ncol(df1)){
			temp <- (df1[i, j] - treatment_mean[j] - block_mean[i] + grand_mean)^2
			sse <- sse + temp
		}
	}
	mse <- sse / df_e

	fvalue_t <- mst / mse
	fvalue_b <- msb / mse

	criticalV_t <- qf(1 - alpha, df_t, df_e)
	criticalV_b <- qf(1 - alpha, df_b, df_e)

	pvalue_t <- 1 - pf(fvalue_t, df_t, df_e) 
	pvalue_b <- 1 - pf(fvalue_b, df_b, df_e) 

	ans <- matrix( nrow = 3, ncol = 6, dimnames = list(c("Treatments", "Blocks", "Errors"), 
				c("SS", "df", "MS", "F", "pvalue", "F-crit")))
	ans[1, 1] <- sst
	ans[1, 2] <- df_t
	ans[1, 3] <- mst
	ans[1, 4] <- fvalue_t
	ans[1, 5] <-pvalue_t
	ans[1, 6] <- criticalV_t

	ans[2, 1] <- ssb
	ans[2, 2] <- df_b
	ans[2, 3] <- msb
	ans[2, 4] <- fvalue_b
	ans[2, 5] <-pvalue_b
	ans[2, 6] <- criticalV_b

	ans[3, 1] <- sse
	ans[3, 2] <- df_e
	ans[3, 3] <- mse

	return(ans)
}

#a <- anova.2w(df1)
#print(a)

