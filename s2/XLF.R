library("quantmod")

## SPDR Financial select sector 
getSymbols("XLF",src="yahoo")
barChart(XLF)

XLF.returns = periodReturn(XLF,period='daily')
XLF.ndays = dim(XLF.returns)[1]

XLF.today.returns = XLF.returns
XLF.today.returns[1,] = NA
XLF.today.returns = subset(XLF.today.returns, !is.na(XLF.today.returns))

XLF.prev.returns = XLF.returns
XLF.prev.returns[XLF.ndays,] = NA
XLF.prev.returns = subset(XLF.prev.returns, !is.na(XLF.prev.returns))

XLF.corr.returns = data.frame(XLF.today.returns)
XLF.corr.returns$prev.returns = XLF.prev.returns

names(XLF.corr.returns) = c("today.returns", "prev.returns")

cor(XLF.corr.returns)

XLF.corr.returns$today_bins=cut(XLF.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
XLF.corr.returns$prev_bins =cut(XLF.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

XLF.freq_table = table(XLF.corr.returns$prev_bins, XLF.corr.returns$today_bins)

XLF.cond_prob = XLF.freq_table/colSums(XLF.freq_table)

XLF.freq_table

sum(XLF.freq_table)

print(round(XLF.cond_prob,2))
