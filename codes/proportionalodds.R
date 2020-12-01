rm(list=ls())
final<-read.csv("final526.csv")
#Draw several plots
library(dplyr)
table(final$psoriasis)
#continuous variable: age, poverty, BMI
library(corrplot)
pdf("cor.pdf", width = 6, height = 6)
M<-cor(final)
par(mfrow=c(1,1))
corrplot(M, method="color")
dev.off()
#Predictors_conti
pdf("summary_conti.pdf", width = 9, height = 4)
par(mfrow=c(1,3))
plot(density(final$age), xlab = "", main=c("age"), lwd = 2)
plot(density(final$income), xlab = "", main=c("income"), lwd = 2)
plot(density(final$BMI), xlab = "", main=c("BMI"), lwd = 2)
dev.off()

final<-data.table(final)
table(final$psoriasis)

final.p <- final[psoriasis>0]
final.p[final.p$psoriasis==4,c("psoriasis"):=list(3)]
final.p[alcohol==2, c("alcohol"):=1]
final.p[diabetes==3, c("diabetes"):=2]
final.p$HBP <- 2-final.p$HBP 
final.p$diabetes <- 2-final.p$diabetes 
final.p$smoke<-2- final.p$smoke 
library(nnet)
multinom<-nnet::multinom
fit.full = multinom(psoriasis ~ gender + age + ethnicity+ countrybirth + income + 
                      alcohol + BMI + HBP + diabetes + smoke, data = final.p)
summary(fit.full) # deviance 404.2295 with df =22

fit1 = polr(as.factor(psoriasis) ~ gender + age + ethnicity+ countrybirth + income + 
              alcohol + BMI + HBP + diabetes + smoke, data = final.p)

fit<-step(fit1, trace=0)
summary(fit) #deviance 420.7735 with df = 3
1-pchisq(420.7735 - 404.2295, df = 19)
#cannot reject H_0 so that we just can use this model.


#Let's adjust alcohol, BMI, HBP, diabets, smoke
fit.multi = polr(as.factor(psoriasis) ~ income + 
              as.factor(alcohol) + BMI + as.factor(HBP) + as.factor(diabetes) + 
                as.factor(smoke), data = final.p)
summary(fit.multi)
#alcohol 1: regularly drinking alocohol : the odds of being >j vs being <= j is exp(-0.0504) = 0.95 (decrease 5%)
#BMI: as the BMI increase by 10, the odds of being >j vs being <= j is exp(10 * 0.009248) = 1.10 (increase 10%)
#HBP 1: high blood pressure: the odds of being >j vs being <= j is exp(-0.0707) = 0.93 (decrease 7%)
#diabetes 1: diabetes: the odds of being >j vs being <= j is exp(0.2257) = 1.25 (incrase 25%)
#smoke 1: smoker: the odds of being >j vs being <= j is exp(-0.1270) = 0.8807 (decrease 12%)


logitgof(final.p$psoriasis,ord=TRUE,fitted(fit.multi))

fit.vgam <- vglm(as.numeric(psoriasis) ~ income + alcohol + BMI + HBP + diabetes + smoke,
                 cumulative(parallel=TRUE, reverse=FALSE), final.p)
fit.vgam1 <- vglm(as.numeric(psoriasis) ~ income + alcohol + BMI + HBP + diabetes + smoke,
                  cumulative(parallel=FALSE, reverse=FALSE), final.p)
summary(fit.vgam) #419.3161 df = 424 is better. 
summary(fit.vgam1)#412.2302,df = 418
pchisq(419.3161-412.2302, df=6, lower.tail = FALSE)

predict(fit.multi, new.data = c())


exp(-0.2160 - 0.0863 * 1.96)
exp(-0.2160 + 0.0863 * 1.96)

exp(-0.2519 - 0.3019 * 1.96)
exp(-0.2519 + 0.3019 * 1.96)