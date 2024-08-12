function [teta] = lm2teta(lambda,matrices,dim,alphabet,F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
teta=zeros((dim*alphabet+1)*F,1);
for n=1:dim
    teta((n-1)*alphabet*F+1:n*alphabet*F)=tens2mat(matrices{n},[1,2]);
end
teta(dim*alphabet*F+1:(dim*alphabet+1)*F)=lambda;
