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

cv = matrix(0, ncol=12)
radius = matrix(0, ncol=12)
for (i in 1:12){
  coef.corr <- rcorr(as.matrix(modif1_data[start:end,]), type = "pearson")  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr$r)) # compute distance  
  
  links<-as.data.frame(as.table(coef.d)) # creates a table of three columns for each correlation among two variables   
  colnames(links)[3]="weight"  #Rename the third columns as "weight"
  
  nodes<-stock_id  
  g <- graph_from_data_frame(d=links, vertices=nodes, directed=F)
  mst <- mst(g, algorithm="prim")
  
  df_mst <- as_long_data_frame(mst)
  central_v = which.max(degree(mst))
  cv[i] = which.max(degree(mst))
  
  all_paths = all_simple_paths(mst, from=central_v, to=V(mst), cutoff=-1)
  
  all_dists = matrix(0, ncol=length(all_paths))
  for (pp in 1:length(all_paths)){
    for (qq in 1:(length(all_paths[[pp]])-1)){
      aa = all_paths[[pp]][qq]
      bb = all_paths[[pp]][qq+1]
      all_dists[pp] = all_dists[pp] + distances(mst, v=aa, to=bb)
    }
  }
  radius[i] = max(all_dists)  
  
  start = start + step
  end = end + step
}

write_xlsx(as.data.frame(radius), path="radius.xlsx")


