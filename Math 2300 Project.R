M1 <- matrix(c(6,-4,1,-4,6,-1,1,-1,11), ncol = 3, byrow =T)
G2 <- matrix(c(-16,84,0,0,40,0,24,-36,8), ncol = 3, byrow =T)
v1 <- c(1,0,0)
print(v1)
V1 <- v1 %*% t(M1)
print(V1)

ev1 <- V1/6
print(ev1)

V2 <- ev1 %*% t(M1)

ev2 <- V2/ 8.833333

V3 <- ev2 %*% t(M1)

ev3 <- V3/10.09434

V4 <- ev3 %*% t(M1)

ev4 <- V4/10.56262

V5 <- ev4 %*% t(M1)

ev5 <- V5/ 10.82481

V6 <- ev5 %*% t(M1)

ev6 <- V6/11.03207

V7 <- ev6 %*% t(M1)

ev7 <- V7/11.21202

V8 <- ev7 %*% t(M1)

ev8 <- V8/11.36778

V9 <- ev8 %*% t(M1)

ev9 <- V9/11.49952

V10 <- ev9 %*% t(M1)

ev10 <- V10/11.60831

V11 <- ev10 %*% t(M1)

ev11 <- V11/11.69632

V12 <- ev11 %*% t(M1)

ev12 <- V12/11.76632

V13 <- ev12 %*% t(M1)

ev13 <- V13/11.82127

V14 <- ev13 %*% t(M1)

ev14 <- V14/11.86392

V15 <- ev14 %*% t(M1)

ev15 <- V15/11.89677

V16 <- ev15 %*% t(M1)

ev16 <- V16/11.92191 

V17 <- ev16 %*% t(M1)

ev17 <- V17/ 11.94105

V18 <- ev17 %*% t(M1)

ev18 <- V18/11.95556

V19 <- ev18 %*% t(M1)

ev19 <- V19/11.96655
  
V20 <- ev19 %*% t(M1)

ev20 <- V20/11.97485

V21 <- ev20 %*% t(M1)

ev21 <- V21/ 11.97485

V22 <- ev21 %*% t(M1)

ev22 <- V22/11.99204

V23 <- ev22 %*% t(M1)

ev23 <- V23/11.98934

V24 <- ev23 %*% t(M1)

ev24 <- V24/11.99199

V25 <- ev24 %*% t(M1)

ev25 <- V25/ 11.99399

V26 <- ev25 %*% t(M1)

ev26 <- V26/11.99549

V27 <- ev26 %*% t(M1)

ev27 <- V27/11.99662

V28 <- ev27 %*% t(M1)

ev28 <- V28/11.99746

V29 <- ev28 %*% t(M1)

ev29 <- V29/11.9981

V30 <- ev29 %*% t(M1)

ev30 <- V30/11.99857

V31 <- ev30 %*% t(M1)

ev31 <- V31/11.99893

V32 <- ev31 %*% t(M1)

ev32 <- V32/11.9981

V33 <- ev32 %*% t(M1)

To find the basis for eigenvalue lambda=2 you need to start with the formula (A-lamdaI). A comes from the original matrix. 
Lambda is the eigenvalue, and I is the identity matrix.

bs2m <- M1 - 2*diag(3)
print(bs2m)
Then you need to row reduce the new matrix.
print(rref(bs2m)*"nm")
Then you need to multiply 

library("pracma")
CH <- matrix(c(4,0,-7,3,-5,0,0,2,0,0,7,3,-6,4,-8,5,0,5,2,-3,0,0,9,-1,2), ncol = 5, byrow =T)

charpoly(CH, info = FALSE)
diag(5)
CH*CH-7*CH+15*diag(3)-9*CH^-1


CH^4