function [accuracy] = param_accuracy_calc(lambda1,b_matrices1,a_tensors1,lambda2,b_matrices2,a_tensors2,M,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
teta1=md2teta(lambda1,b_matrices1,M,a_tensors1,N);
teta2=md2teta(lambda2,b_matrices2,M,a_tensors2,N);
accuracy=norm(teta2-teta1);
end