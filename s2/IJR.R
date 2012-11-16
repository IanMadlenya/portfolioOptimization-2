library("quantmod")

## iShares S&P SmallCap 600 Index Fund
getSymbols("IJR",src="yahoo")
barChart(IJR)

IJR.returns = periodReturn(IJR,period='daily')
IJR.ndays = dim(IJR.returns)[1]

IJR.today.returns = IJR.returns
IJR.today.returns[1,] = NA
IJR.today.returns = subset(IJR.today.returns, !is.na(IJR.today.returns))

IJR.prev.returns = IJR.returns
IJR.prev.returns[IJR.ndays,] = NA
IJR.prev.returns = subset(IJR.prev.returns, !is.na(IJR.prev.returns))

IJR.corr.returns = data.frame(IJR.today.returns)
IJR.corr.returns$prev.returns = IJR.prev.returns

names(IJR.corr.returns) = c("today.returns", "prev.returns")

cor(IJR.corr.returns)

IJR.corr.returns$today_bins=cut(IJR.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IJR.corr.returns$prev_bins =cut(IJR.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IJR.freq_table = table(IJR.corr.returns$prev_bins, IJR.corr.returns$today_bins)

IJR.cond_prob = IJR.freq_table/colSums(IJR.freq_table)

IJR.freq_table

sum(IJR.freq_table)

print(round(IJR.cond_prob,2))
