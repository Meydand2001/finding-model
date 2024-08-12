function [alpha] = alpha_mod(alpha,opt)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if opt==1
    c=alpha>-1;
    alpha(c)=-1;
elseif opt==2
    alpha=(alpha-1)./2;
end
end