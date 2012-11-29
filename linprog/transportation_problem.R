
A1 = c(rep(1,3), c=rep(0,6))
A2 = c(rep(0,3), rep(1,3), c=rep(0,3))
A3 = c(rep(0,6), rep(1,3))
A4 = c(1,0,0, 1,0,0, 1,0,0)
A5 = c(0,1,0, 0,1,0, 0,1,0)
A6 = c(0,0,1, 0,0,1, 0,0,1)

library("Rglpk")
mat = rbind(A1,A2,A3,A4,A5,A6)
obj = c(2.65,0.15,0.05,  2.3,-0.15,-0.25, 2.9,0.7,0.65) # objective function coeficients
x1 = 58 # of trained staff at January 1st
dir = c(rep("<=", 3), rep("==", 3))
rhs = c(100,50,200,100,50, 25)

model.formulation = data.frame(mat,dir,rhs)
names(model.formulation) = c("x11", "x12","x13","x21","x22","x23","x31","x32","x33","constraint","b")        
print(model.formulation)

types = rep("I", 9) # Solve as General LP
Rglpk_solve_LP(obj, mat, dir, rhs, types = types, max = TRUE, verbose = TRUE)
