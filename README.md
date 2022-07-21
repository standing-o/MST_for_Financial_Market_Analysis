# MST for financial market analysis
- Building Minimal Spanning Tree (MST) using correlations between stocks

➔ [**`My advanced work`**](https://github.com/standing-o/Dynamic_asset_trees_for_ML)

- Feb. 1, 2022 ~ Present



## Overview

- We use the minimal spanning tree (MST) to identify the structure and dynamics of the US stock market. In particular, by using Dow Jones stock price dataset in  January 2020, we analyze the financial market movements when the COVID-19 just outbreak.

- In this study, we generate several sub-networks not only by using the baseline MST structure, but also by adding important correlations to the MST in turn.  By doing this, we analyze several measurements for MST and its sub-networks:
  - **Average size** of the MSTs and all sub-networks observed in the daily propagations.
  - **Central node** of the MSTs and all sub-networks observed in the daily propagations.
  - **Degree** of the central node of the MSTs for the daily propagations.
  - **Radius** of the MST for the daily propagations.
  - **Mean, variance, skewness, kurtosis** for the correlation coefficients and distances of MSTs for the daily propagation.


## Dataset

- Dow Jones Industrial Average observed every minute during January 2020 (21 days)
- We calculate the returns per minute of the closing prices of the stocks. The return per minute of i stock at time t on date k follows:
<img src="https://latex.codecogs.com/svg.latex?\Large&space;r_i^t=\frac{P_i^k(t+1)-P_i^k(t)}{P_i^k(t)}" width=25%>
,where t+1 is the time one minute after time t.

- And the average prices per day is calculated with the returns per minute above:   
<img src="https://latex.codecogs.com/svg.latex?\Large&space;y_i^k=\frac{1}{N}\sum_{t=1}^{N}r_i^k(t)" width=18%>
,where N is the total number of returns in one day.   
   
➔ As a result, we get a matrix of size 21 by 30. (21 is the number of days in January 2020 and 30 is the number of stocks)   

- We set the window width as 10 days, shifting 1 day. That is, we perform the daily propagation (DP) 12 times for our dataset.

## Minimal Spanning Tree (MST)
- We analyze the correlation-based networks (Mantegna, 1999), which has been the basis of many works for the last two decades.

- First, we obtain the correlation coefficients from the returns of all the stocks:
<img src = "https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/corr_formula.png" width=60%>   
,where <...><sub>m</sub> indicates a time average over the consecutive m days.   

- And, we convert the correlation coefficients into distances:
<img src="https://latex.codecogs.com/svg.latex?\Large&space;d_{ij}=\sqrt{2(1-\rho_{ij})}" width=20%>   
➔ This allows us to get a distance matrix of 30 by 30 size, which is symmetric. That is, considering the entries above(below) the main diagonal of this matrix, a total of 435 (30*30/2 - 15) distances can be obtained.   

- For the distances, we construct the minimal spanning tree (MST) connecting the n stocks using the Prim's algorithm. This network is a connected graph with 29 edges.
- We mainly used the [`igraph`](https://igraph.org/r/doc/mst.html) package of `R` to implement MSTs.
- The MST structures observed for the dataset of the first 10 days:
<img src = 'https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/mst_dp1.png' width=40%>    
➔ The red node is central vertex defined as the node with the largest degree in this study.   

- The **average size** of MSTs and the **radius** of MSTs follow:
<img src='D:\Desktop\Github\MST_for_financial_market_analysis\figs\average_size_of_mst.png' width=40%><img src='D:\Desktop\Github\MST_for_financial_market_analysis\figs\radius_of_mst.png' width=40%>   
   
➔ The average size is a modified version of the normalized tree length (13) and defined as follows:   
<img src="https://latex.codecogs.com/svg.latex?\Large&space;A_s(N)=\frac{1}{n-1}\sum_{d_{ij}\in{N}}d_{ij}" width=25%>   
,where N is the network and n is the number of the nodes in tree N.   
   
➔ The radius is given by:   
<img src="https://latex.codecogs.com/svg.latex?\Large&space;R(MST)=\sum_{d_{ij}\in{\tau_r}}d_{ij}" width=25%>   
,where &tau;<sub>ms</sub> and d<sub>ij</sub> are the trail path from the central node of MST and the distance weight between two consecutive nodes i and j on MST.   

- Comparison of four moments between the correlation coefficients and distances of MSTs
  - Four moments of the correlation coefficients:
  <img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/corr_mean_var.png' width=40%><img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/corr_skew_kurt.png' width=40%>   

  - Four moments of the distances of MSTs:
  <img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/mst_dist_mean_var.png' width=40%><img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/mst_dist_mean_var.png' width=40%>   

## Sub-networks derived from MST

- The sub-network of rank k is obtained by adding n-1 new links increasing distance weights to the subnetwork of rank k-1. (k=0,...,14)
➔ n is the number of nodes in tree and the sub-network of rank 0 is the same as MST.   
  
- All possible sub-networks of the first 10 days:
<img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/all_subnetworks_for_dp1.png' width=80%>   

- The **average size** of all sub-networks and **mean of average size** of all sub-networks follow:
<img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/average_size_of_all_subnetworks.png' width=40%><img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/mean_of_average_size_of_all_subnetworks.png' width=40%>   

- **Degree** of **central vertex** for all sub-networks and **degree distribution** of all sub-networks of the first 10 days:
<img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/degree_of_central_vertex_for_subnetworks.png' width=40%'><img src='https://github.com/standing-o/MST_for_financial_market_analysis/blob/master/figs/dp1_degree_distribution_of_subnetworks.png' width=60%>   

## Info
- Authors : GWANGIL KIM, SEOYOUNG OH, DOOBAE JUN









