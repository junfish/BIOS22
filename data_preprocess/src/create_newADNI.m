clc, clear
% this code file is stored in /Users/jasonyu/Research Projects/MICCAI22/DataPreprocess/src
% cd into .../MICCAI22/

% # < 1 --> 388 participants --> Final_dataset_no_date_diff.xlsx
% # < 1 and no error --> 365 participants --> Final_dataset_no_date_diff_no_error.xlsx
%  
% # < 8 --> 595 participants --> Final_dataset_7_date_diff.xlsx
% # < 8 and no error --> 566 participants --> Final_dataset_7_date_diff_no_error.xlsx
% 
% # < 15 --> 680 participants --> Final_dataset_14_date_diff.xlsx
% # < 15 and no error --> 649 participants --> Final_dataset_14_date_diff_no_error.xlsx
% 
% # < 21 --> 709 participants --> Final_dataset_20_date_diff.xlsx
% # < 21 and no error --> 674 participants --> Final_dataset_20_date_diff_no_error.xlsx
% 
% # < 31 --> 725 participants --> Final_dataset_30_date_diff.xlsx                          %% unique: 723
% # < 31 and no error --> 688 participants --> Final_dataset_30_date_diff_no_error.xlsx
% 
% # < 61 --> 731 participants --> Final_dataset_60_date_diff.xlsx
% # < 61 and no error --> 694 participants --> Final_dataset_60_date_diff_no_error.xlsx    %% unique: 692
% 
% # < 81 --> 735 participants --> Final_dataset_80_date_diff.xlsx                          %% unique: 733
% # < 81 and no error --> 697 participants --> Final_dataset_80_date_diff_no_error.xlsx    

load("./DataPreprocess/data/data_original/ADNI.mat")
data_name = '30_date_diff';
T = readtable(['./DataPreprocess/data/data_after_process/Final_dataset_' data_name '.xlsx']);
% IID = xlsread('./data/data_after_process/Final_dataset_date_diff_20_no_error.xlsx', 'A2:D675');
% [Scores, ~, ~] = xlsread('./data/data_after_process/Final_dataset_date_diff_20_no_error.xlsx', 'B2:D675');

% IID transformation from 023S0031 to 1023_S_0031
T.IID = insertAfter(T.IID, 4 * ones(size(T.IID, 1), 1), "_");
T.IID = insertAfter(T.IID, 3 * ones(size(T.IID, 1), 1), "_");
T.IID = insertAfter(T.IID, zeros(size(T.IID, 1), 1), "1");


% for index = 1:newADNI.sbjNum
%     new_str = insertAfter("1" + IID{index, 1}, 4, "_");
% end

unique_T = unique(T);
% index_array = find_index(T.IID, ADNI.sbjID);
% [index_array, unique_index] = unique(index_array,'stable');
% IID = IID(unique_index', 1);
% Scores = Scores(unique_index', :);

newADNI.sbjID = unique_T.IID;
newADNI.AD_stage = unique_T.AD_label;
newADNI.adas13 = unique_T.adas13;
newADNI.MMSE = unique_T.MMSE;
newADNI.QT_ID = ADNI.QT_ID;
index_array = find_index(unique_T.IID, ADNI.sbjID);
newADNI.imgData{1, 1} = ADNI.imgData{1, 1}(index_array, :);
newADNI.imgData{1, 2} = ADNI.imgData{1, 2}(index_array, :);
newADNI.imgData{1, 3} = ADNI.imgData{1, 3}(index_array, :);

newADNI.roiNum = size(newADNI.imgData{1, 1}, 2);
newADNI.modalityNum = size(newADNI.imgData, 2);
newADNI.sbjNum = size(unique_T.IID, 1);

% count the number of participants in each class
Count = zeros(1, 5);
for class_index = 1:5
    Count(1, class_index) = sum(unique_T.AD_label == class_index);
end

newADNI.COUNT = Count;
save(['./DataPreprocess/data/data_pack/newADNI_' int2str(newADNI.sbjNum) '.mat'], "newADNI")

function [index_array] = find_index(IID, sbjID)
    index_array = zeros(1, size(IID, 1));
    for i = 1:size(IID, 1)
        for j = 1:size(sbjID, 1)
            if IID{i, 1} == sbjID{j, 1}
                index_array(1, i) = j;
            end
        end
    end
end