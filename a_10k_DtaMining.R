#Calling Packages
library(xlsx);library(rJava);library(ggplot2)
library(summarytools);library(dplyr);library(tidyr)
library(splitstackshape);library(plyr)

#import data set
wk <- read.csv("/Users/yerikovargas/Documents/FCA/SM.csv")

#names and levels 
names(wk)

#Types of variables and levels #str(wk)
#Histogram Net Margin #hist(wk$NetMargin)

#Expanding categories  (108 levels)
wk$cat <- gsub("\\*","", wk$Configuration)

gc <- cSplit_e(data = wk, split.col = "cat", sep = ",", mode = "binary",
               type = "character", fill = "0", drop = FALSE)  

#for >10,000
gc$d.nm <- ifelse(wk$NetMargin > 10000, "1", "0")

#for >12,000
#gc$d.nm <- ifelse(wk$NetMargin > 12000, "1", "0")

table(gc$d.nm)

## 75% of the sample size
smp_size <- floor(1.0* nrow(gc))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(gc)), size = smp_size)
train_GC <- gc#[train_ind, ]
test_GC <- gc[-train_ind, ]
names(train_GC)


########################end---------------------------------------**********************************
########################end---------------------------------------**********************************

