library("quantmod")

## iShares Global Energy sector 
getSymbols("IXC",src="yahoo")
barChart(IXC)

IXC.returns = periodReturn(IXC,period='daily')
IXC.ndays = dim(IXC.returns)[1]

IXC.today.returns = IXC.returns
IXC.today.returns[1,] = NA
IXC.today.returns = subset(IXC.today.returns, !is.na(IXC.today.returns))

IXC.prev.returns = IXC.returns
IXC.prev.returns[IXC.ndays,] = NA
IXC.prev.returns = subset(IXC.prev.returns, !is.na(IXC.prev.returns))

IXC.corr.returns = data.frame(IXC.today.returns)
IXC.corr.returns$prev.returns = IXC.prev.returns

names(IXC.corr.returns) = c("today.returns", "prev.returns")

cor(IXC.corr.returns)

IXC.corr.returns$today_bins=cut(IXC.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IXC.corr.returns$prev_bins =cut(IXC.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IXC.freq_table = table(IXC.corr.returns$prev_bins, IXC.corr.returns$today_bins)

IXC.cond_prob = IXC.freq_table/colSums(IXC.freq_table)

IXC.freq_table

sum(IXC.freq_table)

print(round(IXC.cond_prob,2))
