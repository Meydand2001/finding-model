function [tetacheck] = tetacheck_calc(alpha,teta,r,v,dim,alphabet,F)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
tetacheck=zeros(size(teta));
    for j=1:dim*F+1
        if j~=dim*F+1
            interval=(j-1)*alphabet+1:j*alphabet;
            tetacheck(interval)=teta(interval)-2.*alpha(j).*r(interval)+(alpha(j).^2).*v(interval);  
        else
            interval=(j-1)*alphabet+1;
            tetacheck(interval:end)=teta(interval:end)-2.*alpha(j).*r(interval:end)+(alpha(j).^2).*v(interval:end);
        end     
    end
end