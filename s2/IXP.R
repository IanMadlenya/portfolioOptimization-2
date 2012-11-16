library("quantmod")

## iShares Global Telecommunications 
getSymbols("IXP",src="yahoo")
barChart(IXP)

IXP.returns = periodReturn(IXP,period='daily')
IXP.ndays = dim(IXP.returns)[1]

IXP.today.returns = IXP.returns
IXP.today.returns[1,] = NA
IXP.today.returns = subset(IXP.today.returns, !is.na(IXP.today.returns))

IXP.prev.returns = IXP.returns
IXP.prev.returns[IXP.ndays,] = NA
IXP.prev.returns = subset(IXP.prev.returns, !is.na(IXP.prev.returns))

IXP.corr.returns = data.frame(IXP.today.returns)
IXP.corr.returns$prev.returns = IXP.prev.returns

names(IXP.corr.returns) = c("today.returns", "prev.returns")

cor(IXP.corr.returns)

IXP.corr.returns$today_bins=cut(IXP.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IXP.corr.returns$prev_bins =cut(IXP.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IXP.freq_table = table(IXP.corr.returns$prev_bins, IXP.corr.returns$today_bins)

IXP.cond_prob = IXP.freq_table/colSums(IXP.freq_table)

IXP.freq_table

sum(IXP.freq_table)

print(round(IXP.cond_prob,2))
