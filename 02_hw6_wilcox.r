#library(XLConnect)
#fileXls = "Xr19-15.xlsx"
#exc <- loadWorkbook(fileXls)
#df1 <- readWorksheet(exc, 1)
#head(df1)

my.wilcox <- function(data1, data2, alternative){
	data1 <- data1[!is.na(data1)]
	data2 <- data2[!is.na(data2)]

	n1 <- length(data1)
	n2 <- length(data2)

	data_all <- c(data1, data2)
	data_all_sorted <- sort(data_all)
	ranked_df <- data.frame(raw = data_all_sorted, rank = 1:length(data_all_sorted))
	# 以組別代號code為分組標的進行分組
	avg_rank <- aggregate(ranked_df, by = list(ranked_df$raw), FUN = mean)
	samp1 <- data.frame(raw = data1)
	samp1 <- merge(samp1, avg_rank)
	t <- sum(samp1$rank)

	et <- n1 * (n1 + n2 + 1) / 2
	sigma_t <- sqrt(n1 * n2 * (n1 + n2 + 1) / 12)
	z_value <- (t- et) / sigma_t

	if(alternative != "greater" && alternative != "less" && alternative != "two.sided"){
		return(NULL)	
	}else{
		if(alternative == "greater"){
			p_value <- 1 - pnorm(z_value)
		}
		else if(alternative == "less"){
			p_value <-  pnorm(z_value)
		
		}
		else if(alternative == "two.sided"){
			if(z_value < 0){
				p_value <- pnorm(z_value) * 2
			}else{
				p_value <- (1 - pnorm(z_value)) * 2
			}
		}

		ans <- list(T = t, ET = et, SigmaT = sigma_t, n1 = n1, n2 = n2, z = z_value, pvalue = p_value)
		return(ans)
		#return(samp1)
	}
}

#data1 <- df1[, 1]
#data2 <- df1[, 2]
#out <- my.wilcox(data2, data1, "greater")
#print(out)

