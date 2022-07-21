library(vegan)
library(clue)
library(tidyverse)
library(readxl)
library(expm)
library(writexl)
# Load dataset
setwd("D:/GoogleDrive/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/modif_dataset/")

dir="D:/GoogleDrive/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/orig_dataset/"
day_list = substr(list.files(path=dir), 12, 21)

stock_id = c('MMM', 'AXP', 'AAPL', 'BA', 'CAT', 'CVX', 'CSCO', 'KO',
'DIS', 'DOW', 'XOM', 'GS', 'HD', 'IBM', 'INTC', 'JNJ', 'JPM', 'MCD', 'MRK', 'MSFT', 'NKE', 'PFE',
'PG', 'TRV', 'UNH', 'VZ', 'V', 'WMT', 'WBA', 'RTX')

modif1_data <- read.csv('modif_dataset1.csv', header = FALSE) # {s(i+1)-s(i)}/s(i) --> mean  (21 by 30)
names(modif1_data) <- stock_id


start = 1
end = 10
step = 1

N = 30  # the number of stocks

max = 12
# four moments
m_1 <- matrix(0, ncol=max, nrow=1)
m_2 <- matrix(0, ncol=max, nrow=1)
m_3 <- matrix(0, ncol=max, nrow=1)
m_4 <- matrix(0, ncol=max, nrow=1)

for (i in 1:max){
  coef.corr <- cor(modif1_data[start:end,])  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr)) # compute distance  
  d <- as.dist(as.matrix(coef.d)) # find distance matrix 
  
  # Function spantree finds a minimum spanning tree (MST) connecting all points, 
  # but disregarding dissimilarities that are at or above the threshold or NA.
  
  tr <- spantree(d)
  
  ## Plot as a dendrogram
  cl <- as.hclust(tr)
  # plot(cl, main = paste("Hierarchical tree associated with MST from", day_list[start]," to ", day_list[end]))
  
  lower_corr <- coef.corr[lower.tri(coef.corr, diag = FALSE)]
  # 1. mean correlation coefficient
  m_1[,i] <- (1/(N*(N-1)/2))*sum(lower_corr)
  
  # 2. variance
  m_2[,i] <- (1/(N*(N-1)/2))*sum((lower_corr - m_1[,i])^2)
  
  # 3. skewness
  m_3[,i] <- (1/(N*(N-1)/2))*sum(((lower_corr - m_1[,i])^3)/(m_2[,i]^(3/2)))
  
  # 4. kurtosis
  m_4[,i] <- (1/(N*(N-1)/2))*sum(((lower_corr - m_1[,i])^4)/(m_2[,i]^2))
  start = start + step
  end = end + step
}
write_xlsx(as.data.frame(m_1), path="m1.xlsx")
write_xlsx(as.data.frame(m_2), path="m2.xlsx")
write_xlsx(as.data.frame(m_3), path="m3.xlsx")
write_xlsx(as.data.frame(m_4), path="m4.xlsx")