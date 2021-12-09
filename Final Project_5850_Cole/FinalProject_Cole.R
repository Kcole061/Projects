Bball <- read.csv("totals_stats.csv")
summary(Bball)
dim(Bball)
mlr <- lm(PTS ~ FG + FGA + FG., data = Bball)
summary(mlr)

LBJreg <- Bball[1:16,]
head(LBJreg,10)


mlrLBJreg <- lm(PTS ~  FG. + AST + DRB + STL + BLK, data = LBJreg)
summary(mlrLBJreg)

LBJpo <- Bball[17:29,]

mlrLBJpo <- lm(PTS ~  FG. + AST + DRB + STL + BLK, data = LBJpo)
summary(mlrLBJpo)

MJreg <- Bball[30:44,]
mlrMJreg <- lm(PTS ~  FG. + AST + DRB + STL + BLK, data = MJreg)
summary(mlrMJreg)


MJpo <- Bball[45:57,]
mlrMJpo <- lm(PTS ~  FG. + AST + DRB + STL + BLK, data = MJpo)
summary(mlrMJpo)


KBreg <- Bball[58:77,]

mlrKBreg <- lm(PTS ~  FG. + AST + DRB + STL + BLK, data = KBreg)
summary(mlrKBreg)

KBpo <- Bball[78:92,]
mlrKBpo <- lm(PTS ~  FG. + AST + DRB + STL + BLK, data = KBpo)
summary(mlrKBpo)

#Made a new data frame for Lebron and Kobe because they played longer than jordan
#I made them all have 15 year time spans so i can put them evenly into a data
LBJreg1 <- Bball[1:15,]
KBreg1 <- Bball[58:72,]

dim(MJreg)
dim(KBreg1)
dim(LBJreg1)
regMKL <- rbind (MJreg, KBreg1,LBJreg1)

dim(regMKL)
library(MASS)
library(ISLR)
library(class)

kfolds <- 5
folds <- rep_len(1:kfolds, 45)
folds <- sample(folds, 45)

qda.test.error.fold <- rep(0, kfolds)

for(k in 1:kfolds){
  fold <- which(folds == k)
  
  reg_train <- regMKL[-fold, ]
  reg_test <- regMKL[fold, ]
  
  qda.fit <- qda(Player ~ PTS + FG. + AST + DRB + STL + BLK, data = reg_train)
  qda.pred <- predict(qda.fit, reg_test )
  qda.class <- qda.pred$class 
  qda.table <- table(qda.class, reg_test$Player)
  qda.test.error <- 1 - (qda.table[1,1] + qda.table[2,2] + qda.table[3,3])/sum(qda.table)
  qda.test.error.fold[k] <- qda.test.error
}

qda.error <- mean(qda.test.error.fold)
qda.error


lda.test.error.fold <- rep(0, kfolds)

for(k in 1:kfolds){
  fold <- which(folds == k)
  
  reg_train <- regMKL[-fold, ]
  reg_test <- regMKL[fold, ]
  
  lda.fit <- lda(Player ~ PTS + FG. + AST + DRB + STL + BLK, data = reg_train)
  lda.pred <- predict(lda.fit, reg_test)
  lda.class <- lda.pred$class 
  lda.table <- table(lda.class,  reg_test$Player)
  lda.test.error <- 1 - (lda.table[1,1] + lda.table[2,2] + lda.table[3,3])/sum(lda.table)
  lda.test.error.fold[k] <- lda.test.error
}

lda.error <- mean(lda.test.error.fold)
lda.error



# Fitting Regression Trees
set.seed(1116)
train <- sample(1:nrow(regMKL), nrow(regMKL)/2)
tree.regMKL <- tree(PTS ~ ., subset = train, data = regMKL)
summary(tree.regMKL)

plot(tree.regMKL)
text(tree.regMKL, pretty = 0)

yhat <- predict(tree.regMKL, newdata = regMKL[-train, ])
test.PTS <- regMKL[-train, 30]
cbind(yhat, test.PTS)[1:10,]
mean((yhat - test.PTS)^2)

cv.regMKL <- cv.tree(tree.regMKL)
cv.regMKL
which.min(cv.regMKL$dev)
cv.regMKL$size[1] 

# Using best = 1 made an error so I used 3 just to get another prediction. 

prune.regMKL <- prune.tree(tree.regMKL, best = 3)
plot(prune.regMKL)
text(prune.regMKL, pretty = 0)

par(mfrow = c(1,2))
plot(tree.regMKL)
text(tree.regMKL, pretty = 0)
plot(prune.regMKL)
text(prune.regMKL, pretty = 0)

yhat <- predict(prune.regMKL, newdata = regMKL[-train, ])
test.salary <- regMKL[-train, 30]
cbind(yhat, test.PTS)[1:10,]
mean((yhat - test.PTS)^2)
