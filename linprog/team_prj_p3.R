r1 = rep(1,8)
r2 = c(-12,-1,-2,-.9,-6,-4,2,.3)
r3 = c(8,-3,1,-.2,1.7,-3,.8,-1.3)
r4 = c(1.2,1.3,2.25,5,4,1.9,2.3,2.2)
r5 = c(-1.2,-1.3,1.5,2.11,4,1.9,3.5,2)
r6 = c(1.3,2.1,-1.5,-2,-2,.8,.2,.99)
r7 = c(2,.1,.6,.2,-1.5,2.3,-2,.2)
r8 = c(2.8,3.3,1.8,1.55,3,2,1.25,4)
r9 = c(2,3,-5,-2,-3,-2,4.25,-3)
r10 = c(-1.5,2.3,-5.7,-3,-2.111,2.78,2.3,-2.11)
r11 = c(2,-3,-1.5,-.12,2.3,-.99,1.9,-2.3)
r12 = c(2,1,-1.5,-2,1,-3,1,1.2)

mat = rbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12) # A matrix 
rhs = c(1227.8,299,899,2878,109.8,675.2,597,13001,786.3,315.7,357.96,845.13) # column b - ie rhs
dir = c("==", "<=", "<=", "<=", ">=", "<=", "<=", "<=", "<=", "<=", "<=", "<=") # constraint direction 
var_names = c("x1","x2", "x3", "x4","x5","x6","x7","x8") # decision variable names 
obj = c(1,-5,16,3,-1,6,2.8,2.1) # objective function coefficients  
  
model.formulation = data.frame(mat)
names(model.formulation)=var_names
model.formulation$sign=dir
model.formulation$b = rhs
print(model.formulation)
types = rep("C",12)
Rglpk_solve_LP(obj, mat, dir, rhs, types = types, max = TRUE, verbose = TRUE)

