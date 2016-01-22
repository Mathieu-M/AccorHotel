
# Packages ----------------------------------------------------------------

library("vars")
library("portes")
library("egcm")
library("Kendall")
library("TSA")
library('tseries')
library("zoo")
library("ggplot2")
source("Code/Functions.R")


# Data transformation -----------------------------------------------------

# Novotel_bc:
novotel_bc <- novotel %>% filter(Date<"2015-01-01")

ggplot(data=novotel_bc,aes(Date,global)) + geom_line() + geom_smooth()

tsnovotel_bc <- zoo(novotel_bc$global,order.by=novotel_bc$Date)
tsnovotel_bc <- ts(tsnovotel_bc)


# Stationarity ------------------------------------------------------------

# trend:
trendtest <- MannKendall(tsnovotel_bc)
summary(trendtest)
# No evidence of a trend
length(tsnovotel_bc)
# Seasonal pattern:
a <- periodogram(tsnovotel_bc)
FF <- abs(fft(tsnovotel_bc)/sqrt(737))^2
P <- (4/737)*FF[1:(737/2+1)] # Only need the first (n/2)+1 values of the FFT result.
f <- (0:(round(737/2)))/737 # this creates harmonic frequencies from 0 to .5 in steps of 1/128.
plot(f, P, type="l") # This plots the periodogram; type = “l” creates a line plot.  Note: l is lowercase L, not number 1.

max(P)

a
