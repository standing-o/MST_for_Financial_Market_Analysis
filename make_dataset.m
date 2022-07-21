clear; clc; close all;

% base variable
list = ls('orig_dataset'); dir_list = list(3:23,:);

[base_data, base_header] = xlsread(strjoin({'orig_dataset/',dir_list(1,:)},''));
allname = base_header(1,:);
name = allname(3:2:size(base_data,2)+1);

% first modified dataset : = {s(i+1)-s(i)}/s(i) --> mean  (21 by 30)
modif_1 = zeros(size(dir_list, 1), 30);

for i = 1:size(dir_list, 1)
    
    [data, header] = xlsread(strjoin({'orig_dataset/',dir_list(i, :)},''));
    matrix1 = data(:,2:2:size(data, 2));
    
    if isnan(matrix1(1,1))
        matrix1 = matrix1(2:size(data,1), :);
    end
    
    deri_mat = deri(matrix1);
    modif_1(i, :) = mean(deri_mat, 1);
    
end    

% second modified dataset : mean --> {s(i+1)-s(i)}/s(i) (20 by 30)
% mod2 = zeros(size(dir_list, 1), 30);
% for i = 1:size(dir_list, 1)
%     
%     [data, header] = xlsread(strjoin({'orig_dataset/',dir_list(i, :)},''));
%     matrix2 = data(:,2:2:size(data, 2));
%     
%     if isnan(matrix2(1,1))
%         matrix2 = matrix2(2:size(data,1), :);
%     end
%     
%     mod2(i, :) = mean(matrix2, 1);    
% end    
% 
% modif_2 = deri(mod2);


% filename = 'modif_dataset/modif_dataset1.xlsx';
% T1 = table(modif_1);
% writetable(T1, filename, 'Sheet','MyNewSheet','WriteVariableNames',false);
% 
% filename = 'modif_dataset/modif_dataset2.xlsx';
% T2 = table(modif_2);
% writetable(T2, filename, 'Sheet','MyNewSheet','WriteVariableNames',false);



