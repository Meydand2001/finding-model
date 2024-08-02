function [accuracy] = param_matrix_calc(matrix1,matrix2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
l=size(matrix1,2);
cost_matrix=zeros(l);
for i=1:l
    for j=1:l
        cost_matrix(i,j)=sqrt(sum((matrix1(:,i)-matrix2(:,j)).^2));
    end
end
match=matchpairs(cost_matrix,100);
accuracy=sum(cost_matrix(sub2ind(size(cost_matrix),match(:,1),match(:,2))));
end