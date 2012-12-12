c = c(rep(2000,5),rep(1000,5))

A1 = matrix(c(0,0,0,0,0, 90, 0,0,0,0), nrow=1)
b1 = c(160*51 - 6555)  


A2a = 160*diag(5)
A2b = -90*diag(5)
A2 = cbind(A2a, c(0,0,0,0,0),A2b[,1:4])
b2 = c(7510,9000,10225,9500,11250)

A3a = diag(5)
A3a[2,1] = A3a[3,2] = A3a[4,3] = A3a[5,4] = -0.92
A3b = -0.92*diag(5)
A3 = cbind(A3a,A3b)
b3 = c(0.92*51, rep(0,4))

# c
# A1
# b1
# A2
# b2
# A3
# b3

simplex(a=c, A1=A1, b1=b1, A2=A2,b2=b2, A3=A3, b3=b3)

