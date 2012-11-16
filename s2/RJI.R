library("quantmod")

## ELEMENTS Rogers Intl Commodity ETN 
getSymbols("RJI",src="yahoo")
barChart(RJI)

RJI.returns = periodReturn(RJI,period='daily')
RJI.ndays = dim(RJI.returns)[1]

RJI.today.returns = RJI.returns
RJI.today.returns[1,] = NA
RJI.today.returns = subset(RJI.today.returns, !is.na(RJI.today.returns))

RJI.prev.returns = RJI.returns
RJI.prev.returns[RJI.ndays,] = NA
RJI.prev.returns = subset(RJI.prev.returns, !is.na(RJI.prev.returns))

RJI.corr.returns = data.frame(RJI.today.returns)
RJI.corr.returns$prev.returns = RJI.prev.returns

names(RJI.corr.returns) = c("today.returns", "prev.returns")

cor(RJI.corr.returns)

RJI.corr.returns$today_bins=cut(RJI.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
RJI.corr.returns$prev_bins =cut(RJI.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

RJI.freq_table = table(RJI.corr.returns$prev_bins, RJI.corr.returns$today_bins)

RJI.cond_prob = RJI.freq_table/colSums(RJI.freq_table)

RJI.freq_table

sum(RJI.freq_table)

print(round(RJI.cond_prob,2))
