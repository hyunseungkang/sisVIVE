\name{cv.sisVIVE}
\alias{cv.sisVIVE}
\title{Computes K-fold cross validation for selecting lambda}
\description{Computes a K-fold cross validation for }
\usage{cv.sisVIVE(Y, D, Z, lambdaSeq, K = 10, intercept = TRUE, normalize = TRUE)}
\arguments{
  \item{Y}{A numeric vector of outcomes}
  \item{D}{A numeric vector of exposures}
  \item{Z}{A numeric matrix of instruments, with each column referring to one instrument}
  \item{lambdaSeq}{A numeric vector of lambdas to cross-validate from. Cross-validation will be performed only on these sequence of lambdas. You can either supply lambdaSeq or nLambda. See Details}
  \item{K}{Number of cross-validation folds}
  \item{intercept}{A logical declaring whether the intercept be included. Default is TRUE}
  \item{normalize}{A logical declaring whether the columns of Z should be scaled with variance 1. Default is TRUE}
}
\details{Performs K-fold cross validiation to select lambda and returns the "best" lambda based on this cross-validation. If lambdaSeq is unspecified, the algorithm defaults to using the sequence of lambdas selected by sisVIVE. If lambdaSeq is specified, the algorithm will only evaluate its cross-validation on the specified lambdaSeq.}
\value{
    A list is returned, which contains the estimates of alpha, beta, and the set of invalid instruments for the "best" lambda chosen by cross validation
    \item{lambda}{"best" lambda as chosen by cross validation}
	\item{estCVError}{Estimated cross-validated error at this lambda}
	\item{alpha}{Estimate of alpha at the said lambda}
    \item{beta}{Estimate of beta, the causal effect of exposure on outcome, at the said lambda}
    \item{whichInvalid}{Estimate of set of invalid instruments at the said lambda}
}
\author{Hyunseung Kang}
\examples{
library(MASS)
library(lars)

n = 1000; L = 10; s= 3;
Z <- matrix(rnorm(n*L),n,L)
error <- mvrnorm(n,rep(0,2),matrix(c(1,0.8,0.8,1),2,2))
intD = rnorm(1); ZtoD =   rnorm(L,0,1); ZtoY = c(rnorm(s),rep(0,L-s)); DtoY = 1; intY = rnorm(1)
D = intD + Z \%*\% ZtoD + error[,1]
Y = intY + Z \%*\% ZtoY + D * DtoY + error[,2]

result = cv.sisVIVE(Y,D,Z,K=10)

}
\keyword{ cross validation}
\keyword{ sisVIVE}
