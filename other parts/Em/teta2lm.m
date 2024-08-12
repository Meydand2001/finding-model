function [lambda,matrices] = teta2lm(teta,dim,alphabet,F)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
matrices=cell(1,dim);
for n=1:dim
    %teta((n-1)*dim*F+1:n*dim*F)=tens2mat(matrices{n},[1,2]);
    matrices{1,n}=reshape(teta((n-1)*alphabet*F+1:n*alphabet*F),alphabet,F);
end
lambda=teta(dim*alphabet*F+1:(dim*alphabet+1)*F);
end

function [lambda]=teta2l(teta,dim,alphabet,F)
 lambda=teta(dim*alphabet*F+1:(dim*alphabet+1)*F);
end