library("quantmod")

## iShares S&P MidCap 400 Index Fund
getSymbols("IJH",src="yahoo")
barChart(IJH)

IJH.returns = periodReturn(IJH,period='weekly')
IJH.ndays = dim(IJH.returns)[1]

IJH.today.returns = IJH.returns
IJH.today.returns[1,] = NA
IJH.today.returns = subset(IJH.today.returns, !is.na(IJH.today.returns))

IJH.prev.returns = IJH.returns
IJH.prev.returns[IJH.ndays,] = NA
IJH.prev.returns = subset(IJH.prev.returns, !is.na(IJH.prev.returns))

IJH.corr.returns = data.frame(IJH.today.returns)
IJH.corr.returns$prev.returns = IJH.prev.returns

names(IJH.corr.returns) = c("today.returns", "prev.returns")

cor(IJH.corr.returns)

IJH.corr.returns$today_bins=cut(IJH.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IJH.corr.returns$prev_bins =cut(IJH.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IJH.freq_table = table(IJH.corr.returns$prev_bins, IJH.corr.returns$today_bins)

IJH.cond_prob = IJH.freq_table/colSums(IJH.freq_table)

IJH.freq_table

sum(IJH.freq_table)

print(round(IJH.cond_prob,2))
