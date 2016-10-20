\name{predict.sisVIVE}
\alias{predict.sisVIVE}
\title{Estimates set of invalid instruments or the causal effect of exposure on outcome from a sisVIVE object }
\description{predict.sisVIVE can estimate a set of invalid instruments or the causal effect of exposure on outcome for any particular lambda(s)}
\usage{\method{predict}{sisVIVE}(object, lambda, type = c("coefficients", "instruments"), ...)}
\arguments{
  \item{object}{A fitted sisVIVE object}
  \item{lambda}{A numerical vector of lambda(s) to obtain estimates. The length of this vector can be one.}
  \item{type}{If type="coefficients", predict returns estimated alpha and betas (i.e. the causal effect of exposure on outcome) for supplied lambda(s). If type = "instruments", predict returns estimated set of invalid instruments for supplied lambda(s)}
  \item{\dots}{Any other argument for predict.lars}
}
\details{predict() estimates the alphas and betas for given sequence of lambda(s) or set of invalid instrument.}
\value{
  \item{lambda}{Sequence of lambda(s) supplied by the user}
  \item{alpha}{If type="coefficients", alpha is the estimated direct effect of the instruments on the outcome. Each row refers to an estimated alpha for one lambda value and each column refers to the corresponding column in Z}
  \item{beta}{If type="coefficients", beta is the estimated causal effect of exposure on outcome. Each entry refers to an estimated beta for one lambda value}
  \item{instruments}{If type="instruments",provides a character vector of invalid instruments. Each entry refers to column indices of Z that are estimated to be invalid.}
}
\author{Hyunseung Kang}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{summary, and cv.sisVIVE}
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
estCoef1 = predict(result,lambda = 10,type="coefficients")
estCoef2 = predict(result,lambda = seq(1,100,10),type="coefficients")
estInst1 = predict(result,lambda = 10,type="instruments")
estInst2 = predict(result,lambda = seq(1,100,10),type="instruments")
}
\keyword{ sisVIVE}
