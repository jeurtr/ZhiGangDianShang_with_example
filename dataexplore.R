##clear workplace
rm(list=ls())
##set working directory
setwd('C:/Users/dell/Desktop/�Ǹɵ���/data/reviews-20170810')

##load data
data<-read.csv('./1.csv',header=T,encoding = 'utf-8')

#load packages
library(sqldf)
library(ggplot2)
library(parallel)
library(doParallel)
library(ggthemes)    #pictures themes
library(Hmisc)

#parallel processing set up
n_CORES<-detectCores()  #���CPU����
cluster_set<-makeCluster(n_CORES) #���в�������
registerDoParallel(cluster_set)

##
head(data)
describe(data)

##����ҵ�����ȥ��author
data1<-data[-6]
head(data1)

##CommentNum
table(data1$CommentNum)
hist(data1$CommentNum)  #96%����Ϊ0��ȥ��
data2<-data1[-10]
head(data2)

##ReviewDate
#��ת��ΪageReview��ȥ��
data3<-data2[-6]
write.csv(data3,'data3.csv')


##HelpfulVote
table(data3$HelpfulVote) #74.9Ϊ0
hist(data3$HelpfulVote)

##VerifiedPurchase
table(data3$VerifiedPurchase) 
hist(data3$VerifiedPurchase)  #90.8%Ϊvp

##REviewSum�ֲ����
REviewSum<-sqldf('select distinct Asin,ReviewSum
      from data3
      order by Asin')
hist(REviewSum$ReviewSum)
table(REviewSum$ReviewSum)
describe(REviewSum$ReviewSum)



data1<-sqldf('select distinct Asin,star,count(1)
             from data
             group by Asin,star
             order by Asin,star')

mode(data1$Star)
as.numeric(data1$Star)

write.csv(data1,'data1.csv')

##
data2<-sqldf('select distinct Asin,StarSum
             from data
             order by Asin')

write.csv(data2,'data2.csv')

##
data3<-sqldf('select  *
             from data
             where Asin="B00004R9XT"
             ')
##
table(data$CommentNum)
hist(data$CommentNum)