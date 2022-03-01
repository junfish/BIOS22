data_name = '692';
% Traverse the hyperparameter CP-rank R here
Y_ind = 1;
for R = 1:100
    run_exp(strcat('knn-3_rbf_', data_name, '_116'), Y_ind, R);
    run_exp(strcat('knn-4_rbf_', data_name, '_116'), Y_ind, R);
end
