clc,clear
data_name = '692';
Xtt = load(strcat('newADNI_', data_name, '_116_3'), 'Xten').Xten;
load(strcat('newADNI_', data_name, '_116_3'), 'testInd', 'trainInd', 'Y');
[feature_num, modality_num, sample_num] = size(Xtt);

K_values = [10 20 30 40 50 60 70 80 90 100 110 116];

knn_3_tensor = zeros(feature_num, feature_num, sample_num);
knn_4_tensor = zeros(feature_num, feature_num, modality_num, sample_num);

for i = 1:sample_num
    knn_3_tensor(:,:,i) = rbf_sim(Xtt(:,:,i));
    for j = 1:modality_num
        knn_4_tensor(:,:,j,i) = rbf_sim(Xtt(:,j,i));
    end
end


for i = 1:size(K_values, 2)
    [sorted_knn_3_tensor, index_3] = sort(knn_3_tensor,2);
    select_3_index = index_3(:,1:K_values(i),:);
    knn_3_save_tensor = zeros(size(knn_3_tensor));

    [sorted_knn_4_tensor, index_4] = sort(knn_4_tensor,2);
    select_4_index = index_4(:,1:K_values(i),:,:);
    knn_4_save_tensor = zeros(size(knn_4_tensor));
    for f_index = 1:feature_num
        for s_index = 1:sample_num
            for sort_index = 1:K_values(i)
                knn_3_save_tensor(f_index, select_3_index(f_index,sort_index,s_index), s_index) ...
                = knn_3_tensor(f_index, select_3_index(f_index,sort_index,s_index), s_index);
                for m_index = 1:modality_num
                    knn_4_save_tensor(f_index, select_4_index(f_index,sort_index,m_index,s_index), m_index, s_index) ...
                    = knn_4_tensor(f_index, select_4_index(f_index,sort_index,m_index,s_index), m_index, s_index);
                end
            end
        end
    end

    
    dir_name = strcat('./DataPreprocess/data/data_pack/',int2str(sample_num),'_116_116');
    if ~isfolder(dir_name)
        mkdir(dir_name)
    end
    X = reshape(permute(knn_3_save_tensor, [2 1 3]), feature_num*feature_num, sample_num)';
    Xt = X;
    Xten = knn_3_save_tensor;
    save(strcat(dir_name,'/knn-3_rbf_',int2str(sample_num),'_',int2str(K_values(i)),'.mat'),'X','Xt','Xten','Y','testInd','trainInd');

    dir_name = strcat('./DataPreprocess/data/data_pack/',int2str(sample_num),'_116_116_3');
    if ~isfolder(dir_name)
        mkdir(dir_name)
    end
    X = reshape(permute(knn_4_save_tensor, [2 1 3 4]), feature_num*feature_num*modality_num, sample_num)';
    Xt = X;
    Xten = knn_4_save_tensor;
    save(strcat(dir_name,'/knn-4_rbf_',int2str(sample_num),'_',int2str(K_values(i)),'.mat'),'X','Xt','Xten','Y','testInd','trainInd');
end

% sim_matrix = rbf_sim(Xtt(:,:,1));
% sim_matrix_2 = rbf_sim(Xtt(:,1,1));
% sim_matrix_3 = rbf_sim(Xtt(:,2,1));

function [sim_matrix] = rbf_sim(vec);
    region_num = size(vec, 1);
    sim_matrix = zeros(region_num);
    for i = 1:region_num
        sim_i2all = exp(-sqrt(sum((vec - vec(i,:)).^2, 2)));
        sim_matrix(i, :) = sim_i2all';
    end
end

