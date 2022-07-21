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
library(randomcoloR)
library(writexl)
library(latex2exp)


# Load dataset
setwd("D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/modif_dataset/")

dir="D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/orig_dataset/"
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
max = 9
num = n/2   # n/2

ntl <- matrix(0, ncol=num, nrow=12)

for (i in 1:12){
  coef.corr <- rcorr(as.matrix(modif1_data[start:end,]), type = "pearson")  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr$r)) # compute distance  
  
  links<-as.data.frame(as.table(coef.d)) # creates a table of three columns for each correlation among two variables   
  colnames(links)[3]="weight"  #Rename the third columns as "weight"
  # write.csv(links, file="links.csv") 
  
  nodes<-stock_id  
  g <- graph_from_data_frame(d=links, vertices=nodes, directed=F)
  mst <- mst(g, algorithm="prim")
  
  df_mst <- as_long_data_frame(mst)
  sorted_coef <- links[!(links$weight == 0),]   # delete i=j
  sorted_coef <- sorted_coef[(duplicated(sorted_coef$weight)), ]  # lower triangle
  
  
  for (m in 1:length(df_mst$weight)){
    sorted_coef <- sorted_coef[!(sorted_coef$weight == df_mst$weight[m]),]
  }  # delete elements inculded in mst
  
  

  
  ntl[i,1] <- (1/(length(df_mst$weight)))*sum(df_mst$weight)
  
  modif_mst <- mst
  
  
  
  for (j in 1:(num-1)){  ## n/2-1
    for (k in 1:(n-1)){  ##  n-1
      modif_mst <- add_edges(modif_mst, c(sorted_coef$Var1[(n-1)*(j-1)+k], sorted_coef$Var2[(n-1)*(j-1)+k]), weight = sorted_coef$weight[(n-1)*(j-1)+k])
    }

    df_modif_mst <- as_long_data_frame(modif_mst)
    
    # normalized tree length
    ntl[i,j+1] <- (1/(length(df_modif_mst$weight)))*sum(df_modif_mst$weight)

  }
  start = start + step
  end = end + step
  

}

write_xlsx(as.data.frame(ntl), path = "3_all_ntl.xlsx")


