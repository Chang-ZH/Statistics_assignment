# Statistics_assignment #

1.   [Sampling](#01_hw09)
2.   [Confidence Interval](#01_hw11)
3.   [T-test](#01_hw12)
4.   [Case: Fake Wine](#02_hw01)
5.   [F-test](#02_hw02)
6.   [One-way ANOVA](#02_hw03)
7.   [Two-way ANOVA](#02_hw04)
8.   [Wilcoxon Rank Sum Test](#02_hw06)

<h2 id="01_hw09">Sampling</h2>

function `mysample()` performs random sample without replacement. R has a build-in sampling function named `sample()` that does the job. To help you better understand the sampling procedure and hone your R programming skill, we are going to develop a mysample() function from ground-up. This function takes two inputs:

- **n** is the size of the population.
- **size** is the number of records to be sampled.

The returning value of mysample is a list of **non-overlapping** integers between 1 to n. For example: 

    >mysample(10,3)
    [1] 2 5 1

The above example is to sample 3 records from a population of 10 records. The returning value is a list of 3 values: 2, 5, and 1\.

You should not use the existing sample() function. You should follow the following procedure to generate the output:

- Generate a list of n uniform random numbers. 
- Use the `order()` function to obtain the permutation that sort the list of random number in increasing order. 
- Return the top size index from the permutation in the previous step.

You should check whether size is larger than n. Set size to n in this case.

<h2 id="01_hw11">Confidence Interval</h2>

function `mycfint()` compute the confidence interval of an input sample. The function should take the following input parameters (in this order):

- **samp1** is a vector of sample. 
- **alpha** is the significant level with a default value of 0.05\.
- **psigma** is population standard deviation with a default value of 0\.

The function should output a vector of 2 elements. The first element is the **lower confidence limit (LCL)** and second element is the **upper confidence limit (UCL)**. That is, (LCL, UCL) = ![](http://latex.codecogs.com/gif.latex?%28%5Cbar%20x%20-%20z_%7B%5Calpha%20/%202%7D%5Cfrac%7B%5Csigma%7D%7B%5Csqrt%7Bn%7D%7D%2C%20%5Cbar%20x%20&plus;%20z_%7B%5Calpha%20/%202%7D%5Cfrac%7B%5Csigma%7D%7B%5Csqrt%7Bn%7D%7D%29).

If psigma is zero, use the sample standard deviation from samp1. If psigma is positive, set σ = psigma. <br>
The function should **return NULL** if one of the following conditions are met:

- psigma is negative.
- alpha is 0 or negative.
- alpha is 1 or larger than 1\.

Sample input and output:

    > avec =1:10
    >print(mycfint(avec))
    [1]3.6234777.376523
    >print(mycfint(avec, 0.1))
    [1]3.9251737.074827
    >print(mycfint(avec, 0.01, 5))
    [1]1.4272569.572744

<h2 id="01_hw12">T-test</h2>

function `myhtest()` perform hypothesis test on an input sample. The function should take the following input parameters (in this order):

- **samp1** is a vector of sample.
- **h0mean** is the mean of null hypothesis.
- **htype** should be one of the following: **lefttail**, **twotail**, **righttail**. 
- **alpha** is the significant level with a default value of 0.05\.
- **psigma** is population standard deviation with a default value of 0\.

The function should output a vector of 3 elements. The first element is the **p-value** of the test. The second element is the **z-value** of the test. The third element is either **TRUE or FALSE, indicating whether the null hypothesis is rejected**. <br>
If htype is lefttail, perform a left-tail test; if htype is twotail, perform a two-tail test; if htype is righttail, perform a righ-tail test. If htype is not one of the above three values, return NULL.

If psigma is zero, use the sample standard deviation from samp1. If psigma is positive, set σ = psigma.The function should return NULL if one of the following conditions are met:

- psigma is negative.
- alpha is 0 or negative.
- alpha is 1 or larger than 1\.

Sample input and output:

    > set.seed(102)
    > data1=rnorm(100)
    > ret1 = myhtest(data1, 0.3, "twotail")
    >cat("twotail test:\n")
    twotail test:
    >print(ret1)
    [1]0.07516368-1.779464260.00000000
    >
    > ret1 = myhtest(data1, 0.3, "lefttail")
    >cat("lefttail test:\n")
    lefttail test:
    >print(ret1)
    [1]0.03758184-1.779464261.00000000
    >
    > ret1 = myhtest(data1, 0.3, "righttail")
    >cat("righttail test:\n")
    righttail test:
    >print(ret1)
    [1]0.9624182-1.77946430.0000000
    
    >#NULL returned value
    > ret1 = myhtest(data1, 0.3, "tail")
    >print(ret1)
    NULL

<h2 id="02_hw01">Case: Fake Wine</h2>

Diners at a restaurant were informed on entering that they would be receiving a free glass of wine, which they were told as Cabernet Sauvignon. However, it was not. It was a cheap wine sold for $2 a bottle, popularly known as Two Buck Chuck. Half of the diners were told that the wine was from a new California winery. The other half of diners were informed that the wine they would receive was from a new South Dakota winery. The restaurant featured a fixed menu so that all diners had exactly the same meal. The goal of the experiment was to determine whether the perceived quality of the wine affected their dinning experiment. The amount of food consumed (measured as a percentage of the amount originally served that was consumed by the diner, so that 100 represents a diner who cleaned his or her plate) and the amount of time spent in the restaurant were recorded. The dataset hw1ds1.xlsx contains the data of this experiment.

We are interested in two questions: 

- Is there enough evidence to infer that diners **who believe they are drinking a fine wine (California wine) eat more** than diners who believe they are drinking an inferior wine. The data were recorded in the first and third column of the dataset (named Cal_W_Consumed and SD_W_Consumed).
- Can we conclude that diners **who believe they are drinking a fine wine (Californai wine) spend more time in the restaurant** than diners who believe they are drinking an inferior wine?

Write a function named `fake_wine()` to conduct hypothesis tests regarding the two questions listed above. This function should take four parameters: **cw_consumed**, **cw_time**, **sw_consumed**, and **sw_time**. These four parameters are vectors of data that represent the plate consumed with California wine, the plate consumed with South Dakoda wine, the time spent with California wine, the time spent with South Dakoda wine. Use 𝛼 = 0.05 for any statistical tests in this assignment.

You should first perform **equal-variance tests** to decide which version of t-tests to perform. Your function should return **a list that contains the following elements: var_equal_a, var_equal_b, pvalue_a, and pvalue_b**. These four elements should store whether the variance is equal for Question a and b, and the p-value for Question a and b. 

The following sample code is an example to generate such data structure:

    v1=TRUE 
    v2=FALSE 
    p1=0.03 
    p2=0.08 
    list1 = list(var_equal_a = v1, var_equal_b= v2, pvalue_a= p1, pvalue_b=p2)

Sample code:

    setwd('your_path_to_data')
    library(XLConnect)
    fileXls = "hw1ds1.xlsx"
    exc <- loadWorkbook(fileXls)
    df1 <- readWorksheet(exc,1)
    out1=fake_wine(df1[,1], df1[,2], df1[,3], df1[,4])
    print(out1)

Sample output:

    $var_equal_a
    [1] TRUE
    $var_equal_b
    [1] TRUE
    $pvalue_a
    [1] 0.04705716
    $pvalue_b
    [1] 0.0083043

<h2 id="02_hw02">F-test</h2>

F-Test is how we compare the variance of two populations. We are going to write a function named `my.ftest()` to perform this task. This function should take three parameters (in this order): x1, x2, and alternative:

- **x1**: a vector of sample from population 1 (may contain NAs).
- **x2**: a vector of sample from population 2 (may contain NAs).
- **alternative**: the alternative hypothesis to perform, could be **“greater”**, **“less”**, or **“two.sided”**

The my.ftest function should perform F-test and output a list of four components:

- **fvalue**: the F-statistics.
- **pvalue**: the p-value of F-statistics.
- **n1**: Number of observations in the sample from population 1 (excluding NAs, if any).
- **n2**: Number of observations in the sample from population 2 (excluding NAs, if any).

You should not use the built-in “var.test” function. Note that we allow x1 and x2 to contain NA, and my.ftest should check the existences of any NAs and perform necessary data cleaning before performing any subsequent analysis. Moreover, the function should return NULL if alternative is not one of three legal values.

Sample code: 

    setwd('your_path_to_data') 
    library(XLConnect) 
    fileXls = "hw2ds1.xlsx" 
    exc <- loadWorkbook(fileXls) 
    df1 <- readWorksheet(exc,1)
    cat("performing F-test:\n") 
    f1=my.ftest(df1[,1], df1[,2], "greater") 
    cat("h1=greater\n")
    print(f1)
    f2=my.ftest(df1[,1], df1[,2], "less") 
    cat("h1=less\n") print(f2)
    f3=my.ftest(df1[,1], df1[,2], "two.sided") 
    cat("h1=two.sided\n") print(f3)

Sample output:

    performing F-test:
    h1=greater
    $fvalue
    [1] 1.526058
    $pvalue
    [1] 0.0183164
    $n1
    [1] 100
    $n2
    [1] 100
    h1=less
    $fvalue
    [1] 1.526058
    $pvalue
    [1] 0.9816836
    $n1
    [1] 100
    $n2
    [1] 100
    h1=two.sided
    $fvalue
    [1] 1.526058
    $pvalue
    [1] 0.0366328
    $n1
    [1] 100
    $n2
    [1] 100

<h2 id="02_hw03">One-way ANOVA</h2>

We have learned about one-way ANOVA and how to perform one-way ANOVA in R. **The built-in aov function, however, assume the data is in the “long” format as oppose to the “wide” format that are usually presented in the text book.** In this assignment, you are going to write a function named `anova.1w()` to perform one-way ANOVA that takes input data in a wide format. However, since we are not sure about the number of treatments that is going to have, we need to allow for unspecific number of parameters. That is, anova.1w should be defined as something like:

    anova.1w = function(x1, x2, ...) {
      …your code… 
    }

That is, anova.1w takes two or more parameters. The first two parameters, x1, and x2 are two vectors that contain data from the first and second treatments. Additional data can be passed with additional vector, and will be captured by “...”. You will be able to obtain the additional vectors by casting “…” to a list. The following is an example of how this can be achieved:

    anova.1w = function(x1, x2, ...) { 
      z=list(...) 
      print(z)
    }
    anova.1w(c(1,2,3), c(2,3,4), c(3,4,5), c(4,5,6,6,7))

The output is:

    [[1]]
    [1] 3 4 5
    [[2]]
    [1] 4 5 6 6 7

As can be seen in the above example, we passed four vectors to anova.1w, and the last two vectors were captured by “…,” which can be converted by a list.<br>
Your anova.1w function should return a list that contains the following elements:

- **sst**: sum of squares for treatments.
- **df_t**: degree of freedom for treatments.
- **mst**: mean square for treatment.
- **sse**: sum of squares for errors.
- **df_e**: degree of freedom for errors.
- **mse**: mean square for error.
- **fvalue**: the value of F-test statistics.
- **pvalue**: the p-value of the F-test statistics.

You should implement anova.1w from scratch by following the steps we discussed in class. You should not use the built-in “aov” function. Note that we allow x1, x2, and other input vectors to contain NA, and anova.1w should check the existences of any NAs and perform necessary data cleaning before performing any subsequent analysis.

Sample code:

    setwd('your_data_folder') 
    library(XLConnect) 
    fileXls = "dshw3.xlsx" 
    exc <- loadWorkbook(fileXls) 
    df1 <- readWorksheet(exc,1) 
    ret1=anova.1w(df1[,1], df1[,2], df1[,3]) 
    cat("Reading score:\n") 
    print(ret1) 
    ret1=anova.1w(df1[,4], df1[,5], df1[,6]) 
    cat("Math score:\n") 
    print(ret1) 
    #==== 
    fileXls = "ds_hw3v2.xlsx" 
    exc <- loadWorkbook(fileXls) 
    df1 <- readWorksheet(exc,1) 

Sample output:

    Reading score: 
    $sst 
    [1] 230055.5 
    $df_t 
    [1] 2 
    $mst 
    [1] 115027.7 
    $sse 
    [1] 963466.7 
    $df_e 
    [1] 1528 
    $mse 
    [1] 630.541 
    $fvalue 
    [1] 182.4271 
    $pvalue 
    [1] 0 
    Math score: 
    $sst 
    [1] 451041.7 
    $df_t 
    [1] 2 
    $mst 
    [1] 225520.8 
    $sse 
    [1] 974957.3 
    $df_e 
    [1] 1528

<h2 id="02_hw04">Two-way ANOVA</h2>

We have learned about two-way ANOVA and how to perform two-way ANOVA in R. **The built-in aov function, however, assume the data is in the “long” format as oppose to the “wide” format that are usually presented in the text book**. In this assignment, you are going to write a function named anova.2w to perform two-way ANOVA that takes input data in a wide format. We are going to **assume that samples from all treatments have the same size.** As a result, we can conveniently use a data frame to store all input samples. Each column contains data points from a treatment.

That is, `anova.2w()` takes two parameters. The first parameter is **a data frame that contains all data**. The second parameter is the **significant level** with a default value of 0.05. anova.2w should return a matrix that contains three rows and six columns. The following table summarizes the specification of the returned matrix. You should set row names and column names according to the table below so that the output can be read easily.

<table>
  <tr>
    <td></td>
    <td>SS</td>
    <td>df</td>
    <td>MS</td>
    <td>F</td>
    <td>pvalue</td>
    <td>F-crit</td>
  </tr>
  
  <tr>
    <td>Treatments</td>
    <td>SST</td>
    <td>df for treatments</td>
    <td>MST</td>
    <td>F1 = MST / MSE</td>
    <td>p-value of F1</td>
    <td>Critical value for F1</td>
  </tr>
  
  <tr>
    <td>Blocks</td>
    <td>SSB</td>
    <td>df for blocks</td>
    <td>MSB</td>
    <td>F2 = MSB / MSE</td>
    <td>p-value of F2</td>
    <td>Critical Value for F2</td>
  </tr>
  
  <tr>
    <td>Errors</td>
    <td>SSE</td>
    <td>df for errors</td>
    <td>MSE</td>
    <td>NA</td>
    <td>NA</td>
    <td>NA</td>
  </tr>
</table>

You should implement anova.2w from scratch by following the steps we discussed in class. You should not use the built-in “aov” function.

Sample code: 

    setwd('K:\\Users\\hmlu\\svn_drive3\\teaching\\statistics\\2017 spring\\homework\\hw4') 
    library(XLConnect) 
    fileXls = "dshw4.xlsx" 
    exc <- loadWorkbook(fileXls) 
    df1 <- readWorksheet(exc,1) 
    ret1=anova.2w(df1) 
    print(ret1)

Sample output: 

                     SS  df        MS        F      pvalue 	 F-crit 
    Treatments 204.2222   2 102.11111 4.537253 0.022397672 3.443357 
    Blocks     1150.2222 11 104.56566 4.646320 0.001073857 2.258518 
    Error      495.1111  22  22.50505       NA          NA       NA

<h2 id="02_hw06">Wilcoxon Rank Sum Test</h2>

**The built-in wilcox.test function in R adopted a different procedure to perform Wilcoxon rank Sum Test.** To be consistent with the textbook, we are going to build our own function named `my.wilcox()` that performs Wilcoxon Rank Sum Test according to the procedure explained in the textbook (and our lecture). This function takes three parameters:

- **data1**: a vector that contain the first sample.
- **data2**: a vector that contain the second sample.
- **alternative**: a string that could take the value of **less**, **greater**, or **two.sided**. Your function should return NULL if the input value is illegal.

Your function should remove NAs in data1 and data2 before doing any subsequent computation. The alternative parameter determines the alternative hypothesis we are going to perform. For example, if alternative is “less,” then it corresponds to an alternative hypothesis that population 1 is located to the left of population 2\.

The my.wilcox should return a list that includes the following components:

- **T**: The sum of ranks for data1\.
- **ET**: Expected value of T (under null hypothesis).
-	**SigmaT**: Standard deviation of T (under null hypothesis).
-	**n1**: Sample size of data1\. 
-	**n2**: Sample size of data2\.
-	**z**: z value of hypothesis test.
-	**pvalue**: p-value of hypothesis test.

Sample code: 

    setwd('data_folder')
    library(XLConnect)
    fileXls ="hw6ds1.xlsx"
    exc <- loadWorkbook(fileXls)
    df1 <- readWorksheet(exc,1)
    
    data1=df1[,1]
    data1=data1[!is.na(data1)]
    data2=df1[,2]
    data2=data2[!is.na(data2)]
    
    out1=my.wilcox(data1, data2, "greater")
    print(out1)

Sample output:

    $T
    [1] 32225.5
    $ET
    [1] 31486
    $SigmaT
    [1] 924.862
    $n1
    [1] 182
    $n2
    [1] 163
    $z
    [1] 0.7995788
    $pvalue
    [1] 0.2119774
