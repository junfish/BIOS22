clc,clear
data_name = '692';
load(strcat('newADNI_', data_name, '_116_3'))

folder_name_1 = strcat(data_name, '_116_116');
fileFolder=fullfile(strcat('./DataPreprocess/data/data_pack/', folder_name_1));
dirOutput=dir(fullfile(fileFolder,'*.mat'));
fileNames={dirOutput.name};
for i = 1:size(fileNames, 2)
    X = load(fileNames{1, i}).X;
    Xt = load(fileNames{1, i}).Xt;
    Xten = load(fileNames{1, i}).Xten;
    save(strcat('./DataPreprocess/data/data_pack/', folder_name_1, '/', fileNames{1, i}), 'X', 'Xt', 'Xten', 'Y', 'testInd', 'trainInd')
end

folder_name_2 = strcat(data_name, '_116_116_3');
fileFolder=fullfile(strcat('./DataPreprocess/data/data_pack/', folder_name_2));
dirOutput=dir(fullfile(fileFolder,'*.mat'));
fileNames={dirOutput.name};
for i = 1:size(fileNames, 2)
    X = load(fileNames{1, i}).X;
    Xt = load(fileNames{1, i}).Xt;
    Xten = load(fileNames{1, i}).Xten;
    save(strcat('./DataPreprocess/data/data_pack/', folder_name_2, '/', fileNames{1, i}), 'X', 'Xt', 'Xten', 'Y', 'testInd', 'trainInd')
end

sym_folder_name_1 = strcat('sym_', data_name, '_116_116');
fileFolder=fullfile(strcat('./DataPreprocess/data/data_pack/', sym_folder_name_1));
dirOutput=dir(fullfile(fileFolder,'*.mat'));
fileNames={dirOutput.name};
for i = 1:size(fileNames, 2)
    X = load(fileNames{1, i}).X;
    Xt = load(fileNames{1, i}).Xt;
    Xten = load(fileNames{1, i}).Xten;
    save(strcat('./DataPreprocess/data/data_pack/', sym_folder_name_1, '/', fileNames{1, i}), 'X', 'Xt', 'Xten', 'Y', 'testInd', 'trainInd')
end

sym_folder_name_2 = strcat('sym_', data_name, '_116_116_3');
fileFolder=fullfile(strcat('./DataPreprocess/data/data_pack/', sym_folder_name_2));
dirOutput=dir(fullfile(fileFolder,'*.mat'));
fileNames={dirOutput.name};
for i = 1:size(fileNames, 2)
    X = load(fileNames{1, i}).X;
    Xt = load(fileNames{1, i}).Xt;
    Xten = load(fileNames{1, i}).Xten;
    save(strcat('./DataPreprocess/data/data_pack/', sym_folder_name_2, '/', fileNames{1, i}), 'X', 'Xt', 'Xten', 'Y', 'testInd', 'trainInd')
end