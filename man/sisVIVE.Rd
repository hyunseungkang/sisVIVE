\name{sisVIVE}
\alias{sisVIVE}
\title{ Some Invalid Some Valid Instrumental Variables Estimator}
\description{Selects invalid instruments from a candidate of instruments and estimates the causal effect of exposure on outcome}
\usage{sisVIVE(Y, D, Z, intercept = TRUE, normalize = TRUE)}
\arguments{
  \item{Y}{A numeric vector of outcomes}
  \item{D}{A numeric vector of exposures}
  \item{Z}{A numeric matrix of instruments, with each column referring to one instrument}
  \item{intercept}{A logical declaring whether the intercept be included. Default is TRUE}
  \item{normalize}{A logical declaring whether the columns of Z should be scaled with variance 1. Default is TRUE}
}
\details{Given a candidate of instruments, the algorithm selects invalid instruments and estimates the causal effect of exposure on outcome by leveraging LARS. The entire solution path, which includes the estimate of the causal effect as well as the estimated set of invalid instruments, is computed for lambda.}
\value{
    A "sisVIVE" object is returned, for which print, plot, summary, and predict methods exist.
    \item{alpha}{Estimates of alpha, the causal effect of the instrument on the outcome. Each row represents a lambda value and each column corresponds to the estimate of alpha corresponding to that same column in Z}
    \item{beta}{Estimate of beta, the causal effect of the exposure on the outcome. Each entry represents an estimate of beta for a lambda value}
    \item{whichInvalid}{Estimate of which instruments are invalid. Each entry refers to the column indexes of the Z matrix which were deemed to be invalid for a lambda value}
	\item{lambda}{Lambda used in the algorithm}
	\item{larsObject}{A LARS object}
	\item{Y}{A numeric vector of outcomes}
    \item{D}{A numeric vector of exposures}
    \item{Z}{A numeric matrix of instruments, with each column referring to one instrument}
	\item{Dhat}{A numeric vector of predicted exposure given instruments}
}
\references{For LARS: Efron, Hastie, Johnstone and Tibshirani (2003) "Least Angle Regression" (with discussion) Annals of Statistics}
\author{Hyunseung Kang. We thank Frank Windmeijer for his suggestion to improve the code.}
\seealso{summary and predict methods for sisVIVE, and cv.sisVIVE which performs cross-validation to choose the tuning parameter}
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

