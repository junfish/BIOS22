import scipy.io as sio
from sklearn.neighbors import kneighbors_graph
import numpy as np
from scipy.spatial.distance import euclidean
import os

# xx = np.arange(24)
# xxx = np.reshape(xx, (2,3,4), order = 'F')
# xxxx = np.reshape(xxx, (6, 4), order = 'F')
# xxxx_tr = np.transpose(xxxx)
# xxxx_re = np.reshape(xxxx, (4, 6), order = 'F')
# xxxx_retr = np.reshape(xxxx, (4, 6))
# xxxxx = np.reshape(xxx, 24, order = 'F')
# xxxxxx = np.reshape(xxx, (2, 12), order = 'F')

rbf_distance = lambda x_i, x_j: np.exp(-euclidean(x_i, x_j)) # define the rbf distance via the rbf kernel function, which is actually a kind of similarity
cos_similarity = lambda x_i, x_j: np.dot(x_i, x_j)/(np.linalg.norm(x_i) * np.linalg.norm(x_j)) # define the distance via the cosine similarity

# print(cos_similarity(np.array([1, 2, 3]), np.array([2, 2, 3])))
new_dict = sio.loadmat('../data/data_pack/newADNI_692_116_3.mat')
del new_dict['testInd']
del new_dict['trainInd']
del new_dict['Y']
Xten = new_dict['Xten']
feature_num, modality_num, sample_num = Xten.shape
# 116 * 3 * 755
############## 116 * 116 * 3 * 755 ################ asym
des_dir = '../data/data_pack/' + str(sample_num) + '_116_116_3'
if not os.path.isdir(des_dir):
    os.mkdir(des_dir)
for k in [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 116]: # set different k value
    Xten_neighbor_graph = np.zeros(shape = (feature_num, feature_num, modality_num, sample_num))
    for modality in range(modality_num):
        for sample in range(sample_num):
            A = kneighbors_graph(Xten[:, modality, sample].reshape(-1, 1), k, mode='distance', metric = rbf_distance, include_self = True)
            B = A.toarray()

            # code block to construct symmetrical tensor
            # dim = B.shape[0]
            # for row in range(dim):
            #     for col in range(row + 1, dim):
            #         if B[col, row] > B[row, col]:
            #             B[row, col] = B[col, row]
            #         else:
            #             B[col, row] = B[row, col]

            Xten_neighbor_graph[:, :, modality, sample] = B
    new_dict['Xten'] = Xten_neighbor_graph
    new_dict['X'] = np.transpose(np.reshape(Xten_neighbor_graph, (feature_num * feature_num * modality_num, sample_num), order = 'F'))
    new_dict['Xt'] = new_dict['X']
    sio.savemat(des_dir + '/knn-4_rbf_' + str(sample_num) + '_' + str(k) + '.mat', new_dict) # _sym
################### 116 * 116 * 755 ################### asym
des_dir = '../data/data_pack/' + str(sample_num) + '_116_116'
if not os.path.isdir(des_dir):
    os.mkdir(des_dir)
for neighbor in [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 116]:
    Xten_neighbor_graph = np.zeros(shape = (feature_num, feature_num, sample_num))
    for sample in range(sample_num):
        # print(Xten[:, :, sample].shape)
        A = kneighbors_graph(Xten[:, :, sample], neighbor, mode='distance', metric = rbf_distance, include_self = True)
        B = A.toarray()

        # code block to construct symmetrical tensor
        # dim = B.shape[0]
        # for row in range(dim):
        #     for col in range(row + 1, dim):
        #         if B[col, row] > B[row, col]:
        #             B[row, col] = B[col, row]
        #         else:
        #             B[col, row] = B[row, col]

        Xten_neighbor_graph[:, :, sample] = B
    new_dict['Xten'] = Xten_neighbor_graph
    new_dict['X'] = np.transpose(np.reshape(Xten_neighbor_graph, (feature_num * feature_num, sample_num), order='F'))
    new_dict['Xt'] = new_dict['X']
    # new_dict['Y'] = new_dict['Y'].astype(np.float64)
    sio.savemat(des_dir + '/knn-3_rbf_' + str(sample_num) + '_' + str(neighbor) + '.mat', new_dict)
############## 116 * 116 * 3 * 755 ################
des_dir = '../data/data_pack/sym_' + str(sample_num) + '_116_116_3'
if not os.path.isdir(des_dir):
    os.mkdir(des_dir)
for k in [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 116]: # set different k value
    Xten_neighbor_graph = np.zeros(shape = (feature_num, feature_num, modality_num, sample_num))
    for modality in range(modality_num):
        for sample in range(sample_num):
            A = kneighbors_graph(Xten[:, modality, sample].reshape(-1, 1), k, mode='distance', metric = rbf_distance, include_self = True)
            B = A.toarray()

            # code block to construct symmetrical tensor
            dim = B.shape[0]
            for row in range(dim):
                for col in range(row + 1, dim):
                    if B[col, row] > B[row, col]:
                        B[row, col] = B[col, row]
                    else:
                        B[col, row] = B[row, col]

            Xten_neighbor_graph[:, :, modality, sample] = B
    new_dict['Xten'] = Xten_neighbor_graph
    new_dict['X'] = np.transpose(np.reshape(Xten_neighbor_graph, (feature_num * feature_num * modality_num, sample_num), order = 'F'))
    new_dict['Xt'] = new_dict['X']
    sio.savemat(des_dir + '/sym_knn-4_rbf_' + str(sample_num) + '_' + str(k) + '.mat', new_dict) # _sym
################### 116 * 116 * 755 ###################
des_dir = '../data/data_pack/sym_' + str(sample_num) + '_116_116'
if not os.path.isdir(des_dir):
    os.mkdir(des_dir)
for neighbor in [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 116]:
    Xten_neighbor_graph = np.zeros(shape = (feature_num, feature_num, sample_num))
    for sample in range(sample_num):
        # print(Xten[:, :, sample].shape)
        A = kneighbors_graph(Xten[:, :, sample], neighbor, mode='distance', metric = rbf_distance, include_self = True)
        B = A.toarray()

        # code block to construct symmetrical tensor
        dim = B.shape[0]
        for row in range(dim):
            for col in range(row + 1, dim):
                if B[col, row] > B[row, col]:
                    B[row, col] = B[col, row]
                else:
                    B[col, row] = B[row, col]

        Xten_neighbor_graph[:, :, sample] = B
    new_dict['Xten'] = Xten_neighbor_graph
    new_dict['X'] = np.transpose(np.reshape(Xten_neighbor_graph, (feature_num * feature_num, sample_num), order='F'))
    new_dict['Xt'] = new_dict['X']
    # new_dict['Y'] = new_dict['Y'].astype(np.float64)
    sio.savemat(des_dir + '/sym_knn-3_rbf_' + str(sample_num) + '_' + str(neighbor) + '.mat', new_dict)



