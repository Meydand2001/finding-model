function [teta] = md2teta(lambda,b_matrices,M,a_tensors,N)
%MD2TETA Summary of this function goes here
%   Detailed explanation goes here

teta=lambda(:);
for m=1:M
    teta=[teta; b_matrices{m}(:)];
end
for n=1:N
    teta=[teta; a_tensors{n}(:)];
end
end
