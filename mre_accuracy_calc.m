function [mre] = mre_accuracy_calc(pmf1,pmf2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mre = sqrt(sum((pmf1(:)-pmf2(:)).^2)/sum(pmf1(:).^2));
end