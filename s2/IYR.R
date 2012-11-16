library("quantmod")

## Down Jones US Real EState  
getSymbols("IYR",src="yahoo")
barChart(IYR)

IYR.returns = periodReturn(IYR,period='daily')
IYR.ndays = dim(IYR.returns)[1]

IYR.today.returns = IYR.returns
IYR.today.returns[1,] = NA
IYR.today.returns = subset(IYR.today.returns, !is.na(IYR.today.returns))

IYR.prev.returns = IYR.returns
IYR.prev.returns[IYR.ndays,] = NA
IYR.prev.returns = subset(IYR.prev.returns, !is.na(IYR.prev.returns))

IYR.corr.returns = data.frame(IYR.today.returns)
IYR.corr.returns$prev.returns = IYR.prev.returns

names(IYR.corr.returns) = c("today.returns", "prev.returns")

cor(IYR.corr.returns)

IYR.corr.returns$today_bins=cut(IYR.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IYR.corr.returns$prev_bins =cut(IYR.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IYR.freq_table = table(IYR.corr.returns$prev_bins, IYR.corr.returns$today_bins)

IYR.cond_prob = IYR.freq_table/colSums(IYR.freq_table)

IYR.freq_table

sum(IYR.freq_table)

print(round(IYR.cond_prob,2))
