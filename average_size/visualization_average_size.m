clear; clc; close all;

% base variable
list = ls('average_length'); dir_list = list(3:end,:);

orig_dl = xlsread('average_length/1_orig_ntl');
mean_dl = xlsread('average_length/2_mean_ntl');
all_dl = xlsread('average_length/3_all_ntl');

dp = ["Dp_1" "Dp_2" "Dp_3" "Dp_4" "Dp_5" "Dp_6" "Dp_7" "Dp_8" "Dp_9" "Dp_{10}" "Dp_{11}" "Dp_{12}"];
       
my_yellow = [0.9856 0.7372 0.2537];
% 1. average length of original MST
% 
% box1 = [6 6 9 9];
% boxy1=[-1 1 1 -1]*max(orig_dl)*2;
% 
% plot([1:12], orig_dl, '-o');
% patch(box1,boxy1,[0 1 0], 'FaceAlpha',0.2, 'EdgeColor', 'none', 'FaceColor', my_yellow)
% 
% xlabel('Daily Propagation', 'FontSize',15)
% ylabel('Average size of MST', 'FontSize',15)
% xlim([0.5 12.5]);
% ylim([0.5 1]);
% xticks([1:12]);
% xticklabels(dp);
% set(gca, 'xticklabel', dp);
% 
% % add peak arrow
% ax = gca;
% pos = ax.Position;
% 
% normpx1 = pos(3)*(([6 6]-ax.XLim(1))./range(ax.XLim))+ pos(1);
% normpy1 = pos(4)*(([0.8+0.07 0.8+0.03]-ax.YLim(1))./range(ax.YLim))+ pos(2);
% 
% normpx2 = pos(3)*(([9 9]-ax.XLim(1))./range(ax.XLim))+ pos(1);
% normpy2 = pos(4)*(([0.74+0.07 0.74+0.03]-ax.YLim(1))./range(ax.YLim))+ pos(2);
% 
% annotation('arrow', normpx1, normpy1, 'Color', 'black', 'LineWidth', 1.7);
% annotation('arrow', normpx2, normpy2, 'Color', 'black', 'LineWidth', 1.7);




% % 2. mean of average length of subnetworks

% box2 = [6 6 9 9];
% boxy2=[-1 1 1 -1]*max(mean_dl)*2;
% 
% plot([1:12], mean_dl, '-o');
% patch(box2, boxy2, [0 1 0], 'FaceAlpha',0.2, 'EdgeColor', 'none', 'FaceColor', my_yellow)
% 
% xlabel('Daily Propagation', 'FontSize',15)
% ylabel('Mean of average size of subnetworks', 'FontSize',15)
% xlim([0.5 12.5]);
% ylim([0.5 1.5]);
% xticks([1:12]);
% xticklabels(dp);
% set(gca, 'xticklabel', dp);
% 
% ax = gca;
% pos = ax.Position;
% 
% normpx1 = pos(3)*(([6 6]-ax.XLim(1))./range(ax.XLim))+ pos(1);
% normpy1 = pos(4)*(([1.2+0.13 1.2+0.05]-ax.YLim(1))./range(ax.YLim))+ pos(2);
% 
% normpx2 = pos(3)*(([9 9]-ax.XLim(1))./range(ax.XLim))+ pos(1);
% normpy2 = pos(4)*(([1.17+0.13 1.17+0.05]-ax.YLim(1))./range(ax.YLim))+ pos(2);
% 
% annotation('arrow', normpx1, normpy1, 'Color', 'black', 'LineWidth', 1.7);
% annotation('arrow', normpx2, normpy2, 'Color', 'black', 'LineWidth', 1.7);



% 3. average length of subnetworks for all dp
lineStyles = {'-', '--', ':', '-.'};

myColors = ['r' 'b' 'k'];
j=1;
for i=1:12
    plot(1:15, all_dl(i,:), 'linestyle', lineStyles{rem(i-1,numel(lineStyles))+1}, 'color', myColors(j),'LineWidth', 1.5);
    xlim([0.5 15.5]);
    ylim([0.5 1.5]);
    xticks([1:15]);
    xticklabels([(0:14)])
    colormap(hsv);
    xlabel('Rank', 'FontSize',15)
    ylabel('Average size of subnetworks', 'FontSize',15)

    hold on
    if mod(i,4)==0
        j = j+1;
    end    
end
box3 = [2 2 5 5];
boxy3=[-1 1 1 -1]*max(max(all_dl))*2;
patch(box3, boxy3, [0 1 0], 'FaceAlpha',0.2, 'EdgeColor', 'none', 'FaceColor', my_yellow)
legend(dp, 'Location', 'southeast', 'NumColumns',4, 'Orientation', 'horizontal');




