library("quantmod")

## iShares Global Technology sector 
getSymbols("IXN",src="yahoo")
barChart(IXN)

IXN.returns = periodReturn(IXN,period='daily')
IXN.ndays = dim(IXN.returns)[1]

IXN.today.returns = IXN.returns
IXN.today.returns[1,] = NA
IXN.today.returns = subset(IXN.today.returns, !is.na(IXN.today.returns))

IXN.prev.returns = IXN.returns
IXN.prev.returns[IXN.ndays,] = NA
IXN.prev.returns = subset(IXN.prev.returns, !is.na(IXN.prev.returns))

IXN.corr.returns = data.frame(IXN.today.returns)
IXN.corr.returns$prev.returns = IXN.prev.returns

names(IXN.corr.returns) = c("today.returns", "prev.returns")

cor(IXN.corr.returns)

IXN.corr.returns$today_bins=cut(IXN.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IXN.corr.returns$prev_bins =cut(IXN.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IXN.freq_table = table(IXN.corr.returns$prev_bins, IXN.corr.returns$today_bins)

IXN.cond_prob = IXN.freq_table/colSums(IXN.freq_table)

IXN.freq_table

sum(IXN.freq_table)

print(round(IXN.cond_prob,2))
