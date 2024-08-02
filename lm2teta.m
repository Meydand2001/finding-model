function [teta] = lm2teta(lambda,a_matrices,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
teta=lambda(:);
for n=1:N
    teta=[teta; a_matrices{n}(:)];
end