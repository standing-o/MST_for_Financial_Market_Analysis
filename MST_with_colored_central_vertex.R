# Packages
library(Hmisc)
library(vegan)
library(clue)
library(tidyverse)
library(readxl)
library(stats)
library(dplyr)
library(igraph)
library(writexl)

# Load dataset
setwd("D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/modif_dataset/")

dir="D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/orig_dataset/"
day_list = substr(list.files(path=dir), 12, 21)

stock_id = c('MMM', 'AXP', 'AAPL', 'BA', 'CAT', 'CVX', 'CSCO', 'KO',
'DIS', 'DOW', 'XOM', 'GS', 'HD', 'IBM', 'INTC', 'JNJ', 'JPM', 'MCD', 'MRK', 'MSFT', 'NKE', 'PFE',
'PG', 'TRV', 'UNH', 'VZ', 'V', 'WMT', 'WBA', 'RTX')

modif1_data <- read.csv('modif_dataset1.csv', header = FALSE) # {s(i+1)-s(i)}/s(i) --> mean  (21 by 30)
names(modif1_data) <- stock_id

cv <- read.csv('central_vertex_all_dp.csv', header = FALSE)
all_cv <- cv[2:13, ]
set.seed(7)

# MST
start = 1
end = 10
step = 1
for (i in 1:1){   ##12
  setwd("D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/fig/")
  coef.corr <- rcorr(as.matrix(modif1_data[start:end,]), type = "pearson")  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr$r)) # compute distance  
  
  links<-as.data.frame(as.table(coef.d)) # creates a table of three columns for each correlation among two variables   
  colnames(links)[3]="weight"  #Rename the third columns as "weight"
  
  # write_xlsx(links, path=paste("links",i,".xlsx",sep=''))
  
  nodes <-stock_id  
  g <- graph_from_data_frame(d=links, vertices=nodes, directed=F)
  mst <- mst(g, algorithm="prim")
  
  MST <- as_data_frame(mst)
  # write_xlsx(MST, path=paste("MST",i,".xlsx",sep=''))
  
  set.seed(7)
  if (i==1){
    coords <- layout_(mst, with_lgl())  # as_tree, with_lgl
  }
  # write_xlsx(MST, path=paste("MST",i,".xlsx",sep=''))
  
  #   V(mst)$color <- ifelse(V(mst)==which.max(degree(mst)), "red", "lightblue")
  
  
  
  if (all_cv[i,2]!=0){
    V(mst)$color <- ifelse(V(mst)$name %in% all_cv[i,1:2], "red", "lightblue")
  }
  else{
    V(mst)$color <- ifelse(V(mst)$name %in% all_cv[i,1], "red", "lightblue")
  }
    
 
  
  png(filename = paste("mst_dp",i,".png", sep=''), width=800, height=800, unit="px")
  plot(mst, layout = coords, vertex.label.font = 2, edge.width = 2,
              edge.color = 'black',
              vertex.size=20, vertex.color = V(mst)$color, vertex.label.cex = 1.5, 
              vertex.label.color = 'black', cex.main=1.5)
  dev.off()

  
  start = start + step
  end = end + step
  
}


