\name{summary.sisVIVE}
\alias{summary.sisVIVE}
\title{A summary of the sisVIVE object}
\description{
Produces a summary of the sisVIVE object, including the estimates of the causal effect of exposure on outcome and the estimated set of invalid instruments for sequence of lambdas
}
\usage{\method{summary}{sisVIVE}(object,...)}
\arguments{
  \item{object}{a sisVIVE object}
  \item{\dots}{additional arguments for summary generic}
}
\details{Each row summarizes an estimated causal effect of exposure on outcome and the estimated set of invalid instruments for one lambda}
\value{Each row summarizes an estimated causal effect of exposure on outcome and the estimated set of invalid instruments for one lambda. For the estimated set of invalid instruments, each number is a column index number for Z that is estimated to be invalid.}
\author{Hyunseung Kang}
\seealso{predict and cv.sisVIVE}
\examples{
library(MASS)
library(lars)

n = 1000; L = 10; s= 3;
Z <- matrix(rnorm(n*L),n,L)
error <- mvrnorm(n,rep(0,2),matrix(c(1,0.8,0.8,1),2,2))
intD = rnorm(1); ZtoD =   rnorm(L,0,1); ZtoY = c(rnorm(s),rep(0,L-s)); DtoY = 1; intY = rnorm(1)
D = intD + Z \%*\% ZtoD + error[,1]
Y = intY + Z \%*\% ZtoY + D * DtoY + error[,2]

result = sisVIVE(Y,D,Z)
summary(result)
}
\keyword{ sisVIVE }
