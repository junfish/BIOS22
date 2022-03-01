function SURF = run_exp(data_name, Y_ind, R); % Y_ind is used for the response value selection
clc;
addpath('./Methods/proposed_code/tensorlab/');

method_name = 'SURF';

%% Initialize
data         = load(data_name);
sample_num   = size(data.Xt,1);
Nt           = size(data.Xt,2);
trainInd     = data.trainInd;
testInd      = data.testInd;
t            = 5;                   % for 5-fold cross validation
rng('default');


%% Run methods to match different input format
X = data.Xt;
Y = data.Y;
% Y = Y(:, Y_ind);
Y = my_normalize(Y(:, Y_ind));
% Xten = data.Xten;
for i = 1:t
    fprintf('The %d th repeat \n',i);
    if ndims(data.Xten)==3
        Xtrain = data.Xten(:,:,trainInd{i,1});
    elseif ndims(data.Xten)==4
        Xtrain = data.Xten(:,:,:,trainInd{i,1});
    end
    time1 = cputime;
    [~,~,Wt,~,~,~,~,~] = main_SURF(Xtrain, X(trainInd{i,1},:),Y(trainInd{i,1}), R); 
    Xtest    = X(testInd{i,1},:);
    Ytest = Xtest * Wt';
    Ytest = sum(Ytest,2);
    time(i) = cputime - time1;
    RMSE(i) = sqrt(mse(Y(testInd{i,1}), Ytest));
    S(i)    = sum(sum(Wt,1)==0)/Nt;
    W{i}    = Wt;
end
SURF = struct();
SURF.RMSE = RMSE;
SURF.S = S;
SURF.W = W;
SURF.time = time;
dir_name = strcat('./Methods/results/',method_name,'/',int2str(sample_num));
if ~isfolder(dir_name)
    mkdir(dir_name)
end
filename = strcat(dir_name,'/',data_name,'_y',int2str(Y_ind));
% filename = strcat('./Methods/results/R_y1/',data_name,'_',int2str(R));
save([filename '.mat'],'SURF');
result = [mean(RMSE), mean(S), mean(time); ...
          std(RMSE), std(S), std(time)];
csvwrite([filename '.csv'], result);
       
end
% end
