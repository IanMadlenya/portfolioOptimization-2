library("quantmod")

## SPDR Enery select sector 
getSymbols("XLE",src="yahoo")
barChart(XLE)

XLE.returns = periodReturn(XLE,period='daily')
XLE.ndays = dim(XLE.returns)[1]

XLE.today.returns = XLE.returns
XLE.today.returns[1,] = NA
XLE.today.returns = subset(XLE.today.returns, !is.na(XLE.today.returns))

XLE.prev.returns = XLE.returns
XLE.prev.returns[XLE.ndays,] = NA
XLE.prev.returns = subset(XLE.prev.returns, !is.na(XLE.prev.returns))

XLE.corr.returns = data.frame(XLE.today.returns)
XLE.corr.returns$prev.returns = XLE.prev.returns

names(XLE.corr.returns) = c("today.returns", "prev.returns")

cor(XLE.corr.returns)

XLE.corr.returns$today_bins=cut(XLE.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
XLE.corr.returns$prev_bins =cut(XLE.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

XLE.freq_table = table(XLE.corr.returns$prev_bins, XLE.corr.returns$today_bins)

XLE.cond_prob = XLE.freq_table/colSums(XLE.freq_table)

XLE.freq_table

sum(XLE.freq_table)

print(round(XLE.cond_prob,2))
