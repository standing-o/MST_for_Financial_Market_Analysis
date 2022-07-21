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
library(ggplot2)
library(R.devices)

# Load dataset
setwd("D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/modif_dataset/")

dir="D:/Google 드라이브/Research/Stock_dynamical_model/Hierarchical structure/fixed_minutes_dataset/orig_dataset/"
day_list = substr(list.files(path=dir), 12, 21)

stock_id = c('MMM', 'AXP', 'AAPL', 'BA', 'CAT', 'CVX', 'CSCO', 'KO',
'DIS', 'DOW', 'XOM', 'GS', 'HD', 'IBM', 'INTC', 'JNJ', 'JPM', 'MCD', 'MRK', 'MSFT', 'NKE', 'PFE',
'PG', 'TRV', 'UNH', 'VZ', 'V', 'WMT', 'WBA', 'RTX')

modif1_data <- read.csv('modif_dataset1.csv', header = FALSE) # {s(i+1)-s(i)}/s(i) --> mean  (21 by 30)
modif_cv_dp1 <- read.csv('modif_central_vertex_dp1.csv', header = TRUE)
names(modif1_data) <- stock_id

# MST
start = 1
end = 10
step = 1

n = 30
num = n/2   # n/2
set.seed(7)

# palette

my_color <- c("lightblue", rev(heat.colors(28))[seq(11,28,2)])       #    RGB values 



for (i in 1:1){   ##12
  coef.corr <- rcorr(as.matrix(modif1_data[start:end,]), type = "pearson")  ## create the correlation coefficients
  coef.d <- sqrt(2*(1-coef.corr$r)) # compute distance  
  
  links<-as.data.frame(as.table(coef.d)) # creates a table of three columns for each correlation among two variables   
  colnames(links)[3]="weight"  #Rename the third columns as "weight"

  nodes <-stock_id  
  g <- graph_from_data_frame(d=links, vertices=nodes, directed=F)
  mst <- mst(g, algorithm="prim")
  
  MST <- as_data_frame(mst)
  
  set.seed(7)
  if (i==1){
    coords <- layout_(mst, with_lgl())  # as_tree, with_lgl
  }

  
  V(mst)[as.character(modif_cv_dp1$dp_1)]$color = as.character(my_color[modif_cv_dp1$Freq])
  
  
  png(file = paste("color_mst_dp",i,".png", sep=''), width=800, height=800)
  plot(mst, layout = coords, vertex.label.font = 2, edge.width = 2,
       edge.color = 'black',
       vertex.size=20, vertex.color = V(mst)$color, vertex.label.cex = 1.5, 
       vertex.label.color = 'black', cex.main=1.5)
  dev.off()
  
  
  start = start + step
  end = end + step
  
}





