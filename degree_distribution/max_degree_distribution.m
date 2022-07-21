clear; clc; close all;

max_deg = xlsread('degree_distribution/all_max_deg.xlsx');







dp = ["Dp_1" "Dp_2" "Dp_3" "Dp_4" "Dp_5" "Dp_6" "Dp_7" "Dp_8" "Dp_9" "Dp_{10}" "Dp_{11}" "Dp_{12}"];
lineStyles = {'-', '--', ':', '-.'};

myColors = ['r' 'b' 'k'];
j=1;
for i=1:12
    plot(0:14, max_deg(i,:), 'linestyle', lineStyles{rem(i-1,numel(lineStyles))+1}, 'color', myColors(j),'LineWidth', 1);
    xlim([-0.5 14.5]);
    xticks([0:14]);
    xticklabels([0:14])
%     colormap(hsv);
    xlabel('Rank', 'FontSize',15)
    ylabel('Degree', 'FontSize',15)

    hold on
    if mod(i,4)==0
        j = j+1;
    end    
end    
legend(dp, 'Location', 'southeast', 'NumColumns',4, 'Orientation', 'horizontal');




