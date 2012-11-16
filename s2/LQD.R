library("quantmod")

## SPDR Financial select sector 
getSymbols("LQD",src="yahoo")
barChart(LQD)

LQD.returns = periodReturn(LQD,period='daily')
LQD.ndays = dim(LQD.returns)[1]

LQD.today.returns = LQD.returns
LQD.today.returns[1,] = NA
LQD.today.returns = subset(LQD.today.returns, !is.na(LQD.today.returns))

LQD.prev.returns = LQD.returns
LQD.prev.returns[LQD.ndays,] = NA
LQD.prev.returns = subset(LQD.prev.returns, !is.na(LQD.prev.returns))

LQD.corr.returns = data.frame(LQD.today.returns)
LQD.corr.returns$prev.returns = LQD.prev.returns

names(LQD.corr.returns) = c("today.returns", "prev.returns")

cor(LQD.corr.returns)

LQD.corr.returns$today_bins=cut(LQD.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
LQD.corr.returns$prev_bins =cut(LQD.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

LQD.freq_table = table(LQD.corr.returns$prev_bins, LQD.corr.returns$today_bins)

LQD.cond_prob = LQD.freq_table/colSums(LQD.freq_table)

LQD.freq_table

sum(LQD.freq_table)

print(round(LQD.cond_prob,2))
