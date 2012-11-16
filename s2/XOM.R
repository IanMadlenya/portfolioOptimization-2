library("quantmod")

getSymbols("XOM",src="yahoo")
barChart(XOM)

XOM.returns = periodReturn(XOM,period='daily')
XOM.ndays = dim(XOM.returns)[1]

XOM.today.returns = XOM.returns
XOM.today.returns[1,] = NA
XOM.today.returns = subset(XOM.today.returns, !is.na(XOM.today.returns))

XOM.prev.returns = XOM.returns
XOM.prev.returns[XOM.ndays,] = NA
XOM.prev.returns = subset(XOM.prev.returns, !is.na(XOM.prev.returns))

XOM.corr.returns = data.frame(XOM.today.returns)
XOM.corr.returns$prev.returns = XOM.prev.returns

names(XOM.corr.returns) = c("today.returns", "prev.returns")

cor(XOM.corr.returns)

XOM.corr.returns$today_bins=cut(XOM.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
XOM.corr.returns$prev_bins =cut(XOM.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

XOM.freq_table = table(XOM.corr.returns$prev_bins, XOM.corr.returns$today_bins)

XOM.cond_prob = XOM.freq_table/colSums(XOM.freq_table)

XOM.freq_table

sum(XOM.freq_table)

print(round(XOM.cond_prob,2))
