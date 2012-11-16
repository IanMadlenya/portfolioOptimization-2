library("quantmod")

## IShares Barclays TIPS Bond   
getSymbols("TIP",src="yahoo")
barChart(TIP)

TIP.returns = periodReturn(TIP,period='daily')
TIP.ndays = dim(TIP.returns)[1]

TIP.today.returns = TIP.returns
TIP.today.returns[1,] = NA
TIP.today.returns = subset(TIP.today.returns, !is.na(TIP.today.returns))

TIP.prev.returns = TIP.returns
TIP.prev.returns[TIP.ndays,] = NA
TIP.prev.returns = subset(TIP.prev.returns, !is.na(TIP.prev.returns))

TIP.corr.returns = data.frame(TIP.today.returns)
TIP.corr.returns$prev.returns = TIP.prev.returns

names(TIP.corr.returns) = c("today.returns", "prev.returns")

cor(TIP.corr.returns)

TIP.corr.returns$today_bins=cut(TIP.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
TIP.corr.returns$prev_bins =cut(TIP.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

TIP.freq_table = table(TIP.corr.returns$prev_bins, TIP.corr.returns$today_bins)

TIP.cond_prob = TIP.freq_table/colSums(TIP.freq_table)

TIP.freq_table

sum(TIP.freq_table)

print(round(TIP.cond_prob,2))
