clear; clc; close all;

% base variable
m1 = xlsread('m1.xlsx');
m2 = xlsread('m2.xlsx');
m3 = xlsread('m3.xlsx');
m4 = xlsread('m4.xlsx');

x0=10;
y0=10;
width=700;
height=500;

set(gcf,'position',[x0,y0,width,height])
dp = ["Dp_1" "Dp_2" "Dp_3" "Dp_4" "Dp_5" "Dp_6" "Dp_7" "Dp_8" "Dp_9" "Dp_{10}" "Dp_{11}" "Dp_{12}"];
       
% 1. MEAN of corr coef
subplot(2,1,1)
plot([1:12], m1, '-o');
% xlabel('Daily Propagation', 'FontSize',15)
ylabel('Mean', 'FontSize',15)
xlim([0.5 12.5]);
ylim([0.05 0.4]);
xticks([1:12]);
xticklabels(dp);
% set(gca, 'xticklabel', dp);

% 2. VARIANCE of corr coef
subplot(2,1,2)
plot([1:12], m2, '-o');
xlabel('Daily Propagation', 'FontSize',15)
ylabel('Variance', 'FontSize',15)
xlim([0.5 12.5]);
ylim([0.085 0.14]);
xticks([1:12]);
xticklabels(dp);
% set(gca, 'xticklabel', dp);

% 3. skewness of corr coef
% subplot(2,1,1)
% plot([1:12], m3, '-o');
% xlabel('Daily Propagation', 'FontSize',15)
% ylabel('Skewness', 'FontSize',15)
% xlim([0.5 12.5]);
% ylim([-0.7 -0.15]);
% xticks([1:12]);
% xticklabels(dp);
% set(gca, 'xticklabel', dp);
% 
% 4. kurtosis of corr coef
% subplot(2,1,2)
% plot([1:12], m4, '-o');
% xlabel('Daily Propagation', 'FontSize',15)
% ylabel('Kurtosis', 'FontSize',15)
% xlim([0.5 12.5]);
% ylim([2.4 3.1]);
% xticks([1:12]);
% xticklabels(dp);
% set(gca, 'xticklabel', dp);



