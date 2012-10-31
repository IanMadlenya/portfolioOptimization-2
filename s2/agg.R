## spy data processing

getSymbols("AGG",src="yahoo")
barChart(AGG)


agg.returns = periodReturn(AGG,period='daily')
dim(agg.returns)

ndays = dim(spy_returns)[1]
day.returns = data.frame(agg.returns[-1,])
dim(day.returns)

prev.returns =  agg.returns[1:ndays,]
dim(prev.returns)

day.returns$prev.returns = prev.returns
day.returns[1:10,]
agg.returns[1:10,]

day.returns$daily_bin =cut(day.returns$daily.returns, breaks = c(-1.0,-0.04,-0.02, 0.0, 0.02, 0.04, 1.0))
day.returns$prev_bin  =cut(day.returns$prev.returns,  breaks = c(-1.0,-0.04,-0.02, 0.0, 0.02, 0.04, 1.0))

table(day.returns$prev_bin, day.returns$daily_bin)

