clear; clc; close all;

% base variable
rad = xlsread('radius');

x0=10;
y0=10;
width=700;
height=500;

set(gcf,'position',[x0,y0,width,height])
dp = ["Dp_1" "Dp_2" "Dp_3" "Dp_4" "Dp_5" "Dp_6" "Dp_7" "Dp_8" "Dp_9" "Dp_{10}" "Dp_{11}" "Dp_{12}"];

my_yellow = [0.9856 0.7372 0.2537];       
box = [5 5 8 8];
boxy=[-1 1 1 -1]*max(rad)*2;

% 1. radius of original MST
plot([1:12], rad, '-o');
patch(box, boxy,[0 1 0], 'FaceAlpha',0.2, 'EdgeColor', 'none', 'FaceColor', my_yellow)  % custom background box

hold on

xlabel('Daily Propagation', 'FontSize',15)
ylabel('Radius of MST', 'FontSize',15)
xlim([0.5 12.5]);
ylim([0 10]);
xticks([1:12]);
xticklabels(dp);
% set(gca, 'xticklabel', dp);

% add peak arrow
ax = gca;
pos = ax.Position;

normpx1 = pos(3)*(([5 5]-ax.XLim(1))./range(ax.XLim))+ pos(1);
normpy1 = pos(4)*(([7.8+1.2 7.8+0.5]-ax.YLim(1))./range(ax.YLim))+ pos(2);

normpx2 = pos(3)*(([8 8]-ax.XLim(1))./range(ax.XLim))+ pos(1);
normpy2 = pos(4)*(([7.4+1.2 7.4+0.5]-ax.YLim(1))./range(ax.YLim))+ pos(2);

annotation('arrow', normpx1, normpy1, 'Color', 'black', 'LineWidth', 1.7);
annotation('arrow', normpx2, normpy2, 'Color', 'black', 'LineWidth', 1.7);

% peak triangle arrow
% plot([5 8], [8.3 8] , 'v', 'MarkerFaceColor', 'k');  



