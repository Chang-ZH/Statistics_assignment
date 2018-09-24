#library(XLConnect)
#fileXls = "hw1ds1.xlsx"
#exc <- loadWorkbook(fileXls)
#df1 <- readWorksheet(exc, 1)
#head(df1)

#set.seed(5552)
#cwdata = df1[, 1:2]
#swdata = df1[, 3:4]
#ind1 = sample(nrow(cwdata), size = 100, replace = TRUE)
#cwdata = cwdata[ind1,]
#ind2 = sample(nrow(swdata), size = 100, replace = TRUE)
#swdata = swdata[ind2,]

fake_wine <- function(cw_consumed, cw_time, sw_consumed, sw_time){
	cw_consumed <- cw_consumed[!is.na(cw_consumed)]
	cw_time <- cw_time[!is.na(cw_time)]
	sw_consumed <- sw_consumed[!is.na(sw_consumed)]
	sw_time <- sw_time[!is.na(sw_time)]

	consumed_ftest <- FALSE
	time_ftest <- FALSE

	n_cwc <- length(cw_consumed)
	mean_cwc <- mean(cw_consumed)
	var_cwc <- var(cw_consumed)
	
	n_cwt <- length(cw_time)
	mean_cwt <- mean(cw_time)
	var_cwt <- var(cw_time)
	
	n_swc <- length(sw_consumed)
	mean_swc <- mean(sw_consumed)
	var_swc <- var(sw_consumed)
	
	n_swt <- length(sw_time)
	mean_swt <- mean(sw_time)
	var_swt <- var(sw_time)
	
	##a
	consumed_ftest_value <- var_cwc / var_swc
	ucl_consumed <- qf(1 - 0.025, n_cwc - 1, n_swc - 1)
	lcl_consumed <- qf(0.025, n_cwc - 1, n_swc - 1)
	#check whether the var are equal
	if((consumed_ftest_value < ucl_consumed) & (consumed_ftest_value > lcl_consumed)){
		consumed_ftest <- TRUE
	}
	#t test
	if(consumed_ftest == TRUE){
		mutual_var <- (var_cwc * (n_cwc - 1) + var_swc * (n_swc - 1)) / (n_cwc + n_swc - 2)
		df <- n_cwc + n_swc - 2
		t_test <- ((mean_cwc - mean_swc) - 0) / (mutual_var / n_cwc + mutual_var / n_swc)^0.5
		consumed_pvalue <- 1 - pt(t_test, df)
	}else{
		c <- var_cwc / n_cwc
		s <- var_swc / n_swc
		df <- (c + s)^2 / ((c^2 / (n_cwc - 1)) + (s^2 / (n_swc - 1)))
		t_test <- ((mean_cwc - mean_swc) - 0) / (var_cwc / n_cwc + var_swc / n_swc)^0.5
		consumed_pvalue <- 1 - pt(t_test, df)
	}

	##b
	time_ftest_value <- var_cwt / var_swt
	ucl_time <- qf(1 - 0.025, n_cwt - 1, n_swt - 1)
	lcl_time <- qf(0.025, n_cwt - 1, n_swt - 1)
	#check whether the var are equal
	if((time_ftest_value < ucl_time) & (time_ftest_value > lcl_time)){
		time_ftest <- TRUE
	}
	#t test
	if(time_ftest == TRUE){
		mutual_var <- (var_cwt * (n_cwt - 1) + var_swt * (n_swt - 1)) / (n_cwt + n_swt - 2)
		df <- n_cwt + n_swt - 2
		t_test <- ((mean_cwt - mean_swt) - 0) / (mutual_var / n_cwt + mutual_var / n_swt)^0.5
		time_pvalue <- 1 - pt(t_test, df)
	}else{
		c <- var_cwt / n_cwt
		s <- var_swt / n_swt
		df <- (c + s)^2 / ((c^2 / (n_cwt - 1)) + (s^2 / (n_swt - 1)))
		t_test <- ((mean_cwt - mean_swt) - 0) / (var_cwt / n_cwt + var_swt / n_swt)^0.5
		time_pvalue <- 1 - pt(t_test, df)
	}

	ans <- list(var_equal_a = consumed_ftest, var_equal_b = time_ftest, pvalue_a = consumed_pvalue, pvalue_b = time_pvalue)

	return(ans)
}

#out1 = fake_wine(df1[, 1], df1[, 2], df1[, 3], df1[, 4])
#out1 = fake_wine(cwdata[, 1], cwdata[, 2], swdata[, 1], swdata[, 2])
#print(out1)

