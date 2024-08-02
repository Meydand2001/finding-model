function dist = distfun(v1,v2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dist=sqrt(sum((v1-v2).^2,2));
end