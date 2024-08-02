function [accuracy] = param_accuracy_calc(lambda1,b_matrices1,c_tensors1,lambda2,b_matrices2,c_tensors2,M,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
accuracy = param_matrix_calc(lambda1,lambda2);
model_norm=sqrt(sum(lambda1.^2));
for m=1:M
    accuracy = sqrt(accuracy.^2 + param_matrix_calc(b_matrices1{m},b_matrices2{m}).^2);
    squared_m=b_matrices1{m}.^2;
    model_norm = sqrt(model_norm.^2+sum(squared_m(:)));
end
for n=1:N
    c_tensor1 = c_tensors1{n};
    c_tensor2 = c_tensors2{n};
    c_matrix1 = tens2mat(c_tensor1,1,2:size(size(c_tensor1),2));
    c_matrix2 = tens2mat(c_tensor2,1,2:size(size(c_tensor2),2));
    accuracy = sqrt(accuracy.^2 + param_matrix_calc(c_matrix1,c_matrix2).^2);
    squared_c=c_matrix1.^2;
    model_norm = sqrt(model_norm.^2+sum(squared_c(:)));
end
accuracy = accuracy / model_norm;
end