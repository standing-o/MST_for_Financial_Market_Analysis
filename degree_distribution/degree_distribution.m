clear; clc; close all;

% base variable
orig_rf = xlsread('degree_distribution/orig_relafreq_dp_12.xlsx');
rf = xlsread('degree_distribution/relafreq_dp_12.xlsx');
relafreq = [orig_rf rf];
max_deg = xlsread('degree_distribution/all_max_deg.xlsx');

x0=10;
y0=10;
width=1000;
height=800;
set(gcf,'position',[x0,y0,width,height])


% 3D degree distribution : x(degree), y(Dp), z(rf)
h=bar3(relafreq);



for i = 1:numel(h)
  index = logical(kron(relafreq(:, i) == 0, ones(6, 1)));
  zData = get(h(i), 'ZData');
  zData(index, :) = nan;

  set(h(i), 'ZData', zData);
end
hold on

max_relafreq = zeros(1,15);
% for k = 1:15
%     max_relafreq(k) = relafreq(max_deg(1,k)+1, k);
% end    

plot3(1:15, max_deg(1,:)+1, max_relafreq, 'r', 'LineWidth', 3)

set(gca,'color', [0.8 0.8 0.8]);
colormap default
xlabel('Number of links added to MST', 'FontSize',15)
ylabel('Degree', 'FontSize',15)
zlabel('Relative Frequencys', 'FontSize',15)
xticks([1:2:15]);
xticklabels([(0:2:14)*29]);

ylim([0.5 30.5]);
yticks([1:2:30]);
yticklabels([(0:2:29)]);

xh = get(gca,'XLabel'); % Handle of the x label
% set(xh, 'Units', 'Normalized')
pos = get(xh, 'Position');
set(xh, 'Position',pos.*[1.5 1 1], 'Rotation', 20)

yh = get(gca,'YLabel'); % Handle of the y label
% set(yh, 'Units', 'Normalized')
pos = get(yh, 'Position');
set(yh, 'Position',pos.*[1 0.7 1.5],'Rotation',-35)

zh = get(gca,'ZLabel'); % Handle of the y label
% set(yh, 'Units', 'Normalized')
pos = get(zh, 'Position');
set(zh, 'Position',pos.*[2 1 1])




