## spy data processing

getSymbols("SPY",src="yahoo")
barChart(SPY)

spy.returns = periodReturn(SPY,period='daily')
dim(spy.returns)

ndays = dim(spy_returns)[1]
day.returns = data.frame(spy.returns[-1,])
dim(day.returns)

prev.returns =  spy.returns[1:ndays,]
dim(prev.returns)

day.returns$prev.returns = prev.returns
day.returns[1:10,]
spy.returns[1:10,]

day.returns$daily_bin =cut(day.returns$daily.returns, breaks = c(-1.0,-0.04,-0.02, 0.0, 0.02, 0.04, 1.0))
day.returns$prev_bin  =cut(day.returns$prev.returns,  breaks = c(-1.0,-0.04,-0.02, 0.0, 0.02, 0.04, 1.0))

table(day.returns$prev_bin, day.returns$daily_bin)

  

