library("quantmod")

## iShares S&P Global 100 Index Fund
getSymbols("IOO",src="yahoo")
barChart(IOO)

IOO.returns = periodReturn(IOO,period='daily')
IOO.ndays = dim(IOO.returns)[1]

IOO.today.returns = IOO.returns
IOO.today.returns[1,] = NA
IOO.today.returns = subset(IOO.today.returns, !is.na(IOO.today.returns))

IOO.prev.returns = IOO.returns
IOO.prev.returns[IOO.ndays,] = NA
IOO.prev.returns = subset(IOO.prev.returns, !is.na(IOO.prev.returns))

IOO.corr.returns = data.frame(IOO.today.returns)
IOO.corr.returns$prev.returns = IOO.prev.returns

names(IOO.corr.returns) = c("today.returns", "prev.returns")

cor(IOO.corr.returns)

IOO.corr.returns$today_bins=cut(IOO.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IOO.corr.returns$prev_bins =cut(IOO.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IOO.freq_table = table(IOO.corr.returns$prev_bins, IOO.corr.returns$today_bins)

IOO.cond_prob = IOO.freq_table/colSums(IOO.freq_table)

IOO.freq_table

sum(IOO.freq_table)

print(round(IOO.cond_prob,2))
