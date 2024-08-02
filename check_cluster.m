matrices=init_matrices(1,5,4);
matrix1=matrices{1};
matrix2=repmat(matrix1,1,3);
matrix3=matrix2+0.005*rand(5,12);
[kld_distance,idx] = cluster_coloumns(matrix3,12,3);