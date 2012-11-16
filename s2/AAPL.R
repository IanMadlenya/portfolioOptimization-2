library("quantmod")

## AAPLe
getSymbols("AAPL",src="yahoo")
barChart(AAPL)

AAPL.returns = periodReturn(AAPL,period='daily')
AAPL.ndays = dim(AAPL.returns)[1]

AAPL.today.returns = AAPL.returns
AAPL.today.returns[1,] = NA
AAPL.today.returns = subset(AAPL.today.returns, !is.na(AAPL.today.returns))

AAPL.prev.returns = AAPL.returns
AAPL.prev.returns[AAPL.ndays,] = NA
AAPL.prev.returns = subset(AAPL.prev.returns, !is.na(AAPL.prev.returns))

AAPL.corr.returns = data.frame(AAPL.today.returns)
AAPL.corr.returns$prev.returns = AAPL.prev.returns

names(AAPL.corr.returns) = c("today.returns", "prev.returns")

cor(AAPL.corr.returns)

AAPL.corr.returns$today_bins=cut(AAPL.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
AAPL.corr.returns$prev_bins =cut(AAPL.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

AAPL.freq_table = table(AAPL.corr.returns$prev_bins, AAPL.corr.returns$today_bins)

AAPL.cond_prob = AAPL.freq_table/colSums(AAPL.freq_table)

AAPL.freq_table

sum(AAPL.freq_table)

print(round(AAPL.cond_prob,2))
