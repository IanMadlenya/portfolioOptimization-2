library("quantmod")

## Dow Jones INTL Real Estate 
getSymbols("RWX",src="yahoo")
barChart(RWX)

RWX.returns = periodReturn(RWX,period='daily')
RWX.ndays = dim(RWX.returns)[1]

RWX.today.returns = RWX.returns
RWX.today.returns[1,] = NA
RWX.today.returns = subset(RWX.today.returns, !is.na(RWX.today.returns))

RWX.prev.returns = RWX.returns
RWX.prev.returns[RWX.ndays,] = NA
RWX.prev.returns = subset(RWX.prev.returns, !is.na(RWX.prev.returns))

RWX.corr.returns = data.frame(RWX.today.returns)
RWX.corr.returns$prev.returns = RWX.prev.returns

names(RWX.corr.returns) = c("today.returns", "prev.returns")

cor(RWX.corr.returns)

RWX.corr.returns$today_bins=cut(RWX.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
RWX.corr.returns$prev_bins =cut(RWX.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

RWX.freq_table = table(RWX.corr.returns$prev_bins, RWX.corr.returns$today_bins)

RWX.cond_prob = RWX.freq_table/colSums(RWX.freq_table)

RWX.freq_table

sum(RWX.freq_table)

print(round(RWX.cond_prob,2))
