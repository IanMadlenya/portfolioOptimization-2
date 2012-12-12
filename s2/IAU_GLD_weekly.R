library("quantmod")

## iShares Gold Trust  
getSymbols("IAU",src="yahoo")
barChart(IAU)

IAU.returns = periodReturn(IAU,period='weekly')
IAU.ndays = dim(IAU.returns)[1]

IAU.today.returns = IAU.returns
IAU.today.returns[1,] = NA
IAU.today.returns = subset(IAU.today.returns, !is.na(IAU.today.returns))

IAU.prev.returns = IAU.returns
IAU.prev.returns[IAU.ndays,] = NA
IAU.prev.returns = subset(IAU.prev.returns, !is.na(IAU.prev.returns))

IAU.corr.returns = data.frame(IAU.today.returns)
IAU.corr.returns$prev.returns = IAU.prev.returns

names(IAU.corr.returns) = c("today.returns", "prev.returns")

cor(IAU.corr.returns)

IAU.corr.returns$today_bins=cut(IAU.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
IAU.corr.returns$prev_bins =cut(IAU.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

IAU.freq_table = table(IAU.corr.returns$prev_bins, IAU.corr.returns$today_bins)

IAU.cond_prob = IAU.freq_table/colSums(IAU.freq_table)

####################################

## SPDR Gold Trust  
getSymbols("GLD",src="yahoo")
barChart(GLD)

GLD.returns = periodReturn(GLD,period='daily')
GLD.ndays = dim(GLD.returns)[1]

GLD.today.returns = GLD.returns
GLD.today.returns[1,] = NA
GLD.today.returns = subset(GLD.today.returns, !is.na(GLD.today.returns))

GLD.prev.returns = GLD.returns
GLD.prev.returns[GLD.ndays,] = NA
GLD.prev.returns = subset(GLD.prev.returns, !is.na(GLD.prev.returns))

GLD.corr.returns = data.frame(GLD.today.returns)
GLD.corr.returns$prev.returns = GLD.prev.returns

names(GLD.corr.returns) = c("today.returns", "prev.returns")

cor(GLD.corr.returns)

GLD.corr.returns$today_bins=cut(GLD.corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
GLD.corr.returns$prev_bins =cut(GLD.corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

GLD.freq_table = table(GLD.corr.returns$prev_bins, GLD.corr.returns$today_bins)

GLD.cond_prob = GLD.freq_table/colSums(GLD.freq_table)

################### print freq table and conditionap probabilities
GLD.freq_table

IAU.freq_table

sum(GLD.freq_table)

sum(IAU.freq_table)


print(round(GLD.cond_prob,2))

print(round(IAU.cond_prob,2))
