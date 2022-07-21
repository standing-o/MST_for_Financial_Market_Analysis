# Packages
library(Hmisc)
library(vegan)
library(clue)
library(tidyverse)
library(readxl)
library(stats)
library(igraph)
library(affy)
library(estrogen)
library(vsn)
library(genefilter)
library(demography)
library(latex2exp)
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

# MST
start = 1
end = 10
step = 1

n = 30
num = n/2   # n/2

modif_cv = array(0, dim = c(12,15,30))
modif_degree = array(0, dim = c(12,15,2))
for (i in 1:1){
  coef.corr <- rcorr(as.matrix(modif1_data[start:end,]), type = "pearson")  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr$r)) # compute distance  
  
  links<-as.data.frame(as.table(coef.d)) # creates a table of three columns for each correlation among two variables   
  colnames(links)[3]="weight"  #Rename the third columns as "weight"
  
  nodes<-stock_id  
  g <- graph_from_data_frame(d=links, vertices=nodes, directed=F)
  mst <- mst(g, algorithm="prim")
  
  df_mst <- as_long_data_frame(mst)
  
  
  sorted_coef <- links[!(links$weight == 0),]   # delete i=j
  sorted_coef <- sorted_coef[(duplicated(sorted_coef$weight)), ]  # lower triangle
  
  for (m in 1:length(df_mst$weight)){
    sorted_coef <- sorted_coef[!(sorted_coef$weight == df_mst$weight[m]),]
  }  # delete elements inculded in mst
  
  
  sorted_coef <- sorted_coef[order(sorted_coef$weight), ]  # sort
  modif_mst <- mst
  
  modif_degree[i,1,1] = degree(mst)[which(stock_id == 'MSFT')]
  modif_degree[i,1,2] = degree(mst)[which(stock_id == 'TRV')]
  
  
  max_degree = which(degree(mst)==max(degree(mst)))
  
  for (p in 1:length(max_degree)){
    modif_cv[i,1,p] = stock_id[max_degree[p]]
  }
  
  degree
  
  for (j in 1:(num-1)){  ## n/2-1 (num-1)
    for (k in 1:(n-1)){  ##  n-1
      modif_mst <- add_edges(modif_mst, c(sorted_coef$Var1[(n-1)*(j-1)+k], sorted_coef$Var2[(n-1)*(j-1)+k]))
    }
    if (j==1){
      coords<-layout_(modif_mst, as_tree())
    }
    modif_degree[i,j+1,1] = degree(modif_mst)[which(stock_id == 'MSFT')]
    modif_degree[i,j+1,2] = degree(modif_mst)[which(stock_id == 'TRV')]  
      
    max_modif_degree = which(degree(modif_mst)==max(degree(modif_mst)))
    for (q in 1:length(max_modif_degree)){
      modif_cv[i,j+1,q] = stock_id[max_modif_degree[q]]
    }
    
  }
  
  
  start = start + step
  end = end + step
}

