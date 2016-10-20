# sisVIVE

sisVIVE is an R package that selects invalid instruments from a candidate list of instruments and estimates the causal effect of the exposure on the outcome in a linear instrumental variables model. The method is detailed in Kang, Zhang, Cai, and Small (2016).

To install this package in R from GitHub, run the following commands:

```R
install.packages("devtools")
library(devtools) 
install_github("hyunseungkang/sisVIVE")
```

To install this package in R from CRAN, run the following command:

```R
install.packages("sisVIVE")
```

# Examples

```R
library(sisVIVE)

### Create data consistng of L = 10 IVs where first s = 3 IVs are invalid
# Sample size is n = 1000 and true treatment effect, DtoY, is 1.

# Here, Y = n * 1 vector of outcomes
#       D = n * 1 vector of treatment
#       Z = n * L matrix of instruments

n = 1000; L = 10; s= 3;
Z <- matrix(rnorm(n*L),n,L)
error <- mvrnorm(n,rep(0,2),matrix(c(1,0.8,0.8,1),2,2))
intD = 1; ZtoD = rep(1,L); 
intY = 1; ZtoY = c(rep(1,s),rep(0,L-s)); DtoY = 1

D = intD + Z \%*\% ZtoD + error[,1]
Y = intY + Z \%*\% ZtoY + D * DtoY + error[,2]

# Run sisVIVE with tuning parameter chosen via cross-validation
cv.sisVIVE(Y,D,Z)
```

#### References
Kang, H., Zhang, A., Cai, T. T., and Small, D. S. (2016). <a href="http://www.tandfonline.com/doi/full/10.1080/01621459.2014.994705">'Instrumental Variables EStiamtion with Some Invalid Instruments and its Application to Mendelian Randomization.'</a> <i>Journal of the American Statistical Association </i>, 111, 132-144.
