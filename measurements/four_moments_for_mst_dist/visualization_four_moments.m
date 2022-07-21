clear; clc; close all;

% base variable
m1 = xlsread('nm1.xlsx');
m2 = xlsread('nm2.xlsx');
m3 = xlsread('nm3.xlsx');
m4 = xlsread('nm4.xlsx');

x0=10;
y0=10;
width=700;
height=500;

set(gcf,'position',[x0,y0,width,height])
dp = ["Dp_1" "Dp_2" "Dp_3" "Dp_4" "Dp_5" "Dp_6" "Dp_7" "Dp_8" "Dp_9" "Dp_{10}" "Dp_{11}" "Dp_{12}"];
       
% % 1. MEAN of N-1 distances in MST
% subplot(2,1,1)
% plot([1:12], m1, '-o');
% % xlabel('Daily Propagation', 'FontSize',15)
% ylabel('Mean', 'FontSize',15)
% xlim([0.5 12.5]);
% ylim([0.6 0.85]);
% xticks([1:12]);
% xticklabels(dp);
% % set(gca, 'xticklabel', dp);
% 
% % 2. VARIANCE of N-1 distances in MST
% subplot(2,1,2)
% plot([1:12], m2, '-o');
% xlabel('Daily Propagation', 'FontSize',15)
% ylabel('Variance', 'FontSize',15)
% xlim([0.5 12.5]);
% ylim([0.01 0.035]);
% xticks([1:12]);
% xticklabels(dp);
% % set(gca, 'xticklabel', dp);

% 3. skewness of N-1 distances in MST
subplot(2,1,1)
plot([1:12], m3, '-o');
xlabel('Daily Propagation', 'FontSize',15)
ylabel('Skewness', 'FontSize',15)
xlim([0.5 12.5]);
ylim([-0.5 2.3]);
xticks([1:12]);
xticklabels(dp);
set(gca, 'xticklabel', dp);

% 4. kurtosis of N-1 distances in MST
subplot(2,1,2)
plot([1:12], m4, '-o');
xlabel('Daily Propagation', 'FontSize',15)
ylabel('Kurtosis', 'FontSize',15)
xlim([0.5 12.5]);
ylim([1.8 9]);
xticks([1:12]);
xticklabels(dp);
set(gca, 'xticklabel', dp);



