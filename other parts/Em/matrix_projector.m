function [matrix_p] = matrix_projector(matrix,N,K)
matrix_p=zeros(N,K);
for k=1:K
    matrix_p(:,k)=projector(matrix(:,k),N);
end