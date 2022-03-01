clc, clear
K_values = [10 20 30 40 50 60 70 80 90 100 110 116];
% K_values = 1:116;
data_name = '692';

% % run experiments for tensor with the size of 692 * 116 * 3
load(strcat('newADNI_', data_name, '_116_3'))
for Y_ind = 1:3
    run_exp(strcat('newADNI_', data_name, '_116_3'), Y_ind);
end
% % run experiments for tensor with the size of 692 * 116 * 116
for i = 1:12
    for Y_ind = 1:3
        run_exp(strcat('knn-3_rbf_', data_name, '_', int2str(K_values(i))), Y_ind);
    end
end
% 
% % run experiments for tensor with the size of 692 * 116 * 116 *3
for i = 1:12
    for Y_ind = 1:3
        run_exp(strcat('knn-4_rbf_', data_name, '_', int2str(K_values(i))), Y_ind);
    end
end
% % run experiments for tensor with the size of 692 * 116 * 116
for i = 1:12
    for Y_ind = 1:3
        run_exp(strcat('sym_knn-3_rbf_', data_name, '_', int2str(K_values(i))), Y_ind);
    end
end
% 110 y2 y3

% run experiments for tensor with the size of 692 * 116 * 116 *3
for i = 1:12
    for Y_ind = 1:3
        run_exp(strcat('sym_knn-4_rbf_', data_name, '_', int2str(K_values(i))), Y_ind);
    end
end

