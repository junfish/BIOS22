clc,clear
% this code file is stored in /Users/jasonyu/Research Projects/MICCAI22/DataPreprocess/src
% cd into .../MICCAI22/

% # < 1 --> 388 participants
% # < 1 and no error --> 365 participants
% 
% # < 8 --> 595 participants
% # < 8 and no error --> 566 participants
% 
% # < 15 --> 680 participants
% # < 15 and no error --> 649 participants
% 
% # < 21 --> 709 participants
% # < 21 and no error --> 674 participants
% 
% # < 31 --> 725 participants
% # < 31 and no error --> 688 participants
% 
% # < 61 --> 731 participants
% # < 61 and no error --> 694 participants   %% unique: 692
% 
% # < 81 --> 735 participants   %% 733
% # < 81 and no error --> 697 participants

data_name = '723';
foldNum = 5;

load(['./DataPreprocess/data/data_pack/newADNI_' data_name '.mat'])
imgData = getfield(newADNI, 'imgData');

x1 = imgData{1, 1};
x2 = imgData{1, 2};
x3 = imgData{1, 3};

% stack the imgData
X = zeros(newADNI.sbjNum, newADNI.roiNum, newADNI.modalityNum);
X(:,:,1) = x1;
X(:,:,2) = x2;
X(:,:,3) = x3;

Xten = permute(X, [2 3 1]);
% X(:,348+1:348*2) = X;
% X(:,348*2 + 1:348*3) = X(:,1:348);

X = reshape(Xten, newADNI.roiNum * newADNI.modalityNum, newADNI.sbjNum)';
Xt = X;

Y = zeros(newADNI.sbjNum, 3);
Y(:, 1) = getfield(newADNI, 'AD_stage');
Y(:, 2) = getfield(newADNI, 'adas13');
Y(:, 3) = getfield(newADNI, 'MMSE');

trainNum = round(newADNI.sbjNum * 5 / 6);

for i = 1:foldNum
    index = randperm(newADNI.sbjNum);
    trainidx = index(:,1:trainNum).';
    testidx = index(:,trainNum + 1:newADNI.sbjNum);
    trainInd(i,1) = {trainidx};
    testInd(i,1) = {testidx};
end

save(['./DataPreprocess/data/data_pack/newADNI_' int2str(newADNI.sbjNum) '_' int2str(newADNI.roiNum) '_' int2str(newADNI.modalityNum) '.mat'], ...
    'X', 'Xt', 'Xten', 'Y', 'testInd', 'trainInd')

