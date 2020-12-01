rm(list=ls())
library(MASS)
library(dplyr)
library(nnet)
library(generalhoslem)
library(VGAM)
library(pROC)
library(data.table)

#set working directory and read data
setwd("E:/Purdue/2020fall/STAT526/project")
psodata = read.csv(file = "final.csv")

#preprocess data
index = (psodata$alcohol==2)
psodata$alcohol[index] = 0

index = (psodata$HBP==2)
psodata$HBP[index] = 0


index = (psodata$diabetes==2)
psodata$diabetes[index] = 0


index = (psodata$smoke==2)
psodata$smoke[index] = 0


psodata$gender = as.factor(psodata$gender)
psodata$ethnicity = as.factor(psodata$ethnicity)
psodata$countrybirth = as.factor(psodata$countrybirth)
psodata$alcohol = as.factor(psodata$alcohol)
psodata$HBP = as.factor(psodata$HBP)
psodata$diabetes = as.factor(psodata$diabetes)
psodata$smoke = as.factor(psodata$smoke)
index = (psodata$psoriasis==4)
psodata$psoriasis[index] = 3 
index = (psodata$psoriasis>0)
psodata$psoriasis[index] = 1
psodata$psoriasis = as.factor(psodata$psoriasis)
head(psodata)


#logistic model 
mod1 = glm(psoriasis ~ ., family=binomial, data=psodata)
summary(mod1)
logitgof(psodata$psoriasis, fitted(mod1))

mod2 = step(mod1, trace=0)
summary(mod2)
logitgof(psodata$psoriasis, fitted(mod2))

confint(mod2)

predictor_vars = psodata[c(-1,-5,-6,-10)]
probs<- mod2$fitted.values
# #find threshold based on accuracy
# T = seq(0,1,0.01)
# best_t = 0
# meanvalue = 0
# for(t in T){
#   predicted.classes <- ifelse(probs > t, 1, 0)
#   m = mean(predicted.classes == psodata$psoriasis)
#   if(m>meanvalue){
#     meanvalue = m
#     best_t = t
#   }
# }
# print(best_t)
# print(meanvalue)


#find threshold based on f1_score
T = seq(0,1,0.01)
best_t = 0
f1score = 0
best_cm = list()
for(t in T){
  prediction <- ifelse(probs > t, 1, 0)
  dt = data.table('1'=c(length(which(prediction==1 & psodata$psoriasis==1)), length(which(prediction==1 & psodata$psoriasis==0))),
                  '0'=c(length(which(prediction==0 & psodata$psoriasis==1)), length(which(prediction==0 & psodata$psoriasis==0))))
  cm = as.matrix(dt)
  if(cm[1,1]==0){
    f1 = 0
  }
  else{
    prec = cm[1,1]/(cm[1,1]+cm[1,2])
    recall = cm[1,1]/(cm[1,1]+cm[2,1])
    f1 = 2*prec*recall/(recall+prec)
  }
  if(f1>f1score){
    best_t = t
    f1score=f1
    best_cm = cm
  }
}
print(best_t)
print(f1score)
print(best_cm)


