#library(XLConnect)
#fileXls = "hw2ds1.xlsx"
#exc <- loadWorkbook(fileXls)
#df1 <- readWorksheet(exc, 1)
#head(df1)
#
#x1 <- df1[, 1]
#x2 <- df1[, 2]

#set.seed(5552)
#cwdata = df1[, 1:2]
#swdata = df1[, 3:4]
#ind1 = sample(nrow(cwdata), size = 100, replace = TRUE)
#cwdata = cwdata[ind1,]
#ind2 = sample(nrow(swdata), size = 100, replace = TRUE)
#swdata = swdata[ind2,]

my.ftest <- function(x1, x2, alternative){

	if(alternative != "greater" && alternative != "less" && alternative != "two.side"){
		return(NULL)
	}else{

		x1 <- x1[!is.na(x1)]
		x2 <- x2[!is.na(x2)]

		#f_result <- FALSE

		n1 <- length(x1)
		mean1 <- mean(x1)
		var1 <- var(x1)
	
		n2 <- length(x2)
		mean2 <- mean(x2)
		var2 <- var(x2)
			
		fvalue <- var1 / var2

		if(alternative == "greater"){
			#ucl <- qf(1 - 0.025, n_cwc - 1, n_swc - 1)
			#lcl <- qf(0.025, n_cwc - 1, n_swc - 1)
			#check whether the var are equal
			#if((fvalue < ucl_consumed) & (fvalue > lcl_consumed)){
			#	f_result <- TRUE
			#}
			pvalue <- 1 - pf(fvalue, n1 - 1, n2 - 1)
		}
		else if(alternative == "less"){
			pvalue <- pf(fvalue, n1 - 1, n2 - 1)
		
		}
		else if(alternative == "two.side"){
			if(fvalue > 0)
				pvalue <- (1 - pf(fvalue, n1 - 1, n2 - 1)) *2
			else
				pvalue <- pf(fvalue, n1 - 1, n2 - 1) *2
		}
		
		ans <- list(fvalue = fvalue, pvalue = pvalue, n1 = n1, n2 = n2)
		return(ans)
	}
}

#f1 <- my.ftest(x1, x2, "greater")
#print(f1)
#f2 <- my.ftest(x1, x2, "less")
#print(f2)
#f3 <- my.ftest(x1, x2, "two.side")
#print(f3)
#f4 <- my.ftest(x1, x2, "test")
#print(f4)

